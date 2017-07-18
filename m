From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 6/6] mmc: sdhci: remove CONFIG_MMC_DEBUG from the
 driver
Date: Tue, 18 Jul 2017 12:38:20 +0300
Message-ID: <b21d0902-826c-c4b2-0bf0-7ff453a9bfa6@intel.com>
References: <1500368376-160272-1-git-send-email-shawn.lin@rock-chips.com>
 <1500368503-160501-1-git-send-email-shawn.lin@rock-chips.com>
 <1500368503-160501-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:17022 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbdGRJog (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Jul 2017 05:44:36 -0400
In-Reply-To: <1500368503-160501-2-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

On 18/07/17 12:01, Shawn Lin wrote:
> sdhci uses CONFIG_MMC_DEBUG for showing ADMA descriptor
> when occurring ADMA error. And it's also used to  dump the
> registers whenever calling sdhci_add_host.
> 
> On one hand, I don't see any burden to always print the state
> ADMA descriptor as it's rare and will help folks better understand
> what was happening when seeing ADMA error.
> 
> On the other, git-blame points out that CONFIG_MMC_DEBUG for
> sdhci_add_host was added since it's merged for the first time.
> I don't know what exactly the intention was, but I guess folks
> don't need it at all? IMHO, it's another all-or-none proposition.
> I'd prefer to remove this sdhci_dumpregs from sdhci_add_host totally.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
>  drivers/mmc/host/sdhci.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ecd0d43..82f1761 100644
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
> @@ -3747,10 +3743,6 @@ int __sdhci_add_host(struct sdhci_host *host)
>  		goto untasklet;
>  	}
>  
> -#ifdef CONFIG_MMC_DEBUG
> -	sdhci_dumpregs(host);
> -#endif

We should still DBG() the interesting registers like SDHCI_HOST_VERSION,
SDHCI_PRESENT_STATE, SDHCI_CAPABILITIES, SDHCI_CAPABILITIES_1.  Better to do
it earlier on though, like in sdhci_setup_host() after checking
mmc_regulator_get_supply().

> -
>  	ret = sdhci_led_register(host);
>  	if (ret) {
>  		pr_err("%s: Failed to register LED device: %d\n",
> 

