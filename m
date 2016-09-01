From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1 1/3] sdhci-pci: refactor intel_mrfld_mmc_probe_slot()
Date: Thu, 1 Sep 2016 16:20:33 +0300
Message-ID: <1eac5d15-bdda-eab9-c604-294d8726ae7f@intel.com>
References: <1472463221-11948-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:52471 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752629AbcIANZI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Sep 2016 09:25:08 -0400
In-Reply-To: <1472463221-11948-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On 29/08/16 12:33, Andy Shevchenko wrote:
> Refactor intel_mrfld_mmc_probe_slot() to use switch case. The change allows to
> add a support for SD and SDIO interfaces without any pain.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 93bb0ff..40f4fe8 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -422,14 +422,19 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>  
>  static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
>  {
> -	if ((PCI_FUNC(slot->chip->pdev->devfn) != INTEL_MRFLD_EMMC_0) &&
> -	    (PCI_FUNC(slot->chip->pdev->devfn) != INTEL_MRFLD_EMMC_1))
> +	unsigned int func = PCI_FUNC(slot->chip->pdev->devfn);
> +
> +	switch (func) {
> +	case INTEL_MRFLD_EMMC_0:
> +	case INTEL_MRFLD_EMMC_1:
> +		slot->host->mmc->caps |= MMC_CAP_NONREMOVABLE |
> +					 MMC_CAP_8_BIT_DATA |
> +					 MMC_CAP_1_8V_DDR;
> +		break;
> +	default:
>  		/* SD support is not ready yet */
>  		return -ENODEV;
> -
> -	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
> -				 MMC_CAP_1_8V_DDR;
> -
> +	}
>  	return 0;
>  }
>  
> 

