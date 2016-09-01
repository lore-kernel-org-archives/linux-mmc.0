From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 1/3] sdhci-pci: refactor intel_mrfld_mmc_probe_slot()
Date: Thu, 1 Sep 2016 16:17:59 +0200
Message-ID: <CAPDyKFrHjV-gPGSY2viR=oi+y0h+P1zzEzm7ySZ+21bmLEcwZA@mail.gmail.com>
References: <1472463221-11948-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37291 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933918AbcIAOSD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Sep 2016 10:18:03 -0400
Received: by mail-wm0-f54.google.com with SMTP id v143so24216033wmv.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Sep 2016 07:18:03 -0700 (PDT)
In-Reply-To: <1472463221-11948-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 29 August 2016 at 11:33, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Refactor intel_mrfld_mmc_probe_slot() to use switch case. The change allows to
> add a support for SD and SDIO interfaces without any pain.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, applied for next!

Kind regards
Uffe

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
> -       if ((PCI_FUNC(slot->chip->pdev->devfn) != INTEL_MRFLD_EMMC_0) &&
> -           (PCI_FUNC(slot->chip->pdev->devfn) != INTEL_MRFLD_EMMC_1))
> +       unsigned int func = PCI_FUNC(slot->chip->pdev->devfn);
> +
> +       switch (func) {
> +       case INTEL_MRFLD_EMMC_0:
> +       case INTEL_MRFLD_EMMC_1:
> +               slot->host->mmc->caps |= MMC_CAP_NONREMOVABLE |
> +                                        MMC_CAP_8_BIT_DATA |
> +                                        MMC_CAP_1_8V_DDR;
> +               break;
> +       default:
>                 /* SD support is not ready yet */
>                 return -ENODEV;
> -
> -       slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
> -                                MMC_CAP_1_8V_DDR;
> -
> +       }
>         return 0;
>  }
>
> --
> 2.8.1
>
