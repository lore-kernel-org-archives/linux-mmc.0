Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AA1C636D4
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Feb 2023 10:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjBQK46 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Feb 2023 05:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjBQK45 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2023 05:56:57 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A8A62413
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 02:56:56 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f7so350493pgu.2
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 02:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676631415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=szUhwp36rcjb9tm6Fq6IRBOldXj/Qr9+MV3mTH4JZqc=;
        b=Sl/gWwXYliiGzO1kxdx4PEwWlOhqHX2W21cS5077geTdVD28AFldoZT39SLz+XS03r
         Si5wG9hNaGdAQtfHmMoqEcQXSXFB6qjkweOY7lGiItuM0iURGyua2F7i0iXoa6SGj6lB
         amqHIAbEdliUgxwDFB3YipJlwWI+9JmjoQ5PZ+aCokky4Neh9fOC6lGt5NtxMfrBXktr
         Edtt/PC2kbU9tQvdODI0fIFa7FTBDCE60kBB+sYgtGgigQYfYCFn9sn13Xm3XJZSEysA
         MEVuw3DORANo/FGKKuWTsnx3sX3Olyzp7kb24TF9EDqA37kDWqijMmNK0VlIpBI6KsM8
         noiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676631415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szUhwp36rcjb9tm6Fq6IRBOldXj/Qr9+MV3mTH4JZqc=;
        b=QfEjJHsqzAhVX3FVr4hEQKLxfKArrGAaChoApGtL0dQRvtINOuvDeOOYo0bI7BkHLn
         NJEOV87UBCuPPmidhU3WcjOW+H+HNeoHUCJ2P0jjC1fre6Wa3UqhUa8WLGmbZWsOp24d
         yE70+7q/9kpOXkNDdkialW3ggKlE5HolCJjl4dBJZEXf3OHToUgbitFlV85FuR8xMzHN
         8nvSECU9nd6oYkotmVxgv7l6H6c7vHbXRVsqZ9U+eQv7/phLPGb4hFNgyU4JlKo8JENv
         JN6aOqxf0SET7Y5EDyWitmBmWmwWJ/Yc/1pVzu+QwTpprVWXxZ26MzcG8sI/mugLyeF3
         cqug==
X-Gm-Message-State: AO0yUKVr+wDYPS+ZRyyOCskwcHaKNyMQ2OL0QUVQrwchP6zLYMupH4gY
        MvkDj01BuSTNTqgcSNCmM6cKR7aR3RrD9g/ZEOgz/A==
X-Google-Smtp-Source: AK7set9nL74tFK1Sxv7hRt+wGq8ZRPEIHYTChESsds6ZxneeX3u1CkXORrg6bZkJ+nCm/EYFXia/2yuxMofU5j4BVYI=
X-Received: by 2002:aa7:95a9:0:b0:5a8:ba5b:575 with SMTP id
 a9-20020aa795a9000000b005a8ba5b0575mr1435521pfk.40.1676631415538; Fri, 17 Feb
 2023 02:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20230217083005.128668-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230217083005.128668-1-yang.lee@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Feb 2023 11:56:18 +0100
Message-ID: <CAPDyKFoUJ-j9NocWTiTVHSRBQ1YAtM2TH1SrCHByh911Jaa1UA@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: meson-gx: Use devm_platform_get_and_ioremap_resource()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 17 Feb 2023 at 09:30, Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 079c52dbeca6..a5a9a19a9a42 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1204,8 +1204,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>         if (ret)
>                 return dev_err_probe(&pdev->dev, ret, "device reset failed\n");
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       host->regs = devm_ioremap_resource(&pdev->dev, res);
> +       host->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>         if (IS_ERR(host->regs))
>                 return PTR_ERR(host->regs);
>
> --
> 2.20.1.7.g153144c
>
