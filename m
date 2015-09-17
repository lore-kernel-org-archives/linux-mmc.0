From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-pltfm: Use of_property_read_u32 instead of
 open-coding it
Date: Thu, 17 Sep 2015 16:57:22 +0200
Message-ID: <CAPDyKFpRwpbS22_hySQE1s_C8jeg5QQFXz-Jp=OvfR9Kr0huLg@mail.gmail.com>
References: <1442491646-9421-1-git-send-email-tklauser@distanz.ch>
	<1442495394-19819-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36918 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbbIQO5X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Sep 2015 10:57:23 -0400
Received: by wicfx3 with SMTP id fx3so31065193wic.0
        for <linux-mmc@vger.kernel.org>; Thu, 17 Sep 2015 07:57:22 -0700 (PDT)
In-Reply-To: <1442495394-19819-1-git-send-email-tklauser@distanz.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 17 September 2015 at 15:09, Tobias Klauser <tklauser@distanz.ch> wrote:
> Use of_property_read_u32 instead of of_get_property with return value
> checks and endianness conversion.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Thanks, applied for next!

Kind regards
Uffe

> ---
> v2:
>   - Directly use plfrm_host->clock in the call to of_property_read_u32(), as
>     suggested by Ulf Hansson.
>
>  drivers/mmc/host/sdhci-pltfm.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index a207f5a..87fb5ea 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -71,9 +71,7 @@ void sdhci_get_of_property(struct platform_device *pdev)
>         struct device_node *np = pdev->dev.of_node;
>         struct sdhci_host *host = platform_get_drvdata(pdev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       const __be32 *clk;
>         u32 bus_width;
> -       int size;
>
>         if (of_get_property(np, "sdhci,auto-cmd12", NULL))
>                 host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
> @@ -101,9 +99,7 @@ void sdhci_get_of_property(struct platform_device *pdev)
>             of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
>                 host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>
> -       clk = of_get_property(np, "clock-frequency", &size);
> -       if (clk && size == sizeof(*clk) && *clk)
> -               pltfm_host->clock = be32_to_cpup(clk);
> +       of_property_read_u32(np, "clock-frequency", &pltfm_host->clock);
>
>         if (of_find_property(np, "keep-power-in-suspend", NULL))
>                 host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
> --
> 2.5.0
>
>
