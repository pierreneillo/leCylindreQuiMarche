## Mécaniques de jeu se basant sur la géométrie

- [G & P] Créer des puzzles pour chaque fin de zones de la map, utilisant les nouvelles mécaniques fondées sur la géométrie apprises dans la zone (et un puzzle vénère de fin de jeu utilisant tout), faire au moins un puzzle chacun.
- Accéder à chaque zones de la map grâce à des changements de volumes spécifiques qu'il faudrait débloquer

### [H?] Polymorphisme

Permettre au cylindre de changer de forme (ensemble de formes possibles limité / formes à débloquer au fur et à mesure du jeu), ex: cône, cylindre plus allongé / moins allongé

Ca pourrait permettre de déclencher des mécanismes:
- Rotation sur soi-même en changeant de forme en cours de rotation pour gagner de la vitesse et taper très fort sur quelque chose
- Passer des obstacles en utilisant le polymorphisme (ex: fente étroite demandant de rouler en forme cylindre moins allongé)
- Associer une forme et un objet pour obtenir une fonctionnalité supplémentaire, e.g. cône + chaîne ou  barbelé = foreuse
- Garder le même volume entre différentes formes au moins jusqu'à un certain point du jeu, puis débloquer une fonctionnalité permettant de changer de volume 
- Limites supérieures et inférieures au changement de taille/largeur, qui pourraient être dépassées (avec avertissement bien visible typiquement perso clignote en rouge) avec effets à réfléchir (par exemple, gros bonus à court terme mais impact négatif sur le reste de la partie, qui pourrait être compensé en effectuant une quête difficile)

### Faire rouler le cylindre

- [P] Possiblité d'alterner entre roulade (+ de vitesse, - maniable) et "marche" ou saut (comme un ressort) (cylindre à la verticale) (+ maniable, - de vitesse) (eventuellement une capacité à débloquer rapidement)
- [P] Possibilité d'augmenter la vitesse en roulade quand le cylindre est dans une pente
- [G] Ajouter de l'inertie

### Engrenages et mécanismes

- Utiliser la forme du cylindre pour activer des mécanismes, e.g. relier deux engrenages parallèles en plaçant le cylindre perpendiculaire à ceux-ci pour faire tourner l'un si l'autre tourne (un peu inspiré de zelda totk)
- Ajouter de la durabilité aux items qu'on peut merge (cf ma proposition pour interface: le nombre qu'on en a crée une barre de dura affichée dans la molette, qui permet de ne pas s'embêter à changer h24 d'items)
- Utiliser la forme du cylindre pour faire des puzzles (comme pour les boîtes pour les enfants avec des trous de différentes formes)

### Restreindre l'exploration du monde en débloquant des compétences au cours du jeu

Débloquer les polymorphismes, le saut, etc au cours du jeu

## Interface

- [G & P] Interface ou menu 2D (HUD) pour les pdv, inventaire, etc.
- [G] Switcher entre les formes avec Tab, et entre les objets avec molette

## [G & P] Storyline (à développer)

Eventuellement, idée d'une entité polymorphique qui a été restreinte au début (sort d'un ennemi ou truc du genre) à une forme de cylindre et doit regagner ses capacités polymorphiques au cours de la partie

## Mécaniques

Quêtes secondaires, dialogues simples avec des png

## [P] Musique de jeu

A réfléchir

## Monde

- [G & P] Réfléchir à comment la caméra suit le perso

### Map

- [P] height map
- textures adaptées
- [G] décor: arbres etc
- [à voir] décor lointain figé (ex: montagnes), eventuellement 2D, éventuellement sa "maison" ou sa contrée d'origine

## Langues
[P] Utiliser des fichiers .i18n pour avoir plusieurs langues (anglais et français)
