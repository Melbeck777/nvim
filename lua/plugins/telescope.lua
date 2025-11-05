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
            file_ignore_patterns = {
                "[/\\]%.git[/\\]",
                -- よくあるビルド・巨大ディレクトリ
                "[/\\]node_modules[/\\]",
                "[/\\]dist[/\\]",
                "[/\\]build[/\\]",
                "[/\\]%.venv[/\\]", "[/\\]venv[/\\]",
                "[/\\]coverage[/\\]", "[/\\]target[/\\]",
                -- バイナリや画像拡張子（末尾一致）
                "%.png$", "%.jpg$", "%.jpeg$", "%.gif$", "%.webp$", "%.mp4$", "%.mov$",
                -- ロックファイル
                "yarn%.lock$", "pnpm%-lock%.yaml$",
            },
        },
        pickers = {
            find_files = {
                hidden = true,
                no_ignore = false,
                --find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" }
            },
            live_grep = {
                additional_args = function(_)
                    local args = {
                        "-F",
                        "-S",
                        "--hidden",
                        "--glob", "!**/.git/*",
                    }
                    return args
                end,
            },
            grep_string = {
                additional_args = function(_)
                    local args = {
                        "-P",
                        "-S",
                        "--hidden",
                        "--glob", "!**/.git/*",
                    }
                    return args
                end,
            }
        },
    },
    keys = {
        { "<Space>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
        { "<Space>fg", function() require("telescope.builtin").live_grep() end,  desc = "Live grep" },
        { "<Space>fb", function() require("telescope.builtin").buffers() end,    desc = "Buffers" },
        { "<Space>fh", function() require("telescope.builtin").help_tags() end,  desc = "Help tags" },
        { "<Space>fo", function() require("telescope.builtin").git_files() end,  desc = "Git files" },
        {
            "<Space>fG",
            function()
                local builtin = require("telescope.builtin")
                builtin.live_grep({
                    additional_args = function(_)
                        return { "-P", "-S", "--hidden", "--glob", "!**/.git/*" }
                    end,
                })
            end,
            desc = "Live grep (PCRE2 regex JP)"
        },
    },
    config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
        -- pcall(telescope.load_extension, "fzf") -- fzf-native を使う場合
    end,
}
