From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 01/12] mmc: sdhci-omap: Update 'power_mode' outside
 sdhci_omap_init_74_clocks
Date: Thu, 21 Dec 2017 10:57:46 +0200
Message-ID: <c1b5049f-7b70-5abf-192d-3752d64d53c0@intel.com>
References: <20171214130941.26666-1-kishon@ti.com>
 <20171214130941.26666-2-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:45422 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751525AbdLUI6P (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 21 Dec 2017 03:58:15 -0500
In-Reply-To: <20171214130941.26666-2-kishon@ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com

On 14/12/17 15:09, Kishon Vijay Abraham I wrote:
> Updating 'power_mode' in sdhci_omap_init_74_clocks results in
> 'power_mode' never updated to MMC_POWER_OFF during card
> removal. This results in initialization sequence not sent to the
> card during re-insertion.
> Fix it here by adding sdhci_omap_set_power_mode to update power_mode.
> This function can also be used later to perform operations that
> are specific to a power mode (e.g, disable tuning during power off).
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-omap.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 628bfe9a3d17..96985786cadf 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -244,6 +244,12 @@ static int sdhci_omap_start_signal_voltage_switch(struct mmc_host *mmc,
>  	return 0;
>  }
>  
> +static void sdhci_omap_set_power_mode(struct sdhci_omap_host *omap_host,
> +				      u8 power_mode)
> +{
> +	omap_host->power_mode = power_mode;
> +}
> +
>  static void sdhci_omap_set_bus_mode(struct sdhci_omap_host *omap_host,
>  				    unsigned int mode)
>  {
> @@ -273,6 +279,7 @@ static void sdhci_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  
>  	sdhci_omap_set_bus_mode(omap_host, ios->bus_mode);
>  	sdhci_set_ios(mmc, ios);
> +	sdhci_omap_set_power_mode(omap_host, ios->power_mode);
>  }
>  
>  static u16 sdhci_omap_calc_divisor(struct sdhci_pltfm_host *host,
> @@ -401,8 +408,6 @@ static void sdhci_omap_init_74_clocks(struct sdhci_host *host, u8 power_mode)
>  	sdhci_omap_writel(omap_host, SDHCI_OMAP_STAT, INT_CC_EN);
>  
>  	enable_irq(host->irq);
> -
> -	omap_host->power_mode = power_mode;
>  }
>  
>  static struct sdhci_ops sdhci_omap_ops = {
> @@ -504,6 +509,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	omap_host->host = host;
>  	omap_host->base = host->ioaddr;
>  	omap_host->dev = dev;
> +	omap_host->power_mode = MMC_POWER_UNDEFINED;
>  	host->ioaddr += offset;
>  
>  	mmc = host->mmc;
> 

