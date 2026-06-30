--- Performs additional setup after installation
--- Documentation: https://mise.jdx.dev/tool-plugin-development.html#postinstall-hook
--- @param ctx {rootPath: string, runtimeVersion: string, sdkInfo: table} Context

require("util")

function PLUGIN:PostInstall(ctx)
  local sdkInfo = ctx.sdkInfo[PLUGIN.name]
  local path = sdkInfo.path

  local filename = get_filename()
  os.execute("gunzip " .. path .. "/" .. filename)

  local binary = filename:gsub(".gz", "")
  local binaries = {[binary] = PLUGIN.name}
  install_from_map(path, binaries)

  -- Verify installation works. Don't redirect output so the real cause
  -- (e.g. a dyld library load failure) is reported instead of being swallowed.
  local destFile = path .. "/bin/" .. PLUGIN.name
  local result = os.execute(destFile .. " --version")
  if result ~= 0 then
    error(PLUGIN.name .. " installation appears to be broken")
  end
end
