From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-pci: Set MMC_CAP_AGGRESSIVE_PM for
 BYT-related Intel controllers
Date: Thu, 30 Mar 2017 21:31:09 +0200
Message-ID: <CAPDyKFpSw_CMUY85hJXzjWarMRzVMXw-Q76ndLc91Z49PzEiGA@mail.gmail.com>
References: <1490724510-105153-1-git-send-email-azhar.shaikh@intel.com>
 <1490811393-109654-1-git-send-email-azhar.shaikh@intel.com> <1490811393-109654-2-git-send-email-azhar.shaikh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33897 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934667AbdC3TbL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Mar 2017 15:31:11 -0400
Received: by mail-vk0-f48.google.com with SMTP id z204so67245070vkd.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Mar 2017 12:31:10 -0700 (PDT)
In-Reply-To: <1490811393-109654-2-git-send-email-azhar.shaikh@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Azhar Shaikh <azhar.shaikh@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 29 March 2017 at 20:16, Azhar Shaikh <azhar.shaikh@intel.com> wrote:
> Set MMC_CAP_AGGRESSIVE_PM for BYT-related Intel SD card
> controllers.
>
> Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>


Thanks, applied for next!

Kind regards
Uffe


> ---
> Changes in v2:
>   - Rebased the patch on top of 'next' branch.
>   - No code change.
>
>  drivers/mmc/host/sdhci-pci-core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 6c0440e..833072b 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -630,16 +630,15 @@ static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
>  static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
>  {
>         byt_read_dsm(slot);
> -       slot->host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> +       slot->host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
> +                                MMC_CAP_AGGRESSIVE_PM;
>         slot->cd_idx = 0;
>         slot->cd_override_level = true;
>         if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BXT_SD ||
>             slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BXTM_SD ||
>             slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD ||
> -           slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_SD) {
> +           slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_SD)
>                 slot->host->mmc_host_ops.get_cd = bxt_get_cd;
> -               slot->host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
> -       }
>
>         return 0;
>  }
> --
> 1.9.1
>
