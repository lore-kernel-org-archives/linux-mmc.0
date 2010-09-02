From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] sdhci-s3c: support non-standard clock setting for c210
Date: Thu, 02 Sep 2010 19:20:14 +0900
Message-ID: <005101cb4a88$7283d080$578b7180$%kim@samsung.com>
References: <4C7CDA39.1020907@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:29752 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab0IBKUG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Sep 2010 06:20:06 -0400
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L8400ATR7DF9B10@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 02 Sep 2010 19:20:03 +0900 (KST)
Received: from kgenekim ([12.23.103.96])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L84009MY7DFKW@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 02 Sep 2010 19:20:04 +0900 (KST)
In-reply-to: <4C7CDA39.1020907@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, matt@console-pimps.org, 'Marek Szyprowski' <m.szyprowski@samsung.com>

Jaehoon Chung wrote:
> 
> This is sdhci-s3c patch for c210.
> c210 didn't use divider of host controller.
> 
> Host Controller need other clock setting methods.
> 
> So I add the callback functions for s5pc210.
> also I set 400KHz for initial clock.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>  Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> ---
>  arch/arm/plat-samsung/include/plat/sdhci.h |   19 ++++++++
>  drivers/mmc/host/sdhci-s3c.c               |   68
> ++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-
> samsung/include/plat/sdhci.h
> index 30844c2..7c75ee3 100644
> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> @@ -15,6 +15,8 @@
>  #ifndef __PLAT_S3C_SDHCI_H
>  #define __PLAT_S3C_SDHCI_H __FILE__
> 
> +#include <plat/devs.h>
> +
>  struct platform_device;
>  struct mmc_host;
>  struct mmc_card;
> @@ -288,4 +290,21 @@ static inline void s5pv210_default_sdhci3(void) { }
> 
>  #endif /* CONFIG_S5PV210_SETUP_SDHCI */
> 
> +/* re-define device name depending on support. */
> +static inline void s3c_hsmmc_setname(char *name)
> +{
> +#ifdef CONFIG_S3C_DEV_HSMMC
> +	s3c_device_hsmmc0.name = name;
> +#endif
> +#ifdef CONFIG_S3C_DEV_HSMMC1
> +	s3c_device_hsmmc1.name = name;
> +#endif
> +#ifdef CONFIG_S3C_DEV_HSMMC2
> +	s3c_device_hsmmc2.name = name;
> +#endif
> +#ifdef CONFIG_S3C_DEV_HSMMC3
> +	s3c_device_hsmmc3.name = name;
> +#endif
> +}
> +
>  #endif /* __PLAT_S3C_SDHCI_H */

It would be helpful to me if you could separate platform and driver patches.
And if you want to add s3c_hsmmc_setname(), please send together code that
it is used.

> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 71ad416..3927793 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -52,6 +52,11 @@ struct sdhci_s3c {
>  	struct clk		*clk_bus[MAX_BUS_CLK];
>  };
> 
> +enum soc_type {
> +	TYPE_SAMSUNG,	/* S5PC1XX, S3C... */
> +	TYPE_S5PC210,	/* S5PC210 */
> +};
> +
>  static inline struct sdhci_s3c *to_s3c(struct sdhci_host *host)
>  {
>  	return sdhci_priv(host);
> @@ -232,6 +237,52 @@ static unsigned int sdhci_s3c_get_min_clock(struct
> sdhci_host *host)
>  	return min;
>  }
> 
> +/**
> +* sdhci_s3c_get_max_clk - callback to get maximum clock frequency.
> +*/
> +static unsigned int sdhci_s5pc210_get_max_clock(struct sdhci_host *host)
> +{
> +	struct sdhci_s3c *ourhost = to_s3c(host);
> +	unsigned int rate;
> +	int ptr = ourhost->cur_clk;
> +
> +	rate = clk_round_rate(ourhost->clk_bus[ptr], UINT_MAX);
> +
> +	return rate;
> +}
> +
> +/**
> + * sdhci_s3c_get_min_clock - callback to get minimal supported clock
value
> +*/
> +static unsigned int sdhci_s5pc210_get_min_clock(struct sdhci_host *host)
> +{
> +	struct sdhci_s3c *ourhost = to_s3c(host);
> +	unsigned int rate;
> +	int ptr = ourhost->cur_clk;
> +
> +	rate = clk_round_rate(ourhost->clk_bus[ptr], 400000);
> +
> +	return rate;
> +}
> +
> +/**
> + * sdhci_s5pc210_set_clock - callback on clock change
> +*/
> +static void sdhci_s5pc210_set_clock(struct sdhci_host *host,
> +		unsigned int clock)
> +{
> +	struct sdhci_s3c *ourhost = to_s3c(host);
> +
> +	if (clock == 0)
> +		return;
> +
> +	sdhci_s3c_set_clock(host, clock);
> +
> +	clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
> +
> +	host->clock = clock;
> +}
> +
>  static struct sdhci_ops sdhci_s3c_ops = {
>  	.get_max_clock		= sdhci_s3c_get_max_clk,
>  	.set_clock		= sdhci_s3c_set_clock,
> @@ -395,6 +446,12 @@ static int __devinit sdhci_s3c_probe(struct
> platform_device *pdev)
>  	host->quirks = 0;
>  	host->irq = irq;
> 
> +	if (pdev->id_entry->driver_data == TYPE_S5PC210) {
> +		sdhci_s3c_ops.set_clock = sdhci_s5pc210_set_clock;
> +		sdhci_s3c_ops.get_min_clock = sdhci_s5pc210_get_min_clock;
> +		sdhci_s3c_ops.get_max_clock = sdhci_s5pc210_get_max_clock;
> +	}
> +
>  	/* Setup quirks for the controller */
>  	host->quirks |= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
>  	host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
> @@ -520,6 +577,16 @@ static int sdhci_s3c_resume(struct platform_device
*dev)
>  #define sdhci_s3c_resume NULL
>  #endif
> 
> +static struct platform_device_id sdhci_driver_ids[] = {
> +	{
> +		.name		= "s3c-sdhci",
> +		.driver_data	= TYPE_SAMSUNG,
> +	}, {
> +		.name		= "s5pc210-sdhci",
> +		.driver_data	= TYPE_S5PC210,
> +	}, { },
> +};
> +
>  static struct platform_driver sdhci_s3c_driver = {
>  	.probe		= sdhci_s3c_probe,
>  	.remove		= __devexit_p(sdhci_s3c_remove),
> @@ -529,6 +596,7 @@ static struct platform_driver sdhci_s3c_driver = {
>  		.owner	= THIS_MODULE,
>  		.name	= "s3c-sdhci",
>  	},
> +	.id_table	= sdhci_driver_ids,
>  };
> 
>  static int __init sdhci_s3c_init(void)
> -- 1.6.0.4

How do you think about using quirk to separate S5PV310 case as following?
I think this is more general method in here...And will be submitted soon
after fixing something.

From: Hyuk Lee <hyuk1.lee@samsung.com>

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 71ad416..1ac2f36 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -96,6 +96,11 @@ static unsigned int sdhci_s3c_get_max_clk(struct
sdhci_host *host)
 	unsigned int rate, max;
 	int clk;
 
+	/* There is only one clock source(sclk) if there is no clock divider
+	 * in the host controller */
+	if(host->quirks & SDHCI_QUIRK_BROKEN_CLOCK_DIVIDER)
+		return clk_round_rate(ourhost->clk_bus[ourhost->cur_clk],
UINT_MAX);
+
 	/* note, a reset will reset the clock source */
 
 	sdhci_s3c_check_sclk(host);
@@ -130,6 +135,11 @@ static unsigned int sdhci_s3c_consider_clock(struct
sdhci_s3c *ourhost,
 	if (!clksrc)
 		return UINT_MAX;
 
+	if(ourhost->host->quirks & SDHCI_QUIRK_BROKEN_CLOCK_DIVIDER) {
+		rate = clk_round_rate(clksrc,wanted);
+		return (wanted - rate);
+	}
+	
 	rate = clk_get_rate(clksrc);
 
 	for (div = 1; div < 256; div *= 2) {
@@ -159,6 +169,7 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host,
unsigned int clock)
 	int best_src = 0;
 	int src;
 	u32 ctrl;
+	unsigned int timeout;
 
 	/* don't bother if the clock is going off. */
 	if (clock == 0)
@@ -204,6 +215,31 @@ static void sdhci_s3c_set_clock(struct sdhci_host
*host, unsigned int clock)
 			(ourhost->pdata->cfg_card)(ourhost->pdev,
host->ioaddr,
 						   &ios, NULL);
 	}
+	
+	if(host->quirks & SDHCI_QUIRK_BROKEN_CLOCK_DIVIDER) {
+		writew(0, host->ioaddr + SDHCI_CLOCK_CONTROL);
+		clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
+
+		writew(SDHCI_CLOCK_INT_EN, host->ioaddr +
SDHCI_CLOCK_CONTROL);
+
+		/* Wait max 20 ms */
+		timeout = 20;
+		while (!((sdhci_readw(host, SDHCI_CLOCK_CONTROL))
+			& SDHCI_CLOCK_INT_STABLE)) {
+			if (timeout == 0) {
+				printk(KERN_ERR "%s: Internal clock never "
+					"stabilised.\n",
mmc_hostname(host->mmc));
+				return;
+			}
+			timeout--;
+			mdelay(1);
+		}
+
+		writew(SDHCI_CLOCK_INT_EN | SDHCI_CLOCK_CARD_EN,
+				host->ioaddr + SDHCI_CLOCK_CONTROL);
+	
+		host->clock = clock;
+	}
 }
 
 /**
@@ -221,6 +257,11 @@ static unsigned int sdhci_s3c_get_min_clock(struct
sdhci_host *host)
 	unsigned int delta, min = UINT_MAX;
 	int src;
 
+	/* There is only one clock source(sclk) if there is no clock divider
+	 * in the host controller */
+	if(host->quirks & SDHCI_QUIRK_BROKEN_CLOCK_DIVIDER)
+		return clk_round_rate(ourhost->clk_bus[2], 400000);
+
 	for (src = 0; src < MAX_BUS_CLK; src++) {
 		delta = sdhci_s3c_consider_clock(ourhost, src, 0);
 		if (delta == UINT_MAX)

...


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

