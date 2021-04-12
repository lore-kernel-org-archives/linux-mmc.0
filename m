Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CC6C433B4
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE63B6135A
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbhDLHxO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbhDLHxO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Apr 2021 03:53:14 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDFDC06138C
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:52:56 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id o2so846022vkn.1
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=haLPUNjjiZEhpuang/uo2eD4NXoYXG1RAvFa9+uUreg=;
        b=Yd+oMly4aZU0RKWqWmoDzMZGGbTSIOObxH9Df5edGOBcyn+TT+oy82vFoB3KCA5FUF
         gbz9MS+wKRCC9yZQ3GC8K+28fC+azQtKI6ANxEBI0Nkroqrh5Zogj2JUPHNiYHlRJBOm
         32/+VHO5ypCk/O3HxSuV8tZEWftN+x8p06rgoHQDB97ymCZQAu/lUD7P+uH4WevWVb58
         taeeww3l4g/8IlDR3eyuLYhbOrgbltz/hKSaeVJahzHiLVv4Rw1p1ZUA+XYBNFPyqVT2
         nt2QTnp8RbI06/B4fkqdzi4jIjjS+4SM+fPOetmwniryNY1l01CZK8g7J0Z/rAzTH7pr
         qGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=haLPUNjjiZEhpuang/uo2eD4NXoYXG1RAvFa9+uUreg=;
        b=X/nzH20Q/9Wh0NAGubQHKLH3BnkBBBBi+FMZYcx0BEjGGZ3iAPtrQne0t6ha6HpEJH
         uS7mNuxl737bgl8RGkgb0sbzZPQg/2XbUXfAwewF3no+8tu4nMFqBRtjJCBYaoSoF1Ck
         X4/8xzNp+z+ggtd//fHMXv6y0w+GspNlRv3NOuPH63fJa47e7t+mjtcO6OCONbjYvUOP
         LnY1JG2P+BBb+397BXJgDfpfJxQgTU0KAU7eD2jmlAfeQB7k8sXlNH6KBH5mt7qj0u92
         sO46vUIEVoTbYpvSug0k6OshMdBCzY4xHCXgUTUa/qJTpYZdzZyC77aEdHM6pa2S3aLM
         9k4Q==
X-Gm-Message-State: AOAM5322ZzXS7njTvz2FOzqR1YUwq5Y/KeSmYwABW6iPCLt3L6PeSnJ9
        RLpK0izsxH9KXPD65527kBVNpzB5zVoiQFGEZ+DAb0GbQMI=
X-Google-Smtp-Source: ABdhPJwL5SnNlCfx9LXYsQGHy81G3AdoBCw3wKeAJ1c1igCwssy6W17LfihBqiSQUVRPDX7Y/lfn57u07HzAWF4nx18=
X-Received: by 2002:a1f:2a95:: with SMTP id q143mr18761115vkq.8.1618213975747;
 Mon, 12 Apr 2021 00:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210409015424.3277212-1-jiayang5@huawei.com>
In-Reply-To: <20210409015424.3277212-1-jiayang5@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Apr 2021 09:52:19 +0200
Message-ID: <CAPDyKFrnaTuBPtGfeaDBxjdk5pgfnBUKz2Emg8MHLYsudit5cw@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci-msm: Remove unnecessary error log
To:     Jia Yang <jiayang5@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 9 Apr 2021 at 03:44, Jia Yang <jiayang5@huawei.com> wrote:
>
> devm_ioremap_resource() has recorded error log, so it's
> unnecessary to record log again.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jia Yang <jiayang5@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-msm.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index d170c919e6e4..e44b7a66b73c 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1863,7 +1863,6 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>         struct mmc_host *mmc = msm_host->mmc;
>         struct device *dev = mmc_dev(mmc);
>         struct resource *res;
> -       int err;
>
>         if (!(cqhci_readl(cq_host, CQHCI_CAP) & CQHCI_CAP_CS))
>                 return 0;
> @@ -1881,11 +1880,8 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>         }
>
>         msm_host->ice_mem = devm_ioremap_resource(dev, res);
> -       if (IS_ERR(msm_host->ice_mem)) {
> -               err = PTR_ERR(msm_host->ice_mem);
> -               dev_err(dev, "Failed to map ICE registers; err=%d\n", err);
> -               return err;
> -       }
> +       if (IS_ERR(msm_host->ice_mem))
> +               return PTR_ERR(msm_host->ice_mem);
>
>         if (!sdhci_msm_ice_supported(msm_host))
>                 goto disable;
> --
> 2.25.1
>
