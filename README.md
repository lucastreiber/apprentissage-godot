# apprentissage-godot

Petit projet de **plateformer 2D** réalisé avec **Godot 4.7** pour apprendre le moteur.

> ⚠️ **Projet d'apprentissage** : il n'a pas vocation à être continué ni à devenir un vrai jeu. Il sert surtout de terrain d'expérimentation et de trace de ce que j'ai appris.

## Contenu du jeu

- **Un personnage jouable** : déplacement, saut, course et attaque.
- **Des slimes ennemis** qui te tuent au contact.
- **Une passerelle mobile** qui se déplace toute seule.
- **Un PNJ dans une tour** : il te parle, déclenche une petite **cinématique scriptée par code**, puis te dit une dernière phrase. Fin de la démo.
- **Menu** : Menu principale avec un bouton jouer, quitter et option (qui ne fait rien).

## Structure du projet

```
├── addons/
│   └── dialogue_manager/   # Plugin de dialogues (Dialogue Manager)
├── assets/                 # Sprites, sons et autres ressources
├── dialogue/               # Fichiers de dialogues (.dialogue)
├── scenes/                 # Scènes Godot (joueur, ennemis, niveau, bulle de dialogue…)
├── scripts/                # Scripts GDScript
├── icon.svg
└── project.godot
```

## Ce que ce projet m'a fait pratiquer

- Mouvement d'un personnage 2D (`CharacterBody2D`), saut, course, attaque
- Ennemis simples et gestion de la mort du joueur
- Couches de collision : `Terrain`, `Player`, `Enemy`
- Plateforme mobile automatique
- Système de dialogues avec le plugin **Dialogue Manager**
- Cinématique scriptée en code
- Gestion des scènes 

## Crédits

- [Dialogue Manager](https://github.com/nathanhoad/godot_dialogue_manager) par Nathan Hoad (plugin tiers, licence MIT).
