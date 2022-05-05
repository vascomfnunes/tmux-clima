#!/usr/bin/env bash

show_details() {
	WEATHER_DETAILS=/tmp/tmux_clima_details
	tmux display-message "$(cat "$WEATHER_DETAILS")"
}
