From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pltfm: remove the unneeded check of disabled device
Date: Thu, 5 Mar 2015 16:03:48 +0100
Message-ID: <CAPDyKFrwP+whb0c50u1fHhZCuMqjMcb62+ygRQ=r+vXs-0P3fw@mail.gmail.com>
References: <1423031633-26915-1-git-send-email-haokexin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:40476 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbbCEPDt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 10:03:49 -0500
Received: by qcvs11 with SMTP id s11so9317363qcv.7
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2015 07:03:48 -0800 (PST)
In-Reply-To: <1423031633-26915-1-git-send-email-haokexin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hao <haokexin@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>

On 4 February 2015 at 07:33, Kevin Hao <haokexin@gmail.com> wrote:
> Since commit cd1e65044d44 ("of/device: Don't register disabled
> devices"), the disabled device will not be registered at all. So
> we don't need to do the check again in the platform device driver.
>
> And the check in the current code is useless even if we really
> run into a disabled device. In this case, it just doesn't parse
> the dtb for the infos such as quirks or clock, but it will continue
> to try to init the disabled device after that check. So just remove it.
>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Applied, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pltfm.c | 54 ++++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index c5b01d6bb85d..b609c03a9ef8 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -75,43 +75,41 @@ void sdhci_get_of_property(struct platform_device *pdev)
>         u32 bus_width;
>         int size;
>
> -       if (of_device_is_available(np)) {
> -               if (of_get_property(np, "sdhci,auto-cmd12", NULL))
> -                       host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
> +       if (of_get_property(np, "sdhci,auto-cmd12", NULL))
> +               host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
>
> -               if (of_get_property(np, "sdhci,1-bit-only", NULL) ||
> -                   (of_property_read_u32(np, "bus-width", &bus_width) == 0 &&
> -                   bus_width == 1))
> -                       host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
> +       if (of_get_property(np, "sdhci,1-bit-only", NULL) ||
> +           (of_property_read_u32(np, "bus-width", &bus_width) == 0 &&
> +           bus_width == 1))
> +               host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
>
> -               if (sdhci_of_wp_inverted(np))
> -                       host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
> +       if (sdhci_of_wp_inverted(np))
> +               host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
>
> -               if (of_get_property(np, "broken-cd", NULL))
> -                       host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +       if (of_get_property(np, "broken-cd", NULL))
> +               host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>
> -               if (of_get_property(np, "no-1-8-v", NULL))
> -                       host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> +       if (of_get_property(np, "no-1-8-v", NULL))
> +               host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>
> -               if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
> -                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> +       if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
> +               host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
>
> -               if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
> -                   of_device_is_compatible(np, "fsl,p1010-esdhc") ||
> -                   of_device_is_compatible(np, "fsl,t4240-esdhc") ||
> -                   of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
> -                       host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> +       if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
> +           of_device_is_compatible(np, "fsl,p1010-esdhc") ||
> +           of_device_is_compatible(np, "fsl,t4240-esdhc") ||
> +           of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
> +               host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>
> -               clk = of_get_property(np, "clock-frequency", &size);
> -               if (clk && size == sizeof(*clk) && *clk)
> -                       pltfm_host->clock = be32_to_cpup(clk);
> +       clk = of_get_property(np, "clock-frequency", &size);
> +       if (clk && size == sizeof(*clk) && *clk)
> +               pltfm_host->clock = be32_to_cpup(clk);
>
> -               if (of_find_property(np, "keep-power-in-suspend", NULL))
> -                       host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
> +       if (of_find_property(np, "keep-power-in-suspend", NULL))
> +               host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
>
> -               if (of_find_property(np, "enable-sdio-wakeup", NULL))
> -                       host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
> -       }
> +       if (of_find_property(np, "enable-sdio-wakeup", NULL))
> +               host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
>  }
>  #else
>  void sdhci_get_of_property(struct platform_device *pdev) {}
> --
> 1.9.3
>
