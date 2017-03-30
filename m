From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-acpi: Set MMC_CAP_AGGRESSIVE_PM for
 BYT-related Intel controllers
Date: Thu, 30 Mar 2017 10:41:19 +0300
Message-ID: <7b084ccd-8862-3430-0842-de496535d7e2@intel.com>
References: <1490724510-105153-1-git-send-email-azhar.shaikh@intel.com>
 <1490811393-109654-1-git-send-email-azhar.shaikh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:27897 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932555AbdC3HrF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 30 Mar 2017 03:47:05 -0400
In-Reply-To: <1490811393-109654-1-git-send-email-azhar.shaikh@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Azhar Shaikh <azhar.shaikh@intel.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On 29/03/17 21:16, Azhar Shaikh wrote:
> Set MMC_CAP_AGGRESSIVE_PM for BYT-related Intel SD card
> controllers.
> 
> Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in v2:
>   - Rebased the patch on top of 'next' branch.
>   - No code change.
> 
>  drivers/mmc/host/sdhci-acpi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 665c5f3..c6a9a1b 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -263,10 +263,8 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
>  
>  	/* Platform specific code during sd probe slot goes here */
>  
> -	if (hid && !strcmp(hid, "80865ACA")) {
> +	if (hid && !strcmp(hid, "80865ACA"))
>  		host->mmc_host_ops.get_cd = bxt_get_cd;
> -		host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
> -	}
>  
>  	return 0;
>  }
> @@ -302,7 +300,7 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
>  	.quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>  	.quirks2 = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
>  		   SDHCI_QUIRK2_STOP_WITH_TC,
> -	.caps    = MMC_CAP_WAIT_WHILE_BUSY,
> +	.caps    = MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_AGGRESSIVE_PM,
>  	.probe_slot	= sdhci_acpi_sd_probe_slot,
>  };
>  
> 

