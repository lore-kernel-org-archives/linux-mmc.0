From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [v4, 1/5] mmc: sdhci-of-esdhc: add peripheral clock support
Date: Thu, 20 Apr 2017 10:32:33 +0300
Message-ID: <66edd7f6-fb2d-8a95-09b0-f9a5a0a9c9b3@intel.com>
References: <1491887431-31894-1-git-send-email-yangbo.lu@nxp.com>
 <1491887431-31894-2-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30529 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941354AbdDTHiW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 20 Apr 2017 03:38:22 -0400
In-Reply-To: <1491887431-31894-2-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>

On 11/04/17 08:10, Yangbo Lu wrote:
> eSDHC could select peripheral clock or platform clock as clock source by
> the PCS bit of eSDHC Control Register, and this bit couldn't be reset by
> software reset for all. In default, the platform clock is used. But we have
> to use peripheral clock since it has a higher frequency to support eMMC
> HS200 mode and SD UHS-I mode. This patch is to add peripheral clock support
> and use it instead of platform clock if it's declared in eSDHC dts node.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v2:
> 	- None
> Changes for v3:
> 	- None
> Changes for v4:
> 	- Added clk_put()
> 	- Used udelay() to poll ESDHC_CLOCK_STABLE

Should probably include <linux/ktime.h> otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc.h    |  1 +
>  drivers/mmc/host/sdhci-of-esdhc.c | 72 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> index ece8b37..5343fc0 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -54,6 +54,7 @@
>  
>  /* Control Register for DMA transfer */
>  #define ESDHC_DMA_SYSCTL		0x40c
> +#define ESDHC_PERIPHERAL_CLK_SEL	0x00080000
>  #define ESDHC_DMA_SNOOP			0x00000040
>  
>  #endif /* _DRIVERS_MMC_SDHCI_ESDHC_H */
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index ff37e74..6d024b6 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -19,6 +19,7 @@
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/sys_soc.h>
> +#include <linux/clk.h>
>  #include <linux/mmc/host.h>
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
> @@ -30,6 +31,7 @@ struct sdhci_esdhc {
>  	u8 vendor_ver;
>  	u8 spec_ver;
>  	bool quirk_incorrect_hostver;
> +	unsigned int peripheral_clock;
>  };
>  
>  /**
> @@ -414,15 +416,25 @@ static int esdhc_of_enable_dma(struct sdhci_host *host)
>  static unsigned int esdhc_of_get_max_clock(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
>  
> -	return pltfm_host->clock;
> +	if (esdhc->peripheral_clock)
> +		return esdhc->peripheral_clock;
> +	else
> +		return pltfm_host->clock;
>  }
>  
>  static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
> +	unsigned int clock;
>  
> -	return pltfm_host->clock / 256 / 16;
> +	if (esdhc->peripheral_clock)
> +		clock = esdhc->peripheral_clock;
> +	else
> +		clock = pltfm_host->clock;
> +	return clock / 256 / 16;
>  }
>  
>  static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
> @@ -512,6 +524,33 @@ static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
>  	sdhci_writel(host, ctrl, ESDHC_PROCTL);
>  }
>  
> +static void esdhc_clock_enable(struct sdhci_host *host, bool enable)
> +{
> +	u32 val;
> +	ktime_t timeout;
> +
> +	val = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
> +
> +	if (enable)
> +		val |= ESDHC_CLOCK_SDCLKEN;
> +	else
> +		val &= ~ESDHC_CLOCK_SDCLKEN;
> +
> +	sdhci_writel(host, val, ESDHC_SYSTEM_CONTROL);
> +
> +	/* Wait max 20 ms */
> +	timeout = ktime_add_ms(ktime_get(), 20);
> +	val = ESDHC_CLOCK_STABLE;
> +	while (!(sdhci_readl(host, ESDHC_PRSSTAT) & val)) {
> +		if (ktime_after(ktime_get(), timeout)) {
> +			pr_err("%s: Internal clock never stabilised.\n",
> +				mmc_hostname(host->mmc));
> +			break;
> +		}
> +		udelay(10);
> +	}
> +}
> +
>  static void esdhc_reset(struct sdhci_host *host, u8 mask)
>  {
>  	sdhci_reset(host, mask);
> @@ -613,6 +652,9 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_esdhc *esdhc;
> +	struct device_node *np;
> +	struct clk *clk;
> +	u32 val;
>  	u16 host_ver;
>  
>  	pltfm_host = sdhci_priv(host);
> @@ -626,6 +668,32 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
>  		esdhc->quirk_incorrect_hostver = true;
>  	else
>  		esdhc->quirk_incorrect_hostver = false;
> +
> +	np = pdev->dev.of_node;
> +	clk = of_clk_get(np, 0);
> +	if (!IS_ERR(clk)) {
> +		/*
> +		 * esdhc->peripheral_clock would be assigned with a value
> +		 * which is eSDHC base clock when use periperal clock.
> +		 * For ls1046a, the clock value got by common clk API is
> +		 * peripheral clock while the eSDHC base clock is 1/2
> +		 * peripheral clock.
> +		 */
> +		if (of_device_is_compatible(np, "fsl,ls1046a-esdhc"))
> +			esdhc->peripheral_clock = clk_get_rate(clk) / 2;
> +		else
> +			esdhc->peripheral_clock = clk_get_rate(clk);
> +
> +		clk_put(clk);
> +	}
> +
> +	if (esdhc->peripheral_clock) {
> +		esdhc_clock_enable(host, false);
> +		val = sdhci_readl(host, ESDHC_DMA_SYSCTL);
> +		val |= ESDHC_PERIPHERAL_CLK_SEL;
> +		sdhci_writel(host, val, ESDHC_DMA_SYSCTL);
> +		esdhc_clock_enable(host, true);
> +	}
>  }
>  
>  static int sdhci_esdhc_probe(struct platform_device *pdev)
> 

