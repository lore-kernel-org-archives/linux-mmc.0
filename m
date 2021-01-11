Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEC3C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 18:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0CF2250E
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 18:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389907AbhAKSH3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jan 2021 13:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389737AbhAKSH2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jan 2021 13:07:28 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99E0C0617A3
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jan 2021 10:06:10 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id 73so122676uac.8
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jan 2021 10:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xJ8YDKbxR0sQku70wpmYgvX7eELSwUoWloC9fmHXNmU=;
        b=q81pozcj3Pmf2bhfGxlxs45cc6b4Bi2QA/SNd554PItVmnmZvr7dRJD6TYeMPs93I4
         vs/ynhU0C+GkVk3GXMJDmYg4vy88LUGD8M66RHqLJ8Zn71V7hNAO4GSK+Czpj63fd4Us
         rLAo6UdovtS3qpibGylZ4UzNZ6N6nHwxOhc5pW3FsDmF14bAvo29O4ZZwt0JA0A5hOdC
         WPu4Cisg73iJ9as4Znr7mYATYR2t3yZ/t21wo8Lhhz4yvrvfSm0e4hWxn1+p/HO00DQm
         uujiQGAunZIoKzQqMrb+Y/kbeo2nD8JEKaP8vV829Sql0lgY961m3ob6Nft/QdA1jOfb
         2K+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJ8YDKbxR0sQku70wpmYgvX7eELSwUoWloC9fmHXNmU=;
        b=Em3A2Qkf85XpWhGGnLSkdumYsfKDErTVUKGSgarT2/u8cNQ7rcrYrMQAocJWpNwRdv
         X1QCCbg2ZtZoIUcPW8lKgmysMJEGpSYY6ORkkMSiLBU20+sc8WfuMXZ0LTaF6mCWdaga
         gsRnJU02r4uwh0jsF8SJubJ8u/WqfO56gxeKaZ6sDPoTXgmcuZaCUOcr4OFhBGwz9SSo
         chnMsEM4fmAuT+UKT+MIWwcAH4LrapcmUy1M7H7nEu8ZOyUxu5PGbPn8tBmUlJ1s0r7S
         nZNF2NtWP8ia4xoVigHn0q9AXu/za4DmnfUJHRq4mYofa+Xz9Nm9H+aJzGo/P5zov7Jq
         WBDA==
X-Gm-Message-State: AOAM533hGI9Jksv1T7cjBw4X/G496BThYGGDHRTum09aGzE+WKMQgaoY
        gs0agt6FAwHm/1j8CU3FSkRVt+wV6NsnV0Df47Sjzg==
X-Google-Smtp-Source: ABdhPJxVD2cdVp2AVtGa1ryKzW4m7SdkdXsEsZoLJJ4o0s5acV7JwdRmehxkyvB93BGQZc6120EmdPQ7nwIAkb+AweY=
X-Received: by 2002:a9f:204e:: with SMTP id 72mr655260uam.19.1610388370170;
 Mon, 11 Jan 2021 10:06:10 -0800 (PST)
MIME-Version: 1.0
References: <20201209194202.54099-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20201209194202.54099-1-christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Jan 2021 19:05:32 +0100
Message-ID: <CAPDyKFqPnbig9s2h43c07c8tyDt12sFgDZFnQ+mfh=bbtdmRcg@mail.gmail.com>
Subject: Re: [PATCH] mmc: owl-mmc: Fix a resource leak in an error handling
 path and in the remove function
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 9 Dec 2020 at 20:42, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'dma_request_chan()' calls should be balanced by a corresponding
> 'dma_release_channel()' call.
>
> Add the missing call both in the error handling path of the probe function
> and in the remove function.
>
> Fixes: ff65ffe46d28 ("mmc: Add Actions Semi Owl SoCs SD/MMC driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/owl-mmc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
> index 53b81582f1af..5490962dc8e5 100644
> --- a/drivers/mmc/host/owl-mmc.c
> +++ b/drivers/mmc/host/owl-mmc.c
> @@ -640,7 +640,7 @@ static int owl_mmc_probe(struct platform_device *pdev)
>         owl_host->irq = platform_get_irq(pdev, 0);
>         if (owl_host->irq < 0) {
>                 ret = -EINVAL;
> -               goto err_free_host;
> +               goto err_release_channel;
>         }
>
>         ret = devm_request_irq(&pdev->dev, owl_host->irq, owl_irq_handler,
> @@ -648,19 +648,21 @@ static int owl_mmc_probe(struct platform_device *pdev)
>         if (ret) {
>                 dev_err(&pdev->dev, "Failed to request irq %d\n",
>                         owl_host->irq);
> -               goto err_free_host;
> +               goto err_release_channel;
>         }
>
>         ret = mmc_add_host(mmc);
>         if (ret) {
>                 dev_err(&pdev->dev, "Failed to add host\n");
> -               goto err_free_host;
> +               goto err_release_channel;
>         }
>
>         dev_dbg(&pdev->dev, "Owl MMC Controller Initialized\n");
>
>         return 0;
>
> +err_release_channel:
> +       dma_release_channel(owl_host->dma);
>  err_free_host:
>         mmc_free_host(mmc);
>
> @@ -674,6 +676,7 @@ static int owl_mmc_remove(struct platform_device *pdev)
>
>         mmc_remove_host(mmc);
>         disable_irq(owl_host->irq);
> +       dma_release_channel(owl_host->dma);
>         mmc_free_host(mmc);
>
>         return 0;
> --
> 2.27.0
>
