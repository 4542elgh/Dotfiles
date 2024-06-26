return(
    {
        "olimorris/codecompanion.nvim",
        config = function ()
            require("codecompanion").setup({
                adapters = {
                    openai = require("codecompanion.adapters").use("openai", {
                        env = {
                            api_key = "openai_api_key",
                        },
                        schema = {
                            model = {
                                default = "gpt-3.5-turbo-16k"
                            }
                        }
                    }),
                    strategies = {
                        chat = "openai",
                        inline = "openai",
                        tool = "openai"
                    },
                },
            })
        end
    }
)
