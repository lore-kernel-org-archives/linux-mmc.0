Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1645EB64DD
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Jul 2023 11:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjGMLGI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Jul 2023 07:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbjGMLGH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2023 07:06:07 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CCB268F
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:06:04 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5701eaf0d04so4508497b3.2
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689246363; x=1691838363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jQ5zJ3RE3bkqHW8nA39k1wel/wtNjBxuxQZqeE/oUIc=;
        b=AF4JKuK521m6pB4IPsTQ+GbIWvx6HdZRWVs+C/32ulGesRM1zmk1vbHB4UwV1J6XP3
         zd7N23Hr2cH+MRs2rq8FOD+J/ndsTIujQp7lzgR+eh48apV2E/O/x7pwTjuNqGypgJYv
         U5Yl5JQyBCCTKaccyP4uHt8Plaw+gPFq/0Cq4sVbo+RqhBH7Rf9zZb2UQVz7aQvrKV2X
         BSS/CrJU1XisLVIOnKYIv7DJniMH7Bq7bmHtpy/Oi6UBYSyt9knrS6YZoBjHP6Rxg79w
         GA+Zi1PUbXLsu2USX7EwENOe1S8HkIPv0yN3dRPKvde1q6/e2pJfiy3vpofdakqwW0kg
         ZfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689246363; x=1691838363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQ5zJ3RE3bkqHW8nA39k1wel/wtNjBxuxQZqeE/oUIc=;
        b=PdxODH99vjXSKGKDci/r9qTeNRByt248JgjfPl+6o7Odkxqs99S7GRbSr0qPnXQh3j
         cAHnecwolGoOh/QoeCV6DTnxtY8Gq3ovxzqdulq4rWZQnNHfSU3oq5asTxa42W3iJwQO
         pPyAz8REFK3h8x/9pBQr7/OVCRkg8ptZtuIE0gsRckRNxD3JBF9ph/JVx13mhaosBY+6
         5vzjgYSlo0+oxrkWeKhrRZg2fnFn7x4Sk/GLZSwYtbpXbeamoxT7jVpz458v5zESTe57
         ZC3WwdomL7tCzn6j6ts/itgdCSaSbZ63TfpWFDW152niRYP0Zj1Vc3StSlKk8/fTh2YT
         ksbA==
X-Gm-Message-State: ABy/qLbCNYsEWncsy6v5lU0Xtouj9Skxk0aaRDhSrZOl9TNXHS5nMCOP
        PM/yfCNw8pjbH4VUn14xzgGpVd0iNYnuTgcTnEu3lw==
X-Google-Smtp-Source: APBJJlG6zZPjAMen3wDVjrgT8dwhjGZ3m8Hcib7Gz1vJ0iqq3SC5gZIHOnTB0izb/nMffmR2rQGrjr1dp1LGr3QanzM=
X-Received: by 2002:a0d:dfcf:0:b0:570:6a58:d864 with SMTP id
 i198-20020a0ddfcf000000b005706a58d864mr1098399ywe.51.1689246363583; Thu, 13
 Jul 2023 04:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230622090233.188539-1-harperchen1110@gmail.com>
In-Reply-To: <20230622090233.188539-1-harperchen1110@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jul 2023 13:05:27 +0200
Message-ID: <CAPDyKFqGG4S9GYZhikt--BhSpemke0t3859mX5QN7Rc2ajYwZQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunplus: fix return value check of mmc_add_host()
To:     Wei Chen <harperchen1110@gmail.com>
Cc:     tonyhuang.sunplus@gmail.com, lhjeff911@gmail.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 22 Jun 2023 at 11:02, Wei Chen <harperchen1110@gmail.com> wrote:
>
> mmc_add_host() may return error, if we ignore its return value,
> 1. the memory allocated in mmc_alloc_host() will be leaked
> 2. null-ptr-deref will happen when calling mmc_remove_host()
> in remove function spmmc_drv_remove() because deleting not
> added device.
>
> Fix this by checking the return value of mmc_add_host(). Moreover,
> I fixed the error handling path of spmmc_drv_probe() to clean up.
>
> Signed-off-by: Wei Chen <harperchen1110@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sunplus-mmc.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
> index db5e0dcdfa7f..a96e90ea6541 100644
> --- a/drivers/mmc/host/sunplus-mmc.c
> +++ b/drivers/mmc/host/sunplus-mmc.c
> @@ -902,7 +902,7 @@ static int spmmc_drv_probe(struct platform_device *pdev)
>
>         ret = mmc_of_parse(mmc);
>         if (ret)
> -               goto probe_free_host;
> +               goto clk_disable;
>
>         mmc->ops = &spmmc_ops;
>         mmc->f_min = SPMMC_MIN_CLK;
> @@ -911,7 +911,7 @@ static int spmmc_drv_probe(struct platform_device *pdev)
>
>         ret = mmc_regulator_get_supply(mmc);
>         if (ret)
> -               goto probe_free_host;
> +               goto clk_disable;
>
>         if (!mmc->ocr_avail)
>                 mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> @@ -927,9 +927,17 @@ static int spmmc_drv_probe(struct platform_device *pdev)
>         host->tuning_info.enable_tuning = 1;
>         pm_runtime_set_active(&pdev->dev);
>         pm_runtime_enable(&pdev->dev);
> -       mmc_add_host(mmc);
> +       ret = mmc_add_host(mmc);
> +       if (ret)
> +               goto pm_disable;
>
> -       return ret;
> +       return 0;
> +
> +pm_disable:
> +       pm_runtime_disable(&pdev->dev);
> +
> +clk_disable:
> +       clk_disable_unprepare(host->clk);
>
>  probe_free_host:
>         if (mmc)
> --
> 2.25.1
>
