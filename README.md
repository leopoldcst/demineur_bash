# 💣 Démineur Bash

> Un jeu de **démineur revisité 100% en Bash**, jouable directement depuis le terminal avec les commandes Unix (`cat`, `ls`, etc.). 

---

## 📏 But du jeu

Ouvre 5 cases (commande cat) sans bombe pour remporter la partie !
Mais attention ⚠️ : dans une grille de 25 cases, plusieurs bombes sont dissimulées...

À toi de déduire les cases sûres grâce aux indices d’adjacence : chaque case affiche le nombre de bombes dans ses 8 cases voisines.

## ⚙️ Comment installer le jeu ?

1. Clone le repo github
2. installer la bibliothèque inotify-tools (librairie qui permet une surveillance du système de fichiers)
> sudo apt install inotify-tools
3. Aller dans le dossier demineur_bash
4. Donner les droits d’exécution
> chmod +x *.sh
5. Tu es prêt à jouer 🎮

## Lancer une partie 

Dans le fichier demineur_bash, exécute la commande suivante : 
> ./lancer_jeu.sh

Cela lance automatiquement deux scripts de surveillance en arrière-plan :
* 💣 surveillance_bombe.sh : déclenche une défaite si tu ouvres une bombe
* 🏆 surveillance_victoire.sh : déclenche une victoire si tu ouvres 5 cases sûres


## 🕹️ Commandes à utiliser

Tu joues avec les commandes Unix classiques :

| Action | Commande |
|---------|-----------|
| Voir la grille | `ls carte/` |
| Ouvrir une case | `cat carte/A3` |
| Vérifier si la partie est perdue | `ls carte/TIMEUP` |
| Vérifier si la partie est gagnée | `ls carte/VICTORY` |
| Relancer une partie | `./lancer_jeu.sh` |
| Arrêter la surveillance | `pkill -f inotifywait` |
  



---
