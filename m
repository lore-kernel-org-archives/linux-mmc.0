From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC v2 2/2] mmc: sdhci-pci: Use ACPI to get max frequency for
 Intel byt sdio controller sub-vended by NI
Date: Thu, 17 Nov 2016 14:26:34 +0200
Message-ID: <d9254fda-8249-2dfa-2939-80c224cae05f@intel.com>
References: <1479227541-21201-1-git-send-email-zach.brown@ni.com>
 <1479227541-21201-3-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479227541-21201-3-git-send-email-zach.brown@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zach Brown <zach.brown@ni.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 15/11/16 18:32, Zach Brown wrote:
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
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 9741505..4c31d16 100644
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
> @@ -377,6 +378,18 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
>  
>  static int ni_byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
>  {
> +#ifdef CONFIG_ACPI
> +	/* Get max freq from ACPI for NI hardware */

The comment seems a little redundant.

> +	acpi_status status;
> +	unsigned long long max_freq;
> +
> +	status = acpi_evaluate_integer(ACPI_HANDLE(&slot->chip->pdev->dev),
> +				       "MXFQ", NULL, &max_freq);
> +	if (ACPI_FAILURE(status))
> +		return -EINVAL;

I wonder if you should print an error message to let the user know why the
driver failed to probe.

> +
> +	slot->host->mmc->f_max = max_freq * 1000000;
> +#endif
>  	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE |
>  				 MMC_CAP_WAIT_WHILE_BUSY;
>  	return 0;
> 
