Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB1AC05027
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Feb 2023 10:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBQK4r (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Feb 2023 05:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBQK4q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2023 05:56:46 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781A662419
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 02:56:44 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id fh15-20020a17090b034f00b0023127b2d602so955014pjb.2
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 02:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qL9D7opV5FlButcIFs+D5dml5+uZHYprzNmObUFhYpg=;
        b=b35uDJ4BTWHKcjV+ndJTUdlujdWns6GhZ3wBcGdu5le4OecC9oeuwz9hbGxLBoDVLx
         ZkVRsE41IjbfotgQbUTP878Nut6Xdlp82CeycYuLWJ5lZQ2SGeN8GfKGaFyZH/8SDvFN
         qboVdQk7ZK6ep5Y1qEBQLrsg27DktgXvG6yHTzSiCAYw6rAn0AG+P9NAonIKCR679dok
         08vk6RIUazmiCuBsnu0cduJfkk6P496XFceRhP/7T97UzRsnKYuEJJ47X8FoIuLFfSIX
         kaWyeUp7WHBSnZCj5FXqyXfOhfcpLcczDNQxKmR37pe7rs0wyA/FBLHEvf8NLFR3nGb/
         fwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qL9D7opV5FlButcIFs+D5dml5+uZHYprzNmObUFhYpg=;
        b=dpcUXWU67T8A3ymOmjFx+GW5M8YWG/Q1YbeU3jyRD78fmLxTrGHboCln3VHIK+Lw7U
         GFf2tVLI9Vao5GiEX81CalaCsEJIjV5eCSlxSMeXksbE+VwAyIq/2z80t7Y//NSn/rCR
         OiDO2dFt2pelKNAO7QxqgptiRSYYxbsyLF9uuckgNFpVJaFAe8DHPLclRnu5im+3UHG1
         8B1RQq+dVlYZpCpZ1PvkdtRmwv54Q0TOnHfXLcX/E+trB4cY86po6czQxlzIvJs12FyS
         gIO/JNq/WkrYfR+KR3nc8+ib3YLtYlPP6huerzaZJx4BHNHRhdW0jgL9YRuUqmLHZGvm
         OX+Q==
X-Gm-Message-State: AO0yUKXcqt7cinIQbenQy7l73kgoBgZNu+oBLsYoY0CBUlYID9FwXZKv
        jHuuwHPlG6NXvQMlQ4MH782FQZs9lwM/LoE8CFxS9g==
X-Google-Smtp-Source: AK7set8/3hGFfpeRYlD+tUybEgVpGpn3np/IuVQOzJ75dMcdpHnGJ5LGPNNdRBMEmUbFQ78VqcfTkdHmsaur08h7j/k=
X-Received: by 2002:a17:903:2643:b0:19b:5233:51d8 with SMTP id
 je3-20020a170903264300b0019b523351d8mr182684plb.13.1676631403920; Fri, 17 Feb
 2023 02:56:43 -0800 (PST)
MIME-Version: 1.0
References: <b316c6ba-a373-f1d2-27d2-9add5e25a9d2@gmail.com>
In-Reply-To: <b316c6ba-a373-f1d2-27d2-9add5e25a9d2@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Feb 2023 11:56:07 +0100
Message-ID: <CAPDyKFrUezBm=ALtdyM-6jy8zdpMW5HN_xi=21+-Hv4aUjB9fQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: use devm_clk_get_enabled() for core clock
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Feb 2023 at 21:01, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> Use devm_clk_get_enabled() to simplify the code.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 079c52dbe..6ed95c555 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -155,7 +155,6 @@ struct meson_host {
>         struct  mmc_command     *cmd;
>
>         void __iomem *regs;
> -       struct clk *core_clk;
>         struct clk *mux_clk;
>         struct clk *mmc_clk;
>         unsigned long req_rate;
> @@ -1166,6 +1165,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>         struct resource *res;
>         struct meson_host *host;
>         struct mmc_host *mmc;
> +       struct clk *core_clk;
>         int cd_irq, ret;
>
>         mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(struct meson_host));
> @@ -1228,17 +1228,13 @@ static int meson_mmc_probe(struct platform_device *pdev)
>                 host->pins_clk_gate = NULL;
>         }
>
> -       host->core_clk = devm_clk_get(&pdev->dev, "core");
> -       if (IS_ERR(host->core_clk))
> -               return PTR_ERR(host->core_clk);
> -
> -       ret = clk_prepare_enable(host->core_clk);
> -       if (ret)
> -               return ret;
> +       core_clk = devm_clk_get_enabled(&pdev->dev, "core");
> +       if (IS_ERR(core_clk))
> +               return PTR_ERR(core_clk);
>
>         ret = meson_mmc_clk_init(host);
>         if (ret)
> -               goto err_core_clk;
> +               return ret;
>
>         /* set config to sane default */
>         meson_mmc_cfg_init(host);
> @@ -1322,8 +1318,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
>         free_irq(host->irq, host);
>  err_init_clk:
>         clk_disable_unprepare(host->mmc_clk);
> -err_core_clk:
> -       clk_disable_unprepare(host->core_clk);
>         return ret;
>  }
>
> @@ -1338,7 +1332,6 @@ static int meson_mmc_remove(struct platform_device *pdev)
>         free_irq(host->irq, host);
>
>         clk_disable_unprepare(host->mmc_clk);
> -       clk_disable_unprepare(host->core_clk);
>
>         return 0;
>  }
> --
> 2.39.1
>
