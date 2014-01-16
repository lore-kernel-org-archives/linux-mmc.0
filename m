From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/7] mmc: omap: clarify DDR timing mode between SD-UHS and eMMC
Date: Thu, 16 Jan 2014 11:49:38 +0100
Message-ID: <CAPDyKFp3vKwZa5Y2cXdQ035M3Tm+LT8yD7_B2xvb6ZxOKNSz7g@mail.gmail.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
	<002101cf11fb$bf5c6280$3e152780$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:42770 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbaAPKtk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2014 05:49:40 -0500
Received: by mail-qc0-f171.google.com with SMTP id n7so2149212qcx.30
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2014 02:49:38 -0800 (PST)
In-Reply-To: <002101cf11fb$bf5c6280$3e152780$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Chris Ball <chris@printf.net>, Balaji T K <balajitk@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 15 January 2014 15:11, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Replaced UHS_DDR50 with MMC_DDR52.
>
> CC: Balaji T K <balajitk@ti.com>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index dbd32ad..cca397e 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -540,7 +540,7 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
>          *      - MMC/SD clock coming out of controller > 25MHz
>          */
>         if ((mmc_slot(host).features & HSMMC_HAS_HSPE_SUPPORT) &&
> -           (ios->timing != MMC_TIMING_UHS_DDR50) &&
> +           (ios->timing != MMC_TIMING_MMC_DDR52) &&

Even if I can't find anywhere that OMAP has enabled the corresponding
host caps for UHS SD cards, it still might be the case that OMAP
actually is able to handle the 1.8V I/O voltage switches and thus you
should like keep that.

You find the omap specific hack in omap_hsmmc_switch_opcond(). Ideally
the driver should be updated to implement the
host_ops->start_signal_voltage_switch and host_ops->card_busy instead.

Maybe some the OMAP guys can tell use more to be sure.

Kind regards
Ulf Hansson


>             ((OMAP_HSMMC_READ(host->base, CAPA) & HSS) == HSS)) {
>                 regval = OMAP_HSMMC_READ(host->base, HCTL);
>                 if (clkdiv && (clk_get_rate(host->fclk)/clkdiv) > 25000000)
> @@ -560,7 +560,7 @@ static void omap_hsmmc_set_bus_width(struct omap_hsmmc_host *host)
>         u32 con;
>
>         con = OMAP_HSMMC_READ(host->base, CON);
> -       if (ios->timing == MMC_TIMING_UHS_DDR50)
> +       if (ios->timing == MMC_TIMING_MMC_DDR52)
>                 con |= DDR;     /* configure in DDR mode */
>         else
>                 con &= ~DDR;
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
