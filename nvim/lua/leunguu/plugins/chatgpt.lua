return {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	config = function()
		require("chatgpt").setup({
			api_host_cmd = "",
			api_key_cmd = "",
			openai_params = {
				max_tokens = 20000,
			},
			actions_paths = { "/home/ubuntu/.config/nvim/lua/leunguu/plugins/actions.json" },
			openai_edit_params = {
				model = "meta.llama3-70b-instruct-v1:0",
				max_tokens = 2048,
			},
		})
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		"nvim-telescope/telescope.nvim",
	},
}
