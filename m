Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7FAC433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Feb 2021 11:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B5264E27
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Feb 2021 11:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhBVL6P (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Feb 2021 06:58:15 -0500
Received: from condef-04.nifty.com ([202.248.20.69]:34118 "EHLO
        condef-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhBVL6N (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Feb 2021 06:58:13 -0500
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-04.nifty.com with ESMTP id 11MBlQnn006597;
        Mon, 22 Feb 2021 20:47:26 +0900
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 11MBjmSq026019;
        Mon, 22 Feb 2021 20:45:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 11MBjmSq026019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1613994349;
        bh=XycS92IGA3vLF6aa9ZEP5cx7aX8qlkuTZWFQ5Nsc3mo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pxLlUel3rZgmGgieTAUcqXqa/u7C8LHYJkoHTmk304NKqB1CkTweK4oHRY/oilMdZ
         eUKw1wRm6nRlqD7ar1SgKL5sChqh4tfLBIkCAu1zXimhpGnlpb6rVa7Q1T5MvBH6DW
         4WNU7v819T+0p+75FntMyyqabBqwV5hr7FfQc6ZpJWTIQEKHCccjWMjobZqw1w2CxW
         UHTMFZcfUnlNkCCj1B17LYJ9BLySwB5ZzWy91WErRlb9ZXqRh1cJ1wLsSn0sIHfb/n
         0DYBiEL6hEor2ktacyyobbf3OekSV7rPzBOfsUyhkvOGAx1jXFfe1Cz9zP7HZNGYIa
         oAfvbf3YJjH7g==
X-Nifty-SrcIP: [209.85.210.177]
Received: by mail-pf1-f177.google.com with SMTP id u26so464878pfn.6;
        Mon, 22 Feb 2021 03:45:49 -0800 (PST)
X-Gm-Message-State: AOAM532qhbcs2kMnz+FeHqiRJ3tsuPBPCEdodMG8zJ3YmF6EnmjqQ0R6
        T4rWsAoi7LzA6e4xE8+Mc6gTnPApMM1BrbbmFwU=
X-Google-Smtp-Source: ABdhPJzg8YvMz+G0Com1JcOMBvXR+cwLw21c4AEbMPt+R+k+o7Ro5o3jSTZdRWIQ5c+kyR2CNajAS4OJgpWf2Y56Mgc=
X-Received: by 2002:a62:1412:0:b029:1ec:bc11:31fd with SMTP id
 18-20020a6214120000b02901ecbc1131fdmr21092690pfu.76.1613994348588; Mon, 22
 Feb 2021 03:45:48 -0800 (PST)
MIME-Version: 1.0
References: <20210220142935.918554-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20210220142935.918554-1-christophe.jaillet@wanadoo.fr>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 22 Feb 2021 20:45:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNATar8hf7B=HeaWO4D8DhmABXjNZ16H_+KQr=gEx+9Bgrg@mail.gmail.com>
Message-ID: <CAK7LNATar8hf7B=HeaWO4D8DhmABXjNZ16H_+KQr=gEx+9Bgrg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: uniphier-sd: Fix an error handling path in uniphier_sd_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        kernel@esmil.dk, Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, Feb 20, 2021 at 11:31 PM Christophe JAILLET
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
> ---

I no longer have access to this hardware, but
by browsing the code, this seems correct.

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>






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


--
Best Regards
Masahiro Yamada
