
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

;void cls(void)
	public	cls_

cls_:
	cp	a		;must set Z flag NANDEYANENN!!
	_BIOSCALL	00C3H
	ret

