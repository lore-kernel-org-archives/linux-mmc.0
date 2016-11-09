From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC 2/2] mmc: sdhci-pci: Use ACPI to get max frequency for Intel
 byt sdio host controller sub-vended by NI
Date: Wed, 9 Nov 2016 15:24:24 +0200
Message-ID: <af8a14a2-55a5-1d44-663e-53ff20408f10@intel.com>
References: <1478635635-14953-1-git-send-email-zach.brown@ni.com>
 <1478635635-14953-3-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39563 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932642AbcKIN3V (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 9 Nov 2016 08:29:21 -0500
In-Reply-To: <1478635635-14953-3-git-send-email-zach.brown@ni.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zach Brown <zach.brown@ni.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/11/16 22:07, Zach Brown wrote:
> On NI 9037 boards the max SDIO frequency is limited by trace lengths
> and other layout choices. The max SDIO frequency is stored in an ACPI
> table, as MXFQ.
> 
> The driver reads the ACPI entry MXFQ during sdio_probe_slot and sets the
> f_max field of the host with it.
> 
> Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
> Reviewed-by: Jaeden Amero <jaeden.amero@ni.com>
> Reviewed-by: Josh Cartwright <joshc@ni.com>
> Signed-off-by: Zach Brown <zach.brown@ni.com>
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index c333ce2..4ac7f16 100644
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
> @@ -377,6 +378,35 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
>  
>  static int ni_byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
>  {
> +#ifdef CONFIG_ACPI
> +	/* Get max freq from ACPI for NI hardware */
> +	acpi_handle acpi_hdl;
> +	acpi_status status;
> +	struct acpi_buffer acpi_result = {
> +		ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *acpi_buffer;
> +	int max_freq;
> +
> +	status = acpi_get_handle(ACPI_HANDLE(&slot->chip->pdev->dev), "MXFQ",
> +				 &acpi_hdl);

Is "MXFQ" an object that has already been deployed or are you inventing it
now?  In the latter case, did you consider device properties as an alternative?

> +	if (ACPI_FAILURE(status))
> +		return  -ENODEV;
> +
> +	status = acpi_evaluate_object(acpi_hdl, NULL,
> +				      NULL, &acpi_result);
> +	if (ACPI_FAILURE(status))
> +		return -EINVAL;
> +
> +	acpi_buffer = (union acpi_object *)acpi_result.pointer;
> +
> +	if (acpi_buffer->type != ACPI_TYPE_INTEGER)
> +		return -EINVAL;
> +
> +	max_freq = acpi_buffer->integer.value;
> +
> +	slot->host->mmc->f_max = max_freq * 1000000;
> +#endif
> +
>  	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE;
>  	return 0;
>  }
> 

