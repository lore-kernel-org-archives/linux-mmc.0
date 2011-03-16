From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 4/4 v4] mmc, ARM: Add zboot from eSD support for SuperH
 Mobile ARM
Date: Wed, 16 Mar 2011 11:20:46 +0900
Message-ID: <AANLkTimBOc2+Ryq+fwas0SPmYqbnJH6_b28DTPJx_p99@mail.gmail.com>
References: <1300071435-26759-1-git-send-email-horms@verge.net.au>
	<1300071435-26759-5-git-send-email-horms@verge.net.au>
	<20110315222738.GA23288@verge.net.au>
	<AANLkTimgwpP-WTGF-E=KO3TAXDX7FP4WnW3XQiHi0Ton@mail.gmail.com>
	<20110316011427.GB6724@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110316011427.GB6724@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Mar 16, 2011 at 10:14 AM, Simon Horman <horms@verge.net.au> wro=
te:
> On Wed, Mar 16, 2011 at 09:37:50AM +0900, Magnus Damm wrote:
>> On Wed, Mar 16, 2011 at 7:27 AM, Simon Horman <horms@verge.net.au> w=
rote:
>> > This allows a ROM-able zImage to be written to eSD and for SuperH =
Mobile
>> > ARM to boot directly from the SDHI hardware block.
>> >
>> > This is achieved by the MaskROM loading the first portion of the i=
mage into
>> > MERAM and then jumping to it. =A0This portion contains loader code=
 which
>> > copies the entire image to SDRAM and jumps to it. From there the z=
Image
>> > boot code proceeds as normal, uncompressing the image into its fin=
al
>> > location and then jumping to it.
>> >
>> > Cc: Paul Mundt <lethal@linux-sh.org>
>> > Cc: Magnus Damm <magnus.damm@gmail.com>
>> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> > Signed-off-by: Simon Horman <horms@verge.net.au>
>> >
>> > ---
>> >
>> > This patch is based on the for-next branch of
>> > Russell King's linux-2.6-arm tree
>> >
>> > v2
>> > * Consistently use __raw_readw(). As pointed out by Paul Mundt
>> >
>> > v3
>> > * Remove mmcif_update_progress2(), it was for debugging during dev=
elopment
>> > * Move CPU specific code into mach/sdhi.h
>> > =A0As requested by Magnus Damm
>> > * Use linux/mmc/tmio.h now that it exists
>> > * Remove SDHI_EXT_SWAP, it is unused
>> > * Replace use of MMCIF_PROGRESS_* with MMC_PROGRESS_*
>> > * Don't include linux/mmc/sh_mmcif.h
>> > =A0+ Replace use of MMCIF_CE_RESP_CMD12 with RESP_CMD12
>> > =A0+ Include linux/io.h
>> >
>> > v4
>> > * Move definition of SDHI_BASE into CPU-specific code.
>> > =A0Thanks to Magnus Damm.
>> > ---
>>
>> > +asmlinkage void mmc_loader(unsigned short *buf, unsigned long len=
)
>> > +{
>> > + =A0 =A0 =A0 int high_capacity;
>> > +
>> > + =A0 =A0 =A0 mmc_init_progress();
>> > +
>> > + =A0 =A0 =A0 mmc_update_progress(MMC_PROGRESS_ENTER);
>> > + =A0 =A0 =A0 sdhi_boot_enter();
>> > +
>> > + =A0 =A0 =A0 /* setup SDHI hardware */
>> > + =A0 =A0 =A0 mmc_update_progress(MMC_PROGRESS_INIT);
>> > + =A0 =A0 =A0 high_capacity =3D sdhi_boot_init(SDHI_BASE);
>> > + =A0 =A0 =A0 if (high_capacity < 0)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> > +
>> > + =A0 =A0 =A0 mmc_update_progress(MMC_PROGRESS_LOAD);
>> > + =A0 =A0 =A0 /* load kernel */
>> > + =A0 =A0 =A0 if (sdhi_boot_do_read(SDHI_BASE, high_capacity,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, /* Ke=
rnel is at block 1 */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (len + T=
MIO_BBS - 1) / TMIO_BBS, buf))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> > +
>> > + =A0 =A0 =A0 sdhi_boot_cleanup();
>> > +
>> > + =A0 =A0 =A0 mmc_update_progress(MMC_PROGRESS_DONE);
>> > +
>> > + =A0 =A0 =A0 return;
>> > +err:
>> > + =A0 =A0 =A0 __raw_writel(__raw_readl(PORTR031_000DR) | 1, PORTR0=
31_000DR);
>> > + =A0 =A0 =A0 for(;;);
>> > +
>> > +}
>>
>> Sorry for not catching this earlier, but this __raw_writel() to
>> PORTR031_000DR is cpu specific as well. So please move that to the C=
PU
>> specific code.
>
> I will just remove that code, its was useful for development
> but I didn't mean to include it in my patch submission.

Ok, good!

>> Not sure if it makes sense at this point, but perhaps it's a good id=
ea
>> to move the mmc_loader() function into the CPU specific portion. As
>> you know, the CPU itself has multiple SDHI hardware blocks, and
>> because of that we want the common SDHI loader to be written to
>> support any SDHI hardware block instance.
>
> Wouldn't that mean moving all of
> arch/arm/boot/compressed/sdhi-shmobile.c into CPU specific code?
> That could easily be achived by just guarding its compilation with
> CONFIG_ARCH_SH7372 (as mmcif-sh7372.c already is) and perhaps
> renaming the file to sdhi-sh7372.c. We could probably move
> arch/arm/mach-shmobile/include/mach/sdhi-sh7372.h back into
> sdhi-shmobile.c.

No, I didn't mean moving all the SDHI loader code into the CPU
specific place - just the mmc_loader() function.

>> Right now the SDHI_BASE variable is limiting the shared SDHI loader
>> code to a fixed hardware block instance. That's fine because we only
>> boot from a single SDHI hardware block instance on sh7372, but futur=
e
>> processors most likely support selecting boot SDHI hardware block
>> instance.
>
> So mmc_loader() would need to take SDHI_BASE as an argument?
> That sounds like a fairly small amount of refactoring.

Yes, that's maybe more realistic, I'm not sure. Please remember that
you probably want to select different GPIO pins for different SDHI
instances, so you also need to adjust the
sdhi_boot_enter()/sdhi_boot_cleanup() to receive SDHI_BASE as an
argument too if you go down that route.

> How do you envisage that the hardware block would be selected?
> At compile time through Kconfig? If so the current #define mechanism
> might be sufficient.

Not through Kconfig. I think you should use Kconfig to enable the SDHI
loader, but you should be able to select the SDHI base address during
run-time. Similar to how we enable platform device drivers with
Kconfig but put the instance information in the platform device
resource and data outside the driver.

So for instance, on some board we may want to read a GPIO pin at boot
up time to select if we should boot from SDHI0 or SDHI1. I would like
the SDHI loader to be designed so we can have support for multiple
instances complied-in. Because of that I'd like to see the fixed
SDHI_BASE disappear from the header, and letting the mmc_loader()
function take the base address as an argument, or simply move the
mmc_loader() function out of the SDHI loader code to give CPU specific
and/or board specific code freedom to select which ever SDHI hardware
block instance(s) they want to load from.

Perhaps this would require some serious refactoring?

Thanks,

/ magnus
