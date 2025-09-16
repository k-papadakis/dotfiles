if [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # >>> JVM installed by coursier >>>
  export JAVA_HOME="/Users/ko.papadakis/Library/Caches/Coursier/arc/https/cdn.azul.com/zulu/bin/zulu17.60.17-ca-jdk17.0.16-macosx_aarch64.tar.gz/zulu17.60.17-ca-jdk17.0.16-macosx_aarch64"
  # <<< JVM installed by coursier <<<

  # >>> coursier install directory >>>
  export PATH="$PATH:$HOME/Library/Application Support/Coursier/bin"
  # <<< coursier install directory <<<
fi
