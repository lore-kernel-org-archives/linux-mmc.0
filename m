Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85859EB64DD
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Jul 2023 11:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjGMLHd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Jul 2023 07:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbjGMLH3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2023 07:07:29 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896392706
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:07:27 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-579dfae6855so4942097b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689246446; x=1691838446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y0pyIQlBvW36Ph+YA2bTE1wsm2dlRAy2qTKSqOZ/cA=;
        b=fz2S5126ZLBxCYxaamY1kV1XyB8Qv9gBhsN9+rJe/eGznO+ScQvoojxk758DPrOL6S
         kiDpyKZGUcZetClE7o3VCBw3m6Akp3mXaCLgfcnhF2eujtVJKQu/+n20W/aIPj0Cd+ty
         WcEQ7nqPg/dCu7Todmj6yWyLlrj/lYAEKkh/bQDIiS/ki0HKFDN41wI9/Ngjrn/rCpAW
         b2Xm7uUaqAUYWAQjje5LQS0xRM7loY95nclMvnumicYpnG3uTZCEGrz1bKYIIMMQVVRq
         bvPcCaAknmhMq63eaYg2k42lGpJdncKI2FTAMeMr2fcyMBzcGqmG6lBfwecmh14bzgfU
         U+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689246446; x=1691838446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Y0pyIQlBvW36Ph+YA2bTE1wsm2dlRAy2qTKSqOZ/cA=;
        b=gq0uT+QPsP7Toh/cAQyykRK/a2a5ZsteexAt4xbgU21m7woUIXfZnzri8LG22x4knq
         rS7TL/FNTmDIUJPBx90rn2g2BoW4WXALnPRgHeQHF+mX9dfCIm9Njz9jKgYpAgncbphs
         BF/SirOD7XtOh/aaMeqbPYC+E5LWWogchdHA8vqFQFpv9jj7AitTloTOHg/fX17G9QGI
         cxCP3hKDkVTFdmh+zk7jYnD199KOrXrS65dD8eAZBYF8GcBsPtPyEMMWtPAee9uFjiur
         27o0YBe10CrA6bzlbmgrf+GPrh/ZzpubR85nmrZYAjAx+yUxmIXwVLyt0eyIxlTUVglG
         L3vg==
X-Gm-Message-State: ABy/qLaDjUz7CUYOeNQBU/4cFWMBWeVT/iaSWewWSPhI5sxNo1zh3a/H
        uNp4lrH3LWZHor//mGp9gpRqqlaqeYFZF6GfNbZyYQ==
X-Google-Smtp-Source: APBJJlHbxUw4wK2EafSLUkStFGslm+iGkZ7cyFQclnB8FQ0STVNA6OJkiIZuxLzFRrbLtf01NpgRbuHPIBXmFf8Rfos=
X-Received: by 2002:a81:7744:0:b0:561:b85e:8d9e with SMTP id
 s65-20020a817744000000b00561b85e8d9emr1304189ywc.15.1689246446662; Thu, 13
 Jul 2023 04:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230704131939.22562-1-frank.li@vivo.com> <20230704131939.22562-3-frank.li@vivo.com>
In-Reply-To: <20230704131939.22562-3-frank.li@vivo.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jul 2023 13:06:50 +0200
Message-ID: <CAPDyKFqEZzph0B3gdy-UVvg_1YytoH3jVtSnv-AYCy9m9FG9cw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: pxamci: Use devm_platform_get_and_ioremap_resource()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 4 Jul 2023 at 15:19, Yangtao Li <frank.li@vivo.com> wrote:
>
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/pxamci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 2a988f942b6c..1142cd2368f6 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -612,7 +612,6 @@ static int pxamci_probe(struct platform_device *pdev)
>         struct resource *r;
>         int ret, irq;
>
> -       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0)
>                 return irq;
> @@ -685,14 +684,14 @@ static int pxamci_probe(struct platform_device *pdev)
>         }
>
>         spin_lock_init(&host->lock);
> -       host->res = r;
>         host->imask = MMC_I_MASK_ALL;
>
> -       host->base = devm_ioremap_resource(dev, r);
> +       host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
>         if (IS_ERR(host->base)) {
>                 ret = PTR_ERR(host->base);
>                 goto out;
>         }
> +       host->res = r;
>
>         /*
>          * Ensure that the host controller is shut down, and setup
> --
> 2.39.0
>
