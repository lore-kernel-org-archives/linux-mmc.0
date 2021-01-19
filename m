Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EA5C432C3
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE6F22DFB
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387946AbhASOts (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392546AbhASNpz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2021 08:45:55 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C006C061795
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jan 2021 05:43:40 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id v23so2388322uam.8
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jan 2021 05:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNvEq5am+ikTvDsBrW7I06pSqyQwukR3vU3Lj1BRMZY=;
        b=SphubxSJTVl0TE0jAYvw8W8A2f9P9Mi5GZALEkVjbxipuCEaJJO53riF85DbU3rdL9
         LpNZQrLAsNSuebeng43zG7UM1hic6+NQ9gU+MTOYYARS80T+KdOjdIFIBjE8VE0zCEua
         bW2Pvf0Fa+Mo2mZMiMuHPCE6udwFMqiwjLf62PqwWVElt3ZNkYSND4twFP4dLdEUriAH
         Z4rRhq67ev1ZkcXUNYVfems6a109dchqMDFU3eejhu5xqhDNLIcU2uNhtkTV5pFotmrf
         aNQ7rhBiFMLAmc1cHEi+ITYc5WUw7A5fS7tmwdK1Dg7bLkvEkBtu6AKUzdlbt3yDtCnj
         HEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNvEq5am+ikTvDsBrW7I06pSqyQwukR3vU3Lj1BRMZY=;
        b=XIrwjwyu5jx7vvFEqRM6WG97903LoBifOHJ47RXUTLhyo4sGLOTWFhITprEIJOPg3n
         8qsRr2v75+TD1oziNkERFmzs2Q14WvcfS5w8wPuXoXduu7AL2kLcq91+0O1nMp8liv1R
         5Nzt23W2nlF95YQBaNFv3keXoFovI7Z3LU88sriQaEZjeG92hOtAvFhHUmE4Cqqx/s6Q
         1nWVmF0CRGD0ugTLMjCcGoL+FKLJwCQoSwRm1DRDshdL/DkY+8mt7dq5RVH7zWS+bLrn
         K2Gh1Pyb3eY3Ajl6a2rhfBqugzd7+3qhwVhEKPLiyLwtTuK0S2zBfQ9CFZOg8y5ZKzhk
         9qIQ==
X-Gm-Message-State: AOAM533bDYpiSQanQPs7miNw7SoVe/Jehsh0AZjy2/7cNNcym0EdYrsZ
        ARP/4yMCxz2TL7xaECEgTW+INUm7Ht+cr2zXmDTu6w==
X-Google-Smtp-Source: ABdhPJx1sJ4xEgc4HsCtvWM79eqIKYNMrMBIhqmEXfnsfu1Ih9nGPi9MRPZTKWZwDPPcFTUk4CrGjvf2AzBXz2uxEvU=
X-Received: by 2002:ab0:768:: with SMTP id h95mr2267466uah.104.1611063819438;
 Tue, 19 Jan 2021 05:43:39 -0800 (PST)
MIME-Version: 1.0
References: <1610704281-11036-1-git-send-email-abaci-bugfix@linux.alibaba.com>
In-Reply-To: <1610704281-11036-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Jan 2021 14:43:03 +0100
Message-ID: <CAPDyKFpwF6gX3YhKGMF=YUGP1UQD=JSuNgvSxuJHG+Ochzv5Bg@mail.gmail.com>
Subject: Re: [PATCH v2] host: omap_hsmmc: style: Simplify bool comparison and conversion
To:     Yang Li <abaci-bugfix@linux.alibaba.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 15 Jan 2021 at 10:51, Yang Li <abaci-bugfix@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
> ./drivers/mmc/host/omap_hsmmc.c:297:6-25: WARNING: Comparison of 0/1 to
> bool variable
>
> According to the context, vqmmc_enabled is more suitable for bool
> type.
>
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
>  -clean up all use of "pbias_enabled", and do the same clean up for
> "vqmmc_enabled".
>
>  drivers/mmc/host/omap_hsmmc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index aa9cc49..2f8038d 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -177,7 +177,7 @@ struct omap_hsmmc_host {
>         struct  regulator       *pbias;
>         bool                    pbias_enabled;
>         void    __iomem         *base;
> -       int                     vqmmc_enabled;
> +       bool                    vqmmc_enabled;
>         resource_size_t         mapbase;
>         spinlock_t              irq_lock; /* Prevent races with irq handler */
>         unsigned int            dma_len;
> @@ -232,7 +232,7 @@ static int omap_hsmmc_enable_supply(struct mmc_host *mmc)
>                         dev_err(mmc_dev(mmc), "vmmc_aux reg enable failed\n");
>                         goto err_vqmmc;
>                 }
> -               host->vqmmc_enabled = 1;
> +               host->vqmmc_enabled = true;
>         }
>
>         return 0;
> @@ -256,7 +256,7 @@ static int omap_hsmmc_disable_supply(struct mmc_host *mmc)
>                         dev_err(mmc_dev(mmc), "vmmc_aux reg disable failed\n");
>                         return ret;
>                 }
> -               host->vqmmc_enabled = 0;
> +               host->vqmmc_enabled = false;
>         }
>
>         if (!IS_ERR(mmc->supply.vmmc)) {
> @@ -285,22 +285,22 @@ static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on)
>                 return 0;
>
>         if (power_on) {
> -               if (host->pbias_enabled == 0) {
> +               if (!host->pbias_enabled) {
>                         ret = regulator_enable(host->pbias);
>                         if (ret) {
>                                 dev_err(host->dev, "pbias reg enable fail\n");
>                                 return ret;
>                         }
> -                       host->pbias_enabled = 1;
> +                       host->pbias_enabled = true;
>                 }
>         } else {
> -               if (host->pbias_enabled == 1) {
> +               if (host->pbias_enabled) {
>                         ret = regulator_disable(host->pbias);
>                         if (ret) {
>                                 dev_err(host->dev, "pbias reg disable fail\n");
>                                 return ret;
>                         }
> -                       host->pbias_enabled = 0;
> +                       host->pbias_enabled = false;
>                 }
>         }
>
> @@ -1861,8 +1861,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>         host->base      = base + pdata->reg_offset;
>         host->power_mode = MMC_POWER_OFF;
>         host->next_data.cookie = 1;
> -       host->pbias_enabled = 0;
> -       host->vqmmc_enabled = 0;
> +       host->pbias_enabled = false;
> +       host->vqmmc_enabled = false;
>
>         platform_set_drvdata(pdev, host);
>
> --
> 1.8.3.1
>
