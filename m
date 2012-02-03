From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH 2/2] mmc: sdhci: always reset all during resume
Date: Fri, 3 Feb 2012 10:02:37 +0800
Message-ID: <20120203020237.GA6865@ladygaga>
References: <1327926439-23603-1-git-send-email-adrian.hunter@intel.com>
 <1327926439-23603-3-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:27677
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753994Ab2BCCCv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Feb 2012 21:02:51 -0500
Content-Disposition: inline
In-Reply-To: <1327926439-23603-3-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>

On Mon, Jan 30, 2012 at 02:27:19PM +0200, Adrian Hunter wrote:
> During suspend the host controller may or may not be powered off.
> In order to get the same result either way, always perform a
> software "reset all" when resuming.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Philip Rakity <prakity@marvell.com>
> Cc: Aaron Lu <aaron.lu@amd.com>

Acked-by: Aaron Lu <aaron.lu@amd.com>

> ---
>  drivers/mmc/host/sdhci.c |   29 +++++++++++------------------
>  1 files changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8d66706..ef2434c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -219,31 +219,20 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
>  	}
>  }
>  
> -static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
> -
> -static void sdhci_init(struct sdhci_host *host, int soft)
> +static void sdhci_init(struct sdhci_host *host)
>  {
> -	if (soft)
> -		sdhci_reset(host, SDHCI_RESET_CMD|SDHCI_RESET_DATA);
> -	else
> -		sdhci_reset(host, SDHCI_RESET_ALL);
> +	sdhci_reset(host, SDHCI_RESET_ALL);
>  
>  	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
>  		SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
>  		SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_INDEX |
>  		SDHCI_INT_END_BIT | SDHCI_INT_CRC | SDHCI_INT_TIMEOUT |
>  		SDHCI_INT_DATA_END | SDHCI_INT_RESPONSE);
> -
> -	if (soft) {
> -		/* force clock reconfiguration */
> -		host->clock = 0;
> -		sdhci_set_ios(host->mmc, &host->mmc->ios);
> -	}
>  }
>  
>  static void sdhci_reinit(struct sdhci_host *host)
>  {
> -	sdhci_init(host, 0);
> +	sdhci_init(host);
>  	sdhci_enable_card_detection(host);
>  }
>  
> @@ -2423,8 +2412,12 @@ int sdhci_resume_host(struct sdhci_host *host)
>  	if (ret)
>  		return ret;
>  
> -	sdhci_init(host, (host->mmc->pm_flags & MMC_PM_KEEP_POWER));
> -	mmiowb();
> +	sdhci_init(host);
> +
> +	/* Force clock and power re-program */
> +	host->pwr = 0;
> +	host->clock = 0;
> +	sdhci_do_set_ios(host, &host->mmc->ios);
>  
>  	ret = mmc_resume_host(host->mmc);
>  	sdhci_enable_card_detection(host);
> @@ -2500,7 +2493,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
>  			host->ops->enable_dma(host);
>  	}
>  
> -	sdhci_init(host, 0);
> +	sdhci_init(host);
>  
>  	/* Force clock and power re-program */
>  	host->pwr = 0;
> @@ -2980,7 +2973,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  		host->vmmc = NULL;
>  	}
>  
> -	sdhci_init(host, 0);
> +	sdhci_init(host);
>  
>  #ifdef CONFIG_MMC_DEBUG
>  	sdhci_dumpregs(host);
> -- 
> 1.7.6.4
> 
> 

