From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: tmio: fix wrong bitmask for SDIO irqs
Date: Fri, 18 Nov 2016 15:29:34 +0100
Message-ID: <CAPDyKFr7wxsG6bF0aS6DQnVRP+8m4qXiU+kz6+wQ9yMEHiumMA@mail.gmail.com>
References: <20161113142912.4041-1-wsa+renesas@sang-engineering.com> <20161113142912.4041-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36221 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932291AbcKRO3g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2016 09:29:36 -0500
Received: by mail-wm0-f48.google.com with SMTP id g23so41823375wme.1
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2016 06:29:36 -0800 (PST)
In-Reply-To: <20161113142912.4041-2-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>

On 13 November 2016 at 15:29, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Commit 7729c7a232a953 ("mmc: tmio: Provide separate interrupt handlers")
> refactored the sdio irq handler and wrongly used the mask for SD irqs,
> not for SDIO irqs. This doesn't really matter in practice because both
> values keep the only interrupt we are interested in. But still, this is
> wrong and wants to be fixed.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/tmio_mmc_pio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index dbc3cb14f3321b..2b04e6e87192c7 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -741,7 +741,7 @@ static void tmio_mmc_sdio_irq(int irq, void *devid)
>                 return;
>
>         status = sd_ctrl_read16(host, CTL_SDIO_STATUS);
> -       ireg = status & TMIO_SDIO_MASK_ALL & ~host->sdcard_irq_mask;
> +       ireg = status & TMIO_SDIO_MASK_ALL & ~host->sdio_irq_mask;
>
>         sdio_status = status & ~TMIO_SDIO_MASK_ALL;
>         if (pdata->flags & TMIO_MMC_SDIO_STATUS_QUIRK)
> --
> 2.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
