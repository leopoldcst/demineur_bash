#!/usr/bin/env bash
# lancer_jeu.sh — lance une nouvelle partie du démineur bash avec deux surveillances

set -euo pipefail
IFS=$'\n\t'

# 🔁 Nettoyage préalable
pkill -f "surveillance_bombe.sh" 2>/dev/null || true
pkill -f "surveillance_victoire.sh" 2>/dev/null || true
rm -f nohup.out surveillance.log victoire.log

# 🧹 Nettoyage avant nouvelle partie
echo "// Nettoyage //"
rm -f carte/TIMEUP carte/VICTORY 2>/dev/null || true
pkill -f inotifywait 2>/dev/null || true
sleep 0.5

# 1️⃣ Création des fichiers de jeu
echo "➡️  Génération de la grille et placement des bombes..."
./cree_bombe.sh

echo "➡️  Calcul des bombes voisines..."
./bombes_voisines.sh >/dev/null

# 2️⃣ Lancement des surveillances
echo "➡️  Lancement des surveillances..."

nohup ./surveillance.sh < /dev/null > surveillance.log 2>&1 &
BOMBE_PID=$!

nohup ./surveillance_victoire.sh < /dev/null > victoire.log 2>&1 &
VICTOIRE_PID=$!

sleep 0.3



# 3️⃣ Instructions
echo ""
echo "=== JEU LANCÉ ==="
echo ""

