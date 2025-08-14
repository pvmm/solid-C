
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

;void setpg(char dsppg,char actpg)
DPPAGE	equ	0faf5H
ACPAGE	equ	0faf6H
RG2SAV	equ	0f3e1H
RG5SAV	equ	0f3e4H
RG6SAV	equ	0f3e5H
RG11SAV	equ	0ffeaH
SCRMOD	equ	0fcafH

	public	setpg_

setpg_:
	ld	h,e
	ld	l,a
	ld	(DPPAGE),HL
	
	ld	a,(vdpo_)
	ld	c,a
	inc	c

	ld	a,l
	rrca	;Pattern name table base address
	rrca
	rrca
	or	1FH
	and	7FH
	ld	(RG2SAV),a
	out	(c),a
	ld	b,82H
	out	(c),b
	
	ld	a,(SCRMOD)
	cp	7
	jp	nc,setpg_sc7
	
	ld	a,0efH	;Sprite attribute table address
	ld	(RG5SAV),a
	out	(c),a
	ld	b,85H
	out	(c),b
	
	ld	a,l
	ld	(RG11SAV),a
	out	(c),a
	ld	b,8bH
	out	(c),b
	
	ld	a,l
	rrca	;Sprite pattern generator  table base address
	rrca
	rrca
	rrca
	or	0FH
	and	3FH
	ld	(RG6SAV),a
	out	(c),a
	ld	b,86H
	out	(c),b

	ret
setpg_SC7:
	ld	a,0f7H	;Sprite attribute table address
	ld	(RG5SAV),a
	out	(c),a
	ld	b,85H
	out	(c),b
	
	ld	a,l
	rla
	or	1
	and	3
	ld	(RG11SAV),a
	out	(c),a
	ld	b,8bH
	out	(c),b
	
	ld	a,l
	rrca	;Sprite pattern generator  table base address
	rrca
	rrca
	or	1eH
	and	3eH
	ld	(RG6SAV),a
	out	(c),a
	ld	b,86H
	out	(c),b

	ret

