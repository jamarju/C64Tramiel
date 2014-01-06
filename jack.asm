/*---------------------------------------------------------------
 
---------------------------------------------------------------*/


.var picture = LoadBinary("jack.koa", BF_KOALA)

:BasicUpstart2(start)

start:

	/*---------------------------------------------
	 = This is where handle the irq for music
	 =--------------------------------------------*/
	 
	lda #$00
	jsr $1000		// init music
	sei					// close all interrupts so we can setup our own
	lda #<irq1
	sta $0314
	lda #>irq1
	sta $0315
	asl $d019
	lda #$7b
	sta $dc0d
	lda #$81
	sta $d01a
	lda #$1b
	sta $d011
	lda #$80
	sta $d012
	cli				// Turn on interrupt handling again
	
	/*---------------------------------------------
	 = This is where we handle the image part
	 =--------------------------------------------*/	

	//--- Setup bank 2 for image ----------------------
	lda $dd00  // set VIC-bank 2 since picture at $4000
	and #$fc
	ora #02    //16kb at bank 2
	sta $dd00 
  //-----------------------------------------------	
	lda #$80   // Bitmap at $4000, screen att $6000 to $d018
	sta $d018
	lda #$18   // multicolor mode   
	sta $d016
	lda #$3b  // vic to bitmap mode
	sta $d011
	lda #picture.getBackgroundColor()
	sta $d020
	lda #picture.getBackgroundColor()
	sta $d021
	ldx #0
!loop:
	.for (var i=0; i<4; i++) {
		lda colorRam+i*$100,x
		sta $d800+i*$100,x
	}
	inx
	bne !loop-
	jmp *

//----------------------------------------------------------
irq1:  	
	asl $d019
	jsr $1003 // play music
	pla
	tay
	pla
	tax
	pla
	rti

//----------------------------------------------------------
.pc = $6000	"ScreenRam" .fill picture.getScreenRamSize(), picture.getScreenRam(i)
.pc = $3000 "ColorRam:" colorRam: .fill picture.getColorRamSize(), picture.getColorRam(i)
.pc = $4000	"Bitmap" .fill picture.getBitmapSize(), picture.getBitmap(i)
.pc = $1000 "Music"
.import binary "ode to 64.bin"

//----------------------------------------------------------
// A little macro
.macro SetBorderColor() {
	inc $d020
}
