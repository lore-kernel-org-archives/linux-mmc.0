From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mediatek: add ops->get_cd() support
Date: Tue, 11 Jul 2017 16:43:54 +0200
Message-ID: <CAPDyKFo+UeW4AMFZDN=ob8U9Oj7mZ24ANyT5LQ=ZQ6YxOtRqKQ@mail.gmail.com>
References: <1499063096-10604-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34501 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933405AbdGKOoB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jul 2017 10:44:01 -0400
Received: by mail-qk0-f181.google.com with SMTP id d78so2723715qkb.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Jul 2017 07:43:55 -0700 (PDT)
In-Reply-To: <1499063096-10604-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>

On 3 July 2017 at 08:24, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> if user plug out sd card slowly, finally card is plugged out but
> cat /proc/partitions can find that card is still exist in kernel.
> that's because alougth get card detect interrupt but CMD13 still
> can get correct response(all other pins are connected expect card
> detect pin).
> add ops->get_cd() can avoid this issue.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mtk-sd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 5c1e178..975c765 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1585,6 +1585,7 @@ static void msdc_hw_reset(struct mmc_host *mmc)
>         .request = msdc_ops_request,
>         .set_ios = msdc_ops_set_ios,
>         .get_ro = mmc_gpio_get_ro,
> +       .get_cd = mmc_gpio_get_cd,
>         .start_signal_voltage_switch = msdc_ops_switch_volt,
>         .card_busy = msdc_card_busy,
>         .execute_tuning = msdc_execute_tuning,
> --
> 1.8.1.1.dirty
>
