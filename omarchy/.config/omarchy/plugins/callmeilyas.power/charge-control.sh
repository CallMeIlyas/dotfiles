#!/usr/bin/env bash
BAT_DIR="/sys/class/power_supply/BAT0"

case "$1" in
  get)
    if [ -f "$BAT_DIR/charge_control_end_threshold" ]; then
      cat "$BAT_DIR/charge_control_end_threshold" 2>/dev/null || echo "100"
    elif [ -f "$BAT_DIR/charge_stop_threshold" ]; then
      cat "$BAT_DIR/charge_stop_threshold" 2>/dev/null || echo "100"
    else
      echo "100"
    fi
    ;;
  set)
    LIMIT="$2"
    if [ "$LIMIT" = "80" ]; then
      if [ -x "$HOME/.local/bin/omarchy-battery-mode" ]; then
        "$HOME/.local/bin/omarchy-battery-mode" home >/dev/null 2>&1
      else
        sudo sed -i "s/^START_CHARGE_THRESH_BAT0=.*/START_CHARGE_THRESH_BAT0=75/" /etc/tlp.conf 2>/dev/null
        sudo sed -i "s/^STOP_CHARGE_THRESH_BAT0=.*/STOP_CHARGE_THRESH_BAT0=80/" /etc/tlp.conf 2>/dev/null
        sudo tlp start >/dev/null 2>&1
      fi
    elif [ "$LIMIT" = "100" ]; then
      if [ -x "$HOME/.local/bin/omarchy-battery-mode" ]; then
        "$HOME/.local/bin/omarchy-battery-mode" travel >/dev/null 2>&1
      else
        sudo sed -i "s/^START_CHARGE_THRESH_BAT0=.*/START_CHARGE_THRESH_BAT0=95/" /etc/tlp.conf 2>/dev/null
        sudo sed -i "s/^STOP_CHARGE_THRESH_BAT0=.*/STOP_CHARGE_THRESH_BAT0=100/" /etc/tlp.conf 2>/dev/null
        sudo tlp start >/dev/null 2>&1
      fi
    fi
    ;;
esac
