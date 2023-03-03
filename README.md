# Clima

![https://github.com/vascomfnunes/tmux-clima/blob/main/media/img/shot.png](https://github.com/vascomfnunes/tmux-clima/blob/main/media/img/shot.png)

**Clima (Esperanto for weather) is a simple plugin that displays the local
weather conditions and temperature in your Tmux status line.**

The location is obtained automatically using your IP address.

Results are cached for 15 minutes by default.

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

Current weather details can be visualized using `prefix + W`, which will display
a standard tmux message with additional weather details:

![https://github.com/vascomfnunes/tmux-clima/blob/main/media/img/details.png](https://github.com/vascomfnunes/tmux-clima/blob/main/media/img/details.png)

## Configuration

### Time-to-live (TTL)

This plugin caches the weather by default for 15 minutes. You can set any other
TTL value (in minutes) using the option:

```bash
set -g @clima_ttl <value_in_minutes>
```

### Unit

Weather temperature unit can be configured through following option (default is 'metric')

```bash
set -g @clima_unit <metric | imperial | kelvin>
```

### Location

You can choose not to show the location in the statusbar with the following
option:

```bash
set -g @clima_show_location 0
```

By default it always show the location in the statusbar.

### Icons

You can choose not to show the weather condition icon in the statusbar with the
following option:

```bash
set -g @clima_show_icon 0
```

By default it always show the icon in the statusbar.

#### Nerd Fonts

Icons are displayed by default using unicode symbols. If you are using a patched
[Nerd Font](https://www.nerdfonts.com/) and prefer to use Nerd Icons:

```bash
set -g @clima_use_nerd_font 1
```

## License

This plugin is licensed under the MIT license. For more information please refer
to the [LICENSE](https://github.com/vascomfnunes/tmux-clima/blob/main/LICENSE) file.
