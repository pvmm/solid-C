
;Copyright (c) 1999-2000 Tatsuhiko Syoji, Japan . All rights reserved.
;
;Redistribution and use in source and binary forms, with or without 
;modification, are permitted provided that the following conditions are 
;met:
;
;1 Redistributions of source code must retain the above copyright notice,
; this list of conditions and the following disclaimer as the first lines
; of this file unmodified.
;
;2 Redistributions in binary form must reproduce the above copyright 
;notice, this list of conditions and the following disclaimer in the 
;documentation and/or other materials provided with the distribution.
;
;THIS SOFTWARE IS PROVIDED BY Tatsuhiko Syoji ``AS IS'' AND ANY EXPRESS 
;ORIMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
; WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
; DISCLAIMED. IN NO EVENT SHALL Tatsuhiko Syoji BE LIABLE FOR ANY DIRECT,
; INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES 
;(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
;SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
;HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, 
;STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING 
;IN
; ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
;POSSIBILITY OF SUCH DAMAGE.

	.z80

EXPTBL	equ	0FCC1h
CALSLT	equ	001Ch

extrn	vdpio_
extrn	vdpo_

	cseg

;void fsetwt(char bit16,unsigned bit15_0)
;FSETWT@ In: A:DE-VRAM Address
;Use AF,BC,DE

;	MODULE	FSETWT
	PUBLIC	fsetwt_

;extrn	vdpio_	;in ginit()
;extrn	vdpo_	;in ginit()
	cseg

FSETWT_:
	OR	A
	JR	Z,SETWT1
	LD	A,4
SETWT1:
	LD	b,A
	LD	A,(vdpo_)
	INC	A
	LD	C,A
	XOR	A
	DI
	OUT	(C),A
	LD	A,45+80H
	OUT	(C),A
	LD	A,D
	RLCA
	RLCA
	AND	00000011B
	OR	b
	OUT	(C),A
	LD	A,14+80H
	OUT	(C),A
	OUT	(C),E
	LD	A,D
	AND	3FH
	OR	01000000B
	OUT	(C),A
	EI
	RET

;	ENDMODULE

