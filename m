From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-acpi: Intel SDIO has broken card detect
Date: Mon, 07 Apr 2014 08:58:29 +0300
Message-ID: <53423E85.4060102@intel.com>
References: <1396526319-614-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49741 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754653AbaDGF7R (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 7 Apr 2014 01:59:17 -0400
In-Reply-To: <1396526319-614-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi Chris

Can this one go in 3.15?

Regards
Adrian


On 03.04.2014 14:58, Adrian Hunter wrote:
> Intel SDIO has broken card detect so add a quirk
> to reflect that.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-acpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 0d372f0..ebb3f39 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -122,6 +122,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
>  };
>  
>  static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
> +	.quirks  = SDHCI_QUIRK_BROKEN_CARD_DETECTION,
>  	.quirks2 = SDHCI_QUIRK2_HOST_OFF_CARD_ON,
>  	.caps    = MMC_CAP_NONREMOVABLE | MMC_CAP_POWER_OFF_CARD,
>  	.flags   = SDHCI_ACPI_RUNTIME_PM,
> 

