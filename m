From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] sdhci: 8 bit widths - allow new QUIRK for 8 bit and v3 sd controller
Date: Tue, 9 Nov 2010 09:36:28 +0800
Message-ID: <AANLkTimp7p9e2+fDdgJ307vKNncJdZTHgzLTK4osPBfz@mail.gmail.com>
References: <74C0C915-257F-41CC-AEA8-C6F5B839586B@marvell.com>
	<20101107220411.GB5376@pengutronix.de>
	<BEF8AD05-D094-4607-8C4F-1908C4FF54B3@marvell.com>
	<20101108091754.GA8638@pengutronix.de>
	<AANLkTi=9omu=yDXEk_=QhGsz6xy3VVxn39T4DF7UvHjR@mail.gmail.com>
	<3AB5566C-7D7A-452E-9A81-C947BAB46FFF@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38582 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875Ab0KIBga convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2010 20:36:30 -0500
Received: by fxm16 with SMTP id 16so4592371fxm.19
        for <linux-mmc@vger.kernel.org>; Mon, 08 Nov 2010 17:36:28 -0800 (PST)
In-Reply-To: <3AB5566C-7D7A-452E-9A81-C947BAB46FFF@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, Nov 8, 2010 at 8:12 PM, Philip Rakity <prakity@marvell.com> wro=
te:
>
> Not a good idea to remove existing quirk for Force 1 bit. =A0 Breaks =
sdhci-of-core.c

you can simply add specific flag in platfrom driver, to make your
patch to be easily accepted :)
After sdhci_add_host
+       if (pxa->pdata->flags & PXA_FLAG_CANT_8_BIT_DATA)
+               host->mmc->caps &=3D ~ MMC_CAP_8_BIT_DATA;

+
>
>
> On Nov 8, 2010, at 3:48 AM, zhangfei gao wrote:
>
>> On Mon, Nov 8, 2010 at 4:17 AM, Wolfram Sang <w.sang@pengutronix.de>=
 wrote:
>>>>> This isn't a quirk, this is platform_data, no?
>>>>
>>>> Never sure of the difference between a quirk and platform data.
>>>> example: =A0Broken card detect is a quirk but maybe some slots on =
the board work and some do not
>>>
>>> A quirk is something which needs to be handled in a special case be=
cause
>>> some controllers do not adhere to the SDHC standard. An 8 bit bus s=
eems
>>> to be in the 3.0 standard, so it is not a quirk :) Does the standar=
d say
>>> anything about how the actual bus width should be handled?
>>>
>>> That said, you are right that quirks have been abused to cover boar=
d
>>> issues. Another reason to clean them up ;)
>>>
>>> Regards,
>>>
>>> =A0 Wolfram
>>>
>>> --
>>> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | Wolfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
>>> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http:/=
/www.pengutronix.de/ =A0|
>>>
>>> -----BEGIN PGP SIGNATURE-----
>>> Version: GnuPG v1.4.10 (GNU/Linux)
>>>
>>> iEYEARECAAYFAkzXwEIACgkQD27XaX1/VRuQ8QCeN1ueDODn5jbt9MS49MCJcQXS
>>> BccAn0VnBmmBbLRFvBf/wo4zStAXUGV0
>>> =3DVwO1
>>> -----END PGP SIGNATURE-----
>>>
>>>
>>
>> Highly concern of abuse of QUIRK, currently the highest bit is
>> (1<<29), while the quirks is u32.
>> Could we remove some quirk, such as SDHCI_QUIRK_FORCE_1_BIT_DATA,
>> which only used to transfer info to caps.
>> We could simply update mmc->caps after sdhci_add_host.
>>
>>
>> arch/arm/plat-pxa/include/plat/sdhci.h | =A0 =A02 ++
>> drivers/mmc/host/sdhci-pxa.c =A0 =A0 =A0 =A0 =A0 | =A0 =A05 +++++
>> drivers/mmc/host/sdhci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 ---
>> include/linux/mmc/sdhci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 --
>> 4 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
>> b/arch/arm/plat-pxa/include/plat/sdhci.h
>> index e49c5b6..661dc48 100644
>> --- a/arch/arm/plat-pxa/include/plat/sdhci.h
>> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
>> @@ -16,6 +16,8 @@
>> /* pxa specific flag */
>> /* Require clock free running */
>> #define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
>> +#define PXA_FLAG_FORCE_1_BIT_DATA (1<<2)
>> +#define PXA_FLAG_CAN_DO_8_BIT_DATA (1<<3)
>>
>> /*
>> =A0* struct pxa_sdhci_platdata() - Platform device data for PXA SDHC=
I
>> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-p=
xa.c
>> index fc406ac..3d63a37 100644
>> --- a/drivers/mmc/host/sdhci-pxa.c
>> +++ b/drivers/mmc/host/sdhci-pxa.c
>> @@ -147,6 +147,11 @@ static int __devinit sdhci_pxa_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (pxa->pdata->flags & PXA_FLAG_FORCE_1_BIT_DATA)
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps &=3D ~(MMC_CAP_4_BIT_DATA =
| MMC_CAP_8_BIT_DATA);
>> + =A0 =A0 if (pxa->pdata->flags & PXA_FLAG_CAN_DO_8_BIT_DATA)
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps |=3D MMC_CAP_8_BIT_DATA;
>> +
>> =A0 =A0 =A0 if (pxa->pdata->max_speed)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->f_max =3D pxa->pdata->max_spe=
ed;
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 154cbf8..2628ec2 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1858,9 +1858,6 @@ int sdhci_add_host(struct sdhci_host *host)
>> =A0 =A0 =A0 mmc->f_max =3D host->max_clk;
>> =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SDIO_IRQ;
>>
>> - =A0 =A0 if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
>> - =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_4_BIT_DATA | MMC_CA=
P_8_BIT_DATA;
>> -
>> =A0 =A0 =A0 if (caps & SDHCI_CAN_DO_HISPD)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SD_HIGHSPEED | MM=
C_CAP_MMC_HIGHSPEED;
>>
>> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
>> index 1fdc673..ede02a4 100644
>> --- a/include/linux/mmc/sdhci.h
>> +++ b/include/linux/mmc/sdhci.h
>> @@ -67,8 +67,6 @@ struct sdhci_host {
>> #define SDHCI_QUIRK_FORCE_BLK_SZ_2048 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1<<20)
>> /* Controller cannot do multi-block transfers */
>> #define SDHCI_QUIRK_NO_MULTIBLOCK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1<<21)
>> -/* Controller can only handle 1-bit data transfers */
>> -#define SDHCI_QUIRK_FORCE_1_BIT_DATA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1<<22)
>> /* Controller needs 10ms delay between applying power and clock */
>> #define SDHCI_QUIRK_DELAY_AFTER_POWER =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1<<23)
>> /* Controller uses SDCLK instead of TMCLK for data timeouts */
>> --
>> 1.7.0.4
>
>
