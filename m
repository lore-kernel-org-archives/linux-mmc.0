From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch 3/3] mmc, ARM: Add zboot from MMC support for SuperH
 Mobile ARM
Date: Mon, 6 Dec 2010 10:11:39 +0900
Message-ID: <20101206011138.GA623@verge.net.au>
References: <20101206001243.949375995@vergenet.net>
 <20101206001310.825497890@vergenet.net>
 <AANLkTin91C9XJKaKTNgvN9b=ExCYbt0ujPFe-qEx57hm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:44707 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab0LFBLn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Dec 2010 20:11:43 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTin91C9XJKaKTNgvN9b=ExCYbt0ujPFe-qEx57hm@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>

On Mon, Dec 06, 2010 at 09:51:55AM +0900, Magnus Damm wrote:
> Hi Simon,
>=20
> Thanks for your work on this!
>=20
> On Mon, Dec 6, 2010 at 9:12 AM, Simon Horman <horms@verge.net.au> wro=
te:
> > This allows a ROM-able zImage to be written to MMC and
> > for SuperH Mobile ARM to boot directly from the MMCIF
> > hardware block.
> >
> > This is achieved by the MaskROM loading the first portion
> > of the image into MERAM and then jumping to it. This portion
> > contains loader code which copies the entire image to SDRAM
> > and jumps to it. From there the zImage boot code proceeds
> > as normal, uncompressing the image into its final location
> > and then jumping to it.
> >
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> >
> > ---
> >
> > This patch depends on "ARM: 6514/1: mach-shmobile: Add zboot suppor=
t for
> > SuperH Mobile ARM" which has been merged into the devel branch
> > of Russell King's linux-2.6-arm tree.
> >
> > Index: linux-2.6-ap4/arch/arm/boot/compressed/mmcif-sh7372.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- /dev/null =C2=A0 1970-01-01 00:00:00.000000000 +0000
> > +++ linux-2.6-ap4/arch/arm/boot/compressed/mmcif-sh7372.c =C2=A0 =C2=
=A0 =C2=A0 2010-12-06 09:11:42.000000000 +0900
> > @@ -0,0 +1,99 @@
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
> > +#include <mach/mmcif.h>
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
> > +
> > +#define SMSTPCR3 =C2=A0 =C2=A0 =C2=A0 0xe615013c
> > +
> > +/* SH7372 specific MMCIF loader
> > + *
> > + * loads the zImage from an MMC card starting from block 1.
> > + *
> > + * The image must be start with a vrl4 header and
> > + * the zImage must start at offset 512 of the image. That is,
> > + * at block 2 (=3Dbyte 1024) on the media
> > + *
> > + * Use the following line to write the vrl4 formated zImage
> > + * to an MMC card
> > + * # dd if=3Dvrl4.out of=3D/dev/sdx bs=3D512 seek=3D1
> > + */
> > +asmlinkage void mmcif_loader(unsigned char *buf, unsigned long len=
)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 /* Initialise LEDS1-4
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* registers: PORT185CR-PORT188CR (LED1=
-LED4 Control)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* value: =C2=A0 =C2=A0 0x10 - enable o=
utput
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> > + =C2=A0 =C2=A0 =C2=A0 __raw_writeb(0x10, PORT185CR);
> > + =C2=A0 =C2=A0 =C2=A0 __raw_writeb(0x10, PORT186CR);
> > + =C2=A0 =C2=A0 =C2=A0 __raw_writeb(0x10, PORT187CR);
> > + =C2=A0 =C2=A0 =C2=A0 __raw_writeb(0x10, PORT188CR);
>=20
> Aren't these LEDs a board-specific property?
>=20
> I believe the rest of the code is common across multiple boards, so
> making it fully sharable would be nice.
>=20
> Please break out the board-specific somehow, perhaps into
> mmcif_update_progress().

Sure, perhaps we could just move this initialisation into head-ap4evb.t=
xt?
Or remove mmcif_update_progress() all together?

> > Index: linux-2.6-ap4/arch/arm/boot/compressed/head-shmobile.S
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6-ap4.orig/arch/arm/boot/compressed/head-shmobile.S 201=
0-12-06 09:11:35.000000000 +0900
> > +++ linux-2.6-ap4/arch/arm/boot/compressed/head-shmobile.S =C2=A0 =C2=
=A0 =C2=A02010-12-06 09:11:42.000000000 +0900
> > @@ -40,14 +59,19 @@ __atags:@ tag #1
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0@ tag #3
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.long =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @ tag->hdr.size =3D 0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0.long =C2=A0 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @ tag->hdr.tag =3D AT=
AG_NONE;
> > -1:
> > +__mach_type:
> > + =C2=A0 =C2=A0 =C2=A0 .long =C2=A0 MACH_TYPE
> > +__image_start:
> > + =C2=A0 =C2=A0 =C2=A0 .long =C2=A0 _start
> > +__image_end:
> > + =C2=A0 =C2=A0 =C2=A0 .long =C2=A0 _got_end
> > +__load_base:
> > + =C2=A0 =C2=A0 =C2=A0 .long =C2=A0 CONFIG_MEMORY_START + 0x0200000=
0 @ Load at 32Mb into SDRAM
>=20
> Just curious, where does these 32Mb come from?

IMHO Its fairly arbitrary where the zImage is copied to.
I chose 32Mb as it is the same place that uboot puts images.

> Say that a board with be equipped with less than 32Mb, how is that ha=
ndled?

It isn't.

An alternate approach might be to just place it at the end of the
destination, which can be approximated using 4 * the compressed image s=
ize.
The same assumption is made in arch/arm/boot/compressed/vmlinux.lds.in.

I'm open to other ideas about where to copy the zImage to.

> > Index: linux-2.6-ap4/Documentation/arm/SH-Mobile/vrl4.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- /dev/null =C2=A0 1970-01-01 00:00:00.000000000 +0000
> > +++ linux-2.6-ap4/Documentation/arm/SH-Mobile/vrl4.c =C2=A0 =C2=A02=
010-12-06 09:11:42.000000000 +0900
> > @@ -0,0 +1,167 @@
> > +/*
> > + * vrl4 format generator
> > + *
> > + * Copyright (C) 2010 Magnus Damm
> > + *
> > + * This file is subject to the terms and conditions of the GNU Gen=
eral Public
> > + * License. =C2=A0See the file "COPYING" in the main directory of =
this archive
> > + * for more details.
> > + */
>=20
> That's sweet, but I don't think I've got anything to do with this
> portion of the code. =3D)

Sorry, I had both of our names there from text copied from elsewhere
and deleted the wrong one.

> Apart from those minor points it all looks very good IMO!

Thanks!

