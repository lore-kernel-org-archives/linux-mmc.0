Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1139AC432C3
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 18:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3AAD22BF3
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 18:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389299AbhAKSHp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jan 2021 13:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390078AbhAKSH3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jan 2021 13:07:29 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8AEC0617A9
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jan 2021 10:06:21 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id j140so6079vsd.4
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jan 2021 10:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hg1atIMlfVq1CP0ks7g47kbF5lVAshm+wDf+UA9H608=;
        b=ZnxO3hgYHJMFo1HJ+QXvvTvE9r0omRXacK/rY3GV4B9tu290Yt76oktPalxYMs9L7l
         yemXzNuqvelGbKVk6uyOeKYaYbki7C4cMrdzZVXZFVe+wZ5cgBlIhKP4tBPM5FcEjPD6
         5zEWM+CPY80IUO0oQYDWFksPCbOUEHJbw+CXw170EO+AazxbEuagx0RKkYu+LaeS32wd
         5YF4QPm4pDkWqAzPsYb/hDBC4q1haWES8x7PdJqAUSfr1rEloM5LKAg09bhvEj6DYbsY
         kjw0fT4M3HfmU63quHpRKpV5VDEEw49AAYVNXvzlgRrTu7UAoIw6MAyeYnlUGoLrNmKl
         N+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hg1atIMlfVq1CP0ks7g47kbF5lVAshm+wDf+UA9H608=;
        b=ndoLtwRNP/f1y6DIWFYLhCadzKKHcIr8y1tmAVG5Av6T5Dfx+NzXFID0L6FPHIgQQr
         GaoQ6xUb88KR4rIZCzs0VNEGjA1QAIADdYgL1p8yEq5OS06KjiT9Eafnu6XyFPJFx3bi
         00ZER38RK7NOP4ZsWu7F91lpOYKthHA7M6zTEaOz/TPo0vc3QRSc9olLU9zKvvjswWB9
         IwZfTpkWf+Lfz2rnfAIX5Lqg+P5gyuHHz4t9RXzQdAGzqfV8DbZifcoeb5spO1U01qrg
         5hXiY2zj/liv62QmtYKbcMhovWtNhMTFl331aEMBaLrz7+7v8YHVgdq20O9l3dur2mbB
         QFng==
X-Gm-Message-State: AOAM533vH4DSNG13tYZ+Xd5zySKPVSkkoFWtMVvHcQrKWMlUNd5KkBoA
        AFFgn1WoQfzgNuIb04ZnS5THeCyCFpLqWm18O15BsQ==
X-Google-Smtp-Source: ABdhPJytzIhVay23HpNWh/83mbi09JAvKFNGkwcFjs0CFwDbUYxfHWcfLIRVQyGOz6/yc0oV7LXjcbdS+YWrgv5pp3I=
X-Received: by 2002:a05:6102:2127:: with SMTP id f7mr861047vsg.48.1610388380405;
 Mon, 11 Jan 2021 10:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20201217210922.165340-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20201217210922.165340-1-christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Jan 2021 19:05:41 +0100
Message-ID: <CAPDyKFo_dxAkUVZ0kj60OQeKoV8OeqWWQejh_NL0OcNjDLfA9Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: usdhi6rol0: Fix a resource leak in the error
 handling path of the probe
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Chris Ball <chris@printf.net>, linux-arm-kernel@axis.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 17 Dec 2020 at 22:09, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> A call to 'ausdhi6_dma_release()' to undo a previous call to
> 'usdhi6_dma_request()' is missing in the error handling path of the probe
> function.
>
> It is already present in the remove function.
>
> Fixes: 75fa9ea6e3c0 ("mmc: add a driver for the Renesas usdhi6rol0 SD/SDIO host controller")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/usdhi6rol0.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index e2d5112d809d..615f3d008af1 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -1858,10 +1858,12 @@ static int usdhi6_probe(struct platform_device *pdev)
>
>         ret = mmc_add_host(mmc);
>         if (ret < 0)
> -               goto e_clk_off;
> +               goto e_release_dma;
>
>         return 0;
>
> +e_release_dma:
> +       usdhi6_dma_release(host);
>  e_clk_off:
>         clk_disable_unprepare(host->clk);
>  e_free_mmc:
> --
> 2.27.0
>
