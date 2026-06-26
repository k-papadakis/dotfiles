if [[ "${OSTYPE}" == "darwin"* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # >>> JVM installed by coursier >>>
  export JAVA_HOME="/Users/ko.papadakis/Library/Caches/Coursier/arc/https/cdn.azul.com/zulu/bin/zulu17.66.19-ca-jdk17.0.19-macosx_aarch64.tar.gz/zulu17.66.19-ca-jdk17.0.19-macosx_aarch64/Contents/Home"
  # <<< JVM installed by coursier <<<

  # >>> coursier install directory >>>
  export PATH="${PATH}:${HOME}/Library/Application Support/Coursier/bin"
  # <<< coursier install directory <<<
fi
