Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFD2C433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9211D64E60
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbhCCBp1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Mar 2021 20:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239800AbhCBKkN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Mar 2021 05:40:13 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB0BC06121D
        for <linux-mmc@vger.kernel.org>; Tue,  2 Mar 2021 02:39:32 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id m15so6616928uah.7
        for <linux-mmc@vger.kernel.org>; Tue, 02 Mar 2021 02:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6r4AOaZqF/J4+5o5s3C3a7TM7mI7cCWrbhUsHuZqOwQ=;
        b=uYWgz5HZmDKSspNGaCfdRY6Fxp6596WGZO4WXNXuQdOKLY+a6GdTBP824esDu591LN
         WvgxdZb5xkGGUK7W9O1w7iUH0LS7pYzYz+nagaWTEug8VqlMRrqIUPTpJSwI8KUiPS1E
         H8yiCa7NFrowm+3LGHVAzq8OkrEIVCEoxwDHMGU4nheE5j54SN/5tl7zUm8iS+TX2jNj
         /o0ZgcWtMLa+qgV8KaTQIirmSsmGee2d5Tgt5DoIgrc+KCooVTx+C6WnRKnTFbGifWNs
         12CHStWRUvZI+8pGt7S9DwKAzYTsOsg9PduQVeuxWKuBIxczAVeFTExO0wU+jeMQ4Puz
         fAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6r4AOaZqF/J4+5o5s3C3a7TM7mI7cCWrbhUsHuZqOwQ=;
        b=rzr0SNHXAkYxCPDGwc46DC3b8ARZ7gp50CWK/7Kv3P/Mou6B3euCsMO4IXeoiUiVVf
         V51l0+qj8w/4+d8Gd0AyC4Cr4eKaRpJYTE30H9JS7tu2DDF+VS6rTkuYGEnAeKrCm1m6
         tCu4cjSN5DcvAVG5ac5EGEuBRmTl+n9ZnPc2/dVmOrGxaaPjtana66Xz49vL/vxTX6n1
         /s2NXpF3dJSPc0rbnn0mpwArvekZa85CLf7p/bZgHnZnKcQYYLnZYvA4PgZPvQ0Qi87d
         FjDzIN1sl/BnNWrlMYktvrcMU7Vv7q89Gmnnyrz+nntDQUc4rl4KKPb9kR/T0eHVUgni
         il0g==
X-Gm-Message-State: AOAM531hEaADzPYmkTKqfrSfuvfmkmawyzn7LKuo/55gpbhZneN8nqs9
        5yTb1BoZNEpmXCJFnpZtB5p0f06SocS4vb9K1AYaDA==
X-Google-Smtp-Source: ABdhPJztcXzXM5ZqgP8ZlRQnPyDftiiHJGFOa7aQnfkPc38todMp/WoR2/CtJkGrNpGBSPvJxvYxYgWXzmAeawEzDzU=
X-Received: by 2002:ab0:c16:: with SMTP id a22mr3399707uak.19.1614681571426;
 Tue, 02 Mar 2021 02:39:31 -0800 (PST)
MIME-Version: 1.0
References: <20210220142935.918554-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20210220142935.918554-1-christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Mar 2021 11:38:54 +0100
Message-ID: <CAPDyKFqscxswNYSSAMi1K+wnF8hWJHFN=o_5v61rWcZYVuF6cg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: uniphier-sd: Fix an error handling path in uniphier_sd_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Doug Anderson <dianders@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 20 Feb 2021 at 15:29, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> A 'uniphier_sd_clk_enable()' call should be balanced by a corresponding
> 'uniphier_sd_clk_disable()' call.
> This is done in the remove function, but not in the error handling path of
> the probe.
>
> Add the missing call.
>
> Fixes: 3fd784f745dd ("mmc: uniphier-sd: add UniPhier SD/eMMC controller driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/uniphier-sd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
> index 2413b6750cec..6f0f05466917 100644
> --- a/drivers/mmc/host/uniphier-sd.c
> +++ b/drivers/mmc/host/uniphier-sd.c
> @@ -635,7 +635,7 @@ static int uniphier_sd_probe(struct platform_device *pdev)
>
>         ret = tmio_mmc_host_probe(host);
>         if (ret)
> -               goto free_host;
> +               goto disable_clk;
>
>         ret = devm_request_irq(dev, irq, tmio_mmc_irq, IRQF_SHARED,
>                                dev_name(dev), host);
> @@ -646,6 +646,8 @@ static int uniphier_sd_probe(struct platform_device *pdev)
>
>  remove_host:
>         tmio_mmc_host_remove(host);
> +disable_clk:
> +       uniphier_sd_clk_disable(host);
>  free_host:
>         tmio_mmc_host_free(host);
>
> --
> 2.27.0
>
