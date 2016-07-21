From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1 1/1] sdhci-pci: Use MRFLD as abbreviation of Merrifield
Date: Thu, 21 Jul 2016 13:13:32 +0300
Message-ID: <5790A04C.2040905@intel.com>
References: <1468321422-135871-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:11556 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415AbcGUKRu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Jul 2016 06:17:50 -0400
In-Reply-To: <1468321422-135871-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On 12/07/16 14:03, Andy Shevchenko wrote:
> Everywhere else in the code MRFLD abbreviation is used for Intel Merrifield. Do
> the same for sdhci-pci.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 18 +++++++++---------
>  drivers/mmc/host/sdhci-pci.h      |  2 +-
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 773532d..d116d4f 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -419,13 +419,13 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>  };
>  
>  /* Define Host controllers for Intel Merrifield platform */
> -#define INTEL_MRFL_EMMC_0	0
> -#define INTEL_MRFL_EMMC_1	1
> +#define INTEL_MRFLD_EMMC_0	0
> +#define INTEL_MRFLD_EMMC_1	1
>  
> -static int intel_mrfl_mmc_probe_slot(struct sdhci_pci_slot *slot)
> +static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
>  {
> -	if ((PCI_FUNC(slot->chip->pdev->devfn) != INTEL_MRFL_EMMC_0) &&
> -	    (PCI_FUNC(slot->chip->pdev->devfn) != INTEL_MRFL_EMMC_1))
> +	if ((PCI_FUNC(slot->chip->pdev->devfn) != INTEL_MRFLD_EMMC_0) &&
> +	    (PCI_FUNC(slot->chip->pdev->devfn) != INTEL_MRFLD_EMMC_1))
>  		/* SD support is not ready yet */
>  		return -ENODEV;
>  
> @@ -435,12 +435,12 @@ static int intel_mrfl_mmc_probe_slot(struct sdhci_pci_slot *slot)
>  	return 0;
>  }
>  
> -static const struct sdhci_pci_fixes sdhci_intel_mrfl_mmc = {
> +static const struct sdhci_pci_fixes sdhci_intel_mrfld_mmc = {
>  	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>  	.quirks2	= SDHCI_QUIRK2_BROKEN_HS200 |
>  			SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  	.allow_runtime_pm = true,
> -	.probe_slot	= intel_mrfl_mmc_probe_slot,
> +	.probe_slot	= intel_mrfld_mmc_probe_slot,
>  };
>  
>  /* O2Micro extra registers */
> @@ -1104,10 +1104,10 @@ static const struct pci_device_id pci_ids[] = {
>  
>  	{
>  		.vendor		= PCI_VENDOR_ID_INTEL,
> -		.device		= PCI_DEVICE_ID_INTEL_MRFL_MMC,
> +		.device		= PCI_DEVICE_ID_INTEL_MRFLD_MMC,
>  		.subvendor	= PCI_ANY_ID,
>  		.subdevice	= PCI_ANY_ID,
> -		.driver_data	= (kernel_ulong_t)&sdhci_intel_mrfl_mmc,
> +		.driver_data	= (kernel_ulong_t)&sdhci_intel_mrfld_mmc,
>  	},
>  
>  	{
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 968b81e..e1d44c0 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -14,7 +14,7 @@
>  #define PCI_DEVICE_ID_INTEL_BSW_EMMC	0x2294
>  #define PCI_DEVICE_ID_INTEL_BSW_SDIO	0x2295
>  #define PCI_DEVICE_ID_INTEL_BSW_SD	0x2296
> -#define PCI_DEVICE_ID_INTEL_MRFL_MMC	0x1190
> +#define PCI_DEVICE_ID_INTEL_MRFLD_MMC	0x1190
>  #define PCI_DEVICE_ID_INTEL_CLV_SDIO0	0x08f9
>  #define PCI_DEVICE_ID_INTEL_CLV_SDIO1	0x08fa
>  #define PCI_DEVICE_ID_INTEL_CLV_SDIO2	0x08fb
> 

