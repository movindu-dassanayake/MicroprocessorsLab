	#include <xc.inc>

psect	code, abs
	
main:
	org	0x0
	goto	start

	org	0x100		    ; Main code starts here at address 0x100
start:
	movlw 	0x0
	movwf	TRISC, A	    ; Port C all outputs
	movwf	TRISE, A	    ; Port E is output
	movlw	0xff
	movwf	TRISD, A	    ; Port D is input
	bra 	test
loop:
	movf	0x08, W		    ; Store register 0x08 in W
	xorwf	PORTD, 0, 0	    ; XOR(PORTD, W) ie get the opposite bit 
	movwf	0x08, A		    ; Store register W in 0x08
	movwf	PORTE, A	    ; Output W into PORTE
	movff 	0x06, PORTC
	incf 	0x06, W, A
test:
	movwf	0x06, A	    ; Test for end of loop condition
	movlw 	0x63
	cpfsgt 	0x06, A
	bra 	loop		    ; Not yet finished goto start of loop again
	goto 	0x0		    ; Re-run program from start

	end	main
