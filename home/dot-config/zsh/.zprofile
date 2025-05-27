if [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # >>> JVM installed by coursier >>>
  export JAVA_HOME="$HOME/Library/Caches/Coursier/arc/https/cdn.azul.com/zulu/bin/zulu21.42.19-ca-jdk21.0.7-macosx_aarch64.tar.gz/zulu21.42.19-ca-jdk21.0.7-macosx_aarch64"
  # <<< JVM installed by coursier <<<

  # >>> coursier install directory >>>
  export PATH="$PATH:$HOME/Library/Application Support/Coursier/bin"
  # <<< coursier install directory <<<
fi
