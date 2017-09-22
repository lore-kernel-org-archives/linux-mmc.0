From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pci: Add support for Intel CDF
Date: Fri, 22 Sep 2017 11:46:11 +0200
Message-ID: <CAPDyKFpA_L=z8uAViPL8ZQGWWY=NAEv2t9C=5P84PKS7KeMOeg@mail.gmail.com>
References: <1505737025-18977-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:55655 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbdIVJqM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2017 05:46:12 -0400
Received: by mail-io0-f173.google.com with SMTP id z187so1799815ioz.12
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2017 02:46:12 -0700 (PDT)
In-Reply-To: <1505737025-18977-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 18 September 2017 at 14:17, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Add PCI Id for Intel CDF.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 1 +
>  drivers/mmc/host/sdhci-pci.h      | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index d0ccc6729fd2..5f3f7b51299f 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1288,6 +1288,7 @@ static int amd_probe(struct sdhci_pci_chip *chip)
>         SDHCI_PCI_DEVICE(INTEL, SPT_SDIO,  intel_byt_sdio),
>         SDHCI_PCI_DEVICE(INTEL, SPT_SD,    intel_byt_sd),
>         SDHCI_PCI_DEVICE(INTEL, DNV_EMMC,  intel_byt_emmc),
> +       SDHCI_PCI_DEVICE(INTEL, CDF_EMMC,  intel_glk_emmc),
>         SDHCI_PCI_DEVICE(INTEL, BXT_EMMC,  intel_byt_emmc),
>         SDHCI_PCI_DEVICE(INTEL, BXT_SDIO,  intel_byt_sdio),
>         SDHCI_PCI_DEVICE(INTEL, BXT_SD,    intel_byt_sd),
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 75196a2b5289..3c1dd79fdbde 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -25,6 +25,7 @@
>  #define PCI_DEVICE_ID_INTEL_SPT_SDIO   0x9d2c
>  #define PCI_DEVICE_ID_INTEL_SPT_SD     0x9d2d
>  #define PCI_DEVICE_ID_INTEL_DNV_EMMC   0x19db
> +#define PCI_DEVICE_ID_INTEL_CDF_EMMC   0x18db
>  #define PCI_DEVICE_ID_INTEL_BXT_SD     0x0aca
>  #define PCI_DEVICE_ID_INTEL_BXT_EMMC   0x0acc
>  #define PCI_DEVICE_ID_INTEL_BXT_SDIO   0x0ad0
> --
> 1.9.1
>
