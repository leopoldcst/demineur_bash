#!/usr/bin/env bash
# surveillance.sh — détecte l'ouverture d'une bombe dans 'carte'

set -euo pipefail
IFS=$'\n\t'

DIR="carte"
TIMEUP_FILE="$DIR/TIMEUP"

echo "👁️  Surveillance active sur '$DIR' (événements: open, access)."
echo "   Si un fichier BOMBE est lu (cat/less/...), la partie sera terminée."

# Surveillance continue — un seul inotifywait, stable
inotifywait -m -e open -e access --format '%w%f' "$DIR" < /dev/null | while read -r file; do
  [[ -f "$file" ]] || continue

  if grep -q "BOMBE" "$file" 2>/dev/null; then
    echo "💥 BOOM ! Le fichier '$file' a été ouvert et contient une BOMBE."
    echo "    Fin de partie : création de '$TIMEUP_FILE'."
    echo "💀 GAME OVER 💀" > "$TIMEUP_FILE"

    # Termine toutes les instances de surveillance
    pkill -f "surveillance.sh" 2>/dev/null || true
    exit 0
  fi
done

