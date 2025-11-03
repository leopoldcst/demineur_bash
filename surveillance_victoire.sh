#!/usr/bin/env bash
# surveillance_victoire.sh — détection de la victoire après ouverture de 5 cases sûres

set -euo pipefail
IFS=$'\n\t'

DIR="carte"
VICTORY_FILE="$DIR/VICTORY"
COUNT_FILE="/tmp/compteur_victoire"

# 🔄 Nettoyage
rm -f "$VICTORY_FILE" "$COUNT_FILE"
touch "$COUNT_FILE"

echo "👁️  [VIC] Surveillance active des ouvertures saines (objectif : 5 cases)..."

inotifywait -m -e open -e access --format '%w%f' "$DIR" < /dev/null | while read -r file; do
  [[ -f "$file" ]] || continue

  # On ignore si c’est une bombe
  if grep -q "BOMBE" "$file" 2>/dev/null; then
    continue
  fi

  # On ignore si déjà compté
  if grep -Fxq "$file" "$COUNT_FILE"; then
    continue
  fi

  # ✅ Nouvelle case sûre ouverte
  echo "$file" >> "$COUNT_FILE"
  nb=$(wc -l < "$COUNT_FILE")
  echo "🧮 [VIC] $nb case(s) sûre(s) ouverte(s)"

  if [[ "$nb" -ge 5 ]]; then
    echo "🎉 [VIC] 5 cases sûres ouvertes — VICTOIRE !"
    echo "🏆 VICTORY" > "$VICTORY_FILE"
    break
  fi
done

# 🔚 Fin propre
pkill -f "surveillance_victoire.sh" 2>/dev/null || true

