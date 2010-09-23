From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: [PATCH v2] tmio_mmc: Allow 2 byte requests in 4-bit mode
Date: Thu, 23 Sep 2010 20:11:26 +0100
Message-ID: <AANLkTi=TPR5zPav0TyM=YaCW22a+G0L0M4jxEFN+FXDW@mail.gmail.com>
References: <6c0f551ff67fb9f67f4b565fbe4ffdc1f4c8bc49.1283164379.git.matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62321 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755813Ab0IWTLr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 15:11:47 -0400
Received: by gwj17 with SMTP id 17so691529gwj.19
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 12:11:47 -0700 (PDT)
In-Reply-To: <6c0f551ff67fb9f67f4b565fbe4ffdc1f4c8bc49.1283164379.git.matt@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Arnd Hannemann <arnd@arndnet.de>, Samuel Ortiz <sameo@linux.intel.com>

If its not already gone through...

Acked-by: Ian Molton <ian@mnementh.co.uk>

--=20
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/



On 30 August 2010 11:50, Matt Fleming <matt@console-pimps.org> wrote:
> From: Yusuke Goda <yusuke.goda.sx@renesas.com>
>
> Adjust the tmio_mmc block size check to accept 2-byte requests in 4-b=
it
> mode if the hardware supports it.
>
> Tested with the SDHI hardware block included in sh7724.
>
> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> ---
>
> Andrew, I've added some code to Yusuke's original patch based on
> feedback from Ian Molton saying that the original change didn't work =
on
> his hardware. I'd really prefer some Tested-by's and Acked-by's befor=
e
> you take this patch just so we can make sure that everybody is happy =
and
> that everybody's hardware still works.
>
> Magnus was worried that this patch would conflict with the SDHI/MMCIF
> hotplug patches from Arnd (particularly "[PATCH 1/4] tmio_mmc: Allow =
the
> mfd driver to specify get_cd handler") but I seem to be able to shuff=
le
> the patches around without any conflicts.
>
> =A0drivers/mfd/sh_mobile_sdhi.c | =A0 =A06 ++++++
> =A0drivers/mmc/host/tmio_mmc.c =A0| =A0 17 ++++++++++++-----
> =A0include/linux/mfd/tmio.h =A0 =A0 | =A0 =A05 +++++
> =A03 files changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mfd/sh_mobile_sdhi.c b/drivers/mfd/sh_mobile_sdh=
i.c
> index 7c23630..9d43316 100644
> --- a/drivers/mfd/sh_mobile_sdhi.c
> +++ b/drivers/mfd/sh_mobile_sdhi.c
> @@ -125,6 +125,12 @@ static int __init sh_mobile_sdhi_probe(struct pl=
atform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_data->capabilities |=3D p->tmio_ca=
ps;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* All SDHI blocks support 2-byte and larger block si=
zes in 4-bit
> + =A0 =A0 =A0 =A0* bus width mode.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 mmc_data->flags |=3D TMIO_MMC_BLKSZ_2BYTES;
> +
> =A0 =A0 =A0 =A0if (p && p->dma_slave_tx >=3D 0 && p->dma_slave_rx >=3D=
 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->param_tx.slave_id =3D p->dma_sla=
ve_tx;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->param_rx.slave_id =3D p->dma_sla=
ve_rx;
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.=
c
> index 1a47221..e7765a8 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -658,14 +658,21 @@ static void tmio_mmc_release_dma(struct tmio_mm=
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
> - =A0 =A0 =A0 /* Hardware cannot perform 1 and 2 byte requests in 4 b=
it mode */
> - =A0 =A0 =A0 if (data->blksz < 4 && host->mmc->ios.bus_width =3D=3D =
MMC_BUS_WIDTH_4) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: %d byte block unsupported i=
n 4 bit mode\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(host->mmc),=
 data->blksz);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 /* Some hardware cannot perform 2 byte requests in 4 bi=
t mode */
> + =A0 =A0 =A0 if (host->mmc->ios.bus_width =3D=3D MMC_BUS_WIDTH_4) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int blksz_2bytes =3D pdata->flags & TMI=
O_MMC_BLKSZ_2BYTES;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->blksz < 2 || (data->blksz < 4=
 && !blksz_2bytes)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: %d byte blo=
ck unsupported in 4 bit mode\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_host=
name(host->mmc), data->blksz);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0tmio_mmc_init_sg(host, data);
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index 24c43bb..085f041 100644
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
> +#define TMIO_MMC_BLKSZ_2BYTES =A0 =A0 =A0 =A0 =A0(1 << 1)
>
> =A0int tmio_core_mmc_enable(void __iomem *cnf, int shift, unsigned lo=
ng base);
> =A0int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned lo=
ng base);
> --
> 1.7.1
>
>
