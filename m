From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Add PCI IDs for Intel Braswell
Date: Fri, 29 Aug 2014 13:08:25 +0200
Message-ID: <CAPDyKFp+NYUOVwjiHLDAB2idSXmUFDGNGxVLUyNRW_XuVCoRkw@mail.gmail.com>
References: <1408530464-8025-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:58518 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177AbaH2LI1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Aug 2014 07:08:27 -0400
Received: by mail-lb0-f173.google.com with SMTP id c11so2399403lbj.18
        for <linux-mmc@vger.kernel.org>; Fri, 29 Aug 2014 04:08:26 -0700 (PDT)
In-Reply-To: <1408530464-8025-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Chris Ball <chris@printf.net>, Alan Cox <alan@linux.intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 20 August 2014 12:27, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> From: Alan Cox <alan@linux.intel.com>
>
> The hardware is the same as used in Baytrail. Add these new PCI IDs to the
> driver's list of supported IDs.
>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci.c | 23 +++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pci.h |  3 +++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index c3a1debc9289..03daad56d884 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -876,6 +876,29 @@ static const struct pci_device_id pci_ids[] = {
>                 .driver_data    = (kernel_ulong_t)&sdhci_intel_byt_emmc,
>         },
>
> +       {
> +               .vendor         = PCI_VENDOR_ID_INTEL,
> +               .device         = PCI_DEVICE_ID_INTEL_BSW_EMMC,
> +               .subvendor      = PCI_ANY_ID,
> +               .subdevice      = PCI_ANY_ID,
> +               .driver_data    = (kernel_ulong_t)&sdhci_intel_byt_emmc,
> +       },
> +
> +       {
> +               .vendor         = PCI_VENDOR_ID_INTEL,
> +               .device         = PCI_DEVICE_ID_INTEL_BSW_SDIO,
> +               .subvendor      = PCI_ANY_ID,
> +               .subdevice      = PCI_ANY_ID,
> +               .driver_data    = (kernel_ulong_t)&sdhci_intel_byt_sdio,
> +       },
> +
> +       {
> +               .vendor         = PCI_VENDOR_ID_INTEL,
> +               .device         = PCI_DEVICE_ID_INTEL_BSW_SD,
> +               .subvendor      = PCI_ANY_ID,
> +               .subdevice      = PCI_ANY_ID,
> +               .driver_data    = (kernel_ulong_t)&sdhci_intel_byt_sd,
> +       },
>
>         {
>                 .vendor         = PCI_VENDOR_ID_INTEL,
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index c101477ef3be..9c1909b2a3ad 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -11,6 +11,9 @@
>  #define PCI_DEVICE_ID_INTEL_BYT_SDIO   0x0f15
>  #define PCI_DEVICE_ID_INTEL_BYT_SD     0x0f16
>  #define PCI_DEVICE_ID_INTEL_BYT_EMMC2  0x0f50
> +#define PCI_DEVICE_ID_INTEL_BSW_EMMC   0x2294
> +#define PCI_DEVICE_ID_INTEL_BSW_SDIO   0x2295
> +#define PCI_DEVICE_ID_INTEL_BSW_SD     0x2296
>  #define PCI_DEVICE_ID_INTEL_MRFL_MMC   0x1190
>  #define PCI_DEVICE_ID_INTEL_CLV_SDIO0  0x08f9
>  #define PCI_DEVICE_ID_INTEL_CLV_SDIO1  0x08fa
> --
> 2.1.0
>
