# 🤖 Eval-Bot 
## Robot en assembleur Cortex M3

![image](https://github.com/Berachem/eval-bot/assets/61350744/c3f507bb-f960-4ace-9e5d-8f322fcee9cd)


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
- R4 : Compteur de collision restantes avant de Forcer
- __R3 : LIBRE__
- __R2 : LIBRE__
- __R1 : LIBRE__
- __R0 : LIBRE__


> Même si cela n'est pas obligatoire, nous avons attitré des registres afin de clarifier au mieux notre code et sa structuration. ✅

# Logigramme

![_Logigramme GIG-Bot](https://github.com/Berachem/eval-bot/assets/61350744/42fb13c4-5dab-47af-a2d3-a5b9db2beebb)




# TODO 🎈
- Logigramme & Pseudo-code
- Rapport et Présentation (groupe 2)






