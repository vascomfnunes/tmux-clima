#!/usr/bin/env bash

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CWD/tmux.sh"

# Weather data reference: http://openweathermap.org/weather-conditions

TTL=$(get_tmux_option @clima_ttl 900)
UNIT=$(get_tmux_option @clima_unit "metric")

symbol() {
    case $1 in
        metric)
            echo '℃'
            ;;
        imperial)
            echo '℉'
            ;;
        kelvin)
            echo ' K'
            ;;
        *)
            echo '℃'
            ;;
    esac
}

icon() {
    case $1 in
            # Thunderstorm group
        200 | 201 | 202 | 210 | 211 | 212 | 221 | 230 | 231 | 232)
            echo '🌩'
            ;;
            # Drizzle group
        300 | 301 | 302 | 310 | 311 | 312 | 313 | 314 | 321)
            echo '🌧'
            ;;
            # Rain group
        500 | 501 | 502 | 503 | 504)
            echo '🌦'
            ;;
        511)
            echo '❄'
            ;;
        520 | 521 | 522 | 531)
            echo '🌧'
            ;;
            # Snow group
        600 | 601 | 602)
            echo '❄'
            ;;
        611 | 612 | 613 | 615 | 616 | 620 | 621 | 622)
            echo '🌨'
            ;;
            # Atmosphere group
        701 | 711 | 721 | 731 | 751 | 761 | 762 | 771)
            echo ' '
            ;;
        741)
            echo '🌫'
            ;;
        781)
            echo '🌪'
            ;;
            # Clear group
        800)
            echo '☀ '
            ;;
            # Clouds group
        801)
            echo '🌤'
            ;;
        802)
            echo '⛅️'
            ;;
        803)
            echo '🌥'
            ;;
        804)
            echo '☁ '
            ;;
        *) echo "$1"
            ;;
    esac
}

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
            ICON=$(icon "$CATEGORY")
            CITY="$(echo "$LOCATION" | jq -r .city)"
            COUNTRY="$(echo "$LOCATION" | jq -r .country)"
            DESCRIPTION="$(echo "$WEATHER" | jq -r .weather[0].main)"
            FEELS_LIKE="Feels like: $(echo "$WEATHER" | jq .main.feels_like | cut -d . -f 1)$SYMBOL"
            WIND_SPEED="Wind speed: $(echo "$WEATHER" | jq .wind.speed) m/s"
            CLIMA="${CITY}: ${ICON} ${TEMP}"
            CLIMA_DETAILS="${CITY}, ${COUNTRY}: ${ICON} ${TEMP}, ${DESCRIPTION}, ${FEELS_LIKE}, ${WIND_SPEED}"

            set_tmux_option "@clima_last_update_time" "$NOW"
            set_tmux_option "@clima_current_value" "$CLIMA"
            set_tmux_option "@clima_details_value" "$CLIMA_DETAILS"
        fi
    fi

    echo -n "$(get_tmux_option "@clima_current_value")"
}

clima
