#!/usr/bin/env bash
# bombes_voisines.sh — calcule les bombes voisines et met à jour les cases non-bombes

set -euo pipefail
IFS=$'\n\t'

DIR="carte"
LETTERS=(A B C D E)
SIZE=5

[[ -d "$DIR" ]] || { echo "❌ Dossier '$DIR' introuvable."; exit 1; }

# Génère la liste des coordonnées
coords=()
for L in "${LETTERS[@]}"; do
  for ((c=1; c<=SIZE; c++)); do
    coords+=("${L}${c}")
  done
done

# Détection des bombes
declare -A is_bomb
for cell in "${coords[@]}"; do
  file="$DIR/$cell"
  [[ -f "$file" ]] || continue
  if grep -q "BOMBE" "$file"; then
    is_bomb["$cell"]=1
  fi
done

# Calcul des voisines
set +e
for cell in "${coords[@]}"; do
  file="$DIR/$cell"
  [[ -f "$file" ]] || continue
  [[ "${is_bomb[$cell]:-0}" -eq 1 ]] && continue

  row_letter=${cell:0:1}
  col_num=${cell:1}
  row_index=-1
  for i in "${!LETTERS[@]}"; do
    [[ "${LETTERS[$i]}" == "$row_letter" ]] && row_index=$i && break
  done

  count=0
  for dr in -1 0 1; do
    for dc in -1 0 1; do
      [[ $dr -eq 0 && $dc -eq 0 ]] && continue
      nr=$((row_index + dr))
      nc=$((col_num + dc))
      if (( nr >= 0 && nr < SIZE && nc >= 1 && nc <= SIZE )); then
        ncell="${LETTERS[nr]}${nc}"
        if [[ "${is_bomb[$ncell]:-0}" -eq 1 ]]; then
          ((count++))
        fi
      fi
    done
  done

  echo "$count" > "$file"
done
set -e

