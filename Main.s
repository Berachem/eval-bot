		AREA    |.text|, CODE, READONLY
		ENTRY
		EXPORT	__main
	
		IMPORT	MOTEUR_INIT					; initialise les moteurs (configure les pwms + GPIO)
		
		IMPORT	MOTEUR_DROIT_ON				; activer le moteur droit
		IMPORT  MOTEUR_DROIT_OFF			; d�activer le moteur droit
		IMPORT  MOTEUR_DROIT_AVANT			; moteur droit tourne vers l'avant
		IMPORT  MOTEUR_DROIT_ARRIERE		; moteur droit tourne vers l'arri�re
		IMPORT  MOTEUR_DROIT_INVERSE		; inverse le sens de rotation du moteur droit
		
		IMPORT	MOTEUR_GAUCHE_ON			; activer le moteur gauche
		IMPORT  MOTEUR_GAUCHE_OFF			; d�activer le moteur gauche
		IMPORT  MOTEUR_GAUCHE_AVANT			; moteur gauche tourne vers l'avant
		IMPORT  MOTEUR_GAUCHE_ARRIERE		; moteur gauche tourne vers l'arri�re
		IMPORT  MOTEUR_GAUCHE_INVERSE		; inverse le sens de rotation du moteur gauche
			
		IMPORT BUMPERS_INIT
		IMPORT READ_BUMPER1
		IMPORT READ_BUMPER2
		IMPORT READ_BUMPERS
			
		IMPORT LEDS_INIT
		IMPORT LEDS_SWITCH
		IMPORT LEDS_ON
		IMPORT LEDS_OFF
		IMPORT LED5_ON
		IMPORT LED4_ON
		
			
		IMPORT SWITCH_INIT
		IMPORT READ_SWITCH1
		IMPORT READ_SWITCH2

__main
;initialisations
	BL BUMPERS_INIT
	BL MOTEUR_INIT	 
	BL LEDS_INIT
	BL SWITCH_INIT

;fonction principale, utilis� pour faire avancer le robot tout droit
PLAY
	BL MOTEUR_DROIT_ON
	BL MOTEUR_GAUCHE_ON	
	
	BL MOTEUR_DROIT_AVANT	   
	BL MOTEUR_GAUCHE_AVANT
	
	
PLAY_LOOP
	
	BL LEDS_SWITCH
	BL WAIT_LED
	
	BL READ_BUMPER1
	cmp r5,#0x00
	BEQ ROTATION_GAUCHE
		
	BL READ_BUMPER2
	cmp r5,#0x00
	BEQ ROTATION_DROITE
	
	BL READ_SWITCH1
	cmp r5,#0x00
	BEQ PAUSE
	
	;BL READ_BUMPERS
	;cmp r5, #0
	;BEQ fin
	
	B PLAY_LOOP

;fonction d'attente avec un timer court, utilis� pour le clignotement des leds
WAIT_LED	
	
	ldr r1, =0xAFFFF 
WAIT_LED_LOOP	
		subs r1, #1
        bne WAIT_LED_LOOP	
		;; retour � la suite du lien de branchement
		BX	LR

;fonction d'attente avec un timer long, utilis� pour la rotation
WAIT_ROTATION
	ldr r1, =0xAFFFFF
WAIT_ROTATION_LOOP
	subs r1, #1
	bne WAIT_ROTATION_LOOP	
	;; retour � la suite du lien de branchement
	BX	LR

;fonction mettant le robot en pause
PAUSE
	BL MOTEUR_GAUCHE_OFF
	BL MOTEUR_DROIT_OFF
	BL LEDS_ON
	
PAUSE_LOOP	
	BL READ_SWITCH2
	CMP r5,#0x00
	BEQ PLAY
	
	B PAUSE_LOOP

;fonction pour effectuer une rotation � droite
ROTATION_DROITE
	BL LEDS_OFF
	BL LED4_ON
	BL MOTEUR_DROIT_ARRIERE
	BL WAIT_ROTATION
	BL LEDS_OFF
	B PLAY

;fonction pour effectuer une rotation � gauche
ROTATION_GAUCHE
	BL LEDS_OFF
	BL LED5_ON
	BL MOTEUR_GAUCHE_ARRIERE
	BL WAIT_ROTATION
	BL LEDS_OFF
	B PLAY
	
	

	NOP
	NOP
	END