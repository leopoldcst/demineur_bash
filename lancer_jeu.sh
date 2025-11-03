#!/usr/bin/env bash
# lancer_jeu.sh — lance une nouvelle partie du démineur bash avec deux surveillances

set -euo pipefail
IFS=$'\n\t'

# 🔁 Nettoyage préalable
pkill -f "surveillance_bombe.sh" 2>/dev/null || true
pkill -f "surveillance_victoire.sh" 2>/dev/null || true
rm -f nohup.out surveillance.log victoire.log

# 🧹 Nettoyage avant nouvelle partie
echo "🧹 Nettoyage avant nouvelle partie..."
rm -f carte/TIMEUP carte/VICTORY 2>/dev/null || true
pkill -f inotifywait 2>/dev/null || true
sleep 0.5

# 1️⃣ Création des fichiers de jeu
echo "➡️  Génération de la grille et placement des bombes..."
./cree_bombe.sh

echo "➡️  Calcul des bombes voisines..."
./bombes_voisines.sh >/dev/null

# 3️⃣ Lancement des surveillances
SURV_LOG="surveillance.log"
VICTOIRE_LOG="victoire.log"
echo "➡️  Lancement des surveillances..."

if [[ "${1:-}" == "--verbose" ]]; then
  ./surveillance_bombe.sh &
  PID_BOMBE=$!
  ./surveillance_victoire.sh &
  PID_VICTOIRE=$!
else
  nohup ./surveillance.sh < /dev/null > "$SURV_LOG" 2>&1 &
  PID_BOMBE=$!
  nohup ./surveillance_victoire.sh < /dev/null > "$VICTOIRE_LOG" 2>&1 &
  PID_VICTOIRE=$!
fi

sleep 0.3

if ps -p "$PID_BOMBE" >/dev/null && ps -p "$PID_VICTOIRE" >/dev/null; then
  echo "👁️  Surveillance BOMBE lancée (PID: $PID_BOMBE) → $SURV_LOG"
  echo "👁️  Surveillance VICTOIRE lancée (PID: $PID_VICTOIRE) → $VICTOIRE_LOG"
else
  echo "⚠️  Échec du lancement de l'une des surveillances !"
  exit 1
fi


# 3️⃣ Instructions
echo ""
echo "=== JEU LANCÉ ==="
echo "Joue avec les commandes UNIX habituelles :"
echo "  ls carte"
echo "  cat carte/A1   # attention : si A1 contient une bombe -> fin de partie"
echo ""
echo "💣 Une bombe → création de carte/TIMEUP"
echo "🎯 5 cases sûres ouvertes → création de carte/VICTORY"
echo "🛑 Arrêt manuel possible avec :"
echo "    kill $PID_BOMBE $PID_VICTOIRE"
echo ""

