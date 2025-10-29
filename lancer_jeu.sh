#!/usr/bin/env bash
# lancer_jeu.sh — lance une nouvelle partie du démineur bash

set -euo pipefail
IFS=$'\n\t'

# 🧹 Nettoyage avant nouvelle partie
echo "🧹 Nettoyage avant nouvelle partie..."
rm -f carte/TIMEUP 2>/dev/null || true
pkill -f inotifywait 2>/dev/null || true
sleep 0.5

# 1️⃣ Génération de la grille et placement des bombes
echo "➡️  Génération de la grille et placement des bombes..."
./cree_bombe.sh >/dev/null

# 2️⃣ Calcul des bombes voisines
echo "➡️  Calcul des bombes voisines..."
./bombes_voisines.sh >/dev/null

# 3️⃣ Lancement de la surveillance
SURV_LOG="surveillance.log"
echo "➡️  Lancement de la surveillance en arrière-plan (nohup -> $SURV_LOG)..."

nohup ./surveillance.sh < /dev/null > >(tee -a "$SURV_LOG") 2>&1 &
SURV_PID=$!
sleep 0.3

if ps -p "$SURV_PID" >/dev/null 2>&1; then
  echo "👁️  Surveillance lancée (PID: $SURV_PID). Log: $SURV_LOG"
else
  echo "⚠️  Échec du lancement de la surveillance !"
  exit 1
fi

# 4️⃣ Si option --follow, suivre le log
if [[ "${1:-}" == "--follow" ]]; then
  echo ""
  echo "📜 Suivi du log en direct (Ctrl-C pour revenir au jeu) :"
  tail -f "$SURV_LOG"
  exit 0
fi

# 5️⃣ Instructions pour le joueur
echo ""
echo "=== JEU LANCÉ ==="
echo "Joue avec les commandes UNIX habituelles :"
echo "  ls carte"
echo "  cat carte/A1   # attention : si A1 contient une bombe -> fin de partie"
echo ""
echo "💣 Si tu ouvres une bombe → le fichier carte/TIMEUP sera créé automatiquement."
echo "🛑 Pour stopper manuellement : kill $SURV_PID"
echo ""

