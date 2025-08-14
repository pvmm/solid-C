	.z80
;	SOLID C Compiler ver 1.00 (pass 2)

	cseg
;{
plxpal_:
	ld	a,e
	ex	de,hl
	add	a,a
	add	a,a
	add	a,a
	add	a,a
	add	a,c
	ld	l,a
	ld	h,0
	add	hl,hl
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,c
	call	setplt_
	ret
;}

;{
plxset_:
	push	ix
	ld	ix,0
	add	ix,sp
	push	hl
	push	de
	xor	a
@1:
	cp	16
	jp	nc,@0
	ld	c,a
	push	af
	ld	(ix-4),e
	ld	(ix-2),l
	ld	(ix-1),h
	call	plxpal_
	pop	af
	inc	a
	ld	e,(ix-4)
	ld	l,(ix-2)
	ld	h,(ix-1)
	jp	@1
@0:
	ld	sp,ix
	pop	ix
	ret
;}

;{
gputs_:
@2:
	ld	a,(hl)
	or	a
	ret	z
	ld	a,(hl)
	ld	de,0
	push	hl
	call	grpprt_
	pop	hl
	inc	hl
	jp	@2
;}

;{
sc0test_:
	ld	bc,7
	ld	de,4
	ld	a,15
	call	color_
	ld	a,80
	ld	(62382),a
	ld	a,80
	ld	(62384),a
	xor	a
	call	screen_
	ld	e,65
	ld	hl,0
	call	vpoke_
	ld	hl,0
	call	vpeek_
	ld	e,65
	ld	hl,1
	call	vpoke_
	ld	hl,2048
	call	setwrt_
	ld	hl,0
@4:
	ld	de,240
	call	?cpshd
	jp	nc,@3
	xor	a
	push	hl
	call	outvdp_
	pop	hl
	inc	hl
	jp	@4
@3:
	ld	de,128
	ld	hl,2048
	call	vpoke_
	ld	de,244
	ld	a,7
	call	wrtvdp_
	ld	de,74
	ld	a,12
	call	wrtvdp_
	ld	de,51
	ld	a,13
	call	wrtvdp_
	call	chget_
	ld	de,0
	ld	a,13
	call	wrtvdp_
	ret
;}

;{
sc1test_:
	ld	bc,7
	ld	de,4
	ld	a,15
	call	color_
	ld	a,1
	call	screen_
	ld	de,6144
	xor	a
	call	fsetwt_
	ld	a,65
	call	outvdp_
	ld	de,6144
	xor	a
	call	fsetrd_
	call	invdp_
	ld	de,6145
	push	af
	xor	a
	call	fsetwt_
	pop	af
	call	outvdp_
	ld	hl,6145
	call	setrd_
	call	invdp_
	ld	hl,6146
	push	af
	call	setwrt_
	pop	af
	call	outvdp_
	call	chget_
	call	cls_
	ld	de,10
	ld	a,5
	call	locate_
	ld	a,(64687)
	add	a,48
	call	chput_
	call	chget_
	ret
;}

vdpbuf_:
	dw	0
	dw	0
	dw	0
	dw	0
	dw	16
	dw	16
	dw	241
	dw	192
vdpbuf2_:
	dw	0
	dw	0
	dw	0
	dw	0
	dw	16
	dw	16
	dw	241
	dw	192
sprpat_:
	db	1
	db	3
	db	7
	db	15
	db	31
	db	63
	db	127
	db	255
	db	255
	db	127
	db	63
	db	31
	db	15
	db	7
	db	3
	db	1
	db	128
	db	192
	db	224
	db	240
	db	248
	db	252
	db	254
	db	255
	db	255
	db	254
	db	252
	db	248
	db	240
	db	224
	db	192
	db	128
?63999:
	db	83,99,114,101,101,110,32,53,32,84
	db	101,115,116,0
;{
sc5test_:
	ld	a,5
	call	screen_
	xor	a
	call	interla_
	ld	bc,1
	ld	de,1
	ld	a,15
	call	color_
	call	cls_
	ld	e,0
	xor	a
	call	setpg_
	ld	de,0
	ld	a,15
	call	setplt_
	ld	de,16
	ld	hl,0
	call	glocate_
	ld	hl,?63999
	call	gputs_
	ld	hl,0
@7:
	ld	de,7
	call	?cpshd
	jp	nc,@5
	ld	b,l
	ld	c,0
	ex	de,hl
	ld	l,e
	ld	h,d
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,bc
	add	hl,de
	push	de
	ex	de,hl
	ld	a,15
	call	setplt_
	ld	hl,0
	ld	(64670),hl
@6:
	ld	hl,(64670)
	ld	a,l
	sub	2
	ld	a,h
	sbc	a,0
	jp	c,@6
	pop	hl
	inc	hl
	jp	@7
@5:
	ld	hl,vdpbuf_
	call	vdpcom_
	ld	hl,0
	call	setrd_
	call	invdp_
	ld	hl,12800
	push	af
	call	setwrt_
	pop	af
	call	outvdp_
	call	chget_
	ld	e,1
	ld	a,1
	call	setpg_
	call	cls_
	ld	a,3
	call	interla_
	ld	hl,31
	ld	(vdpbuf_+12),hl
	ld	hl,256
	ld	(vdpbuf_+6),hl
	ld	hl,vdpbuf_
	call	vdpcom_
	xor	a
	call	inispr_
	ld	de,63488
	xor	a
	call	fsetwt_
	ld	hl,0
@9:
	ld	de,8
	call	?cpshd
	jp	nc,@8
	push	hl
	ld	bc,sprpat_
	add	hl,bc
	ld	a,(hl)
	call	outvdp_
	pop	hl
	inc	hl
	jp	@9
@8:
	ld	de,62464
	xor	a
	call	fsetwt_
	ld	hl,0
@11:
	ld	de,8
	call	?cpshd
	jp	nc,@10
	ld	a,15
	push	hl
	call	outvdp_
	pop	hl
	inc	hl
	jp	@11
@10:
	ld	de,62976
	xor	a
	call	fsetwt_
	ld	a,100
	call	outvdp_
	ld	a,150
	call	outvdp_
	xor	a
	call	outvdp_
	xor	a
	call	outvdp_
	ld	hl,0
	call	setrd_
	call	invdp_
	ld	hl,12800
	push	af
	call	setwrt_
	pop	af
	call	outvdp_
	call	chget_
	ret
;}

