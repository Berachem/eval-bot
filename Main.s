		AREA    |.text|, CODE, READONLY
		ENTRY
		EXPORT	__main
	
		IMPORT	MOTEUR_INIT					; initialise les moteurs (configure les pwms + GPIO)
		
		IMPORT	MOTEUR_DROIT_ON				; activer le moteur droit
		IMPORT  MOTEUR_DROIT_OFF			; déactiver le moteur droit
		IMPORT  MOTEUR_DROIT_AVANT			; moteur droit tourne vers l'avant
		IMPORT  MOTEUR_DROIT_ARRIERE		; moteur droit tourne vers l'arrière
		IMPORT  MOTEUR_DROIT_INVERSE		; inverse le sens de rotation du moteur droit
		
		IMPORT	MOTEUR_GAUCHE_ON			; activer le moteur gauche
		IMPORT  MOTEUR_GAUCHE_OFF			; déactiver le moteur gauche
		IMPORT  MOTEUR_GAUCHE_AVANT			; moteur gauche tourne vers l'avant
		IMPORT  MOTEUR_GAUCHE_ARRIERE		; moteur gauche tourne vers l'arrière
		IMPORT  MOTEUR_GAUCHE_INVERSE		; inverse le sens de rotation du moteur gauche
			
		IMPORT SET_VITESSE_DEFAULT          ; mettre la vitesse par defaut
		IMPORT SET_VITESSE_FORCING			; mettre la vitesse en mode forcing
			
		IMPORT BUMPERS_INIT					; initialiser les bumber
		IMPORT READ_BUMPER1					; lire l'etat du bumper 1
		IMPORT READ_BUMPER2					; lire l'etat du bumper 2
		IMPORT READ_BUMPERS					; lire l'etat des deux bumpers
			
		IMPORT LEDS_INIT					; initialisation des leds
		IMPORT LEDS_SWITCH					; changements de l'etat des deux leds
		IMPORT LEDS_ON						; allumer les deux leds
		IMPORT LEDS_OFF						; eteindre les deux leds
		IMPORT LED5_ON						; allumer la led5
		IMPORT LED4_ON						; allumer la led4
		
			
		IMPORT SWITCH_INIT					; initialiser les boutons switchs
		IMPORT READ_SWITCH1					; lire l'etat du switch 1
		IMPORT READ_SWITCH2					; lire l'etat du switch 2

__main
;initialisations
	BL BUMPERS_INIT
	BL MOTEUR_INIT	 
	BL LEDS_INIT
	BL SWITCH_INIT
	LDR r4, =5 ;nombre de colision frontale avant forcing
	
;Boucle mettant le robot en pause
PAUSE
	BL MOTEUR_GAUCHE_OFF
	BL MOTEUR_DROIT_OFF
	BL LEDS_ON
	
PAUSE_LOOP	
	BL READ_SWITCH1
	CMP r5,#0x00
	BEQ PLAY
	
	B PAUSE_LOOP

;Boucle principale, utilisé pour faire avancer le robot tout droit
PLAY
	BL MOTEUR_DROIT_ON
	BL MOTEUR_GAUCHE_ON	
	
	BL MOTEUR_DROIT_AVANT	   
	BL MOTEUR_GAUCHE_AVANT
PLAY_LOOP
	
	BL LEDS_SWITCH
	BL WAIT_LED
	
	BL READ_BUMPERS
	BEQ COLISION_FRONTALE ;decision arbitraire
	
	BL READ_BUMPER1
	BEQ ACTION_BUMPER1
		
	BL READ_BUMPER2
	BEQ ACTION_BUMPER2
	
	BL READ_SWITCH2
	BEQ PAUSE
	
	B PLAY_LOOP

;instructions pour gérer la colision frontale
COLISION_FRONTALE
	SUBS r4,#1
	BEQ FORCING
	B ROTATION_DROITE
	
;instrutions pour realiser un passage en force
FORCING
	BL SET_VITESSE_FORCING
	LDR r4, =5 ;nombre de colision frontale avant forcing
	BL WAIT_ROTATION
	BL SET_VITESSE_DEFAULT
	BL READ_BUMPERS
	BEQ PAUSE
	B PLAY

;instructions quand le bumber1 est active
ACTION_BUMPER1
	LDR r4, =5 ;nombre de colision frontale avant forcing
	BL ROTATION_GAUCHE

;instructions quand le bumber2 est active
ACTION_BUMPER2
	LDR r4, =5 ;nombre de colision frontale avant forcing
	BL ROTATION_DROITE


;instructions pour effectuer une rotation à droite
ROTATION_DROITE
	BL LEGER_RECUL
	BL LEDS_OFF
	BL LED4_ON
	BL MOTEUR_GAUCHE_AVANT
	BL WAIT_ROTATION
	BL LEDS_OFF
	B PLAY

;instructions pour effectuer une rotation à gauche
ROTATION_GAUCHE
	BL LEGER_RECUL
	BL LEDS_OFF
	BL LED5_ON
	BL MOTEUR_DROIT_AVANT
	BL WAIT_ROTATION
	BL LEDS_OFF
	B PLAY

;routine d'attente avec un timer court, utilisé pour le clignotement des leds
WAIT_LED	
	
	ldr r1, =0xAFFFF 
WAIT_LED_LOOP	
	subs r1, #1
	bne WAIT_LED_LOOP	
	;; retour à la suite du lien de branchement
	BX	LR

;routine d'attente avec un timer long, utilisé pour la rotation
WAIT_ROTATION
	ldr r1, =0xAFFFFF
WAIT_ROTATION_LOOP
	subs r1, #1
	bne WAIT_ROTATION_LOOP	
	;; retour à la suite du lien de branchement
	BX	LR

;routine pour effectuer un leger recul
LEGER_RECUL
	PUSH {LR} ;sauvegarde du retour sur la pile (LR va être réécris pas les appels au autres routines)
	
	BL LEDS_ON
	BL MOTEUR_DROIT_ARRIERE
	BL MOTEUR_GAUCHE_ARRIERE
	BL WAIT_ROTATION
	
	POP {LR} ;recupération du retour sur la pile
	BX LR

;fin du programme
	NOP
	NOP
	END