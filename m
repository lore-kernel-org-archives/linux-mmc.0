From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1]sdhci-pxa: add MMC_CAP_NONREMOVABLE for on-chip
	device
Date: Sun, 5 Dec 2010 03:05:34 +0000
Message-ID: <20101205030534.GB24000@void.printf.net>
References: <AANLkTik+Kg+po=na4Vx6B+BmJMAN_-bq+cB3VrvDpB38@mail.gmail.com> <AANLkTim6_wuc+zSg7qKwGDAAiYfXTqjiMRJiffzNPvCY@mail.gmail.com> <AANLkTim2rF=MfmU81=bBwdFu3QV2qehYmXfQDO8PZrqu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58459 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221Ab0LEDFi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 4 Dec 2010 22:05:38 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTim2rF=MfmU81=bBwdFu3QV2qehYmXfQDO8PZrqu@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Kyungmin Park <kmpark@infradead.org>, Philip Rakity <prakity@marvell.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Matt Fleming <matt@console-pimps.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

Hi,

On Thu, Oct 28, 2010 at 02:00:10AM -0400, zhangfei gao wrote:
> Thanks for your suggestion, here is updated version.
> 
> >From 470140b629e3f044a0951368db8e3dc98ebd8ab3 Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Thu, 28 Oct 2010 10:44:15 -0400
> Subject: [PATCH] sdhci-pxa: add MMC_CAP_NONREMOVABLE for on-chip device
> 
>         To share SDHCI_QUIRK_BROKEN_CARD_DETECTION for on-chip device,
> MMC_CAP_NONREMOVABLE also needed, otherwise polling mode used by
> default
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> CC: Philip Rakity <prakity@marvell.com>
> ---
>  arch/arm/plat-pxa/include/plat/sdhci.h |    2 ++
>  drivers/mmc/host/sdhci-pxa.c           |    6 ++++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
> b/arch/arm/plat-pxa/include/plat/sdhci.h
> index e49c5b6..fc5ceab 100644
> --- a/arch/arm/plat-pxa/include/plat/sdhci.h
> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
> @@ -16,6 +16,8 @@
>  /* pxa specific flag */
>  /* Require clock free running */
>  #define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
> +/* card alwayes wired to host, like on-chip emmc */
> +#define PXA_FLAG_CARD_PERMANENT	(1<<1)
> 
>  /*
>   * struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
> index fc406ac..8455c46 100644
> --- a/drivers/mmc/host/sdhci-pxa.c
> +++ b/drivers/mmc/host/sdhci-pxa.c
> @@ -138,6 +138,12 @@ static int __devinit sdhci_pxa_probe(struct
> platform_device *pdev)
>  	host->irq = irq;
>  	host->quirks = SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> 
> +	if (pxa->pdata->flags & PXA_FLAG_CARD_PERMANENT) {
> +		/* on-chip device */
> +		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
> +	}
> +
>  	if (pdata->quirks)
>  		host->quirks |= pdata->quirks;
> 

Pushed to mmc-next for .38, thanks.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
