-- lua/config/grep_in.lua
--
-- パス正規表現でファイルを絞り込んでから本文検索する。
--   rg --files | rg <パス正規表現>  →  対象ファイル一覧  →  その一覧だけを本文検索
--
-- ripgrep の -g/--glob は glob 専用でパスに正規表現を書けないため、
-- パスの絞り込み（一段目）と本文検索（二段目）を分離している。
--
--   :GrepIn  {パス正規表現}                  絞った集合に対して live_grep を開く
--   :GrepQf  {パス正規表現} {本文正規表現}   結果を quickfix に流す
--
-- どちらも ! を付けると隠しファイル・ignore されたファイルも対象にする。

local M = {}

-- search_dirs はコマンドライン引数として展開されるため、多すぎると ARG_MAX で失敗する
local ARG_MAX_LIMIT = 1000
-- :GrepQf でパスを渡すときのバッチサイズ
local QF_BATCH = 500

local is_win = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

local function notify(msg, level)
	vim.notify(msg, level or vim.log.levels.INFO, { title = "GrepIn" })
end

local function to_lines(s)
	local t = {}
	for line in (s or ""):gmatch("[^\r\n]+") do
		t[#t + 1] = line
	end
	return t
end

local function has_rg()
	if vim.fn.executable("rg") ~= 1 then
		notify("ripgrep (rg) が見つからない", vim.log.levels.ERROR)
		return false
	end
	return true
end

-- 一段目のファイル一覧コマンド。将来 --hidden / --no-ignore を受け付けられるよう opts 経由にしてある
local function file_list_cmd(opts)
	local cmd = { "rg", "--files" }
	if opts.hidden then
		table.insert(cmd, "--hidden")
	end
	if opts.no_ignore then
		table.insert(cmd, "--no-ignore")
	end
	-- node_modules や画像などの除外は config.telescope に一元化してある
	local ok, tcfg = pcall(require, "config.telescope")
	if ok and tcfg.rg_globs then
		vim.list_extend(cmd, tcfg.rg_globs())
	end
	return cmd
end

--- パス正規表現にマッチするファイルのパス一覧を返す。
--- @return string[]|nil paths マッチしたパス（0 件なら空テーブル）。エラー時は nil
--- @return string|nil err エラーメッセージ
local function filter_paths(path_re, opts)
	local files = vim.system(file_list_cmd(opts), { text = true }):wait()
	-- rg はマッチ 0 件で exit 1 を返す。これは正常系
	if files.code > 1 then
		return nil, ("rg --files が失敗した (exit %d): %s"):format(files.code, vim.trim(files.stderr or ""))
	end

	local stdout = files.stdout or ""
	if is_win then
		-- Windows のパス区切りを / に正規化してからパス正規表現に掛ける
		stdout = stdout:gsub("\\", "/")
	end
	if stdout == "" then
		return {}
	end

	-- Lua パターンではなく ripgrep の正規表現でフィルタする（この分離が本機能の中核）
	local filtered = vim.system({ "rg", "--", path_re }, { stdin = stdout, text = true }):wait()
	if filtered.code > 1 then
		return nil, ("パス正規表現が不正: %s"):format(vim.trim(filtered.stderr or ""))
	end
	return to_lines(filtered.stdout)
end

--- パス正規表現で絞った集合に対して live_grep を開く
function M.grep_in(path_re, opts)
	opts = opts or {}
	if not has_rg() then
		return
	end
	if not path_re or path_re == "" then
		notify("パス正規表現を指定する", vim.log.levels.WARN)
		return
	end

	local paths, err = filter_paths(path_re, opts)
	if err then
		notify(err, vim.log.levels.ERROR)
		return
	end
	if #paths == 0 then
		notify(("パスにマッチするファイルなし: /%s/"):format(path_re), vim.log.levels.WARN)
		return
	end
	if #paths > ARG_MAX_LIMIT then
		notify(
			("%d 件ヒットした（上限 %d）。引数長の制限を超えるため live_grep は開かない。\n"):format(
				#paths,
				ARG_MAX_LIMIT
			)
				.. ("パス正規表現をもっと絞るか、:GrepQf '%s' '<本文正規表現>' を使う。"):format(path_re),
			vim.log.levels.WARN
		)
		return
	end

	local ok, builtin = pcall(require, "telescope.builtin")
	if not ok then
		notify("telescope.nvim が読み込めない", vim.log.levels.ERROR)
		return
	end
	builtin.live_grep({
		search_dirs = paths,
		prompt_title = ("Grep in /%s/ (%d files)"):format(path_re, #paths),
		-- 対象ファイルは一段目で確定済みなので、二段目では ignore 規則を効かせない
		additional_args = function(_)
			return { "--hidden", "--no-ignore" }
		end,
	})
end

--- パス正規表現で絞った集合を本文検索し、結果を quickfix に流す
function M.grep_qf(path_re, body_re, opts)
	opts = opts or {}
	if not has_rg() then
		return
	end
	if not path_re or path_re == "" or not body_re or body_re == "" then
		notify("使い方: :GrepQf {パス正規表現} {本文正規表現}", vim.log.levels.WARN)
		return
	end

	local paths, err = filter_paths(path_re, opts)
	if err then
		notify(err, vim.log.levels.ERROR)
		return
	end
	if #paths == 0 then
		notify(("パスにマッチするファイルなし: /%s/"):format(path_re), vim.log.levels.WARN)
		return
	end

	local lines = {}
	for i = 1, #paths, QF_BATCH do
		local batch = vim.list_slice(paths, i, math.min(i + QF_BATCH - 1, #paths))
		-- パスは引数配列として直接渡す。シェルも xargs も経由しないのでスペース入りでも壊れない
		local cmd = { "rg", "--vimgrep", "--no-heading", "--no-messages", "--color=never", "--no-ignore" }
		vim.list_extend(cmd, { "--", body_re })
		vim.list_extend(cmd, batch)

		local res = vim.system(cmd, { text = true }):wait()
		if res.code > 1 then
			notify(("本文検索が失敗した: %s"):format(vim.trim(res.stderr or "")), vim.log.levels.ERROR)
			return
		end
		vim.list_extend(lines, to_lines(res.stdout))
	end

	if #lines == 0 then
		notify(("マッチなし: path=/%s/ body=/%s/"):format(path_re, body_re), vim.log.levels.WARN)
		return
	end

	vim.fn.setqflist({}, " ", {
		title = ("GrepQf /%s/ in /%s/"):format(body_re, path_re),
		lines = lines,
		efm = "%f:%l:%c:%m",
	})
	vim.cmd("copen")
end

--- コマンド引数を空白区切りで分割する。'...' と "..." で囲めば空白を含められる。
--- 正規表現に \ が頻出するのでバックスラッシュはエスケープ扱いしない。
--- @return string[] args
--- @return string|nil unterminated 閉じられていないクォート
local function split_args(s)
	local args, cur, quote, quoted = {}, {}, nil, false
	for ch in (s or ""):gmatch(".") do
		if quote then
			if ch == quote then
				quote = nil
			else
				cur[#cur + 1] = ch
			end
		elseif ch == "'" or ch == '"' then
			quote = ch
			quoted = true
		elseif ch:match("%s") then
			if quoted or #cur > 0 then
				args[#args + 1] = table.concat(cur)
				cur, quoted = {}, false
			end
		else
			cur[#cur + 1] = ch
		end
	end
	if quoted or #cur > 0 then
		args[#args + 1] = table.concat(cur)
	end
	return args, quote
end

function M.setup()
	vim.api.nvim_create_user_command("GrepIn", function(a)
		M.grep_in(a.args, { hidden = a.bang, no_ignore = a.bang })
	end, {
		nargs = 1,
		bang = true,
		desc = "パス正規表現で絞ってから live_grep（! で隠しファイル/ignore も対象）",
	})

	vim.api.nvim_create_user_command("GrepQf", function(a)
		local args, unterminated = split_args(a.args)
		if unterminated then
			notify(("クォート %s が閉じられていない"):format(unterminated), vim.log.levels.ERROR)
			return
		end
		if #args ~= 2 then
			notify(
				"使い方: :GrepQf {パス正規表現} {本文正規表現}\n空白を含む場合は '...' で囲む",
				vim.log.levels.WARN
			)
			return
		end
		M.grep_qf(args[1], args[2], { hidden = a.bang, no_ignore = a.bang })
	end, {
		nargs = "+",
		bang = true,
		desc = "パス正規表現で絞ってから本文検索し quickfix に流す（! で隠しファイル/ignore も対象）",
	})
end

return M
