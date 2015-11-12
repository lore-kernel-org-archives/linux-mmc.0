From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 1/3] mmc: sdhci-pltfm: Add DT properties to set various QUIRKS
Date: Thu, 12 Nov 2015 10:35:35 +0100
Message-ID: <CAPDyKFoFgohMb2dqGQQM_pRFH96EP58ff=N69=oRYEzoj71r0g@mail.gmail.com>
References: <1446836164-16259-1-git-send-email-alcooperx@gmail.com>
	<1446836164-16259-2-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:34425 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953AbbKLJfg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Nov 2015 04:35:36 -0500
Received: by ykfs79 with SMTP id s79so88814210ykf.1
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2015 01:35:35 -0800 (PST)
In-Reply-To: <1446836164-16259-2-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Al Cooper <alcooperx@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com

On 6 November 2015 at 19:56, Al Cooper <alcooperx@gmail.com> wrote:
> Add support for "broken-ddr50", "broken-64-bit-dma"
> and "broken-timeout-value" device tree properties.
> The properties will cause the corresponding quirks bits to be set.
> This allows some of the platform specific QUIRKS setting to be
> moved out of the driver and into the Device Tree node.
>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  drivers/mmc/host/sdhci-pltfm.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index 87fb5ea..cc0730c 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -90,10 +90,14 @@ void sdhci_get_of_property(struct platform_device *pdev)
>         if (of_get_property(np, "no-1-8-v", NULL))
>                 host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>
> +       if (of_get_property(np, "broken-64-bit-dma", NULL))
> +               host->quirks2 |= SDHCI_QUIRK2_BROKEN_64_BIT_DMA;
> +

To me this is yet another step in the wrong direction of sdhci.

Not only have we added a quirk which we likely could avoided, but now
you also suggest to add a DT binding for it.

Please try to avoid this, we shouldn't need to add one DT binding per
quirk, right?

>         if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
>                 host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
>
> -       if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
> +       if (of_get_property(np, "broken-timeout-value", NULL) ||
> +           of_device_is_compatible(np, "fsl,p2020-esdhc") ||
>             of_device_is_compatible(np, "fsl,p1010-esdhc") ||
>             of_device_is_compatible(np, "fsl,t4240-esdhc") ||
>             of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
> @@ -106,6 +110,8 @@ void sdhci_get_of_property(struct platform_device *pdev)
>
>         if (of_find_property(np, "enable-sdio-wakeup", NULL))
>                 host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
> +       if (of_find_property(np, "broken-ddr50", NULL))
> +               host->quirks2 |= SDHCI_QUIRK2_BROKEN_DDR50;

Same comment as above.

Let me also refer to the response from Scott Branden to the earlier
version of this patchset.
http://permalink.gmane.org/gmane.linux.kernel.mmc/34614

Perhaps we should invent a sdhci library function, which each sdhci
variant can use to set capabilities through. Typically useful for
those variants that have a non-reliable capabilities register.

>  }
>  #else
>  void sdhci_get_of_property(struct platform_device *pdev) {}
> --
> 1.9.0.138.g2de3478
>

Kind regards
Uffe
