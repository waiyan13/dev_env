return {
    {
        "stevearc/conform.nvim",
        lazy = true,
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            formatters_by_ft = {
                php = { "php-cs-fixer" },
            },
            formatters = {
                ["php-cs-fixer"] = {
                    command = "php-cs-fixer",
                    args = {
                        "fix",
                        "--rules=@PSR12",
                        "$FILENAME",
                    },
                    stdin = false,
                },
            },
            notfiy_on_error = true,
        },
    },
}
