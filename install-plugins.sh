#!/usr/bin/env bash
set -euo pipefail

# Third-party Omarchy plugins used in this setup
omarchy plugin add https://github.com/SirJul1337/omarchy-lock-explorer.git --enable
omarchy plugin add https://github.com/ah410/omarchy-islamic-prayer-times.git --enable
omarchy plugin add https://github.com/BibekBhusal0/omarchy-focusd.git --enable
omarchy plugin add https://github.com/Woogy7/omarchy-vitals.git --enable
omarchy plugin add https://github.com/MrDemonc/Omarchy-media-control.git --enable
omarchy plugin add https://github.com/FlipZ3ro/screenhub.git --enable
omarchy plugin add https://github.com/alvmarrod/omarchy-kanji-of-the-day.git --enable
# Optional (disabled by default in shell.json)
omarchy plugin add https://github.com/unleashed-nick/omarchy-tempest.git
