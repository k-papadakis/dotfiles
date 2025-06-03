if [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # >>> JVM installed by coursier >>>
  export JAVA_HOME="$HOME/Library/Caches/Coursier/arc/https/cdn.azul.com/zulu/bin/zulu11.80.21-ca-jdk11.0.27-macosx_aarch64.tar.gz/zulu11.80.21-ca-jdk11.0.27-macosx_aarch64"
  # <<< JVM installed by coursier <<<

  # >>> coursier install directory >>>
  export PATH="$PATH:$HOME/Library/Application Support/Coursier/bin"
  # <<< coursier install directory <<<
fi
