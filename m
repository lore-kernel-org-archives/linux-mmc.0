From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 2/2] mmc: sdhci-pci: Use ACPI to get max frequency for
 Intel byt sdio controller sub-vended by NI
Date: Thu, 1 Dec 2016 09:52:22 +0200
Message-ID: <3fff7fbe-1631-735c-32b6-3444ac657ccd@intel.com>
References: <1480360599-13295-1-git-send-email-zach.brown@ni.com>
 <1480360599-13295-3-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49418 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753276AbcLAH5z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Dec 2016 02:57:55 -0500
In-Reply-To: <1480360599-13295-3-git-send-email-zach.brown@ni.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zach Brown <zach.brown@ni.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 28/11/16 21:16, Zach Brown wrote:
> On NI 9037 boards the max SDIO frequency is limited by trace lengths
> and other layout choices. The max SDIO frequency is stored in an ACPI
> table.
> 
> The driver reads the ACPI entry MXFQ during sdio_probe_slot and sets the
> f_max field of the host.
> 
> Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
> Reviewed-by: Jaeden Amero <jaeden.amero@ni.com>
> Reviewed-by: Josh Cartwright <joshc@ni.com>
> Signed-off-by: Zach Brown <zach.brown@ni.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 9741505..c9e51b1 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -27,6 +27,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/mmc/sdhci-pci-data.h>
> +#include <linux/acpi.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-pci.h"
> @@ -375,8 +376,39 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_ACPI
> +static int ni_set_max_freq(struct sdhci_pci_slot *slot)
> +{
> +	acpi_status status;
> +	unsigned long long max_freq;
> +
> +	status = acpi_evaluate_integer(ACPI_HANDLE(&slot->chip->pdev->dev),
> +				       "MXFQ", NULL, &max_freq);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(&slot->chip->pdev->dev,
> +			"MXFQ not found in acpi table\n");
> +		return -EINVAL;
> +	}
> +
> +	slot->host->mmc->f_max = max_freq * 1000000;
> +
> +	return 0;
> +}
> +#else
> +static inline int ni_set_max_freq(struct sdhci_pci_slot *slot)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int ni_byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
>  {
> +	int err;
> +
> +	err = ni_set_max_freq(slot);
> +	if (err)
> +		return err;
> +
>  	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE |
>  				 MMC_CAP_WAIT_WHILE_BUSY;
>  	return 0;
> 

