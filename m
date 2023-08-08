Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778BFC001DB
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Aug 2023 18:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjHHSTp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbjHHSTQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2023 14:19:16 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF782098B
        for <linux-mmc@vger.kernel.org>; Tue,  8 Aug 2023 10:27:23 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bd045336c6so927085a34.2
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2023 10:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691515642; x=1692120442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1aaFBO37dpPCuMBG1yWUb85dTTA1EjCFwxXfWyjK7Qw=;
        b=lVVEVrrMEQUltcQptCqUpH71VwX+00XmuTdulJOUHzmLj2Irs5PkJWEvfdxOmmtMa0
         ZqXCLba6TZMiP/L/m4B8UKlB/MTCTFlRgoEYRlV6900qVQ3sd0VD6aoUYx9EQQSglWMV
         /XK7Bs0U9wmVYJ4gPei8Ia1VAHdOPtBGRpsvewrhuZmHT/1dKBrsyW1V0iy5Yht2lp9Z
         tnvudhR+hl8BxzJ3thUhCVNUBpH/TOfIjZxSVMtZbJ5lRr9Gyw3WCsfUoBRylMpP647n
         Bd2NQi1/bsKsgFKfPuMh2M6tgfd0sYm7LsNNrAqRaAJ9KaEkBUd3GP+t7x5b8UzSd9h3
         rpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515642; x=1692120442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aaFBO37dpPCuMBG1yWUb85dTTA1EjCFwxXfWyjK7Qw=;
        b=UU2KJitq4dtb3uYNcljc5s+lMVt6+TPyjr28MwygtEswLUb9/BUxMBX4zI8uoo/EZ4
         DTvgAL0TlblBrdG8vgsMSXVF/qqzDrkCYCYmHWoiWAc/5999T40Gtu9VZduvXdHY2zlu
         mxTKdu/WD4+aAlxFM4feODia7EsmRrUMv5Qnybef55guxSB4H2tp9JcXXuOXE3nBhxIa
         zlyMRfNnL7WSsm3pA2bfmZb1HT0ZAiECLxg2gtVQofrGHYykk9AJ8FWUtSpiI2fgy9ph
         tAx/Lwzsf1fyGSsKjV9lxMPxupewhz4kAqd9aygHTw5QvabxhNPlvpd+mTW71vVLAZex
         g64A==
X-Gm-Message-State: AOJu0YwImp7KxZ6AnRzq1dvLbvuYsdOgusGMQQaKJaDWCdzCizmHNgbQ
        Hv+snN9xgRCBlESclByu8srPPhrFwVv+HRlDs9Y0lZBAG0TJ39xLM2k=
X-Google-Smtp-Source: AGHT+IFJj9e2EUCkSwSgqtF2y3ZesBe+F0eiTcoGfYJG3GoyMXdp+CIP9EhdafPQbyNW+qk99mZLa2MicI2Cz2nNz/g=
X-Received: by 2002:a25:4ec6:0:b0:d35:9a48:51b0 with SMTP id
 c189-20020a254ec6000000b00d359a4851b0mr7568564ybb.7.1691485293733; Tue, 08
 Aug 2023 02:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230801052321.1328225-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230801052321.1328225-1-harshit.m.mogalapalli@oracle.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 11:00:57 +0200
Message-ID: <CAPDyKFr9inG4dgAUYhrQOEND1Fu1CDajEPoO3W=dBRRXB=kceQ@mail.gmail.com>
Subject: Re: [PATCH next] mmc: sunplus: Fix error handling in spmmc_drv_probe()
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 1 Aug 2023 at 07:23, Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> There are few issues in spmmc_drv_probe():
>
> 1. When mmc allocation fails, goto is a no-op.
> 2. When mmc allocation succeeds, the error paths should use goto instead
>    of direct return.

Rather than adding a bunch of new "gotos", how about converting into
using devm_mmc_alloc_host()?

> 3. platform_get_irq() doesn't return zero, so '<' is sufficient.
>
> Fix the above issues by adding goto instead of direct return, also
> remove NULL check in 'probe_free_host' as we changed the goto to return
> when mmc_alloc_host() fails.
>
> Fixes: 4e268fed8b18 ("mmc: Add mmc driver for Sunplus SP7021")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/a3829ed3-d827-4b9d-827e-9cc24a3ec3bc@moroto.mountain/
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Other than the above, this looks good to me!

Kind regards
Uffe

> ---
> This is based on static analysis with Smatch. Only compile tested.
> ---
>  drivers/mmc/host/sunplus-mmc.c | 41 ++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
> index a55a87f64d2a..21cd49be08c0 100644
> --- a/drivers/mmc/host/sunplus-mmc.c
> +++ b/drivers/mmc/host/sunplus-mmc.c
> @@ -864,10 +864,8 @@ static int spmmc_drv_probe(struct platform_device *pdev)
>         int ret = 0;
>
>         mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
> -       if (!mmc) {
> -               ret = -ENOMEM;
> -               goto probe_free_host;
> -       }
> +       if (!mmc)
> +               return -ENOMEM;
>
>         host = mmc_priv(mmc);
>         host->mmc = mmc;
> @@ -875,30 +873,40 @@ static int spmmc_drv_probe(struct platform_device *pdev)
>         host->dma_int_threshold = 1024;
>
>         host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> -       if (IS_ERR(host->base))
> -               return PTR_ERR(host->base);
> +       if (IS_ERR(host->base)) {
> +               ret = PTR_ERR(host->base);
> +               goto probe_free_host;
> +       }
>
>         host->clk = devm_clk_get(&pdev->dev, NULL);
> -       if (IS_ERR(host->clk))
> -               return dev_err_probe(&pdev->dev, PTR_ERR(host->clk), "clk get fail\n");
> +       if (IS_ERR(host->clk)) {
> +               ret = dev_err_probe(&pdev->dev, PTR_ERR(host->clk), "clk get fail\n");
> +               goto probe_free_host;
> +       }
>
>         host->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> -       if (IS_ERR(host->rstc))
> -               return dev_err_probe(&pdev->dev, PTR_ERR(host->rstc), "rst get fail\n");
> +       if (IS_ERR(host->rstc)) {
> +               ret = dev_err_probe(&pdev->dev, PTR_ERR(host->rstc), "rst get fail\n");
> +               goto probe_free_host;
> +       }
>
>         host->irq = platform_get_irq(pdev, 0);
> -       if (host->irq <= 0)
> -               return host->irq;
> +       if (host->irq < 0) {
> +               ret = host->irq;
> +               goto probe_free_host;
> +       }
>
>         ret = devm_request_threaded_irq(&pdev->dev, host->irq,
>                                         spmmc_irq, spmmc_func_finish_req, IRQF_SHARED,
>                         NULL, host);
>         if (ret)
> -               return ret;
> +               goto probe_free_host;
>
>         ret = clk_prepare_enable(host->clk);
> -       if (ret)
> -               return dev_err_probe(&pdev->dev, ret, "failed to enable clk\n");
> +       if (ret) {
> +               ret = dev_err_probe(&pdev->dev, ret, "failed to enable clk\n");
> +               goto probe_free_host;
> +       }
>
>         ret = mmc_of_parse(mmc);
>         if (ret)
> @@ -940,8 +948,7 @@ static int spmmc_drv_probe(struct platform_device *pdev)
>         clk_disable_unprepare(host->clk);
>
>  probe_free_host:
> -       if (mmc)
> -               mmc_free_host(mmc);
> +       mmc_free_host(mmc);
>
>         return ret;
>  }
> --
> 2.39.3
>
