Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED6EC636D4
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Feb 2023 10:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBQK4v (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Feb 2023 05:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBQK4u (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2023 05:56:50 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904D26241C
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 02:56:49 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id i10so423680pgm.4
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 02:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676631409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3UCADC546vqcgvQAcCkRRuDpElH6K8OW6js21vuLDJM=;
        b=MHCR8VgijeXixy7MepbTesxZLaTehlks0wgRSy3RyhnYEQ5DnzmcjILk4hooJm1ym6
         oibq6KlWHJVF4zszDK/3lH5H3kfmLwaNJLlNUfiqGguZYUrJC4J0ks7jxc6m9XyntXId
         b1RlhNzhRan1VIqYdW1iSFrRxVVwacVkOTEE62U2feK+ysKxSMONYSk6fEr+fxjZxj3T
         vG/4clZ+93ZX1xOniIKLKgsJFpcy3IDQIjy3JJx64pyR8saC8p2xz4BgFMN/GEsj39ZD
         UXIWvzAK6OlKoT4eed6dRtxTDKYAdk154NvSNpTAUK9PZJPaaLp3m8jnR80uWtdHoGU6
         5c6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676631409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UCADC546vqcgvQAcCkRRuDpElH6K8OW6js21vuLDJM=;
        b=W2+o7xNwu/lYbJ91pDrebT4zewmZgis+YwuJYUVZJHXKXP+MaR9r22td7PlbYExeI3
         +VQES4kuAoWOXheUEDIg1KJLLFj1I8zsdjZXx3IkVcyvuAyvGUE5+ZedxeL7vv9IYZwz
         r6tpCXPPeD1JzNdDTdlK6Gd6UjE5yHnkOhHAP9ebWbJEJo2B2tOCgd7Xk43mVUz/KQAv
         Kt0QlQgNchNRnXFsHYjCEBvQ/OOlWY9aBHV4nKxHS+jMo74O/XYdkg1Vnsym5e/KsFD5
         5dsWh35ao+U6WjgFPoopvXww4yNpkKfvcDLwtUlyB5M+zP03k8N8eQy5E2XshvhOdpKC
         fSmg==
X-Gm-Message-State: AO0yUKW1cHZuiFahgE3u9Zl/4wnquI313r6VUDG50GedSN9fohxhGUei
        UtKgyU13b0HVMbBw+BO41cR7NhmnSSg+77Midr4Z1g==
X-Google-Smtp-Source: AK7set8moOcMQkUUQC0J96rO72ysPNFh+d4PrDeRIUS9UDFf+wqRTay6xYcJkPFbC8RKM8j4kLJfCxJIq7aZb+jm56Y=
X-Received: by 2002:aa7:95a9:0:b0:5a8:ba5b:575 with SMTP id
 a9-20020aa795a9000000b005a8ba5b0575mr1435488pfk.40.1676631409050; Fri, 17 Feb
 2023 02:56:49 -0800 (PST)
MIME-Version: 1.0
References: <70e5520f-e327-111d-9ea4-824460e41561@gmail.com>
In-Reply-To: <70e5520f-e327-111d-9ea4-824460e41561@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Feb 2023 11:56:12 +0100
Message-ID: <CAPDyKFp=FWZ99Zq6us6Opym+9qkv6LO7HXOU0aMA3D7eFSq=Pg@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: constify member data of struct meson_host
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Feb 2023 at 21:01, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> Constify member data of struct meson_host. This also allows to remove
> the cast as of_device_get_match_data() returns a const void *.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 6ed95c555..641ea4292 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -150,7 +150,7 @@ struct sd_emmc_desc {
>
>  struct meson_host {
>         struct  device          *dev;
> -       struct  meson_mmc_data *data;
> +       const struct meson_mmc_data *data;
>         struct  mmc_host        *mmc;
>         struct  mmc_command     *cmd;
>
> @@ -1195,8 +1195,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>         if (mmc->caps & MMC_CAP_SDIO_IRQ)
>                 mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
>
> -       host->data = (struct meson_mmc_data *)
> -               of_device_get_match_data(&pdev->dev);
> +       host->data = of_device_get_match_data(&pdev->dev);
>         if (!host->data)
>                 return -EINVAL;
>
> --
> 2.39.1
>
