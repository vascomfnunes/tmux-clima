# Clima

![https://github.com/vascomfnunes/tmux-clima/blob/main/media/img/shot.png](https://github.com/vascomfnunes/tmux-clima/blob/main/media/img/shot.png)

**Clima (Esperanto for weather) is a simple plugin that displays the local
weather conditions and temperature in your Tmux status line.**

The location is obtained automatically using your IP address.

Results are cached in `~/.tmux-clima` for 15 minutes by default.

Currently, it only supports Celsius degrees.

## Requirements

### OpenWeatherMap API key

The weather information is provided by
[OpenWeatherMap](https://openweathermap.org/). To use this plugin you need a
valid OpenWeather API key that can be request
[here](https://openweathermap.org/api).

An environment variable named `OPEN_WEATHER_API_KEY` with the API key value
should be exported to use this plugin:

```bash
export OPEN_WEATHER_API_KEY="[API-KEY-VALUE]"
```

You can add this to your shell configuration or source it from any other file.

### Other dependencies

Make sure you have [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
and [jq](https://stedolan.github.io/jq/download/) installed.

Also, keep in mind that to correctly display the weather conditions
icons you will need to use a patched [Nerd Font](https://www.nerdfonts.com/)

## Install

Then add the plugin to your `~/.tmux.conf`:

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

## Configuration

### Time-to-live (TTL)

This plugin caches the weather by default for 15 minutes. You can set any other
TTL value (in seconds) using the option:

```
set -g @clima_ttl <value_in_seconds>
```

## License

This plugin is licensed under the MIT license. For more information please refer
to the [LICENSE](https://github.com/vascomfnunes/tmux-clima/blob/main/LICENSE) file.
