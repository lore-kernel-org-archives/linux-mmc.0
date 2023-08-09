Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DBEC001B0
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Aug 2023 11:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjHILST (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Aug 2023 07:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjHILSS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Aug 2023 07:18:18 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5C919A1
        for <linux-mmc@vger.kernel.org>; Wed,  9 Aug 2023 04:18:17 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-583fe10bb3cso77028457b3.2
        for <linux-mmc@vger.kernel.org>; Wed, 09 Aug 2023 04:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691579896; x=1692184696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Qd5Q30zi0GR+tG5MZxvetxiAiJ73IWmx5JKTPRK8+M=;
        b=PsPJSySrL4AnBphkJ34Jv0ktjJiWLoGrA/sq7XyP/aocCNnNVVapqD/jVC/jT/SHv6
         W3+QIbDL0CQjvcuhZrpDMe6qBZ6eTm1hRW2HEf8ddNI8dO02GYGBjaBNI9zh+cjOIKlU
         gluh3SYeSfB3YE5OEhw5vpVXhPaavrWUpNTPUbfSFKTEXWF7p2U/Jt1Zt9k7pKwPrAcv
         pewodTa76tgUEZ+dAMEtkF55dIcZrnVcR2rm3f3vfgtORR+FZ1X6stjY3+wEvdogxRfH
         MZpnYDQbp+5U3n8oWDYzUnpfFIe2H9zkPE8gC8z9qsIHLPGOuOetOVgOOwvuQcNK0W7B
         wE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691579896; x=1692184696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Qd5Q30zi0GR+tG5MZxvetxiAiJ73IWmx5JKTPRK8+M=;
        b=V1+HP8+pL1oJf8L5vSlvyVKj3g2K6oFTnSyFIPXVRpRKP37/wjbrfq2m2jHRo8dnsM
         BgZA56YC3GTXhS5XjPNEeudgLFV5Vk7R6E7iVCc9t+HtxRhDAJ8jE9a96pStEkcIGtTY
         3Mb4Q7TqKyzSW9AiCEBQFWP7EEBdyb2HWW7SJwJ7flT9eenvLdV7plP32dRMKUsYTkyb
         mERJ+NBlIiMNFMfwKPFAbXpHfq1fJ4Eipm76t+qYMHTo2Pfb0PI3TCp7h7u2cBvrpu1k
         X9t3qx+hiULdCCdfgj+2gODlPxPhnNmU3moDnAHuaSiYUVEDVAcXJcPysZWI2XQp+flB
         yYIA==
X-Gm-Message-State: AOJu0YwHoi6IycxToQ93qoNdispZ0rn6uMPh5idEHQqQybpoL+MT/y6y
        WUK0wYIgdqhG50fZUyf8uY2gFwkJ24Ta9nbWc2dYHqrK4AqRqKE2
X-Google-Smtp-Source: AGHT+IGAaVsRhtlJf29BE/0dFe7Ba9IqEoZUBqhXJlyuRFQA3EvdRL6X3Q95U5uzJiFBoAXWRka9wV1+2kxpgDrzp7Q=
X-Received: by 2002:a81:c311:0:b0:589:8b55:f7f4 with SMTP id
 r17-20020a81c311000000b005898b55f7f4mr2160229ywk.33.1691579896376; Wed, 09
 Aug 2023 04:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230809071812.547229-1-harshit.m.mogalapalli@oracle.com> <CAPDyKFrstv47OdXeFvSArKwAh40Lq=JXLYfbd8LNCOwAT=b5Cw@mail.gmail.com>
In-Reply-To: <CAPDyKFrstv47OdXeFvSArKwAh40Lq=JXLYfbd8LNCOwAT=b5Cw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Aug 2023 13:17:40 +0200
Message-ID: <CAPDyKFonen0YSAHqX8MMaYfQPUDFrHUY4DUWkNrc4kxzyUWfUg@mail.gmail.com>
Subject: Re: [PATCH next v2 1/2] mmc: sunplus: Fix error handling in spmmc_drv_probe()
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     tonyhuang.sunplus@gmail.com, lhjeff911@gmail.com,
        dan.carpenter@linaro.org, arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, error27@gmail.com,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 9 Aug 2023 at 13:08, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 9 Aug 2023 at 09:18, Harshit Mogalapalli
> <harshit.m.mogalapalli@oracle.com> wrote:
> >
> > When mmc allocation succeeds, the error paths are not freeing mmc.
> >
> > Fix the above issue by changing mmc_alloc_host() to devm_mmc_alloc_host()
> > to simplify the error handling. Remove label 'probe_free_host' as devm_*
> > api takes care of freeing, also remove mmc_free_host() from remove
> > function as devm_* takes care of freeing.
> >
> > Fixes: 4e268fed8b18 ("mmc: Add mmc driver for Sunplus SP7021")
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/all/a3829ed3-d827-4b9d-827e-9cc24a3ec3bc@moroto.mountain/
> > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>
> This doesn't apply on my next branch, please rebase it.
>
> Moreover, it looks like you should replace a few more "goto
> probe_free_host;" with "return ret;". Please have a closer look.

Oh, my bad, please ignore the above!

I had another fix for the sunplus driver queued on my next branch. I
have moved that patch to fixes and applied your patch on top, thanks!

Kind regards
Uffe

> > ---
> > This is based on static analysis with smatch, only compile tested.
> >
> > v1->v2: Simplify code by using devm_mmc_alloc_host() instead of
> > mmc_alloc_host() (Ulf Hansson's suggestion)
> > ---
> >  drivers/mmc/host/sunplus-mmc.c | 14 +++-----------
> >  1 file changed, 3 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
> > index a55a87f64d2a..2bdebeb1f8e4 100644
> > --- a/drivers/mmc/host/sunplus-mmc.c
> > +++ b/drivers/mmc/host/sunplus-mmc.c
> > @@ -863,11 +863,9 @@ static int spmmc_drv_probe(struct platform_device *pdev)
> >         struct spmmc_host *host;
> >         int ret = 0;
> >
> > -       mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
> > -       if (!mmc) {
> > -               ret = -ENOMEM;
> > -               goto probe_free_host;
> > -       }
> > +       mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(struct spmmc_host));
> > +       if (!mmc)
> > +               return -ENOMEM;
> >
> >         host = mmc_priv(mmc);
> >         host->mmc = mmc;
> > @@ -938,11 +936,6 @@ static int spmmc_drv_probe(struct platform_device *pdev)
> >
> >  clk_disable:
> >         clk_disable_unprepare(host->clk);
> > -
> > -probe_free_host:
> > -       if (mmc)
> > -               mmc_free_host(mmc);
> > -
> >         return ret;
> >  }
> >
> > @@ -956,7 +949,6 @@ static int spmmc_drv_remove(struct platform_device *dev)
> >         pm_runtime_put_noidle(&dev->dev);
> >         pm_runtime_disable(&dev->dev);
> >         platform_set_drvdata(dev, NULL);
> > -       mmc_free_host(host->mmc);
> >
> >         return 0;
> >  }
> > --
> > 2.39.3
> >
