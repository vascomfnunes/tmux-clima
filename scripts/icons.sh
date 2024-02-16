#!/usr/bin/env bash

NERD_FONT=$(get_tmux_option @clima_use_nerd_font 0)

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
            [[ $NERD_FONT == 1 ]] && echo ' ' || echo '🌩 '
            ;;
            # Drizzle group
        300 | 301 | 302 | 310 | 311 | 312 | 313 | 314 | 321)
            [[ $NERD_FONT == 1 ]] && echo ' ' || echo '🌧 '

            ;;
            # Rain group
        500 | 501 | 502 | 503 | 504)
            [[ $NERD_FONT == 1 ]] && echo ' ' || echo '🌦 '
            ;;
        511)
            [[ $NERD_FONT == 1 ]] && echo ' ' || echo '❄ '
            ;;
        520 | 521 | 522 | 531)
            [[ $NERD_FONT == 1 ]] && echo ' ' || echo '🌧'
            ;;
            # Snow group
        600 | 601 | 602)
            [[ $NERD_FONT == 1 ]] && echo ' ' || echo '❄ '
            ;;
        611 | 612 | 613 | 615 | 616 | 620 | 621 | 622)
            [[ $NERD_FONT == 1 ]] && echo ' ' || echo '🌨 '
            ;;
            # Atmosphere group
        701 | 711 | 721 | 731 | 751 | 761 | 762 | 771)
            [[ $NERD_FONT == 1 ]] && echo ' ' || echo '  '
            ;;
        741)
            [[ $NERD_FONT == 1 ]] && echo ' ' || echo '🌫 '
            ;;
        781)
            [[ $NERD_FONT == 1 ]] && echo ' ' || echo '🌪 '
            ;;
            # Clear group
        800)
            [[ $NERD_FONT == 1 ]] && echo ' ' || echo '☼ '
            ;;
            # Clouds group
        801)
            [[ $NERD_FONT == 1 ]] && echo ' ' || echo '🌤 '
            ;;
        802 | 804)
            [[ $NERD_FONT == 1 ]] && echo ' ' || echo '☁ '
            ;;
        803)
            [[ $NERD_FONT == 1 ]] && echo ' ' || echo '🌥 '
            ;;
        *)
            echo "$1"
            ;;
    esac
}
