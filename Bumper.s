	AREA    |.text|, CODE, READONLY
			ENTRY
			EXPORT	__mainB

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
	
	IMPORT LEDS_INIT
	IMPORT LED5_ON
	IMPORT LED4_ON
	IMPORT LEDS_OFF
	IMPORT LEDS_ON

__mainB
	
		;branchement du port E
		ldr r6, = SYSCTL_PERIPH_GPIO  			;; RCGC2
		mov r0, #0x10 							;; Enable clock sur GPIO E 0x = ob010000
		str r0, [r6]
		
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
		
		ldr r7, = GPIO_PORTE_BASE + (BROCHE0<<2)
		
		ldr r8, = GPIO_PORTE_BASE + (BROCHE1<<2)
		
		;init led
		BL LEDS_INIT
		
loop
		
		BL LEDS_OFF
		
		
		ldr r10,[r8]
		ldr r11,[r7]
		CMP r10,r11;
		BEQ leds
		
		CMP r10,#0x00
		BEQ led1
		
		CMP r11,#0x00
		BEQ led2
		
		
		

		b loop

led1
		BL LED5_ON
		b loop
		
led2
		BL LED4_ON
		b loop

leds
	BL LEDS_ON
	b loop
