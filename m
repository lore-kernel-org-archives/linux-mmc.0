From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 2/3] sdhci-pci: enable SDIO interface on Intel Merrifield
Date: Thu, 1 Sep 2016 16:18:04 +0200
Message-ID: <CAPDyKFq+_iT_xCHNqXvzptgv+0m5ePtzZtemPG-ZKrHDGfsfhg@mail.gmail.com>
References: <1472463221-11948-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1472463221-11948-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36092 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933991AbcIAOSH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Sep 2016 10:18:07 -0400
Received: by mail-wm0-f51.google.com with SMTP id c133so80944507wmd.1
        for <linux-mmc@vger.kernel.org>; Thu, 01 Sep 2016 07:18:06 -0700 (PDT)
In-Reply-To: <1472463221-11948-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 29 August 2016 at 11:33, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Intel Merrifield is known to have an SDIO interface and on Intel Edison board a
> WiFi card is wired to it.
>
> Enable the interface here to allow WiFi card enumeration.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, applied for next!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 40f4fe8..d38d701 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -419,6 +419,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>  /* Define Host controllers for Intel Merrifield platform */
>  #define INTEL_MRFLD_EMMC_0     0
>  #define INTEL_MRFLD_EMMC_1     1
> +#define INTEL_MRFLD_SDIO       3
>
>  static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
>  {
> @@ -431,6 +432,10 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
>                                          MMC_CAP_8_BIT_DATA |
>                                          MMC_CAP_1_8V_DDR;
>                 break;
> +       case INTEL_MRFLD_SDIO:
> +               slot->host->mmc->caps |= MMC_CAP_NONREMOVABLE |
> +                                        MMC_CAP_POWER_OFF_CARD;
> +               break;
>         default:
>                 /* SD support is not ready yet */
>                 return -ENODEV;
> --
> 2.8.1
>
