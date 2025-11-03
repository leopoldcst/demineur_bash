#!/usr/bin/env bash
# cree_bombe.sh — crée 25 fichiers (5x5) et y place aléatoirement 4 à 7 bombes

set -euo pipefail
IFS=$'\n\t'

DIR="carte"
LETTERS=(A B C D E)
SIZE=5

# Supprime et recrée le dossier
rm -rf "$DIR"
mkdir -p "$DIR"

# Génère les 25 fichiers
coords=()
for L in "${LETTERS[@]}"; do
  for ((c=1; c<=SIZE; c++)); do
    coords+=("${L}${c}")
    echo "?" > "$DIR/${L}${c}"
  done
done

# Tire entre 4 et 7 bombes aléatoires
num_bombs=$((4 + RANDOM % 4))
bomb_cells=($(shuf -e "${coords[@]}" | head -n "$num_bombs"))

# Place les bombes
for b in "${bomb_cells[@]}"; do
  echo "💣 BOMBE" > "$DIR/$b"
done

