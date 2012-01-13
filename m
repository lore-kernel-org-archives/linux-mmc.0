From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 4/5 v4] ESDHC: Workaround for data crc error on p1010rdb
Date: Fri, 13 Jan 2012 02:37:07 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F11669381@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1325827997-27490-1-git-send-email-r66093@freescale.com>
 <1325827997-27490-2-git-send-email-r66093@freescale.com>
 <1325827997-27490-3-git-send-email-r66093@freescale.com>
 <1325827997-27490-4-git-send-email-r66093@freescale.com>
 <1325827997-27490-5-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:52012
	"EHLO DB3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752817Ab2AMChL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 Jan 2012 21:37:11 -0500
In-Reply-To: <1325827997-27490-5-git-send-email-r66093@freescale.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi, Anton,
Could you have any comment about this serial patch?

Thanks
Jerry Huang

> -----Original Message-----
> From: Huang Changming-R66093
> Sent: Friday, January 06, 2012 1:33 PM
> To: linux-mmc@vger.kernel.org
> Cc: Huang Changming-R66093; Jain Priyanka-B32167; Chris Ball
> Subject: [PATCH 4/5 v4] ESDHC: Workaround for data crc error on p1010rdb
> 
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> SD card read was failing (data crc error)on some cards at
> maximum possible frequency on P1010(CCB frequency set to 400MHz).
> Some clock deviations are also observed at this frequency.
> Hence reduced the mmc clock freq.
> 
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> Singed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Chris Ball <cjb@laptop.org>
> ---
> changes for v2:
> 	- change the property to compatible for quirks
> changes for v3:
> 	- fix one compile error
> changes for v4:
> 	- use hooks to suspend/resume the special platform
> 
>  drivers/mmc/host/sdhci-esdhc.h |    9 ++++++++-
>  drivers/mmc/host/sdhci-pltfm.c |    3 +++
>  include/linux/mmc/sdhci.h      |    2 ++
>  3 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-
> esdhc.h
> index b97b2f5..8e00174 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -1,7 +1,7 @@
>  /*
>   * Freescale eSDHC controller driver generics for OF and pltfm.
>   *
> - * Copyright (c) 2007 Freescale Semiconductor, Inc.
> + * Copyright (c) 2007,2011 Freescale Semiconductor, Inc.
>   * Copyright (c) 2009 MontaVista Software, Inc.
>   * Copyright (c) 2010 Pengutronix e.K.
>   *   Author: Wolfram Sang <w.sang@pengutronix.de>
> @@ -56,6 +56,13 @@ static inline void esdhc_set_clock(struct sdhci_host
> *host, unsigned int clock)
>  	if (clock == 0)
>  		goto out;
> 
> +	if (host->quirks2 & SDHCI_QUIRK2_RELAX_FREQ) {
> +		if (clock > 20000000)
> +			clock -= 5000000;
> +		if (clock > 40000000)
> +			clock -= 5000000;
> +	}
> +
>  	while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
>  		pre_div *= 2;
> 
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-
> pltfm.c
> index e64f773..841ffc1 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -79,6 +79,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
>  			|| of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
>  			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> 
> +		if (of_device_is_compatible(np, "fsl,p1010-esdhc"))
> +			host->quirks2 |= SDHCI_QUIRK2_RELAX_FREQ;
> +
>  		clk = of_get_property(np, "clock-frequency", &size);
>  		if (clk && size == sizeof(*clk) && *clk)
>  			pltfm_host->clock = be32_to_cpup(clk);
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index e4b6935..f7c1e13 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -91,6 +91,8 @@ struct sdhci_host {
>  	unsigned int quirks2;	/* More deviations from spec. */
> 
>  #define SDHCI_QUIRK2_OWN_CARD_DETECTION			(1<<0)
> +/* Controller operates the cards at reduced frequency */
> +#define SDHCI_QUIRK2_RELAX_FREQ				(1<<1)
> 
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> --
> 1.7.5.4


