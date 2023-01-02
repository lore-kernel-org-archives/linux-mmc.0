Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A785C4708E
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Jan 2023 12:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjABMt5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Jan 2023 07:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjABMtp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jan 2023 07:49:45 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55E3E4E
        for <linux-mmc@vger.kernel.org>; Mon,  2 Jan 2023 04:49:44 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id g20so10369411pfb.3
        for <linux-mmc@vger.kernel.org>; Mon, 02 Jan 2023 04:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TMEbty0JviNpn+Yg5A0C6kfJvNq8b2Lmd3piEj6ZucM=;
        b=xNxnlhnsuQeYEWCioPL1Rr8t7KdGqG8JqqAo1ZY4yCPqKI1ekX1RVvn6hfY6VcXbiQ
         bhLkJpVx4XcTjJcJd3vHyyi1bBw02wB8HWKsF1+Kfe8CWyQXlb45h2DrifhTSLj1n6fO
         0TCR8WkxW9vO4Uqxw/deI2DBs6S4lAgTSbURM/T1FoIr/N1C8/cra+0sXxD2P1wY6nI2
         6ZwBR6i3mC/5uT1JKqyCyGCWn99hhfFaXpMF1PvYDPaVu36RVyAw+LFmAW4AoRfzS8I7
         gBflxdrFhwI0/xQ4z1/s4+NvgfWQamHqiYlKidycHuMaMN4Fq01IcacExFziiS0cb/Lj
         OnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMEbty0JviNpn+Yg5A0C6kfJvNq8b2Lmd3piEj6ZucM=;
        b=2+unz3rNwm5qBXllKZ/tRcce+bkX/py9sPKy0RTRDHodI/rLWf9HznKDbDDhJsu+Sr
         WWLGS2hz+szWXElMBHq5Yr9j90YfV9/MyTB+M6R3nJCcujyNweWIPg7BLbljJmk+rsEG
         4ENbc30vhCs1Fl5mPZDawsPzaapurNN+4HKV7s0E7KP9nuPvl12CCXy8X1aS7cCJVKTd
         NySxMsOvUDk1XQJcEvsqKLONI4K7Wu6jrsvKWYuhdjmVfAlr82BntAsKzGKsSN4oT5Xz
         Weh5pzootDMWp4IvIWPxxAiRFTQoF9CnZQ87Ghr+onYHtRg4LEE3Ga1Tr2tG7CbBpu6L
         G+KQ==
X-Gm-Message-State: AFqh2kp0h4pi/3aYgFPN14svMYNk1VP9F3V0oIgWH0jq5p3WAPU5dL+e
        vFT3I5Q2P8G2GEJgZYGjefJQRSUabMNobihSsxyylA==
X-Google-Smtp-Source: AMrXdXvzgF7HAsl+aefGp8qa6WXa410ObFc+WdoziWwxlwHOMP/uW5ZYac6nTWvIBRT8mIXKtl58wGKLROQKlWPQDzE=
X-Received: by 2002:a63:5841:0:b0:477:b650:494b with SMTP id
 i1-20020a635841000000b00477b650494bmr2384311pgm.434.1672663784228; Mon, 02
 Jan 2023 04:49:44 -0800 (PST)
MIME-Version: 1.0
References: <7c686fecb11b4ec1f55cd7075dc7cfcdd9b445ba.1670697358.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <7c686fecb11b4ec1f55cd7075dc7cfcdd9b445ba.1670697358.git.christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jan 2023 13:49:08 +0100
Message-ID: <CAPDyKFo7W3EVCFjACB+zaMi8O-wTmCX2winydAB_XtxfnA0Qiw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: sunlpus: Fix an error handling path in spmmc_drv_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 10 Dec 2022 at 19:36, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If an error occurs after successful clk_prepare_enable() call in the probe,
> the clk is not clk_disable_unprepare()'ed.
>
> Use devm_clk_get_enabled() instead of devm_clk_get() to fix, and simplify
> the probe and the remove function accordingly.
>
> Fixes: 4e268fed8b18 ("mmc: Add mmc driver for Sunplus SP7021")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This changes the order of resource releasing when the driver is removed,
> but it looks ok to me.
> ---
>  drivers/mmc/host/sunplus-mmc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
> index db5e0dcdfa7f..3e8856a82188 100644
> --- a/drivers/mmc/host/sunplus-mmc.c
> +++ b/drivers/mmc/host/sunplus-mmc.c
> @@ -878,7 +878,7 @@ static int spmmc_drv_probe(struct platform_device *pdev)
>         if (IS_ERR(host->base))
>                 return PTR_ERR(host->base);
>
> -       host->clk = devm_clk_get(&pdev->dev, NULL);
> +       host->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>         if (IS_ERR(host->clk))
>                 return dev_err_probe(&pdev->dev, PTR_ERR(host->clk), "clk get fail\n");
>
> @@ -896,10 +896,6 @@ static int spmmc_drv_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> -       ret = clk_prepare_enable(host->clk);
> -       if (ret)
> -               return dev_err_probe(&pdev->dev, ret, "failed to enable clk\n");
> -
>         ret = mmc_of_parse(mmc);
>         if (ret)
>                 goto probe_free_host;
> @@ -944,7 +940,6 @@ static int spmmc_drv_remove(struct platform_device *dev)
>
>         mmc_remove_host(host->mmc);
>         pm_runtime_get_sync(&dev->dev);
> -       clk_disable_unprepare(host->clk);

I don't think this improves code quality, but rather the opposite.

Removing the call to clk_disable_unprepare() here, makes the untrained
eye, to believe that the calls to pm_runtime_get_sync() and
pm_runtime_put_noidle() are redundant, while they aren't.

Instead, I suggest we add a call to clk_disable_unprepare() in the
error path in ->probe(), rather than using devm_clk_get_enabled().

>         pm_runtime_put_noidle(&dev->dev);
>         pm_runtime_disable(&dev->dev);
>         platform_set_drvdata(dev, NULL);

Kind regards
Uffe
