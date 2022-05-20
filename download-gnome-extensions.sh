if [ ! $1 ]; then
    echo 'insert download url' >&2
    exit 1
fi

#!/usr/bin/env bash

# Install a target gnome shell extension defined via url

set -euo pipefail

store_url=$1
extensions_path="$HOME/.local/share/gnome-shell/extensions"
zip="$PWD/gnome-extension.zip"


wget "$store_url" -O "$zip"


uuid=$(unzip -c "$zip" metadata.json | grep uuid | cut -d \" -f4)

if [[ ! -d "$extensions_path/$uuid" ]]; then
    mkdir -p "$extensions_path/$uuid"
    unzip -q "$zip" -d "$extensions_path/$uuid"
    # gnome-extensions enable $uuid
fi

killall -SIGQUIT gnome-shell 

sleep 3
gnome-extensions enable $uuid
