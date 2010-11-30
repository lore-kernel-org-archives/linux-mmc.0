From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] [rfc] mmc, sh: Read MMCIF during zboot
Date: Tue, 30 Nov 2010 16:18:20 +0900
Message-ID: <20101130071818.GD1529@verge.net.au>
References: <1290812757-20571-1-git-send-email-horms@verge.net.au>
 <1290812757-20571-2-git-send-email-horms@verge.net.au>
 <AANLkTi=f-o6Bskb_ZAgco2+Hwm-ra+A_oOvtkogycQup@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:45112 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879Ab0K3HSY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Nov 2010 02:18:24 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=f-o6Bskb_ZAgco2+Hwm-ra+A_oOvtkogycQup@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>

On Tue, Nov 30, 2010 at 02:11:43PM +0900, Magnus Damm wrote:
> Hi Simon,
>=20
> Thanks for your work on this! It's nice to see that you can actually
> load some data early on.
>=20
> On Sat, Nov 27, 2010 at 8:05 AM, Simon Horman <horms@verge.net.au> wr=
ote:
> > This is a prototype of code to read the MMCIF during
> > zboot initialisation. The intention is that it will form
> > part of enabling booting from MMC. Very roughly the plan is
> >
> > 1) The Mask Rom will load a small boot program from MMC.
> > =C2=A0 Essentially this will be the first portion of
> > =C2=A0 the kernel to be booted.
> > 2) That program will load the remainder of the kernel
> > =C2=A0 from MMC and boot from it.
> >
> > This patch demonstrates code to perform the read portion of 2).
> > It uses a dummy buffer and only reads in one 512 byte sector.
> > A full implementation of 2) would of course read much more.
> >
> > The patch currently hooks into head-shmobile.S as it
> > depends on initialisation that occurs in that file.
> > However, it is likely that the final implementation
> > will need to be located in head.S where relocation is
> > currently handled.
> >
> > I used a multi-voltage MMC mobile card to test this code.
> > I observed that a single-voltage MMC and MMCplus card caused
> > the code to time-out in sh_mmcif_boot_init() which causes
> > the boot to stop.
> >
> > This patch depends on "ARM: mach-shmobile: Add zboot support for Su=
perH
> > Mobile ARM" and "mmc, sh: Correct value for reset".
> >
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > ---
> > =C2=A0arch/arm/boot/compressed/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 =C2=A04 +
> > =C2=A0arch/arm/boot/compressed/head-shmobile.S | =C2=A0 16 +++++
> > =C2=A0arch/arm/boot/compressed/mmcif-sh7372.c =C2=A0| =C2=A0100 +++=
+++++++++++++++++++++++++++
> > =C2=A03 files changed, 120 insertions(+), 0 deletions(-)
> > =C2=A0create mode 100644 arch/arm/boot/compressed/mmcif-sh7372.c
> >
> > diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/comp=
ressed/Makefile
> > index 0a8f748..f730c10 100644
> > --- a/arch/arm/boot/compressed/Makefile
> > +++ b/arch/arm/boot/compressed/Makefile
> > @@ -49,6 +49,10 @@ ifeq ($(CONFIG_ARCH_SHMOBILE),y)
> > =C2=A0OBJS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D head-shmobile.o
> > =C2=A0endif
> >
> > +ifeq ($(CONFIG_ARCH_SH7372),y)
> > +OBJS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D mmcif-sh7372.o
> > +endif
> > +
> > =C2=A0#
> > =C2=A0# We now have a PIC decompressor implementation. =C2=A0Decomp=
ressors running
> > =C2=A0# from RAM should not define ZTEXTADDR. =C2=A0Decompressors r=
unning directly
> > diff --git a/arch/arm/boot/compressed/head-shmobile.S b/arch/arm/bo=
ot/compressed/head-shmobile.S
> > index 30973b7..700d622 100644
> > --- a/arch/arm/boot/compressed/head-shmobile.S
> > +++ b/arch/arm/boot/compressed/head-shmobile.S
> > @@ -26,6 +26,22 @@
> > =C2=A0#include <mach/zboot.h>
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0b =C2=A0 =C2=A0 =C2=A0 1f
> > + =C2=A0 =C2=A0 =C2=A0 .align
> > +__tmp_stack:
> > + =C2=A0 =C2=A0 =C2=A0 .space =C2=A0128
> > +__dummy_buf:
> > + =C2=A0 =C2=A0 =C2=A0 .space =C2=A0512
> > +__dummy_buf_size:
> > + =C2=A0 =C2=A0 =C2=A0 .long =C2=A0 512
> > +1:
> > + =C2=A0 =C2=A0 =C2=A0 adr =C2=A0 =C2=A0 sp, __tmp_stack
> > + =C2=A0 =C2=A0 =C2=A0 add =C2=A0 =C2=A0 sp, sp, #128
> > + =C2=A0 =C2=A0 =C2=A0 adr =C2=A0 =C2=A0 r0, __dummy_buf
> > + =C2=A0 =C2=A0 =C2=A0 ldr =C2=A0 =C2=A0 r1, __dummy_buf_size
>=20
> Regarding the destination address, look into using CONFIG_MEMORY_STAR=
T
> or perhaps something more advanced like the actual destination addres=
s
> for the kernel - see arch/arm/boot/compressed/head.S and TEXT_OFFSET
> or zreladdr.

