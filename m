From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: Update driver to support without regulators
Date: Tue, 21 Jul 2015 13:40:20 +0200
Message-ID: <CAPDyKFq8NVqkZQ_8oL_5JM0_wYK6-gTaXr9ExHLa767tmcpxxA@mail.gmail.com>
References: <1436902186-6542-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34846 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbbGULkV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jul 2015 07:40:21 -0400
Received: by qkbm65 with SMTP id m65so76298867qkb.2
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jul 2015 04:40:20 -0700 (PDT)
In-Reply-To: <1436902186-6542-1-git-send-email-fcooper@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kishon@ti.com, rogerq@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, Murali Karicheri <m-karicheri2@ti.com>

On 14 July 2015 at 21:29, Franklin S Cooper Jr <fcooper@ti.com> wrote:
> From: Roger Quadros <rogerq@ti.com>
>
> Update driver to support without regulators.
>
> Without this patch boards that do not enable regulator config options will
> fail to boot with a kernel panic.

I guess that's because the rootfs is mounted on the card that doesn't
get detected, right?

>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt |  2 ++
>  drivers/mmc/host/omap_hsmmc.c                           | 14 ++++++++++----
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> index 76bf087..2408e87 100644
> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -22,6 +22,8 @@ ti,dual-volt: boolean, supports dual voltage cards
>  ti,non-removable: non-removable slot (like eMMC)
>  ti,needs-special-reset: Requires a special softreset sequence
>  ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
> +voltage-ranges: Specify the voltage range supported if regulator framework
> +isn't enabled.
>  dmas: List of DMA specifiers with the controller specific format
>  as described in the generic DMA client binding. A tx and rx
>  specifier is required.
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index b2b411d..16c870f 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1551,10 +1551,13 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         if (ios->power_mode != host->power_mode) {
>                 switch (ios->power_mode) {
>                 case MMC_POWER_OFF:
> -                       mmc_pdata(host)->set_power(host->dev, 0, 0);
> +                       if (host->use_reg)
> +                               mmc_pdata(host)->set_power(host->dev, 0, 0);
>                         break;
>                 case MMC_POWER_UP:
> -                       mmc_pdata(host)->set_power(host->dev, 1, ios->vdd);
> +                       if (host->use_reg)
> +                               mmc_pdata(host)->set_power(host->dev, 1,
> +                                                          ios->vdd);
>                         break;
>                 case MMC_POWER_ON:
>                         do_send_init_stream = 1;
> @@ -2082,10 +2085,13 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>                 if (ret)
>                         goto err_irq;
>                 host->use_reg = 1;
> +               mmc->ocr_avail = mmc_pdata(host)->ocr_mask;
> +       } else {
> +               ret = mmc_of_parse_voltage(pdev->dev.of_node, &mmc->ocr_avail);
> +               if (ret)
> +                       goto err_irq;
>         }
>
> -       mmc->ocr_avail = mmc_pdata(host)->ocr_mask;
> -
>         omap_hsmmc_disable_irq(host);
>
>         /*
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

No, I don't like this patch. If your board have regulators which can
be used to find out the voltage levels, we shall use them. We shall
not use DT to workaround this.

So, perhaps the Kconfig section for omap_hsmmc should select
CONFIG_REGULATOR (and friends)?

Kind regards
Uffe
