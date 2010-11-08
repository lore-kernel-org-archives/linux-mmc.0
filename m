From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] sdhci: 8 bit widths - allow new QUIRK for 8 bit and v3 sd controller
Date: Mon, 8 Nov 2010 21:07:03 +0900
Message-ID: <AANLkTin+WP6CqO7dz5vDt-S-+HWpcuwo+RiAZKTpJAeT@mail.gmail.com>
References: <74C0C915-257F-41CC-AEA8-C6F5B839586B@marvell.com>
	<20101107220411.GB5376@pengutronix.de>
	<BEF8AD05-D094-4607-8C4F-1908C4FF54B3@marvell.com>
	<20101108091754.GA8638@pengutronix.de>
	<AANLkTi=9omu=yDXEk_=QhGsz6xy3VVxn39T4DF7UvHjR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52433 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab0KHMHF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2010 07:07:05 -0500
Received: by pzk28 with SMTP id 28so808262pzk.19
        for <linux-mmc@vger.kernel.org>; Mon, 08 Nov 2010 04:07:04 -0800 (PST)
In-Reply-To: <AANLkTi=9omu=yDXEk_=QhGsz6xy3VVxn39T4DF7UvHjR@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, Nov 8, 2010 at 8:48 PM, zhangfei gao <zhangfei.gao@gmail.com> w=
rote:
> On Mon, Nov 8, 2010 at 4:17 AM, Wolfram Sang <w.sang@pengutronix.de> =
wrote:
>>> > This isn't a quirk, this is platform_data, no?
>>>
>>> Never sure of the difference between a quirk and platform data.
>>> example: =A0Broken card detect is a quirk but maybe some slots on t=
he board work and some do not
>>
>> A quirk is something which needs to be handled in a special case bec=
ause
>> some controllers do not adhere to the SDHC standard. An 8 bit bus se=
ems
>> to be in the 3.0 standard, so it is not a quirk :) Does the standard=
 say
>> anything about how the actual bus width should be handled?
>>
>> That said, you are right that quirks have been abused to cover board
>> issues. Another reason to clean them up ;)
>>
>> Regards,
>>
>> =A0 Wolfram
>>
>> --
>> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | Wolfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
>> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://=
www.pengutronix.de/ =A0|
>>
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.4.10 (GNU/Linux)
>>
>> iEYEARECAAYFAkzXwEIACgkQD27XaX1/VRuQ8QCeN1ueDODn5jbt9MS49MCJcQXS
>> BccAn0VnBmmBbLRFvBf/wo4zStAXUGV0
>> =3DVwO1
>> -----END PGP SIGNATURE-----
>>
>>
>
> Highly concern of abuse of QUIRK, currently the highest bit is
> (1<<29), while the quirks is u32.
> Could we remove some quirk, such as SDHCI_QUIRK_FORCE_1_BIT_DATA,
> which only used to transfer info to caps.
> We could simply update mmc->caps after sdhci_add_host.

Good, it's good starting pointing to remove SoC specific quriks.
Now we try to find out that which quirks are needed for SDHCI.

Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

>
>
> =A0arch/arm/plat-pxa/include/plat/sdhci.h | =A0 =A02 ++
> =A0drivers/mmc/host/sdhci-pxa.c =A0 =A0 =A0 =A0 =A0 | =A0 =A05 +++++
> =A0drivers/mmc/host/sdhci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 --=
-
> =A0include/linux/mmc/sdhci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 --
> =A04 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
> b/arch/arm/plat-pxa/include/plat/sdhci.h
> index e49c5b6..661dc48 100644
> --- a/arch/arm/plat-pxa/include/plat/sdhci.h
> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
> @@ -16,6 +16,8 @@
> =A0/* pxa specific flag */
> =A0/* Require clock free running */
> =A0#define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
> +#define PXA_FLAG_FORCE_1_BIT_DATA (1<<2)
> +#define PXA_FLAG_CAN_DO_8_BIT_DATA (1<<3)
>
> =A0/*
> =A0* struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-px=
a.c
> index fc406ac..3d63a37 100644
> --- a/drivers/mmc/host/sdhci-pxa.c
> +++ b/drivers/mmc/host/sdhci-pxa.c
> @@ -147,6 +147,11 @@ static int __devinit sdhci_pxa_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (pxa->pdata->flags & PXA_FLAG_FORCE_1_BIT_DATA)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps &=3D ~(MMC_CAP_4_BIT_DA=
TA | MMC_CAP_8_BIT_DATA);
> + =A0 =A0 =A0 if (pxa->pdata->flags & PXA_FLAG_CAN_DO_8_BIT_DATA)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps |=3D MMC_CAP_8_BIT_DATA=
;
> +
> =A0 =A0 =A0 =A0if (pxa->pdata->max_speed)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mmc->f_max =3D pxa->pdata->max_s=
peed;
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 154cbf8..2628ec2 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1858,9 +1858,6 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0mmc->f_max =3D host->max_clk;
> =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_SDIO_IRQ;
>
> - =A0 =A0 =A0 if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_4_BIT_DATA | MMC=
_CAP_8_BIT_DATA;
> -
> =A0 =A0 =A0 =A0if (caps & SDHCI_CAN_DO_HISPD)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_SD_HIGHSPEED | =
MMC_CAP_MMC_HIGHSPEED;
>
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index 1fdc673..ede02a4 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -67,8 +67,6 @@ struct sdhci_host {
> =A0#define SDHCI_QUIRK_FORCE_BLK_SZ_2048 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0(1<<20)
> =A0/* Controller cannot do multi-block transfers */
> =A0#define SDHCI_QUIRK_NO_MULTIBLOCK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1<<21)
> -/* Controller can only handle 1-bit data transfers */
> -#define SDHCI_QUIRK_FORCE_1_BIT_DATA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1<<22)
> =A0/* Controller needs 10ms delay between applying power and clock */
> =A0#define SDHCI_QUIRK_DELAY_AFTER_POWER =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0(1<<23)
> =A0/* Controller uses SDCLK instead of TMCLK for data timeouts */
> --
> 1.7.0.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
