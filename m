From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 4/4 v4] mmc, ARM: Add zboot from eSD support for SuperH
 Mobile ARM
Date: Wed, 16 Mar 2011 10:14:42 +0900
Message-ID: <20110316011427.GB6724@verge.net.au>
References: <1300071435-26759-1-git-send-email-horms@verge.net.au>
 <1300071435-26759-5-git-send-email-horms@verge.net.au>
 <20110315222738.GA23288@verge.net.au>
 <AANLkTimgwpP-WTGF-E=KO3TAXDX7FP4WnW3XQiHi0Ton@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimgwpP-WTGF-E=KO3TAXDX7FP4WnW3XQiHi0Ton@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

Hi Magnus,

On Wed, Mar 16, 2011 at 09:37:50AM +0900, Magnus Damm wrote:
> Hi Simon,
>=20
> Thanks for your work on this!

[ snip ]

>=20
> On Wed, Mar 16, 2011 at 7:27 AM, Simon Horman <horms@verge.net.au> wr=
ote:
> > This allows a ROM-able zImage to be written to eSD and for SuperH M=
obile
> > ARM to boot directly from the SDHI hardware block.
> >
> > This is achieved by the MaskROM loading the first portion of the im=
age into
> > MERAM and then jumping to it. =C2=A0This portion contains loader co=
de which
> > copies the entire image to SDRAM and jumps to it. From there the zI=
mage
> > boot code proceeds as normal, uncompressing the image into its fina=
l
> > location and then jumping to it.
> >
> > Cc: Paul Mundt <lethal@linux-sh.org>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> >
> > ---
> >
> > This patch is based on the for-next branch of
> > Russell King's linux-2.6-arm tree
> >
> > v2
> > * Consistently use __raw_readw(). As pointed out by Paul Mundt
> >
> > v3
> > * Remove mmcif_update_progress2(), it was for debugging during deve=
lopment
> > * Move CPU specific code into mach/sdhi.h
> > =C2=A0As requested by Magnus Damm
> > * Use linux/mmc/tmio.h now that it exists
> > * Remove SDHI_EXT_SWAP, it is unused
> > * Replace use of MMCIF_PROGRESS_* with MMC_PROGRESS_*
> > * Don't include linux/mmc/sh_mmcif.h
> > =C2=A0+ Replace use of MMCIF_CE_RESP_CMD12 with RESP_CMD12
> > =C2=A0+ Include linux/io.h
> >
> > v4
> > * Move definition of SDHI_BASE into CPU-specific code.
> > =C2=A0Thanks to Magnus Damm.
> > ---
>=20
> > +asmlinkage void mmc_loader(unsigned short *buf, unsigned long len)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 int high_capacity;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 mmc_init_progress();
> > +
> > + =C2=A0 =C2=A0 =C2=A0 mmc_update_progress(MMC_PROGRESS_ENTER);
> > + =C2=A0 =C2=A0 =C2=A0 sdhi_boot_enter();
> > +
> > + =C2=A0 =C2=A0 =C2=A0 /* setup SDHI hardware */
> > + =C2=A0 =C2=A0 =C2=A0 mmc_update_progress(MMC_PROGRESS_INIT);
> > + =C2=A0 =C2=A0 =C2=A0 high_capacity =3D sdhi_boot_init(SDHI_BASE);
> > + =C2=A0 =C2=A0 =C2=A0 if (high_capacity < 0)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 mmc_update_progress(MMC_PROGRESS_LOAD);
> > + =C2=A0 =C2=A0 =C2=A0 /* load kernel */
> > + =C2=A0 =C2=A0 =C2=A0 if (sdhi_boot_do_read(SDHI_BASE, high_capaci=
ty,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, /* Kernel is at block 1 */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (len + TMIO_BBS - 1) / TMIO_BBS, buf))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 sdhi_boot_cleanup();
> > +
> > + =C2=A0 =C2=A0 =C2=A0 mmc_update_progress(MMC_PROGRESS_DONE);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 return;
> > +err:
> > + =C2=A0 =C2=A0 =C2=A0 __raw_writel(__raw_readl(PORTR031_000DR) | 1=
, PORTR031_000DR);
> > + =C2=A0 =C2=A0 =C2=A0 for(;;);
> > +
> > +}
>=20
> Sorry for not catching this earlier, but this __raw_writel() to
> PORTR031_000DR is cpu specific as well. So please move that to the CP=
U
> specific code.

I will just remove that code, its was useful for development
but I didn't mean to include it in my patch submission.

> Not sure if it makes sense at this point, but perhaps it's a good ide=
a
> to move the mmc_loader() function into the CPU specific portion. As
> you know, the CPU itself has multiple SDHI hardware blocks, and
> because of that we want the common SDHI loader to be written to
> support any SDHI hardware block instance.

Wouldn't that mean moving all of
arch/arm/boot/compressed/sdhi-shmobile.c into CPU specific code?
That could easily be achived by just guarding its compilation with
CONFIG_ARCH_SH7372 (as mmcif-sh7372.c already is) and perhaps
renaming the file to sdhi-sh7372.c. We could probably move
arch/arm/mach-shmobile/include/mach/sdhi-sh7372.h back into
sdhi-shmobile.c.

> Right now the SDHI_BASE variable is limiting the shared SDHI loader
> code to a fixed hardware block instance. That's fine because we only
> boot from a single SDHI hardware block instance on sh7372, but future
> processors most likely support selecting boot SDHI hardware block
> instance.

So mmc_loader() would need to take SDHI_BASE as an argument?
That sounds like a fairly small amount of refactoring.

How do you envisage that the hardware block would be selected?
At compile time through Kconfig? If so the current #define mechanism
might be sufficient.

> Apart from those minor bits I think the code is getting into a really
> good shape!

Thanks
