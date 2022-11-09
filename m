Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B5AC4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Nov 2022 12:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKIMfF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 07:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiKIMfE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 07:35:04 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE92B175B8
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 04:35:00 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso3651603pjn.0
        for <linux-mmc@vger.kernel.org>; Wed, 09 Nov 2022 04:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J+VVT+VZ5tB8LbvzqUOspyGnKu6apApc/p5DRNAwVag=;
        b=NxdQSEF8CvIZKuxcpZj+IRKRLwAAB4KqELxfYFTZJBYk8skLBiL5ggjyzeTSj+sKqV
         tiD9ga1cuf4C9I/ZL8/1EnvAGZA9xYMY3+2ApwVHRzFOXPmim9S02eJb77AXQtMV+MoD
         ZgLYI/miqSaIO6PNH1FQzQkSVv7wxorXom+xL/bQ18m2H9VC1/bTrRDUTgGimgCUK+7Y
         oTz3SDi5UaqpfN/oMLFYhLYAHls9Grwie8jpyYPrIbNIR/LEr37N3Il5GGkVd4SoScmx
         SYNaXdCUivsJ0s0np5nTjXolzJP/ttDPsvmlu+nWSIiQz6Zd8bmrB6E++zwBoaHvxcjk
         QjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+VVT+VZ5tB8LbvzqUOspyGnKu6apApc/p5DRNAwVag=;
        b=X93PyX9SbyJKiEs/MD9sYATnWE1q0UkGG4yqejNlKdWXRCaiPObumUlrgQyKuuqbZy
         T1ZisXBiNpERXpT1JK+e+hdKiv4JgYN6pwsaxiqzFY4cE4EKERbGu+limWZTTBhBe23h
         Cvlr4rpLAiEJmx3u/UC6euFB1os92kAB7Px1sn1vDRxsOrwUdcTfEjbayyXJVIS0Wkad
         dQ4x/XvKW5aEe+s7VWgjiq9i6YJvu1APNpouQ/qroSy+U3WktEpYaEs+GtTfZxirFoSl
         sUqrqvA0nVr9QAW0APXlrCjXRLE0CWgAVF3aZ1YG/8vU9yLwDUrzSwAn6MtH48Mg9AeJ
         f/DQ==
X-Gm-Message-State: ACrzQf0Mw0zUsI7vRwEjV0ttdUAR+a/FOxTSljCcuGCd2Kuun0n0SVvd
        YkGzIrHjpnPX+DPuev+e0lCwPcK11yIq0dgr+NJPlg==
X-Google-Smtp-Source: AMsMyM461RMVaPce/sghU2UJg9EnIvxKKF00CGE8IYeYy23QI0Zg1kLC7oC/A6wUyIRsRVKunFtnlzp3LNlnUNxIGUg=
X-Received: by 2002:a17:903:100c:b0:186:63a1:3b5d with SMTP id
 a12-20020a170903100c00b0018663a13b5dmr61929278plb.148.1667997300263; Wed, 09
 Nov 2022 04:35:00 -0800 (PST)
MIME-Version: 1.0
References: <20221108123417.479045-1-yangyingliang@huawei.com>
In-Reply-To: <20221108123417.479045-1-yangyingliang@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Nov 2022 13:34:23 +0100
Message-ID: <CAPDyKFq0RwWiH5uYqUZsjy89f89fMiFbcOhJ6L2V5zf6HYCR1Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: fix return value check of mmc_add_host()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Nov 2022 at 13:35, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> mmc_add_host() may return error, if we ignore its return value,
> it will lead two issues:
> 1. The memory that allocated in mmc_alloc_host() is leaked.
> 2. In the remove() path, mmc_remove_host() will be called to
>    delete device, but it's not added yet, it will lead a kernel
>    crash because of null-ptr-deref in device_del().
>
> Fix this by checking the return value and goto error path which
> will call mmc_free_host().
>
> Fixes: 51c5d8447bd7 ("MMC: meson: initial support for GX platforms")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index df05e60bed9a..6e5ea0213b47 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1335,7 +1335,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
>         }
>
>         mmc->ops = &meson_mmc_ops;
> -       mmc_add_host(mmc);
> +       ret = mmc_add_host(mmc);
> +       if (ret)
> +               goto err_free_irq;
>
>         return 0;
>
> --
> 2.25.1
>
