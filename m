From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc, ARM: Add zboot from MMC support for SuperH Mobile
 ARM
Date: Mon, 10 Jan 2011 08:52:27 +0900
Message-ID: <20110109235224.GA3730@verge.net.au>
References: <20110109124928.GC25591@verge.net.au>
 <20110109231239.GE31708@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:43892 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529Ab1AIXwc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Jan 2011 18:52:32 -0500
Content-Disposition: inline
In-Reply-To: <20110109231239.GE31708@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>

On Sun, Jan 09, 2011 at 11:12:39PM +0000, Russell King - ARM Linux wrote:
> On Sun, Jan 09, 2011 at 09:49:28PM +0900, Simon Horman wrote:
> > diff --git a/arch/arm/boot/compressed/head-shmobile.S b/arch/arm/boot/compressed/head-shmobile.S
> > index 30973b7..de83c5a 100644
> > --- a/arch/arm/boot/compressed/head-shmobile.S
> > +++ b/arch/arm/boot/compressed/head-shmobile.S
> > @@ -25,6 +25,37 @@
> >  	/* load board-specific initialization code */
> >  #include <mach/zboot.h>
> >  
> > +#ifdef CONFIG_ZBOOT_ROM_MMCIF
> > +	/* Load image from MMC */
> > +	adr	sp, __tmp_stack
> > +	add	sp, sp, #128
> 
> This can be replaced with:
> 
> 	adr	sp, __tmp_stack + 128 ?

Thanks, changed.

> > +	ldr	r0, __image_start
> > +	ldr	r1, __image_end
> > +	subs	r1, r1, r0
> > +	ldr	r0, __load_base
> 
> > +	mov	lr, pc
> > +	b	mmcif_loader
> 
> No need for a separate mov instruction - this will do both in one go:
> 	bl	mmcif_loader

Also changed.

> > +
> > +	/* Jump to loaded code */
> > +	ldr	r0, __loaded
> > +	ldr	r1, __image_start
> > +	sub	r0, r0, r1
> > +	ldr	r1, __load_base
> > +	add	pc, r0, r1
> 
> 	*__loaded - *__image_start + *__load_base
> 
> 	&__loaded - &_start + CONFIG_MEMORY_START + 0x02000000
> 
> So this jumps to the '__loaded' label in the just loaded image - are you
> sure you want to jump to a location that contains an address rather than
> code?  I think you want the two changes below to correct that.

Thanks, I have verified that your change is correct.

Actually, I'm rather unsure how my (broken) code got this far.
I suspect that I moved __tmp_stack late in the game and
forgot to re-test the code. My bad.

> > +
> > +__image_start:
> > +	.long	_start
> > +__image_end:
> > +	.long	_got_end
> > +__load_base:
> > +	.long	CONFIG_MEMORY_START + 0x02000000 @ Load at 32Mb into SDRAM
> > +__loaded:
> > +	.long	__loaded
> 
> change to
> 	.long	__continue
> 
> > +	.align
> > +__tmp_stack:
> > +	.space	128
> 
> add __continue
> 
> > +#endif /* CONFIG_ZBOOT_ROM_MMCIF */
> > +
> >  	b	1f
> >  __atags:@ tag #1
> >  	.long	12			@ tag->hdr.size = tag_size(tag_core);
> > diff --git a/arch/arm/boot/compressed/mmcif-sh7372.c b/arch/arm/boot/compressed/mmcif-sh7372.c
> > new file mode 100644
> > index 0000000..c54df5c
> > --- /dev/null
> > +++ b/arch/arm/boot/compressed/mmcif-sh7372.c
> > @@ -0,0 +1,87 @@
> > +/*
> > + * sh7372 MMCIF loader
> > + *
> > + * Copyright (C) 2010 Magnus Damm
> > + * Copyright (C) 2010 Simon Horman
> > + *
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive
> > + * for more details.
> > + */
> > +
> > +#include <linux/mmc/sh_mmcif.h>
> > +#include <mach/mmcif.h>
> > +
> > +#define MMCIF_BASE      (void __iomem *)0xe6bd0000
> > +
> > +#define PORT84CR	0xe6050054
> > +#define PORT85CR	0xe6050055
> > +#define PORT86CR	0xe6050056
> > +#define PORT87CR	0xe6050057
> > +#define PORT88CR	0xe6050058
> > +#define PORT89CR	0xe6050059
> > +#define PORT90CR	0xe605005a
> > +#define PORT91CR	0xe605005b
> > +#define PORT92CR	0xe605005c
> > +#define PORT99CR	0xe6050063
> > +
> > +#define SMSTPCR3	0xe615013c
> 
> These should also be (void __iomem *).
> 
> > diff --git a/arch/arm/mach-shmobile/include/mach/mmcif-ap4eb.h b/arch/arm/mach-shmobile/include/mach/mmcif-ap4eb.h
> > new file mode 100644
> > index 0000000..c6b10ee
> > --- /dev/null
> > +++ b/arch/arm/mach-shmobile/include/mach/mmcif-ap4eb.h
> > @@ -0,0 +1,29 @@
> > +#ifndef MMCIF_AP4EB_H
> > +#define MMCIF_AP4EB_H
> > +
> > +#define PORT185CR      0xe60520b9
> > +#define PORT186CR      0xe60520ba
> > +#define PORT187CR      0xe60520bb
> > +#define PORT188CR      0xe60520bc
> > +
> > +#define PORTR191_160DR 0xe6056014
> 
> Ditto.

Thanks, I've fixed these.
