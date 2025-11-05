# 💣 Démineur Bash

> Un jeu de **démineur revisité 100% en Bash**, jouable directement depuis le terminal avec les commandes Unix (`cat`, `ls`, etc.). 

---

## 📁 Structure du dossier

- `carte/` : la grille générée à chaque partie
- `cree_bombe.sh` : génère la grille et place les bombes
- `bombes_voisines.sh` : calcule les bombes voisines
- `surveillance.sh` : détecte si une bombe est ouverte
- `surveillance_victoire.sh` : détecte 5 ouvertures saines
- `lancer_jeu.sh` : script principal pour démarrer une partie


## 📏 But du jeu

Ouvrir 5 cases (commande cat) sans bombe pour remporter la partie !
Mais attention ⚠️ : dans une grille de 25 cases, plusieurs bombes sont dissimulées...

À toi de déduire les cases sûres grâce aux indices d’adjacence : chaque case affiche le nombre de bombes dans ses 8 cases voisines.

## ⚙️ Comment installer le jeu ?

1. Clone le repo github
2. Installe la bibliothèque `inotify-tools` (utile pour surveiller les fichiers ouverts en temps réel)
```bash
sudo apt install inotify-tools
```
3. Aller dans le dossier demineur_bash
4. Donner les droits d’exécution
```bash
chmod +x *
```
5. Tu es prêt à jouer 🎮

## Lancer une partie 

Dans le fichier demineur_bash, exécute la commande suivante : 
```bash
./lancer_jeu.sh
```

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

## 🎯 Fin de partie

- Si tu ouvres **5 cases sûres** → le fichier `carte/VICTORY` est créé ✅  
- Si tu ouvres **une bombe** → le fichier `carte/TIMEUP` est créé ❌

Tu peux aussi **surveiller les logs** pour voir la partie évoluer en direct :

```bash
tail -f victoire.log        # Affiche les ouvertures sûres
tail -f surveillance.log    # Affiche l'ouverture d'une bombe (si déclenchée)
```

## 📈 Améliorations possibles

- Créer un script `afficher_grille` pour afficher visuellement la grille en 5x5 dans le terminal.
    - Option : renommer temporairement tous les fichiers contenant simplement `0` en `0` (sans extension), pour faciliter un affichage lisible (via `ls`, `column`, etc.).
- Ajouter un **timer** pour complexifier le jeu.
- Générer des grilles plus grandes (10x10, 15x15…) avec difficulté croissante.


---

