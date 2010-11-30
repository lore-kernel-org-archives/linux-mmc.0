From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 1/2] [rfc] mmc, sh: Read MMCIF during zboot
Date: Tue, 30 Nov 2010 14:11:43 +0900
Message-ID: <AANLkTi=f-o6Bskb_ZAgco2+Hwm-ra+A_oOvtkogycQup@mail.gmail.com>
References: <1290812757-20571-1-git-send-email-horms@verge.net.au>
	<1290812757-20571-2-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34645 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab0K3FLo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Nov 2010 00:11:44 -0500
In-Reply-To: <1290812757-20571-2-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>

Hi Simon,

Thanks for your work on this! It's nice to see that you can actually
load some data early on.

On Sat, Nov 27, 2010 at 8:05 AM, Simon Horman <horms@verge.net.au> wrot=
e:
> This is a prototype of code to read the MMCIF during
> zboot initialisation. The intention is that it will form
> part of enabling booting from MMC. Very roughly the plan is
>
> 1) The Mask Rom will load a small boot program from MMC.
> =A0 Essentially this will be the first portion of
> =A0 the kernel to be booted.
> 2) That program will load the remainder of the kernel
> =A0 from MMC and boot from it.
>
> This patch demonstrates code to perform the read portion of 2).
> It uses a dummy buffer and only reads in one 512 byte sector.
> A full implementation of 2) would of course read much more.
>
> The patch currently hooks into head-shmobile.S as it
> depends on initialisation that occurs in that file.
> However, it is likely that the final implementation
> will need to be located in head.S where relocation is
> currently handled.
>
> I used a multi-voltage MMC mobile card to test this code.
> I observed that a single-voltage MMC and MMCplus card caused
> the code to time-out in sh_mmcif_boot_init() which causes
> the boot to stop.
>
> This patch depends on "ARM: mach-shmobile: Add zboot support for Supe=
rH
> Mobile ARM" and "mmc, sh: Correct value for reset".
>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
> =A0arch/arm/boot/compressed/Makefile =A0 =A0 =A0 =A0| =A0 =A04 +
> =A0arch/arm/boot/compressed/head-shmobile.S | =A0 16 +++++
> =A0arch/arm/boot/compressed/mmcif-sh7372.c =A0| =A0100 ++++++++++++++=
++++++++++++++++
> =A03 files changed, 120 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/boot/compressed/mmcif-sh7372.c
>
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compre=
ssed/Makefile
> index 0a8f748..f730c10 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -49,6 +49,10 @@ ifeq ($(CONFIG_ARCH_SHMOBILE),y)
> =A0OBJS =A0 =A0 =A0 =A0 =A0 +=3D head-shmobile.o
> =A0endif
>
> +ifeq ($(CONFIG_ARCH_SH7372),y)
> +OBJS =A0 =A0 =A0 =A0 =A0 +=3D mmcif-sh7372.o
> +endif
> +
> =A0#
> =A0# We now have a PIC decompressor implementation. =A0Decompressors =
running
> =A0# from RAM should not define ZTEXTADDR. =A0Decompressors running d=
irectly
> diff --git a/arch/arm/boot/compressed/head-shmobile.S b/arch/arm/boot=
/compressed/head-shmobile.S
> index 30973b7..700d622 100644
> --- a/arch/arm/boot/compressed/head-shmobile.S
> +++ b/arch/arm/boot/compressed/head-shmobile.S
> @@ -26,6 +26,22 @@
> =A0#include <mach/zboot.h>
>
> =A0 =A0 =A0 =A0b =A0 =A0 =A0 1f
> + =A0 =A0 =A0 .align
> +__tmp_stack:
> + =A0 =A0 =A0 .space =A0128
> +__dummy_buf:
> + =A0 =A0 =A0 .space =A0512
> +__dummy_buf_size:
> + =A0 =A0 =A0 .long =A0 512
> +1:
> + =A0 =A0 =A0 adr =A0 =A0 sp, __tmp_stack
> + =A0 =A0 =A0 add =A0 =A0 sp, sp, #128
> + =A0 =A0 =A0 adr =A0 =A0 r0, __dummy_buf
> + =A0 =A0 =A0 ldr =A0 =A0 r1, __dummy_buf_size

