Return-Path: <SRS0=CGCI=65=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31612C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 07:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F229206F1
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 07:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+DJaO6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgEOHJx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 May 2020 03:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726388AbgEOHJw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2020 03:09:52 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8E5C061A0C
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 00:09:51 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id b11so615726vsa.13
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 00:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3fYY5yxRSWyMrWhXVWpCgKXf6kjqn8O3WyktHkVJvs=;
        b=J+DJaO6lb/DVfzg6le0iyAhKwILSh9Nc5Zg7NpCPc2RTFD2yGXLLzHiAH1J2yeJyCp
         E2eVXIO8AWpFcomiyK1b8HPC/H9I0LW0/r/orhjE6OZIiZkCAbP2Hi210Hxzl7TePTmn
         XLixq8G6wt25vuh0L0D6exnfanu7TUyHHZvH6dndHQA/PXS1ysZUK3e9LInI7dIA00XV
         bkXXkIHJbLaKY9JdKGNk9K3IKSpQXhYUcV67Pi0q5zSI29xzWg54irX5geL6nu5xHJBa
         5MUmKX5yqxomn1dxb1OAVUXXaDslVMTxqPYrALte2T7r08oenkBCpmZXOrl4OQjXpW6c
         7C4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3fYY5yxRSWyMrWhXVWpCgKXf6kjqn8O3WyktHkVJvs=;
        b=KGhWeJEG7MqUjBMQlxNZD/gvRBk37PtinZT1c10lAWFh05M95OlXeGZ5T+BvEhKvBA
         8YFuu5n88B7tB65Kt78hrWVSJnaYMb19V7iOYCE1wnac5+e/mXGxhoE2nafoMoJ5WMTq
         6FuyReAF6zQVRSZ/dOxK8ym2U32OL0esTeVEJQfsmYEvby4sy0iMJD7iZwAQJlC5ITrY
         Pq74p3F+Te2+GPjk5ypG6/ZfzQOdKoW+zmwgyehLewlXJc8H4x6Oe8XAYjdm8soKgG9k
         l/ib3W3Rp5Ut2I67z/EHgWl08jNx1hlI7EXZyB4hwrjno6hQreYkT6SftCfLIbCArCZi
         MfGw==
X-Gm-Message-State: AOAM531hglJrk8SxEWTVh8G1P0hJdALfIXtBWZKSFKbZIYUwb/p2qpBW
        Ge7UuX3me9o2ljGE12DOvZeM3qfmx600vS6+yS5TEg==
X-Google-Smtp-Source: ABdhPJzzUy+Okca43KdCqziTJYdPvVNhxflbrgWvfHQj3Y+hDQBIYW1+MYbVFpP1Mf1G3ejSUZK71yzlaozfixXGP0E=
X-Received: by 2002:a67:302:: with SMTP id 2mr1470297vsd.165.1589526590700;
 Fri, 15 May 2020 00:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200511062158.1790924-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200511062158.1790924-1-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 May 2020 09:09:14 +0200
Message-ID: <CAPDyKFonzvtfeERzxMm0WLWOwR492GCkNvB24bxoOQEfgZXsZw@mail.gmail.com>
Subject: Re: [PATCH] mmc: uniphier-sd: call devm_request_irq() after tmio_mmc_host_probe()
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 11 May 2020 at 08:22, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Currently, tmio_mmc_irq() handler is registered before the host is
> fully initialized by tmio_mmc_host_probe(). I did not previously notice
> this problem.
>
> The boot ROM of a new Socionext SoC unmasks interrupts (CTL_IRQ_MASK)
> somehow. The handler is invoked before tmio_mmc_host_probe(), then
> emits noisy call trace.
>
> Move devm_request_irq() below tmio_mmc_host_probe().
>
> Fixes: 3fd784f745dd ("mmc: uniphier-sd: add UniPhier SD/eMMC controller driver")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/uniphier-sd.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
> index a1683c49cb90..f82baf99fd69 100644
> --- a/drivers/mmc/host/uniphier-sd.c
> +++ b/drivers/mmc/host/uniphier-sd.c
> @@ -610,11 +610,6 @@ static int uniphier_sd_probe(struct platform_device *pdev)
>                 }
>         }
>
> -       ret = devm_request_irq(dev, irq, tmio_mmc_irq, IRQF_SHARED,
> -                              dev_name(dev), host);
> -       if (ret)
> -               goto free_host;
> -
>         if (priv->caps & UNIPHIER_SD_CAP_EXTENDED_IP)
>                 host->dma_ops = &uniphier_sd_internal_dma_ops;
>         else
> @@ -642,8 +637,15 @@ static int uniphier_sd_probe(struct platform_device *pdev)
>         if (ret)
>                 goto free_host;
>
> +       ret = devm_request_irq(dev, irq, tmio_mmc_irq, IRQF_SHARED,
> +                              dev_name(dev), host);
> +       if (ret)
> +               goto remove_host;
> +
>         return 0;
>
> +remove_host:
> +       tmio_mmc_host_remove(host);
>  free_host:
>         tmio_mmc_host_free(host);
>
> --
> 2.25.1
>
