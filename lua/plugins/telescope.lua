-- %LOCALAPPDATA%/nvim/lua/plugins/telescope.lua
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- 高速化したい場合は fzf-native を有効化（要ビルド環境）
		-- {
		-- 	"nvim-telescope/telescope-fzf-native.nvim",
		-- 	build = (vim.fn.has("win32") == 1) and "cmake -S. -Bbuild -G Ninja && cmake --build build --config Release && cmake --install build --prefix build"
		-- 		or "make",
		-- 	cond = function() return vim.fn.executable("make") == 1 or vim.fn.executable("cmake") == 1 end,
		-- },
	},
	opts = {
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
				},
			},
		},
		pickers = {
			find_files = { hidden = true },
		},
	},
	keys = {
		{ "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
		{ "<leader>fg", function() require("telescope.builtin").live_grep()  end, desc = "Live grep"  },
		{ "<leader>fb", function() require("telescope.builtin").buffers()    end, desc = "Buffers"    },
		{ "<leader>fh", function() require("telescope.builtin").help_tags()  end, desc = "Help tags"  },
	},
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		-- pcall(telescope.load_extension, "fzf") -- fzf-native を使う場合
	end,
}
