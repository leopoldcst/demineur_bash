#!/usr/bin/env bash
# create_cartes.sh
# Crée un dossier "carte" contenant 25 fichiers (A1 à E5)

set -e

# Nom du dossier
DIR="carte"

# Nettoyer l'ancien dossier s'il existe
rm -rf "$DIR"
mkdir -p "$DIR"

# Lettres de A à E (5 lignes)
LETTERS=(A B C D E)

# Générer les fichiers A1..E5
for letter in "${LETTERS[@]}"; do
  for ((num=1; num<=5; num++)); do
    touch "$DIR/${letter}${num}"
  done
done

echo "✅ 25 fichiers créés dans le dossier '$DIR/'"

