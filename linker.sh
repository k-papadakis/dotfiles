#!/bin/bash
set -euo pipefail

cd home

# Some programs store their config in ~/Library/Application\ Support
MACOS_CONFIG_DIR="${HOME}/Library/Application Support"
declare -A MAC_CONFIGS

# Add ~/Library/Application\ Support programs here.
# Note that this associative array is used as a hashet,
# meaning that its values don't matter.
MAC_CONFIGS=(["lazygit"]=0)

for p in $(find . -mindepth 1 -maxdepth 2 -not -path ./.config | sed 's|^\./||'); do

  source_path="${PWD}/${p}"

  # If the path is of the form ./config/<conf>, and <conf> is in $MAC_CONFIGS,
  # then change from .config/ to $MACOS_CONFIG_DIR.
  p_stripped="${p#.config/}"
  if [[ ${MAC_CONFIGS[$p_stripped]+_} ]]; then
    target_path="${MACOS_CONFIG_DIR}/${p_stripped}"
  else
    target_path="${HOME}/${p}"
  fi

  # Prompt the user for confirmation before linking
  read -p "Link $source_path -> $target_path? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then

    # Prompt the user for confirmation if the file already exists.
    if [[ -e $target_path ]]; then
      read -p "$target_path already exists. Replace it? (y/n) " -n 1 -r
      echo
      if ! [[ $REPLY =~ ^[Yy]$ ]]; then
        continue
      fi

      echo "Removing ${target_path}"
      rm -r "$target_path"
    fi

    echo "Linking $source_path -> $target_path"
    ln -s "$source_path" "$target_path"
    echo
  fi
done
