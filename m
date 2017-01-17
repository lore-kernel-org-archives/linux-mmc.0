From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tmio: Remove redundant check of mmc->slot.cd_irq
Date: Tue, 17 Jan 2017 16:08:04 +0100
Message-ID: <CAPDyKFoFxY_qswM3mTJ5ahZwb6pYnYGw3Tv2F5BknKE5DCFxQw@mail.gmail.com>
References: <1484061052-25334-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:36864 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdAQPIF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2017 10:08:05 -0500
Received: by mail-it0-f46.google.com with SMTP id r185so105426990ita.0
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jan 2017 07:08:05 -0800 (PST)
In-Reply-To: <1484061052-25334-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>

On 10 January 2017 at 16:10, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> To validate whether native hotplug needs to be used, the tmio driver checks
> whether the mmc->slot.cd_irq has been successfully assigned.
>
> This check is redundant at its current place in tmio_mmc_host_probe(), as
> the mmc core assigns mmc->slot.cd_irq a valid value first when
> mmc_gpiod_request_cd_irq() is called. Therefore, let's just remove the
> check for now, as that also removes a layering violation of the tmio driver
> accessing core specific data via ->slot.cd_irq.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

I have applied this for next, to get it tested.

Wolfram, Simon, please tell if you see any issues!

Kind regards
Uffe

> ---
>  drivers/mmc/host/tmio_mmc_pio.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 3ca97f3..0ef5780 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1177,8 +1177,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>
>         _host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
>                                   mmc->caps & MMC_CAP_NEEDS_POLL ||
> -                                 !mmc_card_is_removable(mmc) ||
> -                                 mmc->slot.cd_irq >= 0);
> +                                 !mmc_card_is_removable(mmc));
>
>         /*
>          * On Gen2+, eMMC with NONREMOVABLE currently fails because native
> --
> 1.9.1
>
