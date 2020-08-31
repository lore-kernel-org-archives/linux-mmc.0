Return-Path: <SRS0=ypud=CJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357C9C433E6
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 18:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A2C2071B
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 18:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="T2KW9+cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHaSfp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgHaSfp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Aug 2020 14:35:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35BFC061575
        for <linux-mmc@vger.kernel.org>; Mon, 31 Aug 2020 11:35:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id c15so3508411plq.4
        for <linux-mmc@vger.kernel.org>; Mon, 31 Aug 2020 11:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=PaGS2uzZD7Kro0ekXrFmFn9ksemHuyaMEDFaP9+HbTs=;
        b=T2KW9+cbq+bqJgzBohyRO9AXZ3t79XlryYl2YWgCmE3YqwFUr81ry3FUWcjyJVBn2p
         xjUiO7MYKO0Tw2gcFcTizQ+dODXK/SBA/KJoFX14hCv9TfWUpeCFG8aMapGwzAQzQ/jC
         CUxdbq35dkUogDSODZNByRWqf3iSNZL4s+x/7gdWYV4MO23W0Bqllva69SV6xWeoO1bW
         AoeECFKdDvFuMr1sobC9HzMtIWYkGrNGudHSNN/e/cXOkz5RJ9ypvz5zfeEc8uX6cXfH
         xf1+FbWEUCOlvRUfKptkUNx4keIbYJlo65lPoprmtXsrrdyMhf91Dq6Q82Mp3bsvfIsM
         8WaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PaGS2uzZD7Kro0ekXrFmFn9ksemHuyaMEDFaP9+HbTs=;
        b=ABQLhpR6SPNckANNig2zWNAjjFeBy8j8dWn1SJvkqXwseSJmO1SkHk56N5KgtxWT4d
         cImmbiV5c+nM2bijS00vi3eTqWJU0uGpMi2tejcOeZnk0rZVeZ6JU41sZujzmfJSLHNp
         ZqTyT/ewZZm+5OwEUpXWvzM70lzqNyxCMRGQWsyPkrBLi74RsXL81eW5cgJdYiB2t3kH
         qQV6Jv4lCuEI0QIGkcoeCrZszfsDRTUZApfEQvvMYDuLLG2kzR43xAjANiPPrxHWkAIx
         ZFMCQvhKZuByU90NKxs1URUUxlLBHXth6YoGwv3Rn938cXLMhAqRODGrmdS2XzfrVja9
         JHeA==
X-Gm-Message-State: AOAM532/yzXF0OkPhS0zK599CO0yv3LLo8UtkV3Dv4VY7JLedYNehu1Z
        8SYUIiIb9b3ExbygNPz59AEIxw==
X-Google-Smtp-Source: ABdhPJxl7Hyfd0zkkHCY81kxkFxx+yC3S6h+KZ79YUwFh9A3MjdXBXFG/oy7hPyTVIgBJNx4CMvGKw==
X-Received: by 2002:a17:90a:764d:: with SMTP id s13mr611974pjl.58.1598898944292;
        Mon, 31 Aug 2020 11:35:44 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id y1sm8088311pgr.3.2020.08.31.11.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 11:35:43 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: meson-gx: use wrapper to avoid accessing internal vars
In-Reply-To: <20200831102324.12566-1-wsa+renesas@sang-engineering.com>
References: <20200831102324.12566-1-wsa+renesas@sang-engineering.com>
Date:   Mon, 31 Aug 2020 11:35:43 -0700
Message-ID: <7hv9gy7jeo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Wolfram Sang <wsa+renesas@sang-engineering.com> writes:

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

> ---
>
> Only buildtested. Found while analyzing retune-handling in the core.
>
>  drivers/mmc/host/meson-gx-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 08a3b1c05acb..a1db8685e30e 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -521,7 +521,7 @@ static int meson_mmc_resampling_tuning(struct mmc_host *mmc, u32 opcode)
>  	val |= ADJUST_ADJ_EN;
>  	writel(val, host->regs + host->data->adjust);
>  
> -	if (mmc->doing_retune)
> +	if (mmc_doing_retune(mmc))
>  		dly = FIELD_GET(ADJUST_ADJ_DELAY_MASK, val) + 1;
>  	else
>  		dly = 0;
> -- 
> 2.20.1
