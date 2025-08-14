
;Copyright (c) 1999-2000 Tatsuhiko Syoji, Japan 982-0221. All rights reserved.
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

CALSLT	equ	001CH
EXPTBL	equ	0FCC1H

_BIOSCALL	macro	addr
	push	ix
	ld	ix,addr
	ld	iy,(EXPTBL-1)
	call	CALSLT
	pop	ix
	endm

	cseg

;char gstex(char port)
;Return A:押された方向 (0-8,9:Run,10:Select)
;Use register AF,BC,HL INT.=on

	cseg

public	gstex_

;EXPTBL	equ	0FCC1h		;slot address of BIOS ROM
GTSTCK	equ	00D5h

cout:	db	0,0,0,9,0,4,2,3,0,6,8,7,10,5,1,0

kanast	equ	0fcach		;かなランプの状態

gstex_:
	or	a
	jp	z,getkb

	ld	b,0		;Port-1=x1xxxxxxB
	cp	2
	jp	nz,setkr
	ld	b,01000000B	;Port-2=x1xxxxxxB

setkr:
	ld	a,(kanast)	;PSG#15=x0101111b
	or	a
	jp	z,kanach	;つけるときBit 7=0
	ld	a,128
kanach:	
	xor	128
	add	a,2fh
	add	a,b		;Port select
	ld	h,a
	ld	a,15
	di
	out	(0a0h),a	;#15
	ld	a,h
	out	(0a1h),a
	ld	a,14		;H=A=PSG#14
	out	(0a0h),a
	in	a,(0a2h)
	ei
	and	0fH
	ld	c,a
	ld	b,0
	ld	hl,cout
	add	hl,bc
	ld	a,(hl)
	ret

getkb:	;キーボード用(おまけ)
	push	ix
	ld	ix,GTSTCK
	ld	iy,(EXPTBL-1)
	call	CALSLT
	pop	ix
	ei
	ret

