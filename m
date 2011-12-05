From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-pci: simplify error handling
Date: Mon, 05 Dec 2011 13:28:59 +0200
Message-ID: <4EDCAAFB.4060209@intel.com>
References: <1322897285.3884.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21296 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755912Ab1LEL3D (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 5 Dec 2011 06:29:03 -0500
In-Reply-To: <1322897285.3884.1.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, Takashi Iwai <tiwai@suse.de>, linux-mmc@vger.kernel.org

On 03/12/11 09:28, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci.c |   38 ++++++++++++++++++--------------------
>  1 files changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index 6878a94..d2e77fb 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -1012,11 +1012,8 @@ static int sdhci_pci_suspend(struct device *dev)
>  
>  		ret = sdhci_suspend_host(slot->host);
>  
> -		if (ret) {
> -			for (i--; i >= 0; i--)
> -				sdhci_resume_host(chip->slots[i]->host);
> -			return ret;
> -		}
> +		if (ret)
> +			goto err_pci_suspend;
>  
>  		slot_pm_flags = slot->host->mmc->pm_flags;
>  		if (slot_pm_flags & MMC_PM_WAKE_SDIO_IRQ)
> @@ -1027,11 +1024,8 @@ static int sdhci_pci_suspend(struct device *dev)
>  
>  	if (chip->fixes && chip->fixes->suspend) {
>  		ret = chip->fixes->suspend(chip);
> -		if (ret) {
> -			for (i = chip->num_slots - 1; i >= 0; i--)
> -				sdhci_resume_host(chip->slots[i]->host);
> -			return ret;
> -		}
> +		if (ret)
> +			goto err_pci_suspend;
>  	}
>  
>  	pci_save_state(pdev);
> @@ -1048,6 +1042,11 @@ static int sdhci_pci_suspend(struct device *dev)
>  	}
>  
>  	return 0;
> +
> +err_pci_suspend:
> +	while (--i >= 0)
> +		sdhci_resume_host(chip->slots[i]->host);
> +	return ret;
>  }
>  
>  static int sdhci_pci_resume(struct device *dev)
> @@ -1113,23 +1112,22 @@ static int sdhci_pci_runtime_suspend(struct device *dev)
>  
>  		ret = sdhci_runtime_suspend_host(slot->host);
>  
> -		if (ret) {
> -			for (i--; i >= 0; i--)
> -				sdhci_runtime_resume_host(chip->slots[i]->host);
> -			return ret;
> -		}
> +		if (ret)
> +			goto err_pci_runtime_suspend;
>  	}
>  
>  	if (chip->fixes && chip->fixes->suspend) {
>  		ret = chip->fixes->suspend(chip);
> -		if (ret) {
> -			for (i = chip->num_slots - 1; i >= 0; i--)
> -				sdhci_runtime_resume_host(chip->slots[i]->host);
> -			return ret;
> -		}
> +		if (ret)
> +			goto err_pci_runtime_suspend;
>  	}
>  
>  	return 0;
> +
> +err_pci_runtime_suspend:
> +	while (--i >= 0)
> +		sdhci_runtime_resume_host(chip->slots[i]->host);
> +	return ret;
>  }
>  
>  static int sdhci_pci_runtime_resume(struct device *dev)