?63998:
	db	83,99,114,101,101,110,32,55,32,84
	db	101,115,116,0
;{
sc7test_:
	call	iniplt_
	ld	a,7
	call	screen_
	xor	a
	call	interla_
	ld	bc,4
	ld	de,4
	ld	a,1
	call	color_
	call	cls_
	ld	e,0
	xor	a
	call	setpg_
	ld	de,16
	ld	hl,0
	call	glocate_
	ld	hl,?63998
	call	gputs_
	ld	bc,0
@13:
	ld	l,c
	ld	h,b
	ld	de,16
	call	?cpshd
	jp	nc,@12
	ld	l,c
	ld	h,b
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ld	(vdpbuf2_+4),hl
	ld	l,c
	ld	h,b
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,bc
	ld	(vdpbuf2_+12),hl
	ld	hl,vdpbuf2_
	push	bc
	call	vdpcom_
	pop	bc
	inc	bc
	jp	@13
@12:
	ld	hl,64
	call	setrd_
	call	invdp_
	ld	hl,25600
	push	af
	call	setwrt_
	pop	af
	call	outvdp_
	call	chget_
	ld	e,1
	ld	a,1
	call	setpg_
	call	cls_
	ld	a,2
	call	interla_
	ld	hl,256
	ld	(vdpbuf2_+6),hl
	ld	hl,0
@15:
	ld	de,16
	call	?cpshd
	jp	nc,@14
	ld	e,l
	ld	d,h
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ld	(vdpbuf2_+4),hl
	ld	bc,15
	ld	a,c
	sub	e
	ld	c,a
	ld	a,b
	sbc	a,d
	ld	b,a
	ld	hl,15
	or	a
	sbc	hl,de
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,bc
	ld	(vdpbuf2_+12),hl
	ld	hl,vdpbuf2_
	push	de
	call	vdpcom_
	pop	hl
	inc	hl
	jp	@15
@14:
	ld	a,3
	call	inispr_
	ld	de,61440
	ld	a,1
	call	fsetwt_
	ld	hl,0
@17:
	ld	de,32
	call	?cpshd
	jp	nc,@16
	push	hl
	ld	bc,sprpat_
	add	hl,bc
	ld	a,(hl)
	call	outvdp_
	pop	hl
	inc	hl
	jp	@17
@16:
	ld	de,63488
	ld	a,1
	call	fsetwt_
	ld	hl,0
@19:
	ld	de,16
	call	?cpshd
	jp	nc,@18
	ld	a,15
	push	hl
	call	outvdp_
	pop	hl
	inc	hl
	jp	@19
@18:
	ld	de,64000
	ld	a,1
	call	fsetwt_
	ld	a,100
	call	outvdp_
	ld	a,150
	call	outvdp_
	xor	a
	call	outvdp_
	xor	a
	call	outvdp_
	ld	hl,32
	call	setrd_
	call	invdp_
	ld	hl,25600
	push	af
	call	setwrt_
	pop	af
	call	outvdp_
	call	chget_
	xor	a
	call	interla_
	ret
;}

;{
main_:
	call	ginit_
	call	sc0test_
	call	sc1test_
	call	sc5test_
	call	sc7test_
	ld	bc,1
	ld	de,1
	ld	a,15
	call	color_
	call	totext_
	ld	hl,0
	ret
;}


	public	plxpal_
	extrn	setplt_
	public	plxset_
	public	gputs_
	extrn	grpprt_
	public	sc0test_
	extrn	color_
	extrn	screen_
	extrn	vpoke_
	extrn	vpeek_
	extrn	setwrt_
	extrn	outvdp_
	extrn	wrtvdp_
	extrn	chget_
	extrn	?cpshd
	public	sc1test_
	extrn	fsetwt_
	extrn	fsetrd_
	extrn	invdp_
	extrn	setrd_
	extrn	cls_
	extrn	locate_
	extrn	chput_
	public	vdpbuf_
	public	vdpbuf2_
	public	sprpat_
	public	sc5test_
	extrn	interla_
	extrn	setpg_
	extrn	glocate_
	extrn	vdpcom_
	extrn	inispr_
	public	sc7test_
	extrn	iniplt_
	public	main_
	extrn	ginit_
	extrn	totext_

	end