Thanks, I'll take a look at that

> As for the number of bytes to load, please have a look at the sh7724
> implementation.

Thanks, will do.

>=20
> > + =C2=A0 =C2=A0 =C2=A0 mov =C2=A0 =C2=A0 lr, pc
> > + =C2=A0 =C2=A0 =C2=A0 b =C2=A0 =C2=A0 =C2=A0 mmcif_loader
> > +
> > + =C2=A0 =C2=A0 =C2=A0 b =C2=A0 =C2=A0 =C2=A0 1f
> > =C2=A0__atags:@ tag #1
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.long =C2=A0 12 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@ tag->hdr.size =3D=
 tag_size(tag_core);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.long =C2=A0 0x54410001 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@ tag->hdr.tag =3D ATAG_CORE;
> > diff --git a/arch/arm/boot/compressed/mmcif-sh7372.c b/arch/arm/boo=
t/compressed/mmcif-sh7372.c
> > new file mode 100644
> > index 0000000..7ffaf27
> > --- /dev/null
> > +++ b/arch/arm/boot/compressed/mmcif-sh7372.c
> > @@ -0,0 +1,100 @@
> > +/*
> > + * sh7372 MMCIF loader
> > + *
> > + * Copyright (C) 2010 Magnus Damm
> > + * Copyright (C) 2010 Simon Horman
> > + *
> > + * This file is subject to the terms and conditions of the GNU Gen=
eral Public
> > + * License. =C2=A0See the file "COPYING" in the main directory of =
this archive
> > + * for more details.
> > + */
> > +
> > +#include <linux/mmc/sh_mmcif.h>
> > +
> > +#define MMCIF_BASE =C2=A0 =C2=A0 =C2=A0(void __iomem *)0xe6bd0000
> > +
> > +#define PORT84CR =C2=A0 =C2=A0 =C2=A0 0xe6050054
> > +#define PORT85CR =C2=A0 =C2=A0 =C2=A0 0xe6050055
> > +#define PORT86CR =C2=A0 =C2=A0 =C2=A0 0xe6050056
> > +#define PORT87CR =C2=A0 =C2=A0 =C2=A0 0xe6050057
> > +#define PORT88CR =C2=A0 =C2=A0 =C2=A0 0xe6050058
> > +#define PORT89CR =C2=A0 =C2=A0 =C2=A0 0xe6050059
> > +#define PORT90CR =C2=A0 =C2=A0 =C2=A0 0xe605005a
> > +#define PORT91CR =C2=A0 =C2=A0 =C2=A0 0xe605005b
> > +#define PORT92CR =C2=A0 =C2=A0 =C2=A0 0xe605005c
> > +#define PORT99CR =C2=A0 =C2=A0 =C2=A0 0xe6050063
> > +#define PORT185CR =C2=A0 =C2=A0 =C2=A00xe60520b9
> > +#define PORT186CR =C2=A0 =C2=A0 =C2=A00xe60520ba
> > +#define PORT187CR =C2=A0 =C2=A0 =C2=A00xe60520bb
> > +#define PORT188CR =C2=A0 =C2=A0 =C2=A00xe60520bc
> > +#define PORTR191_160DR =C2=A00xe6056014
> > +
> > +#define SMSTPCR3 =C2=A0 =C2=A0 =C2=A0 0xe615013c
> > +
> > +enum { MMCIF_PROGRESS_ENTER, MMCIF_PROGRESS_INIT,
> > + =C2=A0 =C2=A0 =C2=A0 MMCIF_PROGRESS_LOAD, MMCIF_PROGRESS_DONE };
> > +
> > +static void mmcif_update_progress(int n)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 __raw_writel((__raw_readl(PORTR191_160DR) & =
~(0xf << 25)) |
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(1 << (25 + n)), PORTR191_160DR);
> > +}
>=20
> This seems like a board specific property to me. So please break it
> out in to a per-board header or similar.

Sure.

> I guess next step is to extend the prototype code so it loads the
> entire kernel from MMC and then jumps to it. =3D)

Yes :-)

