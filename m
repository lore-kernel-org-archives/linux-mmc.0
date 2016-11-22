From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci: Use ACPI to get max frequency for
 Intel byt sdio controller sub-vended by NI
Date: Tue, 22 Nov 2016 09:24:33 +0100
Message-ID: <CAPDyKFrxAu8PhA0bgD22O_Z5i4ocdHrV1SAbVzXfuT-5XizKdQ@mail.gmail.com>
References: <1479769446-8490-1-git-send-email-zach.brown@ni.com> <1479769446-8490-3-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36627 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752817AbcKVIYo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2016 03:24:44 -0500
Received: by mail-wm0-f41.google.com with SMTP id g23so11616304wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 22 Nov 2016 00:24:35 -0800 (PST)
In-Reply-To: <1479769446-8490-3-git-send-email-zach.brown@ni.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zach Brown <zach.brown@ni.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 22 November 2016 at 00:04, Zach Brown <zach.brown@ni.com> wrote:
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

I am not a fan of these kind of "ifdefs" immediately in the code. I
rather see them around functions.

Either separate the code within the ifdefs here into it's own function
(and call it from here) and make a stub function in case when
CONFIG_ACPI is unset. Or, perhaps easier, have one version of
ni_byt_sdio_probe_slot() when CONFIG_ACPI is set and another one when
it's unset.


> +       acpi_status status;
> +       unsigned long long max_freq;
> +
> +       status = acpi_evaluate_integer(ACPI_HANDLE(&slot->chip->pdev->dev),
> +                                      "MXFQ", NULL, &max_freq);
> +       if (ACPI_FAILURE(status)) {
> +               dev_info(&slot->chip->pdev->dev,
> +                       "MXFQ not found in acpi table\n");
> +               return -EINVAL;
> +       }
> +
> +       slot->host->mmc->f_max = max_freq * 1000000;
> +#endif
>         slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE |
>                                  MMC_CAP_WAIT_WHILE_BUSY;
>         return 0;
> --
> 2.7.4
>

Kind regards
Uffe
