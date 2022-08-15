Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE7EC25B08
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Aug 2022 18:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbiHOSwD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Aug 2022 14:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243867AbiHOStf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2022 14:49:35 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3329243309
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 11:28:45 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w197so9426628oie.5
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 11:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PAbaE2BPi2JfE0JMSsYw58hC/bDcDdFIaU6lrhJq/5I=;
        b=V0SfwLj2Yb74etrx6rZia7hwxnv4XkfBI0cZtG1ukS6nLDzSjJMyA1TvyG1buUgVla
         Jejov9nTjZs+kZUP5vQin6bWDO+v86jb6AaxTKWn9Jw1m2KXFY28/noXzobNQVfR3ms+
         1ZoWxmc7QQCiJbTs1VWn7hbPJYEqvN4rMMIAbkjM/xRtsltDcLhuBpD30bljR3kgQb6/
         7LmETzDf4cPdg8jUN2h4bpZL+/MtVjP4Qs2K3sM9gL8QCklk69cQN5/izcXp88d0LkOR
         9udl1jzq251uFJMR7lB/TUdfxUs9yKIglh/0wXZzqwbvy67Fuu76Q1Y4qEuqP8jFXwaf
         e4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PAbaE2BPi2JfE0JMSsYw58hC/bDcDdFIaU6lrhJq/5I=;
        b=bJx7+52s3fiFmC/E0mQQODpAnvbhdaIXdGoRNXUy+Zfcjf6KSvt7CDpfUvGo1jjZR8
         W7pow/jYgUGbCt1G4eX1DvN8pUUUXTnoAlYAb+CuvWzngSbzA7zytITv8ARPWnP3KlwP
         Sbn+3GDK47jT6/3A2sWusCG8KjWhPNI7gumOnwL4bOOaeiukAnFPkfqwPi5R5jz7pssd
         qWhpxI5EqHaa93IYSIcd2ldV1qm5LGFoTBkcXgN7wpoFtbqrbVnb+wJ9yofmlXEbp+RK
         xvn8K2r4e4wfijxW2rPlTjcA/Ldms82jso1voT2/z8WrP8Uht9LSvxWX6r7dPSDQlbF+
         0zGg==
X-Gm-Message-State: ACgBeo1rnn3a95tE9PpyE5Ln7LWOoPuSIn20T0JHaaro0J5fZGVwYS5Y
        3KSqnz4ktX186V8vuHIE+wrSzkmJm3gPivfxHxEbCJxDw5o=
X-Google-Smtp-Source: AA6agR4APC8y0ObSdmVA8gIwBkVKlXdAxjrtt2Pcnsr06+bzyb2N1m7fW/tLBegFGxvYUCkF3SP49wRmVOtKuUNB12U=
X-Received: by 2002:aca:5e89:0:b0:344:80ab:1351 with SMTP id
 s131-20020aca5e89000000b0034480ab1351mr4590109oib.105.1660588124265; Mon, 15
 Aug 2022 11:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220728080048.21336-1-wenbin.mei@mediatek.com>
In-Reply-To: <20220728080048.21336-1-wenbin.mei@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Aug 2022 20:28:04 +0200
Message-ID: <CAPDyKFqg7gDXMKyDXa_oczfkjqEAcsyL-9YJWHE9wA2sY0BGfg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: Clear interrupts when cqe off/disable
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 28 Jul 2022 at 10:01, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> Currently we don't clear MSDC interrupts when cqe off/disable, which led
> to the data complete interrupt will be reserved for the next command.
> If the next command with data transfer after cqe off/disable, we process
> the CMD ready interrupt and trigger DMA start for data, but the data
> complete interrupt is already exists, then SW assume that the data transfer
> is complete, SW will trigger DMA stop, but the data may not be transmitted
> yet or is transmitting, so we may encounter the following error:
> mtk-msdc 11230000.mmc: CMD bus busy detected.
>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>

Applied for fixes and by adding the below tags, thanks!

Fixes: 88bd652b3c74 ("mmc: mediatek: command queue support")
Cc: stable@vger.kernel.org

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 4ff73d1883de..69d78604d1fc 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2446,6 +2446,9 @@ static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
>         /* disable busy check */
>         sdr_clr_bits(host->base + MSDC_PATCH_BIT1, MSDC_PB1_BUSY_CHECK_SEL);
>
> +       val = readl(host->base + MSDC_INT);
> +       writel(val, host->base + MSDC_INT);
> +
>         if (recovery) {
>                 sdr_set_field(host->base + MSDC_DMA_CTRL,
>                               MSDC_DMA_CTRL_STOP, 1);
> @@ -2932,11 +2935,14 @@ static int __maybe_unused msdc_suspend(struct device *dev)
>         struct mmc_host *mmc = dev_get_drvdata(dev);
>         struct msdc_host *host = mmc_priv(mmc);
>         int ret;
> +       u32 val;
>
>         if (mmc->caps2 & MMC_CAP2_CQE) {
>                 ret = cqhci_suspend(mmc);
>                 if (ret)
>                         return ret;
> +               val = readl(host->base + MSDC_INT);
> +               writel(val, host->base + MSDC_INT);
>         }
>
>         /*
> --
> 2.25.1
>
