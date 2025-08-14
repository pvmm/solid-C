
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

;void iniplt(void)
RG16SAV	equ	0ffefH

	public	iniplt_

iniplt_:
	xor	a
	ld	b,a
	ld	a,(vdpo_)
	ld	c,a
	inc	c
	out	(c),b
	ld	a,90H
	out	(c),a
	inc	c

	ld	b,32
	ld	hl,iniplt_tbl
	otir
	ld	a,15
	ld	(RG16SAV),a
	ret

	dseg
iniplt_tbl:
	dw	000H,000H,611H,733H
	dw	117H,327H,151H,627H
	dw	171H,373H,661H,664H
	dw	411H,265H,555H,777H

