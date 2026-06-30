# frozen_string_literal: true

# because we heavily rely on it
brew 'bash'

# to install other tools
brew 'mise'

# crystalline's macOS release binary is dynamically linked against these
# Homebrew libraries (hard-coded /opt/homebrew|/usr/local prefixes), so they
# must be present at runtime or dyld aborts with "Abort trap: 6".
brew 'llvm'
brew 'pcre2'
brew 'bdw-gc'
brew 'libyaml'
