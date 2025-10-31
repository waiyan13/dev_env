local M = {}

function M.setup(opts)
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
            -- jdtls
            local jdtls = require("jdtls")
            local root_markers = {
                ".git", "mvnw", "gradlew", "pom.xml", "build.gradle"
            }
            local root_dir = require("jdtls.setup").find_root(root_markers)

            local home = "/home/ubuntu"
            local workspace = home .. "/.local/share/jdtls/workspace" ..
                                  vim.fn.fnamemodify(root_dir, ":p:h:t")

            local config = vim.tbl_deep_expand("force", opts, {
                cmd = {
                    "java", "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                    "-Dosgi.bundles.defaultStartLevel=4",
                    "-Declipse.product=org.eclipse.jdt.ls.core.product",
                    "-Dlog.protocol=true", "-Dlog.level=ALL", "-Xms1g",
                    "--add-modules=ALL-SYSTEM", "--add-opens",
                    "java.base/java.util=ALL-UNNAMED", "--add-opens",
                    "java.base/java.lang=ALL-UNNAMED",

                    "-javaagent:" .. home .. "/.local/share/lombok.jar",
                    "-Xbootclasspath/a:" .. home .. "/.local/share/lombok.jar",

                    "-jar", home ..
                        "/.local/share/eclipse/jdtls/plugins/org.eclipse.equinox.launcher_1.7.100.v20251014-1222.jar",
                    "-configuration",
                    home .. "/.local/share/eclipse/jdtls/config_linux", "-data",
                    workspace
                },
                root_dir = root_dir
            })
            jdtls.start_or_attach(config)
        end
    })
end

return M
