Définit le comportement dans la sandbox

## Prise en main des commandes

Tuto en HUD (mvt caméra + mvt perso)

## Déblocage d'un morph

Interaction avec un objet => Déblocage du morph cylindre couché => tuto pour tab

## Interaction avec un perso

Perso:
Nom: Tarik


Dialogue initial:

C : Bonjour!
T: Salutations, comment t'appelles-tu?
C : [input nom]
T : Dis-moi [nom], qu'est-ce qui t'amène en ces lieux?
C : ...
T: Je vois...
T : Ta condition physique me semble peu adaptée pour certaines de nos contrées, il te faudra aussi remédier à cela.
T : Es-tu familer avec nos coutumes?
C :
- Oui
- Non
Si non:
	T : Les habitants du pays aiment se poser mutuellement des énigmes, il te faudra sûrement en résoudre au cours de ton périple.
	T : Tu verras, parfois les choses ne marchent pas, ne fonctionnent pas, ne te décourage pas et fais tourner tes méninges, je suis persuadé que tu y arriveras.
	T : Je t'ai préparé une petite énigme à résoudre, reviens me voir quand tu auras terminé
Si oui:
	T : Très bien, je t'ai préparé une petite énigme à résoudre, reviens me voir quand tu auras terminé



Si il revient sans l'avoir fait:
T : Va donc résoudre mon énigme.
C:
	- J'ai besoin d'indices
		T : Peut-être peux-tu utiliser ta compétence nouvellement acquise TODO: changer le dialogue s'il n'a pas acquis la compétence
	- Dis-m'en plus sur vos coutumes
		T : Les habitants du pays aiment se poser mutuellement des énigmes, il te faudra sûrement en résoudre au cours de ton périple.
		T : Tu verras, parfois les choses ne marchent pas, ne fonctionnent pas, ne te décourage pas et fais tourner tes méninges, je suis persuadé que tu y arriveras.
	- Très bien => fin dialogue

Si il revient en l'ayant fait:
T : Bravo! Tu es maintenant prêt pour braver les dangers de notre monde

Si il revient encore:
T : Va donc explorer le monde

## Puzzle (très) simple

Descente avec un truc à casser au bout (rouler assez vite pour le casser)
