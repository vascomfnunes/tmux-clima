#!/usr/bin/env bash

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CWD/tmux.sh"
source "$CWD/icons.sh"

# Weather data reference: http://openweathermap.org/weather-conditions

TTL=$(get_tmux_option @clima_ttl 900)
UNIT=$(get_tmux_option @clima_unit "metric")
SHOW_ICON=$(get_tmux_option @clima_show_icon 1)
SHOW_LOCATION=$(get_tmux_option @clima_show_location 1)

clima() {
	NOW=$(date +%s)
	LAST_UPDATE_TIME=$(get_tmux_option "@clima_last_update_time")
	MOD=$((NOW - LAST_UPDATE_TIME))
	SYMBOL=$(symbol "$UNIT")
	if [ -z "$LAST_UPDATE_TIME" ] || [ "$MOD" -ge "$TTL" ]; then
		LOCATION=$(curl --silent https://ifconfig.co/json)
		LAT=$(echo "$LOCATION" | jq .latitude)
		LON=$(echo "$LOCATION" | jq .longitude)
		WEATHER=$(curl --silent http://api.openweathermap.org/data/2.5/weather\?lat="$LAT"\&lon="$LON"\&APPID="$OPEN_WEATHER_API_KEY"\&units="$UNIT")
		if [ "$?" -eq 0 ]; then
			CATEGORY=$(echo "$WEATHER" | jq .weather[0].id)
			TEMP="$(echo "$WEATHER" | jq .main.temp | cut -d . -f 1)$SYMBOL"
			ICON="$(icon "$CATEGORY")"
			CITY="$(echo "$LOCATION" | jq -r .city)"
			COUNTRY="$(echo "$LOCATION" | jq -r .country)"
			DESCRIPTION="$(echo "$WEATHER" | jq -r .weather[0].main)"
			FEELS_LIKE="Feels like: $(echo "$WEATHER" | jq .main.feels_like | cut -d . -f 1)$SYMBOL"
			WIND_SPEED="Wind speed: $(echo "$WEATHER" | jq .wind.speed) m/s"
			CLIMA=""

			if [ "$SHOW_LOCATION" == 1 ]; then
				CLIMA="$CLIMA$CITY, "
			fi

			if [ "$SHOW_ICON" == 1 ]; then
				CLIMA="$CLIMA$ICON"
			fi

			CLIMA="$CLIMA $TEMP"
			CLIMA_DETAILS="${CITY}, ${COUNTRY}: ${ICON} ${TEMP}, ${DESCRIPTION}, ${FEELS_LIKE}, ${WIND_SPEED}"

			set_tmux_option "@clima_last_update_time" "$NOW"
			set_tmux_option "@clima_current_value" "$CLIMA"
			set_tmux_option "@clima_details_value" "$CLIMA_DETAILS"
		fi
	fi

	echo -n "$(get_tmux_option "@clima_current_value")"
}

clima
