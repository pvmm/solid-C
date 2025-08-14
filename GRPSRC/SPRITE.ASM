
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

EXPTBL	equ	0FCC1H
CALSLT	equ	001CH

	extrn	vdpio_,vdpo_
	extrn	setwrt_

	cseg

;void sprite(char no,char *data)
	global	sprite_

sprite_:
	push	ix

	push	de

	ld	ix,0084H		;CALPAT
	ld	iy,(EXPTBL-1)
	call	CALSLT

	push	hl
	call	setwrt_
	pop	hl

	ld	ix,008AH		;GSPSIZ
	ld	iy,(EXPTBL-1)
	call	CALSLT
	jp	c,_sprite_16

_sprite_8:
	ld	b,8
	jp	_sprite_write

_sprite_16:
	ld	b,32

_sprite_write:
	pop	hl

	ld	a,(vdpo_)
	ld	c,a
	otir

	pop	ix
	ret

