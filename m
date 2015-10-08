From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pci: Add another PCI ID for an Intel eMMC host controller
Date: Thu, 8 Oct 2015 19:36:10 +0200
Message-ID: <CAPDyKFrLudGiiCKByqJPx6O4a9vbJu0p4p_ACMptV-_kTijtdQ@mail.gmail.com>
References: <1444116381-31726-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37539 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933271AbbJHRgL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Oct 2015 13:36:11 -0400
Received: by wicfx3 with SMTP id fx3so35450607wic.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Oct 2015 10:36:10 -0700 (PDT)
In-Reply-To: <1444116381-31726-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 6 October 2015 at 09:26, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Add another PCI ID for an Intel eMMC host controller.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next.

I fixed the rebase myself, as drivers/mmc/host/sdhci-pci.c were
renamed to drivers/mmc/host/sdhci-pci-core.c earlier.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci.c | 8 ++++++++
>  drivers/mmc/host/sdhci-pci.h | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index b3b0a3e4fca1..7ccd4220076c 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -1113,6 +1113,14 @@ static const struct pci_device_id pci_ids[] = {
>         },
>
>         {
> +               .vendor         = PCI_VENDOR_ID_INTEL,
> +               .device         = PCI_DEVICE_ID_INTEL_DNV_EMMC,
> +               .subvendor      = PCI_ANY_ID,
> +               .subdevice      = PCI_ANY_ID,
> +               .driver_data    = (kernel_ulong_t)&sdhci_intel_byt_emmc,
> +       },
> +
> +       {
>                 .vendor         = PCI_VENDOR_ID_O2,
>                 .device         = PCI_DEVICE_ID_O2_8120,
>                 .subvendor      = PCI_ANY_ID,
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 541f1cad5247..cd4f4d74377e 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -24,6 +24,7 @@
>  #define PCI_DEVICE_ID_INTEL_SPT_EMMC   0x9d2b
>  #define PCI_DEVICE_ID_INTEL_SPT_SDIO   0x9d2c
>  #define PCI_DEVICE_ID_INTEL_SPT_SD     0x9d2d
> +#define PCI_DEVICE_ID_INTEL_DNV_EMMC   0x19db
>
>  /*
>   * PCI registers
> --
> 1.9.1
>
