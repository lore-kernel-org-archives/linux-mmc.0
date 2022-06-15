Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8835ECCA473
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jun 2022 17:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354371AbiFOReF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357860AbiFORdk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2022 13:33:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D544F1E3
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jun 2022 10:33:28 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a29so20031547lfk.2
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jun 2022 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S72eeZ+Row01YghjpUmWYlpXnQzipZvAzNu3EG7dF00=;
        b=BR3qLXEgSSszCU9YWAmUJhaphZlQ5NrNHteiKYjbK+3eDpYdpbKiVLT1w/vldEp4pX
         +HF40JInhIku0OCm/pOdQei11tBJSd/sRQUSYNpM6UN/1BGD3idJgDsdLM4C0SRFCv6E
         HoNKUp07pwCmLjoXQeiU114Pm9YDXswIn+4NLoS5hgo/iZEL57b2eJBPA3PM/6xysOVY
         mMge2aJD8FyIUZWDSDDQish4QwCdUPY6yELRZnKF3XriuSWdtZviiqnIRlJQrWUdKyOF
         jaIQfrEi6tdUacNli3heJhT73rzaeOu0mQ2qGtRexeFU8mNVMfB8LBgSLG7kNKAA31DF
         RkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S72eeZ+Row01YghjpUmWYlpXnQzipZvAzNu3EG7dF00=;
        b=zXvMb1Me+57uJhMqUNltQhPmfKIo738b0RXCOFLDhqMVO36SSqnHHVGJYiFh17IE+d
         mGIVN9isiXRHVHDjoiFUP2zugGvyMY/wYPePPzgtbz2jFuQbYPrQO1K720AwxKejUAyC
         PUl002um04zyJKjUU6tchSfdg5bTzWxCk5FyX9z4IKGRKZNh6aH0VmR9g7vT4GYnUWOi
         lC4PdcXI7vHPG7YS+wty0Ctp4yuK66684UVt7JlkhilfvfdwBEGm4vsGaZlUGl2VQ8g5
         XEFJxj831bCsL0tgVvPl+kUuvHcEoJvbRhTEEMG2qHnSvlYKDowQf0hof3GlNj2O5goh
         2BBg==
X-Gm-Message-State: AJIora8NB+P4s8NQUG1MNQ4ZRy38kOeT/uhAbnEIA1vBlK1ciWIpkvuf
        p5Ec2jnjhLVOME8L5cJgyyF385aCKAisTafrM7VKZw==
X-Google-Smtp-Source: AGRyM1sA46kWiGsTwyik4A+h6I0Rt4vExcza34+hBCc/jIKpPP4aUs4AgBut2tMlPe1cEUer3DeVSKylq48GsEqiYSw=
X-Received: by 2002:a05:6512:1047:b0:479:2308:ac0b with SMTP id
 c7-20020a056512104700b004792308ac0bmr349197lfb.167.1655314408139; Wed, 15 Jun
 2022 10:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220609112239.18911-1-mengqi.zhang@mediatek.com>
In-Reply-To: <20220609112239.18911-1-mengqi.zhang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Jun 2022 10:32:52 -0700
Message-ID: <CAPDyKFrBWBKJvLZaZOgK9K3Td0ZNq_0vP=K5ERjja3OnQFCsNA@mail.gmail.com>
Subject: Re: [RESEND V2] mmc: mediatek: wait dma stop bit reset to 0
To:     Mengqi Zhang <mengqi.zhang@mediatek.com>
Cc:     chaotian.jing@mediatek.com, matthias.bgg@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenbin.mei@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 9 Jun 2022 at 04:22, Mengqi Zhang <mengqi.zhang@mediatek.com> wrote:
>
> MediaTek IP requires that after dma stop, it need to wait this dma stop
> bit auto-reset to 0. When bus is in high loading state, it will take a
> while for the dma stop complete. If there is no waiting operation here,
> when program runs to clear fifo and reset, bus will hang.
>
> In addition, there should be no return in msdc_data_xfer_next() if
> there is data need be transferred, because no matter what error occurs
> here, it should continue to excute to the following mmc_request_done.
> Otherwise the core layer may wait complete forever.
>
> Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 195dc897188b..9da4489dc345 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1356,7 +1356,7 @@ static void msdc_data_xfer_next(struct msdc_host *host, struct mmc_request *mrq)
>                 msdc_request_done(host, mrq);
>  }
>
> -static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
> +static void msdc_data_xfer_done(struct msdc_host *host, u32 events,
>                                 struct mmc_request *mrq, struct mmc_data *data)
>  {
>         struct mmc_command *stop;
> @@ -1376,7 +1376,7 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
>         spin_unlock_irqrestore(&host->lock, flags);
>
>         if (done)
> -               return true;
> +               return;
>         stop = data->stop;
>
>         if (check_data || (stop && stop->error)) {
> @@ -1385,12 +1385,15 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
>                 sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_STOP,
>                                 1);
>
> +               ret = readl_poll_timeout_atomic(host->base + MSDC_DMA_CTRL, val,
> +                                               !(val & MSDC_DMA_CTRL_STOP), 1, 20000);
> +               if (ret)
> +                       dev_dbg(host->dev, "DMA stop timed out\n");
> +
>                 ret = readl_poll_timeout_atomic(host->base + MSDC_DMA_CFG, val,
>                                                 !(val & MSDC_DMA_CFG_STS), 1, 20000);
> -               if (ret) {
> -                       dev_dbg(host->dev, "DMA stop timed out\n");
> -                       return false;
> -               }
> +               if (ret)
> +                       dev_dbg(host->dev, "DMA inactive timed out\n");
>
>                 sdr_clr_bits(host->base + MSDC_INTEN, data_ints_mask);
>                 dev_dbg(host->dev, "DMA stop\n");
> @@ -1415,9 +1418,7 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
>                 }
>
>                 msdc_data_xfer_next(host, mrq);
> -               done = true;
>         }
> -       return done;
>  }
>
>  static void msdc_set_buswidth(struct msdc_host *host, u32 width)
> @@ -2416,6 +2417,9 @@ static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
>         if (recovery) {
>                 sdr_set_field(host->base + MSDC_DMA_CTRL,
>                               MSDC_DMA_CTRL_STOP, 1);
> +               if (WARN_ON(readl_poll_timeout(host->base + MSDC_DMA_CTRL, val,
> +                       !(val & MSDC_DMA_CTRL_STOP), 1, 3000)))
> +                       return;
>                 if (WARN_ON(readl_poll_timeout(host->base + MSDC_DMA_CFG, val,
>                         !(val & MSDC_DMA_CFG_STS), 1, 3000)))
>                         return;
> --
> 2.25.1
>
