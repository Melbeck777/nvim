-- init.lua (最上段に置く)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

--windows で :terminalをPowershellにする
local opt = vim.opt
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	local pwsh = vim.fn.executable("pwsh") == 1 and "pwsh" or nil
	local pscore = vim.fn.executable("powershell") == 1 and "powershell"
	local shell = pwsh
	print(shell)
	if shell then
		opt.shell = shell
		opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
		opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s"
		opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s"
		opt.shellquote = ""
		opt.shellxquote = ""
	end
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

opt.helplang = { "ja", "en" }

opt.updatetime = 300
-- :grep が使う外部コマンドを findstr に
-- /S 再帰, /N 行番号, /R 正規表現, /I 大文字小文字無視（必要に応じて外す）
-- /C:%s はパターン全体を1語として渡す（空白を含む検索に必須）
opt.grepprg = "findstr /S /N /R /I /C:%s ."
opt.grepformat = "%f:%l:%m"

opt.pumblend = 0
opt.winblend = 0

opt.laststatus = 3
--vim.nvim_open_win(bufnr(''), v:false, {'relative': 'cursor', 'height': 3, 'width': 10, 'row': 1, 'col': 1})
-- quickfix への取り込み形式: file:line:message
opt.showtabline = 2

-- フォーカスを変更する
local termfeatures = vim.g.termfeatures or {}
termfeatures.osc52 = true
vim.g.termfeatures = termfeatures

require("config.lazy")
require("config.keymap")
