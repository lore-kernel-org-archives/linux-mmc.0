Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4CFC6FD1C
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Mar 2023 12:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjCWMOP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Mar 2023 08:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCWMNz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2023 08:13:55 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB2525E3A
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:43 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i6so24503351ybu.8
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ALFwvw50Oz+gjNGnlwxKeh+PF+7RPaNRR5vajpRayGA=;
        b=lQ/Luegj+SIyFETuhC0mhnn/jgRkpkvEHiFYjAEuHWuSSJvn2FRgMIudLEGhPQ+g/s
         qCKvIlkMea84aQzG0fNMn8cOfnzszxdcUzewbspuhaz6mEjeeqOY3FR+56+A9gnYRUc8
         XjTh07K5Mrn8OoUOHcCvzjCC1dzHqxECkNZgUDCDqhh15BkUpyWE6z0YOYxzKa3/DogH
         VOW6iLubS/7upy1Oik8vyhWoBsKwstOofF8l5P4Vl6lVuS6JHWTQOhv06QSgOyVoRNH1
         pKJCUItaEvXrsdV0G3mZJ6IAojR3EcC/oznO/s8MXymCml5E4k60REnqcaVX0t7jx7fa
         t6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALFwvw50Oz+gjNGnlwxKeh+PF+7RPaNRR5vajpRayGA=;
        b=mSgrcdUwWy23OJid3Gi0PoTmZstxnNIum/CByhpaw1aI5Na7Aus8Smp5oH5P6rKG5D
         Yp5nFjszHmLZKLtLcCba6gsmNNYXq+KPuoil800SGLGfxrYWjWc78VOspRgkktlTvt4J
         bgGxrEOD8iVc9Xg2sAejMsUeU8hEvmI6BQMYBcqp7ORKni3uSxNVs1yIzk1MqQPhrBsA
         tCY6LO+5+lVsO92nGxGJSWhDhtU9bD07pVMer60oBFFtjvRPnA1hKlbZih/MABHgen7G
         Eswxux5vUq24XXJGgRYlVmTmp9I06g0clKfvXvsXLKEJnuSLa0gGti8M5Uv3HgGMPUBM
         AV9g==
X-Gm-Message-State: AAQBX9co0PgQ4A9TZffYGuEFdIjqAYHY5pGq3JxUmau56lQ76VSFdxTI
        MkyUVqxSusEYv7QjUueWQ0PQ8buxbzB6v044lwkzfQ==
X-Google-Smtp-Source: AKy350ZmPZ6Bgl/nzWsMVVusfpOpXKH6gyaGevVQV5K60RTELmGqzP67HWjeBShZfhob5GCO1QOIGHoIxVmw/d31b5I=
X-Received: by 2002:a05:6902:1203:b0:b71:f49f:8d22 with SMTP id
 s3-20020a056902120300b00b71f49f8d22mr1977317ybu.3.1679573622701; Thu, 23 Mar
 2023 05:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230315053434.38316-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230315053434.38316-1-yang.lee@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:13:07 +0100
Message-ID: <CAPDyKFrmrHa7vRAVak7PcxFUPn2TN1n6+s7NQDCNHBwi6_m4KA@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: omap: Use devm_platform_get_and_ioremap_resource()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Mar 2023 at 06:34, Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 57d39283924d..ce78edfb402b 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -1345,8 +1345,7 @@ static int mmc_omap_probe(struct platform_device *pdev)
>         if (irq < 0)
>                 return -ENXIO;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       host->virt_base = devm_ioremap_resource(&pdev->dev, res);
> +       host->virt_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>         if (IS_ERR(host->virt_base))
>                 return PTR_ERR(host->virt_base);
>
> --
> 2.20.1.7.g153144c
>
