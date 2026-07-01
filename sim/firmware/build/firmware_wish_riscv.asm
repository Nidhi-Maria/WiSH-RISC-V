
build/firmware_wish_riscv.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <__start>:
   0:	008000ef          	jal	8 <pre_main>

00000004 <__post_main>:
   4:	0000006f          	j	4 <__post_main>

00000008 <pre_main>:
   8:	00001117          	auipc	sp,0x1
   c:	ff410113          	addi	sp,sp,-12 # ffc <_USER_SP_ADDR>
  10:	0040006f          	j	14 <_text_end>

Disassembly of section .text.startup.main:

00000014 <main>:
  14:	00000513          	li	a0,0
  18:	00008067          	ret

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	3241                	.insn	2, 0x3241
   2:	0000                	.insn	2, 0x0000
   4:	7200                	.insn	2, 0x7200
   6:	7369                	.insn	2, 0x7369
   8:	01007663          	bgeu	zero,a6,14 <main>
   c:	0028                	.insn	2, 0x0028
   e:	0000                	.insn	2, 0x0000
  10:	1004                	.insn	2, 0x1004
  12:	7205                	.insn	2, 0x7205
  14:	3376                	.insn	2, 0x3376
  16:	6932                	.insn	2, 0x6932
  18:	7032                	.insn	2, 0x7032
  1a:	5f31                	.insn	2, 0x5f31
  1c:	326d                	.insn	2, 0x326d
  1e:	3070                	.insn	2, 0x3070
  20:	7a5f 6369 7273      	.insn	6, 0x727363697a5f
  26:	7032                	.insn	2, 0x7032
  28:	5f30                	.insn	2, 0x5f30
  2a:	6d7a                	.insn	2, 0x6d7a
  2c:	756d                	.insn	2, 0x756d
  2e:	316c                	.insn	2, 0x316c
  30:	3070                	.insn	2, 0x3070
	...

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	.insn	4, 0x3a434347
   4:	2820                	.insn	2, 0x2820
   6:	33623167          	.insn	4, 0x33623167
   a:	3630                	.insn	2, 0x3630
   c:	3330                	.insn	2, 0x3330
   e:	6139                	.insn	2, 0x6139
  10:	20293463          	.insn	4, 0x20293463
  14:	3531                	.insn	2, 0x3531
  16:	312e                	.insn	2, 0x312e
  18:	302e                	.insn	2, 0x302e
	...
