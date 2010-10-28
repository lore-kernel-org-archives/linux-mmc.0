From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 1/1]sdhci-pxa: add MMC_CAP_NONREMOVABLE for on-chip
 device
Date: Wed, 27 Oct 2010 20:34:14 -0700
Message-ID: <812494AA-468A-41ED-9FD2-9A21C691D12F@marvell.com>
References: <AANLkTik+Kg+po=na4Vx6B+BmJMAN_-bq+cB3VrvDpB38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:36751 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756615Ab0J1DkA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Oct 2010 23:40:00 -0400
In-Reply-To: <AANLkTik+Kg+po=na4Vx6B+BmJMAN_-bq+cB3VrvDpB38@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Matt Fleming <matt@console-pimps.org>, "eric.y.miao@gmail.com" <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>


Zhangfei,

The patch mixes speed setting and setting the NON_REMOVABLE caps in one patch.  I would prefer to separate these into 2 separate patches.

thanks,

Philp


On Oct 27, 2010, at 7:54 PM, zhangfei gao wrote:

> From 7f3529c21815990ebe4eec684e3c96156f774637 Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Thu, 28 Oct 2010 10:44:15 -0400
> Subject: [PATCH] sdhci-pxa: add MMC_CAP_NONREMOVABLE for on-chip device
> 
>        To share SDHCI_QUIRK_BROKEN_CARD_DETECTION for on-chip device,
> MMC_CAP_NONREMOVABLE also needed, otherwise polling mode used by
> default
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> CC: Philip Rakity <prakity@marvell.com>
> ---
> arch/arm/plat-pxa/include/plat/sdhci.h |    2 ++
> drivers/mmc/host/sdhci-pxa.c           |    8 ++++++++
> 2 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
> b/arch/arm/plat-pxa/include/plat/sdhci.h
> index e49c5b6..fc5ceab 100644
> --- a/arch/arm/plat-pxa/include/plat/sdhci.h
> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
> @@ -16,6 +16,8 @@
> /* pxa specific flag */
> /* Require clock free running */
> #define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
> +/* card alwayes wired to host, like on-chip emmc */
> +#define PXA_FLAG_CARD_PERMANENT	(1<<1)
> 
> /*
>  * struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
> index fc406ac..a88c797 100644
> --- a/drivers/mmc/host/sdhci-pxa.c
> +++ b/drivers/mmc/host/sdhci-pxa.c
> @@ -138,6 +138,12 @@ static int __devinit sdhci_pxa_probe(struct
> platform_device *pdev)
> 	host->irq = irq;
> 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> 
> +	if (pxa->pdata->flags & PXA_FLAG_CARD_PERMANENT) {
> +		/* on-chip device */
> +		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +		host->mmc->caps = MMC_CAP_NONREMOVABLE;
> +	}
> +
> 	if (pdata->quirks)
> 		host->quirks |= pdata->quirks;
> 
> @@ -149,6 +155,8 @@ static int __devinit sdhci_pxa_probe(struct
> platform_device *pdev)
> 
> 	if (pxa->pdata->max_speed)
> 		host->mmc->f_max = pxa->pdata->max_speed;
> +	else
> +		host->mmc->f_max = 50000000;
> 
> 	platform_set_drvdata(pdev, host);
> 
> -- 
> 1.7.0.4
> <0001-sdhci-pxa-add-MMC_CAP_NONREMOVABLE-for-on-chip-devic.patch>

