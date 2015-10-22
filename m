From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci-pci: Add more PCI IDs for Intel controllers
Date: Thu, 22 Oct 2015 15:32:53 +0200
Message-ID: <CAPDyKFrQ7bjJiyHkMGfcuZU4vycHWoV0yVGfZgh_O3KPCGy0Tw@mail.gmail.com>
References: <1445415346-12929-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33842 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757674AbbJVNcz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Oct 2015 09:32:55 -0400
Received: by wikq8 with SMTP id q8so32243184wik.1
        for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2015 06:32:54 -0700 (PDT)
In-Reply-To: <1445415346-12929-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 21 October 2015 at 10:15, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Add PCI IDs for Intel host controllers
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 48 +++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pci.h      |  6 +++++
>  2 files changed, 54 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index b6f6117cb233..cf7ad458b4f4 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1117,6 +1117,54 @@ static const struct pci_device_id pci_ids[] = {
>         },
>
>         {
> +               .vendor         = PCI_VENDOR_ID_INTEL,
> +               .device         = PCI_DEVICE_ID_INTEL_BXT_EMMC,
> +               .subvendor      = PCI_ANY_ID,
> +               .subdevice      = PCI_ANY_ID,
> +               .driver_data    = (kernel_ulong_t)&sdhci_intel_byt_emmc,
> +       },
> +
> +       {
> +               .vendor         = PCI_VENDOR_ID_INTEL,
> +               .device         = PCI_DEVICE_ID_INTEL_BXT_SDIO,
> +               .subvendor      = PCI_ANY_ID,
> +               .subdevice      = PCI_ANY_ID,
> +               .driver_data    = (kernel_ulong_t)&sdhci_intel_byt_sdio,
> +       },
> +
> +       {
> +               .vendor         = PCI_VENDOR_ID_INTEL,
> +               .device         = PCI_DEVICE_ID_INTEL_BXT_SD,
> +               .subvendor      = PCI_ANY_ID,
> +               .subdevice      = PCI_ANY_ID,
> +               .driver_data    = (kernel_ulong_t)&sdhci_intel_byt_sd,
> +       },
> +
> +       {
> +               .vendor         = PCI_VENDOR_ID_INTEL,
> +               .device         = PCI_DEVICE_ID_INTEL_APL_EMMC,
> +               .subvendor      = PCI_ANY_ID,
> +               .subdevice      = PCI_ANY_ID,
> +               .driver_data    = (kernel_ulong_t)&sdhci_intel_byt_emmc,
> +       },
> +
> +       {
> +               .vendor         = PCI_VENDOR_ID_INTEL,
> +               .device         = PCI_DEVICE_ID_INTEL_APL_SDIO,
> +               .subvendor      = PCI_ANY_ID,
> +               .subdevice      = PCI_ANY_ID,
> +               .driver_data    = (kernel_ulong_t)&sdhci_intel_byt_sdio,
> +       },
> +
> +       {
> +               .vendor         = PCI_VENDOR_ID_INTEL,
> +               .device         = PCI_DEVICE_ID_INTEL_APL_SD,
> +               .subvendor      = PCI_ANY_ID,
> +               .subdevice      = PCI_ANY_ID,
> +               .driver_data    = (kernel_ulong_t)&sdhci_intel_byt_sd,
> +       },
> +
> +       {
>                 .vendor         = PCI_VENDOR_ID_O2,
>                 .device         = PCI_DEVICE_ID_O2_8120,
>                 .subvendor      = PCI_ANY_ID,
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index cd4f4d74377e..d1a0b4db60db 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -25,6 +25,12 @@
>  #define PCI_DEVICE_ID_INTEL_SPT_SDIO   0x9d2c
>  #define PCI_DEVICE_ID_INTEL_SPT_SD     0x9d2d
>  #define PCI_DEVICE_ID_INTEL_DNV_EMMC   0x19db
> +#define PCI_DEVICE_ID_INTEL_BXT_SD     0x0aca
> +#define PCI_DEVICE_ID_INTEL_BXT_EMMC   0x0acc
> +#define PCI_DEVICE_ID_INTEL_BXT_SDIO   0x0ad0
> +#define PCI_DEVICE_ID_INTEL_APL_SD     0x5aca
> +#define PCI_DEVICE_ID_INTEL_APL_EMMC   0x5acc
> +#define PCI_DEVICE_ID_INTEL_APL_SDIO   0x5ad0
>
>  /*
>   * PCI registers
> --
> 1.9.1
>
