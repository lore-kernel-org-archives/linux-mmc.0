From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH v2 6/6] mmc: sdhci: remove CONFIG_MMC_DEBUG from the
 driver
Date: Wed, 19 Jul 2017 11:24:09 +0300
Message-ID: <3ca331c8-9e43-bcde-59ff-669cf28097a0@intel.com>
References: <1500450661-158463-1-git-send-email-shawn.lin@rock-chips.com>
 <1500450949-206953-1-git-send-email-shawn.lin@rock-chips.com>
 <1500450949-206953-5-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40112 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753272AbdGSIaZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Jul 2017 04:30:25 -0400
In-Reply-To: <1500450949-206953-5-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

On 19/07/17 10:55, Shawn Lin wrote:
> sdhci uses CONFIG_MMC_DEBUG for showing ADMA descriptor
> when occurring ADMA error. And it's also used to  dump the
> registers whenever calling sdhci_add_host.
> 
> On one hand, I don't see any burden to always print the state
> ADMA descriptor as it's rare and will help folks better understand
> what was happening when seeing ADMA error.
> 
> On the other, folks may be interested in checking some registers
> at probe time. So we remove the sdhci_dumpregs from __sdhci_add_host
> and print some really useful registers in sdhci_setup_host.
> 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> ---
> 
> Changes in v2:
> - rework the changes for sdhci suggested by Adrian
> 
>  drivers/mmc/host/sdhci.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ecd0d43..cf2166e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2502,7 +2502,6 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
>  		sdhci_finish_command(host);
>  }
>  
> -#ifdef CONFIG_MMC_DEBUG
>  static void sdhci_adma_show_error(struct sdhci_host *host)
>  {
>  	void *desc = host->adma_table;
> @@ -2530,9 +2529,6 @@ static void sdhci_adma_show_error(struct sdhci_host *host)
>  			break;
>  	}
>  }
> -#else
> -static void sdhci_adma_show_error(struct sdhci_host *host) { }
> -#endif
>  
>  static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  {
> @@ -3230,6 +3226,13 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	if (ret == -EPROBE_DEFER)
>  		return ret;
>  
> +	DBG("Version:   0x%08x | Present:  0x%08x\n",
> +	    sdhci_readw(host, SDHCI_HOST_VERSION),
> +	    sdhci_readl(host, SDHCI_PRESENT_STATE));
> +	DBG("Caps:      0x%08x | Caps_1:   0x%08x\n",
> +	    sdhci_readl(host, SDHCI_CAPABILITIES),
> +	    sdhci_readl(host, SDHCI_CAPABILITIES_1));
> +
>  	sdhci_read_caps(host);
>  
>  	override_timeout_clk = host->timeout_clk;
> @@ -3747,10 +3750,6 @@ int __sdhci_add_host(struct sdhci_host *host)
>  		goto untasklet;
>  	}
>  
> -#ifdef CONFIG_MMC_DEBUG
> -	sdhci_dumpregs(host);
> -#endif
> -
>  	ret = sdhci_led_register(host);
>  	if (ret) {
>  		pr_err("%s: Failed to register LED device: %d\n",
> 

