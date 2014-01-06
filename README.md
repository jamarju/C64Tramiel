C64Tramiel
==========

Simple C64 interrupt demo showing a image of Jack Tramiel while playing some music.

The demo is written using a cross-assembler known as KickAssembler.
KickAssembler is a really good 6510 assembly written in Java.
You can download KickAssembler from the following URL:

http://www.theweb.dk/KickAssembler/Links.php

This project includes

jack.asm 		The asm file including the code to be compiled with KickAssembler
jack.koa		Koalaimage of Jack Tramiel that is needed for the project.
ode to 64.bin	SID music that is played using interrupt
KOA.d64			Ready made disk image with demo crunched using exomizer. Run this with VICE
