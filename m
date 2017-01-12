From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: mediatek: correct the implementation of msdc_card_busy
Date: Thu, 12 Jan 2017 11:59:13 +0100
Message-ID: <CAPDyKFo-F8+-q2cG+7ViUgrvgqvc4wj-0ZLOkY7OXCbhC-455A@mail.gmail.com>
References: <1483433397-11756-1-git-send-email-yong.mao@mediatek.com> <1483433397-11756-3-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36006 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdALK7Q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jan 2017 05:59:16 -0500
Received: by mail-wm0-f54.google.com with SMTP id c85so13743150wmi.1
        for <linux-mmc@vger.kernel.org>; Thu, 12 Jan 2017 02:59:15 -0800 (PST)
In-Reply-To: <1483433397-11756-3-git-send-email-yong.mao@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yong Mao <yong.mao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 3 January 2017 at 09:49, Yong Mao <yong.mao@mediatek.com> wrote:
> From: yong mao <yong.mao@mediatek.com>
>
> msdc_card_busy only need check if the data0 is low.
> In sdio data1 irq mode, data1 may be low because of interruption.
>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mtk-sd.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 10ef2ae..80ba034 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1074,11 +1074,8 @@ static int msdc_card_busy(struct mmc_host *mmc)
>         struct msdc_host *host = mmc_priv(mmc);
>         u32 status = readl(host->base + MSDC_PS);
>
> -       /* check if any pin between dat[0:3] is low */
> -       if (((status >> 16) & 0xf) != 0xf)
> -               return 1;
> -
> -       return 0;
> +       /* only check if data0 is low */
> +       return !(status & BIT(16));
>  }
>
>  static void msdc_request_timeout(struct work_struct *work)
> --
> 1.7.9.5
>
