Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAD8C2BB40
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 10:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABEA922795
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 10:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbgLDKDp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Dec 2020 05:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgLDKDo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2020 05:03:44 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C594EC0613D1
        for <linux-mmc@vger.kernel.org>; Fri,  4 Dec 2020 02:03:09 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id v8so2941546vso.2
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2020 02:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rcku4lPAn/y4YhBZdjYlkKZQc+t40+z/luVVG1YdFJI=;
        b=DHGwreClgzq5UgdvP5poTN7RLhMGva3+Muj5jp5VFGgimCmx9WYcK0eAsHiPKmOBvm
         fNIxvrpnxT7enGivLKac/vig8mhqLw+2Cr5Ryv3fxuRyEA+glFI9u5W3FH+lcviTWeGe
         gBc30+jMZuskqlYBYm3IDHW+cnGRkBk2GrNsHGWwfc0la+TFas3pa3GnvnDDDfrSJ5E/
         lbhQqn6JI6qM9R1x/J78C+8KnVayuEfKRieda9i6E3ekSvyEAadWUtTwn7t5ZCmq1hzh
         964NVr4rM402IWoljsqluvgZHAACwUvLsZ+XPrjLvLBmKS08Kc99fr5VRKqG48f1KGm8
         G7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rcku4lPAn/y4YhBZdjYlkKZQc+t40+z/luVVG1YdFJI=;
        b=evTkm5RwrgW+Gtx9lTJe/2C63l6LEC9rUNKf34d/KlMbEhtco+j2FP1nGuF4vpW67y
         Jg+G/e7aEYAOiA7QNOceAgrJ1ra4rkU6Pn8PQ7Yhx3E6QCAIvvnfrRsmM1frOsy2RDiO
         K5JZ1Pqt+tre2yrKcdGEFEWlObBmWvCbfWSH5vWvFe1nT2ZitYlvJtegD66Rm1yu9Qub
         60ljAD6sUuXc/ymvV2nKPZWm30mUzDJ6a0V5iHtBWrCl2/hwU1WwkSqgNGgfv8k3mzlk
         oO8RJ1tR9Otz+hKFXPTZS55WnYn10KTLwKrI2mBy0GQ8jaQIWX39+S7+M/8WXzVw7YU9
         oKJQ==
X-Gm-Message-State: AOAM530RT92PUGhi/CriQ6ykJJW+dWB16LiINflKjeHzRODaSiD8oNnq
        0pBu/k89arphzh2sym7kr3ZNXbmJvXSs8U/L/hUMzQ==
X-Google-Smtp-Source: ABdhPJzF251m6Qz8Y2YtlC0BVJfa4JQ2d5vZe0SrIQHOSN0qQQLEJYfanTHuPYzxI3so5RnK5TCTPRNHPYoR6mFf9U4=
X-Received: by 2002:a67:fe85:: with SMTP id b5mr241341vsr.19.1607076189014;
 Fri, 04 Dec 2020 02:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20201203222922.1067522-1-arnd@kernel.org>
In-Reply-To: <20201203222922.1067522-1-arnd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Dec 2020 11:02:32 +0100
Message-ID: <CAPDyKFqtFYqc8i_fVzOUnuZGJjtwjVLqE-vebtOKuYJ-4PrDBg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: mark PM functions as __maybe_unused
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        yong mao <yong.mao@mediatek.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Marek Vasut <marex@denx.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Dec 2020 at 23:29, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The #ifdef check for the suspend/resume functions is wrong:
>
> drivers/mmc/host/mtk-sd.c:2765:12: error: unused function 'msdc_suspend' [-Werror,-Wunused-function]
> static int msdc_suspend(struct device *dev)
> drivers/mmc/host/mtk-sd.c:2779:12: error: unused function 'msdc_resume' [-Werror,-Wunused-function]
> static int msdc_resume(struct device *dev)
>
> Remove the #ifdef and mark all four as __maybe_unused to aovid the
> problem.
>
> Fixes: c0a2074ac575 ("mmc: mediatek: Fix system suspend/resume support for CQHCI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mmc/host/mtk-sd.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index d057fb11112a..de09c6347524 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2683,7 +2683,6 @@ static int msdc_drv_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM
>  static void msdc_save_reg(struct msdc_host *host)

Shouldn't msdc_save|restore_reg() be turned into "__maybe_unused" as well?

>  {
>         u32 tune_reg = host->dev_comp->pad_tune_reg;
> @@ -2742,7 +2741,7 @@ static void msdc_restore_reg(struct msdc_host *host)
>                 __msdc_enable_sdio_irq(host, 1);
>  }
>
> -static int msdc_runtime_suspend(struct device *dev)
> +static int __maybe_unused msdc_runtime_suspend(struct device *dev)
>  {
>         struct mmc_host *mmc = dev_get_drvdata(dev);
>         struct msdc_host *host = mmc_priv(mmc);
> @@ -2752,7 +2751,7 @@ static int msdc_runtime_suspend(struct device *dev)
>         return 0;
>  }
>
> -static int msdc_runtime_resume(struct device *dev)
> +static int __maybe_unused msdc_runtime_resume(struct device *dev)
>  {
>         struct mmc_host *mmc = dev_get_drvdata(dev);
>         struct msdc_host *host = mmc_priv(mmc);
> @@ -2762,7 +2761,7 @@ static int msdc_runtime_resume(struct device *dev)
>         return 0;
>  }
>
> -static int msdc_suspend(struct device *dev)
> +static int __maybe_unused msdc_suspend(struct device *dev)
>  {
>         struct mmc_host *mmc = dev_get_drvdata(dev);
>         int ret;
> @@ -2776,11 +2775,10 @@ static int msdc_suspend(struct device *dev)
>         return pm_runtime_force_suspend(dev);
>  }
>
> -static int msdc_resume(struct device *dev)
> +static int __maybe_unused msdc_resume(struct device *dev)
>  {
>         return pm_runtime_force_resume(dev);
>  }
> -#endif
>
>  static const struct dev_pm_ops msdc_dev_pm_ops = {

You may also change this to a __maybe_unused, as long as you also
assign the .pm pointer in the mt_msdc_driver with
pm_ptr(&msdc_dev_pm_ops).

Ideally the compiler should drop these functions/datas entirely then.

>         SET_SYSTEM_SLEEP_PM_OPS(msdc_suspend, msdc_resume)
> --
> 2.27.0
>

Kind regards
Uffe
