From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 0/3] mmc: sdhci: Set DMA mask properly
Date: Wed, 16 Mar 2016 14:09:01 +0100
Message-ID: <CAPDyKFqq_2OJ30BVdss_7Qmu5kKAEzNWHe3G3BB4FjgA8qW+Kg@mail.gmail.com>
References: <1457316477-8153-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37782 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965993AbcCPNJC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 09:09:02 -0400
Received: by mail-wm0-f41.google.com with SMTP id p65so71742809wmp.0
        for <linux-mmc@vger.kernel.org>; Wed, 16 Mar 2016 06:09:01 -0700 (PDT)
In-Reply-To: <1457316477-8153-1-git-send-email-acourbot@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>

On 7 March 2016 at 03:07, Alexandre Courbot <acourbot@nvidia.com> wrote:
> 64-bit capable devices are supposed to set their own DMA mask. Currently
> this does not happen for sdhci devices excepted for the two (sdhci-acpi
> and sdhci-pci) that define a enable_dma() hook and do it there. However
> this hook is called from several places while DMA mask is supposed to
> be set only once ; for instance the sdhci-acpi driver maintains a flag
> just to make sure the DMA mask is set only upon the first call of this
> hook.
>
> For the vast majority of drivers that do not define a enable_dma() hook, the
> default 32-bit DMA mask is used and there is a risk of using unneeded bounce
> buffers on hosts capable of 64-bit addressing.
>
> The first patch adds a default DMA mask setting function that is called when
> a DMA-capable host is added. It tries to set sane DMA masks according to the
> device's reported capabilities.
>
> The addition of this function seems to make the same code in sdhci-acpi and
> sdhci-pci redundant, so it is removed from these drivers. On top of making
> this series a negative line count, it also removes one usage of the obsolete
> pci_set_dma_mask() function.
>
> Changes since v3:
> - Unset the SDHCI_USE_64_BIT_DMA flag if setting of 64-bit mask failed
> - Carry Acked-bys
>
> Alexandre Courbot (3):
>   mmc: sdhci: Set DMA mask when adding host
>   mmc: sdhci-acpi: Remove enable_dma() hook
>   mmc: sdhci-pci: Do not set DMA mask in enable_dma()
>
>  drivers/mmc/host/sdhci-acpi.c     | 30 ------------------------
>  drivers/mmc/host/sdhci-pci-core.c | 15 ------------
>  drivers/mmc/host/sdhci.c          | 48 +++++++++++++++++++++++++++++++++------
>  3 files changed, 41 insertions(+), 52 deletions(-)
>
> --
> 2.7.2
>

Thanks, applied for next!

Kind regards
Uffe
