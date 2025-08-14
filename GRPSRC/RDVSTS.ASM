
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

;unsigned char rdvsts(char no)
EXBRSA	equ	0FAF8H

	global	rdvsts_,vdpstat_

rdvsts_:
vdpstat_:
	ld	l,a

;Check MSX version
	ld	a,(EXBRSA)
	or	a
	jr	z,rdvsts_m1

	ld	a,(vdpo_)
	ld	c,a
	inc	c
	
	di

	out	(c),l
	ld	a,10001111B
	out	(c),a

	ld	a,(vdpio_)
	ld	c,a
	inc	c
	in	l,(c)

	ld	a,(vdpio_)
	ld	c,a
	inc	c

	xor	a
	out	(c),a
	ld	a,10001111B
	out	(c),a
	ei

	ld	a,l
	ret

rdvsts_m1:
	ld	a,(vdpio_)
	ld	c,a
	inc	c
	in	a,(c)
	ret

