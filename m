From: Daniel Palmer <me@danielpalmer.co.uk>
Subject: Re: atmel-mci causing oops?
Date: Mon, 27 Feb 2012 20:58:41 +0900
Message-ID: <201202272058.41223.me@danielpalmer.co.uk>
References: <201202270949.23934.me@danielpalmer.co.uk> <201202271057.28579.me@danielpalmer.co.uk> <003801ccf4ff$d821bfb0$88653f10$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tomato.cardboardbox.org.uk ([174.143.157.65]:35784 "EHLO
	tomato.cardboardbox.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753527Ab2B0L6y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2012 06:58:54 -0500
In-Reply-To: <003801ccf4ff$d821bfb0$88653f10$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org

> I'm not sure.
> Is there any trace information of kernel?

Hi,

The oops isn't very descriptive so I got kgdb configured:

GNU gdb (GDB) 7.3.1
Copyright (C) 2011 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "--host=x86_64-unknown-linux-gnu --target=arm-
softfloat-eabi".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
(gdb) target remote /dev/ttyUSB0
Remote debugging using /dev/ttyUSB0
0xc0049f6c in ?? ()
(gdb) file /home/daniel/vmlinux 
A program is being debugged already.
Are you sure you want to change the file? (y or n) y
Reading symbols from /home/daniel/vmlinux...done.
(gdb) disassemble
Dump of assembler code for function kgdb_breakpoint:
   0xc0049f4c <+0>:     mrs     r2, CPSR
   0xc0049f50 <+4>:     orr     r3, r2, #128    ; 0x80
   0xc0049f54 <+8>:     msr     CPSR_c, r3
   0xc0049f58 <+12>:    ldr     r3, [pc, #48]   ; 0xc0049f90
   0xc0049f5c <+16>:    ldr     r1, [r3, #4]
   0xc0049f60 <+20>:    add     r1, r1, #1
   0xc0049f64 <+24>:    str     r1, [r3, #4]
   0xc0049f68 <+28>:    msr     CPSR_c, r2
=> 0xc0049f6c <+32>:                    ; <UNDEFINED> instruction: 0xe7ffdeff
   0xc0049f70 <+36>:    mrs     r2, CPSR
   0xc0049f74 <+40>:    orr     r1, r2, #128    ; 0x80
   0xc0049f78 <+44>:    msr     CPSR_c, r1
   0xc0049f7c <+48>:    ldr     r1, [r3, #4]
   0xc0049f80 <+52>:    sub     r1, r1, #1
   0xc0049f84 <+56>:    str     r1, [r3, #4]
   0xc0049f88 <+60>:    msr     CPSR_c, r2
   0xc0049f8c <+64>:    bx      lr
   0xc0049f90 <+68>:    eorgt   r9, r9, r0, lsl r10
End of assembler dump.
(gdb) c
Continuing.
[New Thread 5]

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 5]
sg_virt (sg=0x0) at include/linux/scatterlist.h:199
199     include/linux/scatterlist.h: No such file or directory.
        in include/linux/scatterlist.h
(gdb) bt
#0  sg_virt (sg=0x0) at include/linux/scatterlist.h:199
#1  atmci_write_data_pio (host=0xce994f40) at drivers/mmc/host/atmel-
mci.c:1624
#2  0xc0179b38 in atmci_interrupt (irq=<optimized out>, dev_id=0xce994f40) at 
drivers/mmc/host/atmel-mci.c:1802
#3  0xc004cb40 in handle_irq_event_percpu (desc=0xc02822c4, action=0xce8708a0) 
at kernel/irq/handle.c:126
#4  0xc004cc94 in handle_irq_event (desc=<optimized out>) at 
kernel/irq/handle.c:176
#5  0xc004e780 in handle_level_irq (irq=<optimized out>, desc=0xc02822c4) at 
kernel/irq/chip.c:363
#6  0xc004c530 in generic_handle_irq_desc (desc=<optimized out>, 
irq=<optimized out>) at include/linux/irqdesc.h:114
#7  generic_handle_irq (irq=<optimized out>) at kernel/irq/irqdesc.c:313
#8  0xc000e6ac in handle_IRQ (irq=11, regs=<optimized out>) at 
arch/arm/kernel/irq.c:86

I guess the issue is sg=0x0.

Cheers,

Daniel
 
