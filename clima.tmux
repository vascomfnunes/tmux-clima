#!/usr/bin/env bash

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CWD/scripts/tmux.sh"

weather_script="#($CWD/scripts/clima.sh)"
weather_tag="\#{clima}"

interpolate() {
    local option="$1"
    local value
    value="$(get_tmux_option "$option")"
    local interpolated="${value/$weather_tag/$weather_script}"
    set_tmux_option "$option" "$interpolated"
}

main() {
    interpolate "status-right"
    tmux bind-key -T prefix W show-options -gqv @clima_details_value
}

main
