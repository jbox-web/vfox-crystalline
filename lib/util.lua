function get_platform()
  -- RUNTIME object is provided by mise/vfox
  -- RUNTIME.osType: "Windows", "Linux", "Darwin"
  -- RUNTIME.archType: "amd64", "386", "arm64", etc.

  local os_name = RUNTIME.osType:lower()
  local arch = RUNTIME.archType

  -- Map to your tool's platform naming convention
  -- Adjust these mappings based on how your tool names its releases
  local platform_map = {
    ["darwin"] = {
      ["amd64"] = "x86_64-apple-darwin",
      ["arm64"] = "arm64-apple-darwin",
    },
    ["linux"] = {
      ["amd64"] = "x86_64-unknown-linux-musl",
      ["arm64"] = "arm64-unknown-linux-musl",
      ["386"]   = "386-unknown-linux-musl",
    },
    ["windows"] = {
      ["amd64"] = "x86_64-windows",
      ["386"]   = "386-windows",
    }
  }

  local os_map = platform_map[os_name]
  if os_map then
    return os_map[arch] or "linux_amd64"  -- fallback
  end

  -- Default fallback
  return "linux_amd64"
end

function install_from_map(path, map)
  os.execute("mkdir -p " .. path .. "/bin")

  for source, dest in pairs(map) do
    os.execute("mv " .. path .. "/" .. source .. " " .. path .. "/bin/" .. dest)
    os.execute("chmod +x " .. path .. "/bin/" .. dest)
  end
end

function install_from_list(path, list)
  os.execute("mkdir -p " .. path .. "/bin")

  for _, binary in ipairs(list) do
    os.execute("mv " .. path .. "/" .. binary .. " " .. path .. "/bin/")
    os.execute("chmod +x " .. path .. "/bin/" .. binary)
  end
end
