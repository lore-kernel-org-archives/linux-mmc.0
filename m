From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [v3, 1/7] mmc: sdhci-of-esdhc: add peripheral clock support
Date: Mon, 10 Apr 2017 15:36:16 +0300
Message-ID: <a8810e0a-95fa-a590-6827-15031ff52886@intel.com>
References: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
 <1490600982-5410-2-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4743 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752856AbdDJMl4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 10 Apr 2017 08:41:56 -0400
In-Reply-To: <1490600982-5410-2-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>

On 27/03/17 10:49, Yangbo Lu wrote:
> eSDHC could select peripheral clock or platform clock as clock source by
> the PCS bit of eSDHC Control Register, and this bit couldn't be reset by
> software reset for all. In default, the platform clock is used. But we have
> to use peripheral clock since it has a higher frequency to support eMMC
> HS200 mode and SD UHS-I mode. This patch is to add peripheral clock support
> and use it instead of platform clock if it's declared in eSDHC dts node.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Apart from minor comments:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes for v2:
> 	- None
> Changes for v3:
> 	- None
> ---
>  drivers/mmc/host/sdhci-esdhc.h    |  1 +
>  drivers/mmc/host/sdhci-of-esdhc.c | 70 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 69 insertions(+), 2 deletions(-)
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
> index ff37e74..7ce1caf 100644
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
> +	u32 timeout;
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
> +	timeout = 20;
> +	val = ESDHC_CLOCK_STABLE;
> +	while (!(sdhci_readl(host, ESDHC_PRSSTAT) & val)) {
> +		if (timeout == 0) {
> +			pr_err("%s: Internal clock never stabilised.\n",
> +				mmc_hostname(host->mmc));
> +			break;
> +		}
> +		timeout--;
> +		mdelay(1);

If the time to stabilize is much less that 1 ms then this loop can waste
time.  Have a look at the change in sdhci.c.

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
> @@ -626,6 +668,30 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
>  		esdhc->quirk_incorrect_hostver = true;
>  	else
>  		esdhc->quirk_incorrect_hostver = false;
> +
> +	np = pdev->dev.of_node;
> +	clk = of_clk_get(np, 0);

Should there be a clk_put somewhere?

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

