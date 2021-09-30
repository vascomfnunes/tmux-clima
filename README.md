# Clima

**Clima (Esperanto for weather) is a simple plugin that displays the local
weather conditions and temperature in your Tmux status line.**

The location is obtained automatically using your IP address.

Results are cached in `~/.tmux-clima` for 15 minutes by default.

Currently only displays the temperature in Celsius degrees.

## Requirements

### OpenWeatherMap API key

The weather information is provided by
[OpenWeatherMap](https://openweathermap.org/) and to use this plugin you need a
valid OpenWeather API key that can be request
[here](https://openweathermap.org/api).

An environment variable named `OPEN_WEATHER_API_KEY` with the API key value
should be exported in order to use this plugin:

```bash
export OPEN_WEATHER_API_KEY="[API-KEY-VALUE]"
```

You can add this to your shell configuration or source it from any other file.

### Other dependencies

Make sure you have [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
and [jq](https://stedolan.github.io/jq/download/) installed.

Also keep in mind that in order to correctly display the weather conditions
icons you will need to use a patched [Nerd Font](https://www.nerdfonts.com/)

## Install

Then add the plugin to `~/.tmux.conf`:

```tmux
set -g @plugin 'vascomfnunes/tmux-clima'
```

Load the plugin with `prefix + I`.

## Usage

You can add `#{clima}` to your status line configuration if it already exists.

For example:

```tmux
set -g status-right "#{clima}"
```

## License

This plugin is licensed under the MIT license. For more information please refer
to the [LICENSE](https://github.com/vascomfnunes/tmux-clima/LICENSE) file.