Regarding the destination address, look into using CONFIG_MEMORY_START
or perhaps something more advanced like the actual destination address
for the kernel - see arch/arm/boot/compressed/head.S and TEXT_OFFSET
or zreladdr.

As for the number of bytes to load, please have a look at the sh7724
implementation.

> + =A0 =A0 =A0 mov =A0 =A0 lr, pc
> + =A0 =A0 =A0 b =A0 =A0 =A0 mmcif_loader
> +
> + =A0 =A0 =A0 b =A0 =A0 =A0 1f
> =A0__atags:@ tag #1
> =A0 =A0 =A0 =A0.long =A0 12 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
@ tag->hdr.size =3D tag_size(tag_core);
> =A0 =A0 =A0 =A0.long =A0 0x54410001 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ tag-=
>hdr.tag =3D ATAG_CORE;
> diff --git a/arch/arm/boot/compressed/mmcif-sh7372.c b/arch/arm/boot/=
compressed/mmcif-sh7372.c
> new file mode 100644
> index 0000000..7ffaf27
> --- /dev/null
> +++ b/arch/arm/boot/compressed/mmcif-sh7372.c
> @@ -0,0 +1,100 @@
> +/*
> + * sh7372 MMCIF loader
> + *
> + * Copyright (C) 2010 Magnus Damm
> + * Copyright (C) 2010 Simon Horman
> + *
> + * This file is subject to the terms and conditions of the GNU Gener=
al Public
> + * License. =A0See the file "COPYING" in the main directory of this =
archive
> + * for more details.
> + */
> +
> +#include <linux/mmc/sh_mmcif.h>
> +
> +#define MMCIF_BASE =A0 =A0 =A0(void __iomem *)0xe6bd0000
> +
> +#define PORT84CR =A0 =A0 =A0 0xe6050054
> +#define PORT85CR =A0 =A0 =A0 0xe6050055
> +#define PORT86CR =A0 =A0 =A0 0xe6050056
> +#define PORT87CR =A0 =A0 =A0 0xe6050057
> +#define PORT88CR =A0 =A0 =A0 0xe6050058
> +#define PORT89CR =A0 =A0 =A0 0xe6050059
> +#define PORT90CR =A0 =A0 =A0 0xe605005a
> +#define PORT91CR =A0 =A0 =A0 0xe605005b
> +#define PORT92CR =A0 =A0 =A0 0xe605005c
> +#define PORT99CR =A0 =A0 =A0 0xe6050063
> +#define PORT185CR =A0 =A0 =A00xe60520b9
> +#define PORT186CR =A0 =A0 =A00xe60520ba
> +#define PORT187CR =A0 =A0 =A00xe60520bb
> +#define PORT188CR =A0 =A0 =A00xe60520bc
> +#define PORTR191_160DR =A00xe6056014
> +
> +#define SMSTPCR3 =A0 =A0 =A0 0xe615013c
> +
> +enum { MMCIF_PROGRESS_ENTER, MMCIF_PROGRESS_INIT,
> + =A0 =A0 =A0 MMCIF_PROGRESS_LOAD, MMCIF_PROGRESS_DONE };
> +
> +static void mmcif_update_progress(int n)
> +{
> + =A0 =A0 =A0 __raw_writel((__raw_readl(PORTR191_160DR) & ~(0xf << 25=
)) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << (25 + n)), PORTR191_16=
0DR);
> +}

This seems like a board specific property to me. So please break it
out in to a per-board header or similar.

I guess next step is to extend the prototype code so it loads the
entire kernel from MMC and then jumps to it. =3D)

Cheers,

/ magnus
