From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] sdhci: 8 bit widths - allow new QUIRK for 8 bit and v3
 sd controller
Date: Tue, 9 Nov 2010 04:25:44 -0800
Message-ID: <8C3FAABA-4592-4959-A550-CFFA96E1D510@marvell.com>
References: <74C0C915-257F-41CC-AEA8-C6F5B839586B@marvell.com>
 <20101107220411.GB5376@pengutronix.de>
 <BEF8AD05-D094-4607-8C4F-1908C4FF54B3@marvell.com>
 <20101108091754.GA8638@pengutronix.de>
 <AANLkTi=9omu=yDXEk_=QhGsz6xy3VVxn39T4DF7UvHjR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:47769 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755167Ab0KIM0S convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Nov 2010 07:26:18 -0500
In-Reply-To: <AANLkTi=9omu=yDXEk_=QhGsz6xy3VVxn39T4DF7UvHjR@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


If we support the idea of adding quirks after sdhc_add_host() is called then I support this patch.

see below for minor change

Philip


On Nov 8, 2010, at 3:48 AM, zhangfei gao wrote:

> On Mon, Nov 8, 2010 at 4:17 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>>>> This isn't a quirk, this is platform_data, no?
>>> 
>>> Never sure of the difference between a quirk and platform data.
>>> example:  Broken card detect is a quirk but maybe some slots on the board work and some do not
>> 
>> A quirk is something which needs to be handled in a special case because
>> some controllers do not adhere to the SDHC standard. An 8 bit bus seems
>> to be in the 3.0 standard, so it is not a quirk :) Does the standard say
>> anything about how the actual bus width should be handled?
>> 
>> That said, you are right that quirks have been abused to cover board
>> issues. Another reason to clean them up ;)
>> 
>> Regards,
>> 
>>   Wolfram
>> 
>> --
>> Pengutronix e.K.                           | Wolfram Sang                |
>> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
>> 
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.4.10 (GNU/Linux)
>> 
>> iEYEARECAAYFAkzXwEIACgkQD27XaX1/VRuQ8QCeN1ueDODn5jbt9MS49MCJcQXS
>> BccAn0VnBmmBbLRFvBf/wo4zStAXUGV0
>> =VwO1
>> -----END PGP SIGNATURE-----
>> 
>> 
> 
> Highly concern of abuse of QUIRK, currently the highest bit is
> (1<<29), while the quirks is u32.
> Could we remove some quirk, such as SDHCI_QUIRK_FORCE_1_BIT_DATA,
> which only used to transfer info to caps.
> We could simply update mmc->caps after sdhci_add_host.
> 
> 
> arch/arm/plat-pxa/include/plat/sdhci.h |    2 ++
> drivers/mmc/host/sdhci-pxa.c           |    5 +++++
> drivers/mmc/host/sdhci.c               |    3 ---
> include/linux/mmc/sdhci.h              |    2 --
> 4 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
> b/arch/arm/plat-pxa/include/plat/sdhci.h
> index e49c5b6..661dc48 100644
> --- a/arch/arm/plat-pxa/include/plat/sdhci.h
> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
> @@ -16,6 +16,8 @@
> /* pxa specific flag */
> /* Require clock free running */
> #define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
> +#define PXA_FLAG_FORCE_1_BIT_DATA (1<<2)
> +#define PXA_FLAG_CAN_DO_8_BIT_DATA (1<<3)
> 
> /*
>  * struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
> index fc406ac..3d63a37 100644
> --- a/drivers/mmc/host/sdhci-pxa.c
> +++ b/drivers/mmc/host/sdhci-pxa.c
> @@ -147,6 +147,11 @@ static int __devinit sdhci_pxa_probe(struct
> platform_device *pdev)
> 		goto out;
> 	}
> 
> +	if (pxa->pdata->flags & PXA_FLAG_FORCE_1_BIT_DATA)
> +		host->mmc->caps &= ~(MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA);
> +	if (pxa->pdata->flags & PXA_FLAG_CAN_DO_8_BIT_DATA)
> +		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> +
> 	if (pxa->pdata->max_speed)
> 		host->mmc->f_max = pxa->pdata->max_speed;
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 154cbf8..2628ec2 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1858,9 +1858,6 @@ int sdhci_add_host(struct sdhci_host *host)
> 	mmc->f_max = host->max_clk;
> 	mmc->caps |= MMC_CAP_SDIO_IRQ;
> 
> -	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
> -		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
> -

need to leave CAP_4_BIT DATA defined

eg 
		mmc->caps |= MMC_CAP_4_BIT_DATA;

> 	if (caps & SDHCI_CAN_DO_HISPD)
> 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
> 
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index 1fdc673..ede02a4 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -67,8 +67,6 @@ struct sdhci_host {
> #define SDHCI_QUIRK_FORCE_BLK_SZ_2048			(1<<20)
> /* Controller cannot do multi-block transfers */
> #define SDHCI_QUIRK_NO_MULTIBLOCK			(1<<21)
> -/* Controller can only handle 1-bit data transfers */
> -#define SDHCI_QUIRK_FORCE_1_BIT_DATA			(1<<22)
> /* Controller needs 10ms delay between applying power and clock */
> #define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
> /* Controller uses SDCLK instead of TMCLK for data timeouts */
> -- 
> 1.7.0.4

