# 🤖 Eval-Bot 
## Robot en assembleur Cortex M3

![image](https://github.com/Berachem/eval-bot/assets/61350744/61177575-62eb-4426-996d-c1c2628b6114)

## 📦 Structure du code
- __Bumper.s__
- __Leds.s__
- __Switch.s__
- __Moteur.s__

Enfin, le Maestro : __Main.s__

> Nous avons structurés notre code ainsi afin d'avoir quelque chose de maintenable, clair et le plus simple à utiliser.

## ✨Utilisation des registres
- R12 : Boutton pressoir 2 ⏺ <span style="color: yellow"> [COMPOSANT] </span>
- R11 : Boutton pressoir 1 ⏺ <span style="color: yellow"> [COMPOSANT] </span>
- R10 : LEDs 💡 <span style="color: yellow"> [COMPOSANT] </span>
- R9 : Bumper 1 🚧 <span style="color: yellow"> [COMPOSANT] </span>
- R8 : Bumper 2 🚧 <span style="color: yellow"> [COMPOSANT] </span>
- __R7 : LIBRE__  <span style="color: yellow"> [COMPOSANT] </span>
    - Si vous souhaitez enrichir ce projet en intégrant d'autres composants, ce registres est le mieux placé pour !  
- R6 : Moteur 🚗 <span style="color: yellow"> [COMPOSANT] </span>
- R5 : Comparaison 🧐 
    - là où on STR toutes les résultats des méthodes de read
- __R4 : LIBRE__
- __R3 : LIBRE__
- __R2 : LIBRE__
- __R1 : LIBRE__
- __R0 : LIBRE__


> Même si cela n'est pas obligatoire, nous avons attitré des registres afin de clarifier au mieux notre code et sa structuration. ✅

# TODO 🎈
- quand les deux bumpers sont touchés, demi-tour vers un côté...
- varier la vitesse (+ ou -)
- Utiliser les capteurs infrarouges des roues à la place d'un timer






