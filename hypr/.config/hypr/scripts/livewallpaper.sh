#!/usr/bin/env bash
# Live wallpaper helper for Hyprland using mpvpaper

DEFAULT_VIDEO="$HOME/Downloads/livewallpaper.mp4"
OUTPUT="${MPVPAPER_OUTPUT:-*}"

start() {
    local video="${1:-$DEFAULT_VIDEO}"
    if [[ ! -f "$video" ]]; then
        echo "Error: Video not found at $video" >&2
        return 1
    fi

    # Stop any existing mpvpaper process or systemd unit
    systemctl --user stop mpvpaper 2>/dev/null || true
    killall mpvpaper 2>/dev/null || true
    sleep 0.3

    # Launch mpvpaper via systemd-run or nohup for reliability
    if command -v systemd-run >/dev/null 2>&1; then
        systemd-run --user --unit=mpvpaper mpvpaper -p -o "no-audio loop-file=inf hwdec=auto" "$OUTPUT" "$video"
    else
        nohup mpvpaper -p -o "no-audio loop-file=inf hwdec=auto" "$OUTPUT" "$video" > /dev/null 2>&1 &
    fi
}

stop() {
    systemctl --user stop mpvpaper 2>/dev/null || true
    killall mpvpaper 2>/dev/null || true
}

toggle() {
    if pgrep -x mpvpaper >/dev/null || systemctl --user is-active --quiet mpvpaper; then
        stop
    else
        start "$1"
    fi
}

case "$1" in
    stop)
        stop
        ;;
    restart)
        shift
        start "$@"
        ;;
    toggle)
        shift
        toggle "$@"
        ;;
    status)
        if systemctl --user is-active --quiet mpvpaper 2>/dev/null || pgrep -x mpvpaper >/dev/null; then
            echo "Live wallpaper is running."
        else
            echo "Live wallpaper is stopped."
        fi
        ;;
    start)
        shift
        start "$@"
        ;;
    *)
        if [[ -n "$1" && -f "$1" ]]; then
            start "$1"
        else
            start "$DEFAULT_VIDEO"
        fi
        ;;
esac
