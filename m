From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/3] mmc: initialize struct mmc_command at declaration time
Date: Thu, 14 Apr 2011 23:11:46 -0400
Message-ID: <m3fwpktdhp.fsf@pullcord.laptop.org>
References: <1302753463-31005-1-git-send-email-cjb@laptop.org>
	<alpine.LFD.2.00.1104141931100.24613@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38493 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666Ab1DODHO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 Apr 2011 23:07:14 -0400
In-Reply-To: <alpine.LFD.2.00.1104141931100.24613@xanadu.home> (Nicolas
	Pitre's message of "Thu, 14 Apr 2011 19:37:20 -0400 (EDT)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-mmc@vger.kernel.org

Hi,

On Thu, Apr 14 2011, Nicolas Pitre wrote:
> Did you disassemble the resulting binary to make sure this is actually 
> as performant?
>
> I'm asking because gcc used to do a horrible dumb job with such patterns 
> where it would allocate two instances of the structure on the stack i.e. 
> one for the named variable and one for the initializer, then fill the 
> later with zeroes, and then call memcpy() to copy the initializer over 
> to the named instance.

Nothing horrible as far as I can tell; in fact, the code size on ARM
(stripped mmc_core.ko) decreases by 216 bytes after the patchset here.

Here's a sample disassembly of one function on ARM with gcc-4.6.0, and
diff -y.  Explicit memset (which calls __memzero) on the left, and {0}
initializer (which calls memset) on the right:

00000698 <mmc_set_relative_addr>:			      |	000006c8 <mmc_set_relative_addr>:
 698:	e92d4010 	push	{r4, lr}		      |	 6c8:	e92d4010 	push	{r4, lr}
 69c:	e2504000 	subs	r4, r0, #0		      |	 6cc:	e24dd030 	sub	sp, sp, #48	; 0x30
 6a0:	e24dd030 	sub	sp, sp, #48	; 0x30	      |	 6d0:	e1a04000 	mov	r4, r0
 6a4:	059f0058 	ldreq	r0, [pc, #88]	; 704 <mmc_se |	 6d4:	e3a01000 	mov	r1, #0
 6a8:	03a010ce 	moveq	r1, #206	; 0xce	      |	 6d8:	e1a0000d 	mov	r0, sp
 6ac:	0a000004 	beq	6c4 <mmc_set_relative_addr+0x |	 6dc:	e3a02030 	mov	r2, #48	; 0x30
 6b0:	e5943000 	ldr	r3, [r4]		      |	 6e0:	ebfffffe 	bl	0 <memset>
 6b4:	e3530000 	cmp	r3, #0			      |	 6e4:	e3540000 	cmp	r4, #0
 6b8:	1a000002 	bne	6c8 <mmc_set_relative_addr+0x |	 6e8:	059f0048 	ldreq	r0, [pc, #72]	; 738 <mmc_se
 6bc:	e59f0040 	ldr	r0, [pc, #64]	; 704 <mmc_se |	 6ec:	03a010c4 	moveq	r1, #196	; 0xc4
 6c0:	e3a010cf 	mov	r1, #207	; 0xcf	      |	 6f0:	0a000004 	beq	708 <mmc_set_relative_addr+0x
 6c4:	ebfffffe 	bl	0 <__bug>		      |	 6f4:	e5940000 	ldr	r0, [r4]
 6c8:	e1a0000d 	mov	r0, sp			      |	 6f8:	e3500000 	cmp	r0, #0
 6cc:	e3a01030 	mov	r1, #48	; 0x30		      |	 6fc:	1a000002 	bne	70c <mmc_set_relative_addr+0x
 6d0:	ebfffffe 	bl	0 <__memzero>		      |	 700:	e59f0030 	ldr	r0, [pc, #48]	; 738 <mmc_se
 6d4:	e59430c8 	ldr	r3, [r4, #200]	; 0xc8	      |	 704:	e3a010c5 	mov	r1, #197	; 0xc5
 6d8:	e3a02003 	mov	r2, #3			      |	 708:	ebfffffe 	bl	0 <__bug>
 6dc:	e1a03803 	lsl	r3, r3, #16		      |	 70c:	e59430c8 	ldr	r3, [r4, #200]	; 0xc8
 6e0:	e58d3004 	str	r3, [sp, #4]		      |	 710:	e3a02003 	mov	r2, #3
 6e4:	e5940000 	ldr	r0, [r4]		      |	 714:	e1a03803 	lsl	r3, r3, #16
 6e8:	e3a03015 	mov	r3, #21			      |	 718:	e58d3004 	str	r3, [sp, #4]
 6ec:	e1a0100d 	mov	r1, sp			      |	 71c:	e1a0100d 	mov	r1, sp
 6f0:	e58d2000 	str	r2, [sp]		      |	 720:	e3a03015 	mov	r3, #21
 6f4:	e58d3018 	str	r3, [sp, #24]		      |	 724:	e58d2000 	str	r2, [sp]
 6f8:	ebfffffe 	bl	0 <mmc_wait_for_cmd>	      |	 728:	e58d3018 	str	r3, [sp, #24]
 6fc:	e28dd030 	add	sp, sp, #48	; 0x30	      |	 72c:	ebfffffe 	bl	0 <mmc_wait_for_cmd>
 700:	e8bd8010 	pop	{r4, pc}		      |	 730:	e28dd030 	add	sp, sp, #48	; 0x30
 704:	0000001d 	.word	0x0000001d		      |	 734:	e8bd8010 	pop	{r4, pc}
							      >	 738:	0000001d 	.word	0x0000001d

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
