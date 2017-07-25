From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1] sdhci: pci: Fix up power if device has ACPI companion
Date: Tue, 25 Jul 2017 10:12:43 +0300
Message-ID: <380b2033-1a58-0685-2ea2-51fa58c937de@intel.com>
References: <20170724150750.12217-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:54589 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750756AbdGYHT1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 Jul 2017 03:19:27 -0400
In-Reply-To: <20170724150750.12217-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On 24/07/17 18:07, Andy Shevchenko wrote:
> Fix up a power state in case PCI device has an ACPI companion.
> 
> Do it only for Intel Merrifield for now.
> 
> This is almost copy'n'paste of part of sdhci_acpi_probe() and might be
> split out to a helper function in the future.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

>  drivers/mmc/host/sdhci-pci-core.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index e1721ac37919..2c853cfa8389 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -730,6 +730,24 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>  #define INTEL_MRFLD_SD		2
>  #define INTEL_MRFLD_SDIO	3
>  
> +#ifdef CONFIG_ACPI
> +static void intel_mrfld_mmc_fix_up_power_slot(struct sdhci_pci_slot *slot)
> +{
> +	struct acpi_device *device, *child;
> +
> +	device = ACPI_COMPANION(&slot->chip->pdev->dev);
> +	if (!device)
> +		return;
> +
> +	acpi_device_fix_up_power(device);
> +	list_for_each_entry(child, &device->children, node)
> +		if (child->status.present && child->status.enabled)
> +			acpi_device_fix_up_power(child);
> +}
> +#else
> +static inline void intel_mrfld_mmc_fix_up_power_slot(struct sdhci_pci_slot *slot) {}
> +#endif
> +
>  static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
>  {
>  	unsigned int func = PCI_FUNC(slot->chip->pdev->devfn);
> @@ -751,6 +769,8 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
>  	default:
>  		return -ENODEV;
>  	}
> +
> +	intel_mrfld_mmc_fix_up_power_slot(slot);
>  	return 0;
>  }
>  
> 

