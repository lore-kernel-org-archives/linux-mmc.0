From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci-pci: Build o2micro support in the same module
Date: Thu, 8 Oct 2015 19:35:40 +0200
Message-ID: <CAPDyKFpH5AxudzvDjRk+vLhQxcfAgPq=R+-BshHd_vE82Js77w@mail.gmail.com>
References: <1444073478.2730.308.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36561 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932930AbbJHRfl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Oct 2015 13:35:41 -0400
Received: by wicgb1 with SMTP id gb1so35782948wic.1
        for <linux-mmc@vger.kernel.org>; Thu, 08 Oct 2015 10:35:40 -0700 (PDT)
In-Reply-To: <1444073478.2730.308.camel@decadent.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Peter Guo <peter.guo@bayhubtech.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 5 October 2015 at 21:31, Ben Hutchings <ben@decadent.org.uk> wrote:
> sdhci-pci-o2micro.c contains no initialisation and its functions are only
> called from shdci-pci.c, so there is no reason for it to be a separate
> module, let alone or for it to always be built-in.
>
> - Rename sdhci-pci.c to sdhci-pci-core.c so that the sdhci-pci module
>   can be built from multiple source files
> - Add sdhci-pci-o2micro.c to it
> - Remove redundant exports
>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Thanks, applied patch1, patch2 and the patch fixing the coccinelle
warning from build test.

Kind regards
Uffe

> ---
>  drivers/mmc/host/Makefile                          | 2 +-
>  drivers/mmc/host/{sdhci-pci.c => sdhci-pci-core.c} | 0
>  drivers/mmc/host/sdhci-pci-o2micro.c               | 4 ----
>  3 files changed, 1 insertion(+), 5 deletions(-)
>  rename drivers/mmc/host/{sdhci-pci.c => sdhci-pci-core.c} (100%)
>
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 4f3452a..3595f83 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -9,8 +9,8 @@ obj-$(CONFIG_MMC_MXC)           += mxcmmc.o
>  obj-$(CONFIG_MMC_MXS)          += mxs-mmc.o
>  obj-$(CONFIG_MMC_SDHCI)                += sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_PCI)    += sdhci-pci.o
> +sdhci-pci-y                    += sdhci-pci-core.o sdhci-pci-o2micro.o
>  obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))       += sdhci-pci-data.o
> -obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))       += sdhci-pci-o2micro.o
>  obj-$(CONFIG_MMC_SDHCI_ACPI)   += sdhci-acpi.o
>  obj-$(CONFIG_MMC_SDHCI_PXAV3)  += sdhci-pxav3.o
>  obj-$(CONFIG_MMC_SDHCI_PXAV2)  += sdhci-pxav2.o
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci-core.c
> similarity index 100%
> rename from drivers/mmc/host/sdhci-pci.c
> rename to drivers/mmc/host/sdhci-pci-core.c
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index e2ec108d..9a5e191 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -145,7 +145,6 @@ void sdhci_pci_o2_fujin2_pci_init(struct sdhci_pci_chip *chip)
>         scratch_32 |= 0x00080000;
>         pci_write_config_dword(chip->pdev, O2_SD_MISC_CTRL4, scratch_32);
>  }
> -EXPORT_SYMBOL_GPL(sdhci_pci_o2_fujin2_pci_init);
>
>  int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  {
> @@ -179,7 +178,6 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(sdhci_pci_o2_probe_slot);
>
>  int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  {
> @@ -385,11 +383,9 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(sdhci_pci_o2_probe);
>
>  int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip)
>  {
>         sdhci_pci_o2_probe(chip);
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(sdhci_pci_o2_resume);
>
> --
> Ben Hutchings
> compatible: Gracefully accepts erroneous data from any source
