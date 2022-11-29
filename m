Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A159C46467
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Nov 2022 12:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiK2MzF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiK2MzA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2022 07:55:00 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D1B60EB8
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 04:54:58 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so17228267pjs.4
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 04:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KW4ffafdWRk2eNo+Vd9LUA4QY8ptBxsRJc+ciuZDU9I=;
        b=tDGzByIuBQCRqwpzV5s6jlm7LDDXK0ketuCf0pZm4OO+51o7QQyIO7sj2hUwzlkj3l
         vczBgP5r10LmqxWlRrQ0MHe7ogItlJ6BvApLdFkLfSYtFGTFpabrTdyG5qPEI49ZJ3rm
         Quio1niAnlGO1DlmrJi7vKOuCGmslB5hmOCwJt2JxuZrX1JNSEqlLQF5gdhAEm52p1DF
         FE4Rle36KT05z1CsA11u/4IpLYZ2MpxiLZt1khaasKo79rigGinoJU4uv/M0lw/nEedd
         9CrOk/PTxzjiL4JoXgbbEvTxI/4+QpkY+6Zs7SPIAbiEDR5lNbQPAsI6Nhk9BqW8pui6
         5yJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KW4ffafdWRk2eNo+Vd9LUA4QY8ptBxsRJc+ciuZDU9I=;
        b=RSq6O2wC00IKqU5p66zJCKXm6PEzXNnmP5V9UAMeodMIAVjQcXihNIN37oSUNaDT4I
         2qT7qj9MnJAoY/oCZ2V0YBbtS9aP2RsrntoK87G3+r4VKZ8jboBVmR0qZRthWLcsVbuy
         R9cRGNTACD3e4cRK7ksm0cAjngDHoMzefH4kHFfIylm1kRTA+VIBsenLFiD0xi+D1gXs
         9JfXpa7lzPwCFRJdb0T5F/jd0Ra2jIREnTPwOmV3Su4CKmyYGJodrPUG2k03CL0IhqIz
         CwkIEiST2VUkf2LcQgWQ72xLd+xKRv8pIWzr6Uwfiu8m+5xEsmSB0130SE/P2aQtti07
         /Heg==
X-Gm-Message-State: ANoB5pnwqZTf6rm7ETzoXP7v+0cN2s72RZZlMwqcHhYbI1BQfBH5GmIa
        B8I9iMSt2/WgHAtFH+VJhqTbwVYavsoYtXDgId4uJQ==
X-Google-Smtp-Source: AA0mqf53Fm1c+97bVkY2sGQYz3i1enF9huifz1wXhNyEGCzHavvLEGw2/5bwEZZ3PmacbOA5xVDS8MybnLyZXAom6V0=
X-Received: by 2002:a17:902:a503:b0:188:6baf:2011 with SMTP id
 s3-20020a170902a50300b001886baf2011mr35441978plq.165.1669726498347; Tue, 29
 Nov 2022 04:54:58 -0800 (PST)
MIME-Version: 1.0
References: <20221125090141.3626747-1-cuigaosheng1@huawei.com>
In-Reply-To: <20221125090141.3626747-1-cuigaosheng1@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Nov 2022 13:54:22 +0100
Message-ID: <CAPDyKFqZOMO2vA7cr89LBqfzRT==LmU4yZnAkfHub5sZWMmx9g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: Fix missing clk_disable_unprepare in msdc_of_clock_parse()
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     chaotian.jing@mediatek.com, matthias.bgg@gmail.com,
        drinkcat@chromium.org, wenbin.mei@mediatek.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 25 Nov 2022 at 10:01, Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>
> The clk_disable_unprepare() should be called in the error handling
> of devm_clk_bulk_get_optional, fix it by replacing devm_clk_get_optional
> and clk_prepare_enable by devm_clk_get_optional_enabled.
>
> Fixes: f5eccd94b63f ("mmc: mediatek: Add subsys clock control for MT8192 msdc")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 0f06cc5fec86..abadfc319053 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2605,13 +2605,11 @@ static int msdc_of_clock_parse(struct platform_device *pdev,
>                         return PTR_ERR(host->src_clk_cg);
>         }
>
> -       host->sys_clk_cg = devm_clk_get_optional(&pdev->dev, "sys_cg");
> +       /* If present, always enable for this clock gate */
> +       host->sys_clk_cg = devm_clk_get_optional_enabled(&pdev->dev, "sys_cg");
>         if (IS_ERR(host->sys_clk_cg))
>                 host->sys_clk_cg = NULL;
>
> -       /* If present, always enable for this clock gate */
> -       clk_prepare_enable(host->sys_clk_cg);
> -
>         host->bulk_clks[0].id = "pclk_cg";
>         host->bulk_clks[1].id = "axi_cg";
>         host->bulk_clks[2].id = "ahb_cg";
> --
> 2.25.1
>
