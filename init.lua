vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
--windows で :terminalをPowershellにする
local opt = vim.opt
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	local pwsh = vim.fn.executable("pwsh") == 1 and "pwsh" or nil
	local pscore = vim.fn.executable("powershell") == 1 and "powershell"
	local shell = pwsh or pscore

	if shell then
		opt.shell = shell
		opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPoliciy RemoteSigned -Command"
		opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s"
		opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s"
		opt.shellquote = ""
		opt.shellxquote = ""
	end
end

--マウス有効化
opt.mouse = 'a'
opt.title = true

-- 全角文字表示設定
opt.ambiwidth = 'double'

opt.swapfile = false
opt.backup = false
opt.hidden = true
opt.clipboard:append({unamedplus = true})

opt.number = true
opt.list = true
opt.listchars = {tab = '>-', trail = '*', nbsp = '+'}

opt.smartindent = true
opt.visualbell = true

opt.showmatch = true

opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4

opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true

opt.whichwrap = 'b', 's', 'h', 'l', '<', '>', '[', ']'
opt.backspace = 'start', 'eol', 'indent'

opt.fileformats = 'dos', 'unix', 'mac'

opt.helplang = 'ja', 'en'

opt.updatetime = 300

opt.showtabline = 2

require("config.lazy")


