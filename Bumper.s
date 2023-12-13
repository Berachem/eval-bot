	AREA    |.text|, CODE, READONLY

SYSCTL_PERIPH_GPIO  EQU		0x400FE108 ;SYSCTL_RCGC2_R 

GPIO_PORTE_BASE		EQU		0x40024000 ;GPIO Port E		
	
; Digital enable register
; To use the pin as a digital input or output, the corresponding GPIODEN bit must be set.
GPIO_O_DEN  		EQU 	0x0000051C  ; GPIO Digital Enable (p437 datasheet de lm3s9B92.pdf)

; Pul_up
GPIO_I_PUR   		EQU 	0x00000510  ; GPIO Pull-Up (p432 datasheet de lm3s9B92.pdf)
	
BROCHE0             EQU     0x01		; Broche 0
BROCHE1             EQU     0x02        ; Broche 1	
BROCHE0_1           EQU     0x03        ; Broche 1 et 2
	
	;; The EXPORT command specifies that a symbol can be accessed by other shared objects or executables.
	EXPORT BUMPERS_INIT
	EXPORT READ_BUMPER1
	EXPORT READ_BUMPER2
	EXPORT READ_BUMPERS
	
BUMPERS_INIT
	;branchement du port E
	ldr r6, = SYSCTL_PERIPH_GPIO  			;; RCGC2
	mov r0, #0x10 							;; Enable clock sur GPIO E 0x10 = ob010000
	str r0, [r6]
	
	;waiting for GPIO reg. access
	nop
	nop
	nop
	
	;setup bumpers
	ldr r6, = GPIO_PORTE_BASE+GPIO_I_PUR    ;; Pul_up
	ldr r0, = BROCHE0_1	
	str r0, [r6]
	
	ldr r6, = GPIO_PORTE_BASE+GPIO_O_DEN    ;; Enable Digital Function 
	ldr r0, = BROCHE0_1	
	str r0, [r6]
	
	ldr r9, = GPIO_PORTE_BASE + (BROCHE0<<2)
	ldr r8, = GPIO_PORTE_BASE + (BROCHE1<<2)
	
	BX LR

READ_BUMPER1
	;lecture de l'etat du bumper1
	
	ldr r9, = GPIO_PORTE_BASE + (BROCHE0<<2)
	ldr r5, [r9]
	BX LR

READ_BUMPER2
	;lecture de l'etat du bumper2
	
	ldr r8, = GPIO_PORTE_BASE + (BROCHE1<<2)
	ldr r5, [r8]
	BX LR
	
READ_BUMPERS
	;lecture des deux ports en meme temps

	ldr r8, = GPIO_PORTE_BASE + (BROCHE0_1<<2)
	ldr r5, [r8]
	BX LR
	
	NOP
	NOP
	END