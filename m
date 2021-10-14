Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BCDC433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 11:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A686101E
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 11:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhJNL0z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Oct 2021 07:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhJNL0y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Oct 2021 07:26:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFD6C06174E
        for <linux-mmc@vger.kernel.org>; Thu, 14 Oct 2021 04:24:49 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i24so24841108lfj.13
        for <linux-mmc@vger.kernel.org>; Thu, 14 Oct 2021 04:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGtOo92AjWnKYY5OPbYe9MEWHB9ev5MSnpBwIdnoK64=;
        b=HyeXMegDIQhugU9sQPoCD/5lwNwZUFuKGYhBgll/9ArrEkfaVpI208dAX2MtsEX07w
         zHqUN8sw/J80UqSOGPakEV5W7kHM3E27fSC+KOV9Tn/iEm2D2ecneapPFn9uf6zMeGRo
         Zfjq5HmlRaPdvPyu4/RRdeDLmt9J5Zc2X/+Psy7fy7wcOSZ9zDd1lW/VE5O0dFrOnSpH
         tgvB8E6FjrTQZVDqfkD56h7iyqK7P6CO4SaPQQ4i/YyMF6NEzVAH98APOUjWimsEo+k4
         k+xE4UgEV/f92/n+wptc45aJfIR2JZ5Bo8ZvwuWiHziF+LaouE/NRQnEZBYB15smvSPM
         JS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGtOo92AjWnKYY5OPbYe9MEWHB9ev5MSnpBwIdnoK64=;
        b=CsbGqWs4Iup0c41ENpBHjzr9uJXW3StpKbgnkfEz7VXQbcnYKYg4g2lzW6bCVZQQMU
         D4rJIL6dk7U2CzDAM9zmLYVxO1gO3vcVjmttWRTc16TBWZey7R5AZXd1LrdChjF3M+HN
         36zV+/cm7AOM6PIO8wZuzGqSwmuMn0zhS3QWRFJMN/ep7mNvC+ry2d9nQcYYIZvoSorA
         wzBBDFQAITera8tWIUXpfVEwSF3UpMAXaAFmy7L+lTq+wuacc2WASBIkEoDKyP46Rrb9
         uAWxf6g2JV80GpeEq0h1hzKwVRtRf4Ba90D+CR5YUwvw7+nzIf44eOIBvPdfMFjnRK7p
         XUcg==
X-Gm-Message-State: AOAM5324/qi6Yzi/xhZmWGsNPMTpRTTGlv3Qh9XTcvvaLPqk1VXUhi/a
        Bi3MLWpZvhPGMv4LPnF8WnD21ezJX16QCmo4+j4k/g==
X-Google-Smtp-Source: ABdhPJzL2UMZ09NVAzbjnfTAcDgcPiREcKQT/vEagroDfcuBbtCgsw0BMAaEHT1QlVRzEXve7ktEcuVrG27MFU6PjsM=
X-Received: by 2002:a05:651c:4c9:: with SMTP id e9mr5394747lji.229.1634210683423;
 Thu, 14 Oct 2021 04:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211013100052.125461-1-colin.king@canonical.com>
In-Reply-To: <20211013100052.125461-1-colin.king@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Oct 2021 13:24:07 +0200
Message-ID: <CAPDyKFp7jsEPjun=2mTDGrGM=mHM=jUQvGwDObfMx8odQ9d2Ag@mail.gmail.com>
Subject: Re: [PATCH][next] mmc: moxart: Fix null pointer dereference on
 pointer host
To:     Colin King <colin.king@canonical.com>
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 Oct 2021 at 12:00, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are several error return paths that dereference the null pointer
> host because the pointer has not yet been set to a valid value.
> Fix this by adding a new out_mmc label and exiting via this label
> to avoid the host clean up and hence the null pointer dereference.
>
> Addresses-Coverity: ("Explicit null dereference")
> Fixes: 8105c2abbf36 ("mmc: moxart: Fix reference count leaks in moxart_probe")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/moxart-mmc.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index 7b9fcef490de..16d1c7a43d33 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -566,37 +566,37 @@ static int moxart_probe(struct platform_device *pdev)
>         if (!mmc) {
>                 dev_err(dev, "mmc_alloc_host failed\n");
>                 ret = -ENOMEM;
> -               goto out;
> +               goto out_mmc;
>         }
>
>         ret = of_address_to_resource(node, 0, &res_mmc);
>         if (ret) {
>                 dev_err(dev, "of_address_to_resource failed\n");
> -               goto out;
> +               goto out_mmc;
>         }
>
>         irq = irq_of_parse_and_map(node, 0);
>         if (irq <= 0) {
>                 dev_err(dev, "irq_of_parse_and_map failed\n");
>                 ret = -EINVAL;
> -               goto out;
> +               goto out_mmc;
>         }
>
>         clk = devm_clk_get(dev, NULL);
>         if (IS_ERR(clk)) {
>                 ret = PTR_ERR(clk);
> -               goto out;
> +               goto out_mmc;
>         }
>
>         reg_mmc = devm_ioremap_resource(dev, &res_mmc);
>         if (IS_ERR(reg_mmc)) {
>                 ret = PTR_ERR(reg_mmc);
> -               goto out;
> +               goto out_mmc;
>         }
>
>         ret = mmc_of_parse(mmc);
>         if (ret)
> -               goto out;
> +               goto out_mmc;
>
>         host = mmc_priv(mmc);
>         host->mmc = mmc;
> @@ -687,6 +687,7 @@ static int moxart_probe(struct platform_device *pdev)
>                 dma_release_channel(host->dma_chan_tx);
>         if (!IS_ERR_OR_NULL(host->dma_chan_rx))
>                 dma_release_channel(host->dma_chan_rx);
> +out_mmc:
>         if (mmc)
>                 mmc_free_host(mmc);
>         return ret;
> --
> 2.32.0
>
