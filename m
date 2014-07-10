From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: Preset value not supported in Baytrail eMMC
Date: Thu, 10 Jul 2014 15:00:46 +0200
Message-ID: <CAPDyKFpwUo-CV0656-YnHUOP_z0322Yu3C6HHAqRNBn-RmS75w@mail.gmail.com>
References: <1404817861-23359-1-git-send-email-mauricex.r.petallo@intel.com>
	<1404817861-23359-2-git-send-email-mauricex.r.petallo@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:57615 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbaGJNAr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jul 2014 09:00:47 -0400
Received: by mail-qa0-f41.google.com with SMTP id cm18so7202603qab.14
        for <linux-mmc@vger.kernel.org>; Thu, 10 Jul 2014 06:00:46 -0700 (PDT)
In-Reply-To: <1404817861-23359-2-git-send-email-mauricex.r.petallo@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maurice Petallo <mauricex.r.petallo@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 8 July 2014 13:11, Maurice Petallo <mauricex.r.petallo@intel.com> wrote:
> "SDHCI_QUIRK2_PRESET_VALUE_BROKEN" quirk is added to prohibit
> preset value enabling for Baytrail eMMC controller.
>
> Signed-off-by: Maurice Petallo <mauricex.r.petallo@intel.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-acpi.c | 1 +
>  drivers/mmc/host/sdhci-pci.c  | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 8ce3c28..840788e 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -127,6 +127,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
>         .caps    = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE | MMC_CAP_HW_RESET,
>         .caps2   = MMC_CAP2_HC_ERASE_SZ,
>         .flags   = SDHCI_ACPI_RUNTIME_PM,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>
>  static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index 52c42fc..7514cc7 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -279,6 +279,7 @@ static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
>  static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
>         .allow_runtime_pm = true,
>         .probe_slot     = byt_emmc_probe_slot,
> +       .quirks2        = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>
>  static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
> --
> 1.8.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
