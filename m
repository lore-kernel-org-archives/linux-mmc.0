Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F87C433ED
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47DCB6102A
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhDLHxU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbhDLHxU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Apr 2021 03:53:20 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C18C06138C
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:53:02 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id x4so2669374vkx.5
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEjRzkzGszkYylJXGDtV4r/en+SeT+2kj3aD/Vvt87Y=;
        b=CUEMvkxetbGEQU9YJ9loBMwHEplKBnPwR1VieT4vaAw1qKyLktzFCFCMkK/Uc9diNs
         1dgHEyfERVyD+HQld2b+Sd/W6/lLPjoopx3d1tMJemgCLGkdpZofVcIdP5e4lTM/nf+Z
         9FFmgy1EdcDEsFy2jqrS+CGhGcpu1mZZXxdwoQdjYICzJrZt9J3c7G4vl5efeNJo40rr
         U4HsDYoq9WlTppyDb2Cqb2u9GG0Ma0fsC82z6AvIHTpj3rg8L2px5wDWDk2yBOr//I71
         En3TnWmbK1CAkJtwDpM58/5BkuO7Hk9NkuUw2AOab5ycYWcMYZEVECIslmN1NiFcj5EB
         oxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEjRzkzGszkYylJXGDtV4r/en+SeT+2kj3aD/Vvt87Y=;
        b=N6fRdQtU8v0YqAUhOx8XKVP400WSIXLPAL8kHtIttAZVq8EkvhHQ7sqEwUQ9L/88Nl
         g3GlKpSq22YbH1CD0o9j9RJ3mRrrSKCgN0Vqq1FA2EzwozvEW0OW+5qjCnw6amhRnn3V
         lB4b8EESGNhTbei+qdgDQpddOqYPt+WEKPa3xqLDUIxAKecMKbSqqaPD40Mc4ZRtSwXw
         cf3xVT0xXDpBH+9ELkBeivYAxnR8KY3Dcv6AQc6wyelV7i5DpaXMvPibg9iCpPA0OfoO
         izhFEJy40Y4vRU1Iee+zklOLNfVu3Yf7v+Go0U21E3e5FEqzlyPrS+QPksqTxAfBCnYN
         u6BQ==
X-Gm-Message-State: AOAM533QwLaAukMvyGiv7NapN85aP176Ww6LLqSz/wvSRu2R/Y0I0iDN
        tkpRZexSOnoxp2bJ0F1x2VyXSj4WTR33eWKM480QDQ==
X-Google-Smtp-Source: ABdhPJxD1X9uNNFdKbT8gzQZDyV3755/Viv3xdkUjBAOawlad9eLl4TedcVmmIFywBUo+oQvWWAMUod+Zec2zrL0gts=
X-Received: by 2002:a1f:2c58:: with SMTP id s85mr18470920vks.15.1618213981700;
 Mon, 12 Apr 2021 00:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210409023801.3326572-1-qiulaibin@huawei.com>
In-Reply-To: <20210409023801.3326572-1-qiulaibin@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Apr 2021 09:52:25 +0200
Message-ID: <CAPDyKFqbvZot3mFiManMaZtZw8Cuau-4ewOJSVBdR-MeZU-JwA@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci-st: Remove unnecessary error log
To:     Laibin Qiu <qiulaibin@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        patrice.chotard@foss.st.com, YueHaibing <yuehaibing@huawei.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 9 Apr 2021 at 04:28, Laibin Qiu <qiulaibin@huawei.com> wrote:
>
> devm_ioremap_resource() has recorded error log, so it's
> unnecessary to record log again.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-st.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index 78941ac3a1d6..d41582c21aa3 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -400,10 +400,8 @@ static int sdhci_st_probe(struct platform_device *pdev)
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>                                            "top-mmc-delay");
>         pdata->top_ioaddr = devm_ioremap_resource(&pdev->dev, res);
> -       if (IS_ERR(pdata->top_ioaddr)) {
> -               dev_warn(&pdev->dev, "FlashSS Top Dly registers not available");
> +       if (IS_ERR(pdata->top_ioaddr))
>                 pdata->top_ioaddr = NULL;
> -       }
>
>         pltfm_host->clk = clk;
>         pdata->icnclk = icnclk;
> --
> 2.25.1
>
