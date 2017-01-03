From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1 1/2] mmc: sdhci-pci: Remove unused member cd_con_id
Date: Tue, 3 Jan 2017 16:12:05 +0200
Message-ID: <4b7ca4f1-dd05-f87c-6300-e4583006f90d@intel.com>
References: <20170102120525.178212-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:30441 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934958AbdACORP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Jan 2017 09:17:15 -0500
In-Reply-To: <20170102120525.178212-1-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On 02/01/17 14:05, Andy Shevchenko wrote:
> cd_con_id is not used and always NULL.
> Remove it to make code a bit more cleaner.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 3 +--
>  drivers/mmc/host/sdhci-pci.h      | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 1a72d32af07f..5c275b7d0d53 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -424,7 +424,6 @@ static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
>  static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
>  {
>  	slot->host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> -	slot->cd_con_id = NULL;
>  	slot->cd_idx = 0;
>  	slot->cd_override_level = true;
>  	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BXT_SD ||
> @@ -1817,7 +1816,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  	host->mmc->caps2 |= MMC_CAP2_NO_PRESCAN_POWERUP;
>  
>  	if (slot->cd_idx >= 0) {
> -		ret = mmc_gpiod_request_cd(host->mmc, slot->cd_con_id, slot->cd_idx,
> +		ret = mmc_gpiod_request_cd(host->mmc, NULL, slot->cd_idx,
>  					   slot->cd_override_level, 0, NULL);
>  		if (ret == -EPROBE_DEFER)
>  			goto remove;
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 4abdaed72bd4..36f743464fcc 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -81,7 +81,6 @@ struct sdhci_pci_slot {
>  	int			cd_gpio;
>  	int			cd_irq;
>  
> -	char			*cd_con_id;
>  	int			cd_idx;
>  	bool			cd_override_level;
>  
> 

