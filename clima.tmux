#!/usr/bin/env bash

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CWD/scripts/tmux.sh"

weather_script="#($CWD/scripts/clima.sh)"
weather_tag="\#{clima}"

interpolate() {
	local interpolated="$1"
	local interpolated="${interpolated/$weather_tag/$weather_script}"
	echo "$interpolated"
}

main() {
	set_tmux_option "status-right"
	tmux bind-key -T prefix W run -b "source $CWD/scripts/details.sh && show_details"
}

main
