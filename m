From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pci: Add support for Intel CNP
Date: Thu, 8 Jun 2017 15:52:26 +0200
Message-ID: <CAPDyKFouFmBz0L1Qd6=SYFaShDcFn1+Kti9h7gD0SH0VkjoVUQ@mail.gmail.com>
References: <1496308207-3522-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:33193 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbdFHNwc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 09:52:32 -0400
Received: by mail-qt0-f170.google.com with SMTP id u12so41936716qth.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2017 06:52:32 -0700 (PDT)
In-Reply-To: <1496308207-3522-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 1 June 2017 at 11:10, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Add PCI ids and enhanced strobe support for Intel CNP. This is combined
> with GLK due to the pending CMDQ support which they both share.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 46 ++++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci-pci.h      |  3 +++
>  2 files changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index b3ddc32fa00b..8fa84a013be4 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -543,6 +543,23 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
>         }
>  }
>
> +#define INTEL_HS400_ES_REG 0x78
> +#define INTEL_HS400_ES_BIT BIT(0)
> +
> +static void intel_hs400_enhanced_strobe(struct mmc_host *mmc,
> +                                       struct mmc_ios *ios)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       u32 val;
> +
> +       val = sdhci_readl(host, INTEL_HS400_ES_REG);
> +       if (ios->enhanced_strobe)
> +               val |= INTEL_HS400_ES_BIT;
> +       else
> +               val &= ~INTEL_HS400_ES_BIT;
> +       sdhci_writel(host, val, INTEL_HS400_ES_REG);
> +}
> +
>  static const struct sdhci_ops sdhci_intel_byt_ops = {
>         .set_clock              = sdhci_set_clock,
>         .set_power              = sdhci_intel_set_power,
> @@ -579,6 +596,19 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
>         return 0;
>  }
>
> +static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
> +{
> +       int ret = byt_emmc_probe_slot(slot);
> +
> +       if (slot->chip->pdev->device != PCI_DEVICE_ID_INTEL_GLK_EMMC) {
> +               slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES,
> +               slot->host->mmc_host_ops.hs400_enhanced_strobe =
> +                                               intel_hs400_enhanced_strobe;
> +       }
> +
> +       return ret;
> +}
> +
>  #ifdef CONFIG_ACPI
>  static int ni_set_max_freq(struct sdhci_pci_slot *slot)
>  {
> @@ -654,6 +684,17 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
>         .priv_size      = sizeof(struct intel_host),
>  };
>
> +static const struct sdhci_pci_fixes sdhci_intel_glk_emmc = {
> +       .allow_runtime_pm       = true,
> +       .probe_slot             = glk_emmc_probe_slot,
> +       .quirks                 = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +       .quirks2                = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +                                 SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 |
> +                                 SDHCI_QUIRK2_STOP_WITH_TC,
> +       .ops                    = &sdhci_intel_byt_ops,
> +       .priv_size              = sizeof(struct intel_host),
> +};
> +
>  static const struct sdhci_pci_fixes sdhci_ni_byt_sdio = {
>         .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>         .quirks2        = SDHCI_QUIRK2_HOST_OFF_CARD_ON |
> @@ -1225,9 +1266,12 @@ static int amd_probe(struct sdhci_pci_chip *chip)
>         SDHCI_PCI_DEVICE(INTEL, APL_EMMC,  intel_byt_emmc),
>         SDHCI_PCI_DEVICE(INTEL, APL_SDIO,  intel_byt_sdio),
>         SDHCI_PCI_DEVICE(INTEL, APL_SD,    intel_byt_sd),
> -       SDHCI_PCI_DEVICE(INTEL, GLK_EMMC,  intel_byt_emmc),
> +       SDHCI_PCI_DEVICE(INTEL, GLK_EMMC,  intel_glk_emmc),
>         SDHCI_PCI_DEVICE(INTEL, GLK_SDIO,  intel_byt_sdio),
>         SDHCI_PCI_DEVICE(INTEL, GLK_SD,    intel_byt_sd),
> +       SDHCI_PCI_DEVICE(INTEL, CNP_EMMC,  intel_glk_emmc),
> +       SDHCI_PCI_DEVICE(INTEL, CNP_SD,    intel_byt_sd),
> +       SDHCI_PCI_DEVICE(INTEL, CNPH_SD,   intel_byt_sd),
>         SDHCI_PCI_DEVICE(O2, 8120,     o2),
>         SDHCI_PCI_DEVICE(O2, 8220,     o2),
>         SDHCI_PCI_DEVICE(O2, 8221,     o2),
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index e63fb9b3b776..75196a2b5289 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -37,6 +37,9 @@
>  #define PCI_DEVICE_ID_INTEL_GLK_SD     0x31ca
>  #define PCI_DEVICE_ID_INTEL_GLK_EMMC   0x31cc
>  #define PCI_DEVICE_ID_INTEL_GLK_SDIO   0x31d0
> +#define PCI_DEVICE_ID_INTEL_CNP_EMMC   0x9dc4
> +#define PCI_DEVICE_ID_INTEL_CNP_SD     0x9df5
> +#define PCI_DEVICE_ID_INTEL_CNPH_SD    0xa375
>
>  #define PCI_DEVICE_ID_SYSKONNECT_8000  0x8000
>  #define PCI_DEVICE_ID_VIA_95D0         0x95d0
> --
> 1.9.1
>
