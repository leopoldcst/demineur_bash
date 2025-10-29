# 💣 Démineur Bash

> Un jeu de **démineur 100% en Bash**, jouable directement depuis le terminal avec les commandes Unix (`cat`, `ls`, etc.).  
> Pas d’interface graphique — seulement toi, ton terminal, et quelques bombes prêtes à exploser 💥.

---

## 🎯 Présentation

Le **Démineur Bash** est un mini-jeu rétro entièrement écrit en **scripts Shell**.  
Chaque **case** du plateau est un **fichier texte** (`A1`, `B2`, etc.) dans le dossier `carte/`.  
Certaines contiennent des **bombes**, d’autres un **chiffre** indiquant combien de bombes sont voisines.

🧠 Le but : ouvrir toutes les cases **sans tomber sur une bombe**.

---

## 🕹️ Commandes à utiliser

Tu joues avec les commandes Unix classiques :

| Action | Commande |
|---------|-----------|
| Voir la grille | `ls carte/` |
| Ouvrir une case | `cat carte/A3` |
| Vérifier si la partie est finie | `ls carte/TIMEUP` |
| Relancer une partie | `./lancer_jeu.sh` |
| Arrêter la surveillance | `pkill -f inotifywait` |

Exemple :

```bash
ls carte/
cat carte/B2

## ⚙️ Installation

### 1️⃣ Cloner le dépôt

Télécharge le projet depuis GitHub :

```bash
git clone https://github.com/leopoldcst/demineur_bash.git
cd demineur_bash
