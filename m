From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci: Use ACPI to get max frequency for
 Intel byt sdio controller sub-vended by NI
Date: Tue, 22 Nov 2016 08:46:33 +0200
Message-ID: <13cdcecc-213c-e486-654a-8672391c8fa3@intel.com>
References: <1479769446-8490-1-git-send-email-zach.brown@ni.com>
 <1479769446-8490-3-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:18842 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752212AbcKVGvd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 22 Nov 2016 01:51:33 -0500
In-Reply-To: <1479769446-8490-3-git-send-email-zach.brown@ni.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zach Brown <zach.brown@ni.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 22/11/16 01:04, Zach Brown wrote:
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
>  drivers/mmc/host/sdhci-pci-core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 9741505..a855c97 100644
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
> @@ -377,6 +378,20 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
>  
>  static int ni_byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
>  {
> +#ifdef CONFIG_ACPI
> +	acpi_status status;
> +	unsigned long long max_freq;
> +
> +	status = acpi_evaluate_integer(ACPI_HANDLE(&slot->chip->pdev->dev),
> +				       "MXFQ", NULL, &max_freq);
> +	if (ACPI_FAILURE(status)) {
> +		dev_info(&slot->chip->pdev->dev,

Doesn't it error out the whole probe.  So it should be dev_err()

> +			"MXFQ not found in acpi table\n");
> +		return -EINVAL;
> +	}
> +
> +	slot->host->mmc->f_max = max_freq * 1000000;
> +#endif
>  	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE |
>  				 MMC_CAP_WAIT_WHILE_BUSY;
>  	return 0;
> 

