From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] tmio_mmc: Prevents unexpected status clear
Date: Fri, 27 Aug 2010 17:02:49 +0900
Message-ID: <AANLkTi=GDvOQ8B7fxONJC8gThV9bn40rHv1P7OUvdo+a@mail.gmail.com>
References: <20100708144626.2091f6c1.akpm@linux-foundation.org>
	<4C3BBE77.8080000@renesas.com>
	<20100715132552.fcb5791b.akpm@linux-foundation.org>
	<20100825231107.45227d6a@linux-g6p1.site>
	<20100825160722.9c9c38c8.akpm@linux-foundation.org>
	<4C75BB0D.2030202@renesas.com>
	<20100826075320.0538043b@linux-g6p1.site>
	<AANLkTim2_8UU62hnvSrPK94MgaM35K0PbppGe8yeW-bC@mail.gmail.com>
	<20100826072642.GB19339@console-pimps.org>
	<20100826141237.c31bc1ed.akpm@linux-foundation.org>
	<20100826221024.GA11300@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49419 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab0H0ICu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Aug 2010 04:02:50 -0400
Received: by qyk9 with SMTP id 9so358120qyk.19
        for <linux-mmc@vger.kernel.org>; Fri, 27 Aug 2010 01:02:49 -0700 (PDT)
In-Reply-To: <20100826221024.GA11300@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yusuke Goda <yusuke.goda.sx@renesas.com>, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Paul Mundt <lethal@linux-sh.org>

On Fri, Aug 27, 2010 at 7:10 AM, Matt Fleming <matt@console-pimps.org> =
wrote:
> On Thu, Aug 26, 2010 at 02:12:37PM -0700, Andrew Morton wrote:
>> On Thu, 26 Aug 2010 08:26:42 +0100
>> Matt Fleming <matt@console-pimps.org> wrote:
>>
>> > On Thu, Aug 26, 2010 at 03:58:38PM +0900, Magnus Damm wrote:
>> > >
>> > > Hi Matt,
>> > >
>> > > Just FYI, the newer version of these patches also have a whole b=
unch
>> > > of acked-by and tested-by tags, see this email:
>> > >
>> > > http://lkml.org/lkml/2010/8/20/429
>> > >
>> > > Thanks for your help!
>> >
>> > Argh, right. Claws-mail searching has completely failed me. I didn=
't
>> > even see that thread when searching to "tmio_mmc". Back to mutt..
>> >
>> > Andrew, can you drop the patch with my changelog and pick up the o=
ne in
>> > that thread seeing as it's got all the tags and a new changelog? T=
hanks.
>>
>> I actually already had it, as
>> tmio_mmc-dont-clear-unhandled-pending-interrupts.patch, scheduled fo=
r
>> 2.6.36 and -stable.
>>
>> What's the score with "tmio_mmc: allow 2 byte requests in 4-bit mode=
"?
>> I didn't merge it because Ian said "This change needs to be modified=
 to
>> test what hardware is present. =A0this wont work on my hardware TTBO=
MK.".
>> =A0Then I later _did_ merge it because it got sneakily renamed to
>> "tmio_mmc: revise a limit of the data size".
>
> I've stuck my oar in and confused everybody now, it seems. As Ian
> pointed out, before "tmio_mmc: revise a limit of the data size" can b=
e
> merged something like the following is needed,
>
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.=
c
> index ee7d0a5..3eabd91 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -657,11 +657,15 @@ static void tmio_mmc_release_dma(struct tmio_mm=
c_host *host)
> =A0static int tmio_mmc_start_data(struct tmio_mmc_host *host,
> =A0 =A0 =A0 =A0struct mmc_data *data)
> =A0{
> + =A0 =A0 =A0 struct mfd_cell *cell =3D host->pdev->dev.platform_data=
;
> + =A0 =A0 =A0 struct tmio_mmc_data *pdata =3D cell->driver_data;
> +
> =A0 =A0 =A0 =A0pr_debug("setup data transfer: blocksize %08x =A0nr_bl=
ocks %d\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->blksz, data->blocks);
>
> =A0 =A0 =A0 =A0/* Hardware cannot perform 1 and 2 byte requests in 4 =
bit mode */
> - =A0 =A0 =A0 if (data->blksz < 4 && host->mmc->ios.bus_width =3D=3D =
MMC_BUS_WIDTH_4) {
> + =A0 =A0 =A0 if (data->blksz < 4 && !(pdata->flags & TMIO_MMC_2BYTE_=
BLKSZ) &&
> + =A0 =A0 =A0 =A0 =A0 host->mmc->ios.bus_width =3D=3D MMC_BUS_WIDTH_4=
) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: %d byte block unsupported =
in 4 bit mode\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(host->mmc), =
data->blksz);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index f07425b..56467cb 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -52,6 +52,11 @@
>
> =A0/* tmio MMC platform flags */
> =A0#define TMIO_MMC_WRPROTECT_DISABLE =A0 =A0 (1 << 0)
> +/*
> + * Some controllers can support a 2-byte block size when the bus wid=
th
> + * is configured in 4-bit mode.
> + */
> +#define TMIO_MMC_2BYTE_BLKSZ =A0 =A0 =A0 =A0 =A0 (1 << 1)
>
> =A0int tmio_core_mmc_enable(void __iomem *cnf, int shift, unsigned lo=
ng base);
> =A0int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned lo=
ng base);
>
>
> Magnus, since people have tested 2-byte blksz transfers on SDHI and i=
t
> works, does it make sense to have this change to
> drivers/mfd/sh_mobile_sdhi.c? Are you aware of a version of the SDHI
> block that doens't support this mode?

Yes, updating drivers/mfd/sh_mobile_sdhi.c seems like a good plan.

We've tested this on a few different SH/ARM processors with SDHI, and
they all seem to be ok with 2-byte mode.

> diff --git a/drivers/mfd/sh_mobile_sdhi.c b/drivers/mfd/sh_mobile_sdh=
i.c
> index cd16459..1f3a1b1 100644
> --- a/drivers/mfd/sh_mobile_sdhi.c
> +++ b/drivers/mfd/sh_mobile_sdhi.c
> @@ -112,6 +112,12 @@ static int __init sh_mobile_sdhi_probe(struct pl=
atform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_data->ocr_mask =3D p->tmio_ocr_mas=
k;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* All SDHI blocks support 2-byte and larger block si=
zes in 4-bit
> + =A0 =A0 =A0 =A0* bus width mode.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 mmc_data->flags |=3D TMIO_MMC_2BYTE_BLKSZ;
> +
> =A0 =A0 =A0 =A0if (p && p->dma_slave_tx >=3D 0 && p->dma_slave_rx >=3D=
 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->param_tx.slave_id =3D p->dma_sla=
ve_tx;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->param_rx.slave_id =3D p->dma_sla=
ve_rx;
>
> So I think these patches need to either be merged into "tmio_mmc: rev=
ise
> a limit of the data size" with a bit in the changelog explaning that
> some tmio blocks don't support 2-byte tranfers, or added as separate
> patches before it.
>
> Does everyone agree?

I certainly agree. =3D)

By the way, you may want to check that this patch doesn't collide with
the SDHI/MMCIF hotplug patches that were recently posted to the
linux-sh list.

Thanks a lot!

/ magnus
