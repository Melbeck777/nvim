-- init.lua (最上段に置く)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

local is_win = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
local is_mac = vim.fn.has("macunix") == 1
local is_linux = not is_win and not is_mac

--windows で :terminalをPowershellにする
local opt = vim.opt
if is_win then
	local pwsh = vim.fn.executable("pwsh") == 1 and "pwsh" or nil
	local pscore = vim.fn.executable("powershell") == 1 and "powershell"
	local shell = pwsh
	if shell then
		opt.shell = shell
		opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
		opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s"
		opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s"
		opt.shellquote = ""
		opt.shellxquote = ""
	end
else
	opt.shellquote = ""
	opt.shellxquote = ""
end

if vim.fn.executable("rg") == 1 then
	opt.grepprg = "rg --vimgrep"
	opt.grepformat = "%f:%l:%c:%m"
else
	if is_win then
		opt.grepprg = "findstr /S /N /R /I /C:%s ."
	else
		opt.grepprg = "grep -RIn --exclude-dir=.git --exclude-dire=node_modules --line-number %s ."
	end
	opt.grepformat = "%f:%;"
end

--マウス有効化
opt.mouse = "a"
opt.title = true

-- 全角文字表示設定
opt.ambiwidth = "single"
opt.termguicolors = true
opt.swapfile = false
opt.backup = false
opt.hidden = true
opt.clipboard:append({ "unnamedplus" })

opt.number = true
opt.relativenumber = true
opt.list = true
opt.listchars = { tab = ">-", trail = "*", nbsp = "+" }

opt.smartindent = true
opt.visualbell = true

opt.showmatch = true

opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4

opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true
-- Backspace が行頭で前行と結合し、インデントも越えて効くように
opt.backspace = { "start", "eol", "indent" }
-- カーソル移動キーで行をまたげるように
opt.whichwrap = "b,s,h,l,<,>,[,]"
-- クリップボード設定のスペルも修正（unnamedplus）
opt.fileformats = { "dos", "unix", "mac" }

-- 日本語ファイルの文字コード自動判別（Excel 由来の CSV は cp932 が多い）
-- 前から順に試して、デコードに失敗しなかったものが採用される。
-- euc-jp はバイト範囲が厳しく先に置いても cp932 を誤検出しにくいので、この順序にする。
opt.fileencodings = {
	"ucs-bom", -- BOM 付き UTF-8 / UTF-16（Excel の「UTF-8」出力）
	"utf-8",
	"iso-2022-jp",
	"euc-jp",
	"cp932", -- Shift_JIS
	"latin1",
}
-- 自動判別が外れたときに開き直すコマンド: :Enc cp932 など
vim.api.nvim_create_user_command("Enc", function(o)
	vim.cmd("edit ++enc=" .. o.args)
end, {
	nargs = 1,
	complete = function()
		return { "utf-8", "cp932", "euc-jp", "iso-2022-jp", "utf-16le", "latin1" }
	end,
	desc = "指定した文字コードで開き直す",
})

opt.helplang = { "ja", "en" }

opt.updatetime = 300

opt.pumblend = 0
opt.winblend = 0

opt.laststatus = 3
-- quickfix への取り込み形式: file:line:message
opt.showtabline = 2

vim.keymap.set("n", "s", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("x", "s", "<Nop>", { noremap = true, silent = true })

-- フォーカスを変更する
local termfeatures = vim.g.termfeatures or {}
termfeatures.osc52 = true
vim.g.termfeatures = termfeatures

require("config.lazy")
require("config.keymap")
