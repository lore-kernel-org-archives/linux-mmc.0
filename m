From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 03/12] mmc: sdhci-omap: Add custom set_uhs_signaling
 sdhci_host ops
Date: Thu, 21 Dec 2017 11:01:06 +0200
Message-ID: <7120e913-56c5-f04f-b61e-0e35b474ce84@intel.com>
References: <20171214130941.26666-1-kishon@ti.com>
 <20171214130941.26666-4-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50118 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbdLUJBf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 21 Dec 2017 04:01:35 -0500
In-Reply-To: <20171214130941.26666-4-kishon@ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com

On 14/12/17 15:09, Kishon Vijay Abraham I wrote:
> UHS-1 DDR50 and MMC DDR52 mode require DDR bit to be
> set in the configuration register (MMCHS_CON). Add
> sdhci-omap specific set_uhs_signaling ops to set
> this bit. Also while setting the UHSMS bit, clock should be
> disabled.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Apart from 1 minor comment below:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-omap.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index defe4eac020d..8f7239e2edc2 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -31,6 +31,7 @@
>  #define SDHCI_OMAP_CON		0x12c
>  #define CON_DW8			BIT(5)
>  #define CON_DMA_MASTER		BIT(20)
> +#define CON_DDR			BIT(19)
>  #define CON_CLKEXTFREE		BIT(16)
>  #define CON_PADEN		BIT(15)
>  #define CON_INIT		BIT(1)
> @@ -93,6 +94,9 @@ struct sdhci_omap_host {
>  	u8			power_mode;
>  };
>  
> +static void sdhci_omap_start_clock(struct sdhci_omap_host *omap_host);
> +static void sdhci_omap_stop_clock(struct sdhci_omap_host *omap_host);

These forward declarations aren't needed are they.

> +
>  static inline u32 sdhci_omap_readl(struct sdhci_omap_host *host,
>  				   unsigned int offset)
>  {
> @@ -471,6 +475,26 @@ static void sdhci_omap_init_74_clocks(struct sdhci_host *host, u8 power_mode)
>  	enable_irq(host->irq);
>  }
>  
> +static void sdhci_omap_set_uhs_signaling(struct sdhci_host *host,
> +					 unsigned int timing)
> +{
> +	u32 reg;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	sdhci_omap_stop_clock(omap_host);
> +
> +	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_CON);
> +	if (timing == MMC_TIMING_UHS_DDR50 || timing == MMC_TIMING_MMC_DDR52)
> +		reg |= CON_DDR;
> +	else
> +		reg &= ~CON_DDR;
> +	sdhci_omap_writel(omap_host, SDHCI_OMAP_CON, reg);
> +
> +	sdhci_set_uhs_signaling(host, timing);
> +	sdhci_omap_start_clock(omap_host);
> +}
> +
>  static struct sdhci_ops sdhci_omap_ops = {
>  	.set_clock = sdhci_omap_set_clock,
>  	.set_power = sdhci_omap_set_power,
> @@ -480,7 +504,7 @@ static struct sdhci_ops sdhci_omap_ops = {
>  	.set_bus_width = sdhci_omap_set_bus_width,
>  	.platform_send_init_74_clocks = sdhci_omap_init_74_clocks,
>  	.reset = sdhci_reset,
> -	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +	.set_uhs_signaling = sdhci_omap_set_uhs_signaling,
>  };
>  
>  static int sdhci_omap_set_capabilities(struct sdhci_omap_host *omap_host)
> 

