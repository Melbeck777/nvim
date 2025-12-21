-- %LOCALAPPDATA%/nvim/lua/config/telescope.lua
local M = {}

-- 共通の除外定義
local ignore_dirs = {
	".git/",
	"node_modules/",
	"dist/",
	"build/",
	".venv/",
	"venv/",
	"coverage/",
	"target/",
}
local ignore_files = { "yarn.lock", "pnpm-lock.yaml" }
local ignore_exts = { "png", "jpg", "jpeg", "gif", "webp", "mp4", "mov" }

-- ripgrep に渡す --glob 除外
local function rg_globs()
	local args = { "--glob", "!**/.git/*" }
	for _, d in ipairs(ignore_dirs) do
		table.insert(args, "--glob")
		table.insert(args, "!" .. "**/" .. d .. "**")
	end
	for _, f in ipairs(ignore_files) do
		table.insert(args, "--glob")
		table.insert(args, "!" .. "**/" .. f)
	end
	for _, e in ipairs(ignore_exts) do
		table.insert(args, "--glob")
		table.insert(args, "!" .. "**/*." .. e)
	end
	return args
end

-- fd に渡す --exclude
local function fd_excludes()
	local args = {}
	for _, d in ipairs(ignore_dirs) do
		table.insert(args, "--exclude=" .. d)
	end
	for _, f in ipairs(ignore_files) do
		table.insert(args, "--exclude=" .. f)
	end
	for _, e in ipairs(ignore_exts) do
		table.insert(args, "--exclude=*." .. e)
	end
	return args
end

-- find_files 用コマンド
local function make_find_command()
	if vim.fn.executable("rg") == 1 then
		local cmd = { "rg", "--files", "--hidden", "--follow", "--ignore-vcs" }
		vim.list_extend(cmd, rg_globs())
		return cmd
	elseif vim.fn.executable("fd") == 1 then
		local cmd = { "fd", "--type", "f", "--hidden", "--follow", "--color", "never" }
		vim.list_extend(cmd, fd_excludes())
		return cmd
	end
	return nil
end

function M.rg_args_flat(opts)
	opts = opts or {}
	local base = opts.pcre and { "-P", "-S", "--hidden" } or { "-F", "-S", "--hidden" }
	if vim.fn.executable("rg") == 1 then
		vim.list_extend(base, rg_globs())
	else
		vim.list_extend(base, { "--glob", "!**/.git/*" })
	end
	if opts.max_columns then
		vim.list_extend(base, { "--max-columns=200", "--max-columns-preview" })
	end
	return base
end

function M.opts()
	return {
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
				},
			},
		},
		pickers = {
			find_files = {
				hidden = true,
				no_ignore = false,
				find_command = make_find_command(),
			},
			live_grep = {
				additional_args = function(_)
					return M.rg_args_flat({ pcre = false })
				end,
			},
			grep_string = {
				additional_args = function(_)
					return M.rg_args_flat({ pcre = true, max_columns = true })
				end,
			},
		},
	}
end

return M
