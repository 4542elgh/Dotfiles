return{
    {
        "olimorris/codecompanion.nvim",
        config = function ()
            require("codecompanion").setup({
                adapters = {
                    ollama = require("codecompanion.adapters").use("ollama", {
                        schema = {
                            model = {
                                default = "deepseek-coder-v2",
                            },
                        },
                    })
                },
                strategies = {
                    chat = "ollama",
                    inline = "ollama",
                    tool = "ollama"
                },
            })
        end
    }
}
