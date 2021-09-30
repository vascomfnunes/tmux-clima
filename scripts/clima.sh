#!/usr/bin/env bash

# Weather data reference: http://openweathermap.org/weather-conditions
icon() {
    case $1 in
        # Thunderstorm group
        200|201|202|210|211|212|221|230|231|232) echo '  '
            ;;
        # Drizzle group
        300|301|302|310|311|312|313|314|321) echo '  '
            ;;
        # Rain group
        500|501|502|503|504) echo '  '
            ;;
        511) echo '  '
            ;;
        520|521|522|531) echo '  '
            ;;
        # Snow group
        600|601|602) echo '  '
            ;;
        611|612|613|615|616|620|621|622) echo '  '
            ;;
        # Atmosphere group
        701|711|721|731|741|751|761|762|771|781) echo '  '
            ;;
        # Clear group
        800) echo '  '
            ;;
        # Clouds group
        801) echo '  '
            ;;
        802) echo '  '
            ;;
        803) echo '  '
            ;;
        804) echo '  '
            ;;
        *) echo "$1"
    esac
}

cache_file=~/.tmux-clima
cache_ttl=900

if [[ -f "$cache_file" ]]; then
    local NOW=$(date +%s)
    local MOD=$(date -r "$cache_file" +%s)
    if [[ $(( $NOW - $MOD )) -gt $cache_ttl ]]; then
        rm "$cache_file"
    fi
fi

if [[ ! -f "$cache_file" ]]; then
    LOCATION=$(curl --silent http://ip-api.com/csv)
    LAT=$(echo "$LOCATION" | cut -d , -f 8)
    LON=$(echo "$LOCATION" | cut -d , -f 9)
    WEATHER=$(curl --silent http://api.openweathermap.org/data/2.5/weather\?lat="$LAT"\&lon="$LON"\&APPID="$OPEN_WEATHER_API_KEY"\&units=metric)
    CATEGORY=$(echo "$WEATHER" | jq .weather[0].id)
    TEMP="$(echo "$WEATHER" | jq .main.temp | cut -d . -f 1)°C"
    ICON=$(icon "$CATEGORY")

    echo "${ICON} ${TEMP}" >"$cache_file"
fi

cat "$cache_file"
