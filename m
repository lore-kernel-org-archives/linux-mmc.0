Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4ECC001DB
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Aug 2023 17:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjHHRXL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbjHHRWm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2023 13:22:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988ED7D79D
        for <linux-mmc@vger.kernel.org>; Tue,  8 Aug 2023 09:09:26 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8b2b60731so36657465ad.2
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2023 09:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510931; x=1692115731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oNRskDWNtzJ9riu+LqE4hawWFxgvxlfhvEU+bBPnE3U=;
        b=g2CN5QS8wmfRlotD5QGqa0uJtBTokHzppBApN0hjlnEVWfy6puYMkeNpzplEXODqev
         tYSYrft4GadSUIBsFPPBv2zN5anlVFsUyjiTLD9cR32QOwV3d9PsqIf8CA+OLg1z1ZOG
         +o/DO8hQmM+bWhjZNzIz0sCfeU85YlP1BVcrDsYuom7t1EMWQyNlg8HB89XyqyL+u6H3
         caEDXpge09T7Mpo6d+hytnQJSlV0ITtVAAjTPgsKfhAccfbx79S+dBVsSo7HHOMMcx/4
         c27XcRMtx6rEbk48xUmWpZONltnCt+J0qEmwi3Ahj6QcbQnp52QgxT6ZKvqqa1T9B90k
         AAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510931; x=1692115731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNRskDWNtzJ9riu+LqE4hawWFxgvxlfhvEU+bBPnE3U=;
        b=MWvyPgFq11QIYM/ey5ZN9icpatMEnAEXNPoBAvQz2eldledLj4pasaVA0PWDbxP8hI
         1LiiheUIwu5dGva9o5HJtGIUzf85uDaEkbrzff7f3SuQs9y4ILMQ3d3kZkpPA3iARBkI
         BNN30SPYzQbKQsevtjBbujPoACuw4UqMYCvy0c3bLMUNR9qQSLwRfo/JuD+BNlei7GQG
         RFMLGJXm0W4NcgZ0p0co+qO+5FEQCLPGb0ZIZJCr09ZnlFosERtbt1C8mzKVxPdNUfSe
         2GyQ9zbYSMgSEYo66gMchGpbWurr0itpD53FTo1O6rqEJaX22VGA1nmoQJyV5aobeN9B
         Qzrg==
X-Gm-Message-State: AOJu0YxQ5E+FhbKfQX8zFtEEyTEkag3vb5msQGQ8eJ31fYLzdp1qns3a
        vhmGoSItzI1q+qqthhl5465oBkhAKtw01GkMQIMXlmLG1m5ghFS7
X-Google-Smtp-Source: AGHT+IHU9fAptYlrSkOa3qBmLHq+GizuSj9Jk3kVA843SDvn6b5XNWmECJby4tbZhE+kZPR+LHE2ALxJabDwRCLkLRw=
X-Received: by 2002:a81:920f:0:b0:581:8d25:ff85 with SMTP id
 j15-20020a81920f000000b005818d25ff85mr11361358ywg.3.1691491998598; Tue, 08
 Aug 2023 03:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230802094028.976612-1-lizetao1@huawei.com>
In-Reply-To: <20230802094028.976612-1-lizetao1@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 12:52:42 +0200
Message-ID: <CAPDyKFrWX+=uCCPVYOx-AbthMyRvCLjpgnfY7+0EGH8Ts63ogw@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci-st: Use devm_platform_ioremap_resource_byname()
To:     Li Zetao <lizetao1@huawei.com>
Cc:     patrice.chotard@foss.st.com, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Aug 2023 at 11:41, Li Zetao <lizetao1@huawei.com> wrote:
>
> Convert platform_get_resource_byname() + devm_ioremap_resource() to a
> single call to devm_platform_ioremap_resource_byname(), as this is
> exactly what this function does.
>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-st.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index 6415916fbd91..97f350953c4b 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -348,7 +348,6 @@ static int sdhci_st_probe(struct platform_device *pdev)
>         struct clk *clk, *icnclk;
>         int ret = 0;
>         u16 host_version;
> -       struct resource *res;
>         struct reset_control *rstc;
>
>         clk =  devm_clk_get(&pdev->dev, "mmc");
> @@ -397,9 +396,7 @@ static int sdhci_st_probe(struct platform_device *pdev)
>         }
>
>         /* Configure the FlashSS Top registers for setting eMMC TX/RX delay */
> -       res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> -                                          "top-mmc-delay");
> -       pdata->top_ioaddr = devm_ioremap_resource(&pdev->dev, res);
> +       pdata->top_ioaddr = devm_platform_ioremap_resource_byname(pdev, "top-mmc-delay");
>         if (IS_ERR(pdata->top_ioaddr))
>                 pdata->top_ioaddr = NULL;
>
> --
> 2.34.1
>
