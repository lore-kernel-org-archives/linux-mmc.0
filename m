Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0584AC433E2
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 09:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08FC20709
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 09:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQ+kQwXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgIBJEE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgIBJDy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2020 05:03:54 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC350C061244
        for <linux-mmc@vger.kernel.org>; Wed,  2 Sep 2020 02:03:53 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id r13so1333864uah.10
        for <linux-mmc@vger.kernel.org>; Wed, 02 Sep 2020 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJzUeSF+5rfhIEqW5Y3fudwXDrc2+BNzuQkwiBNzFL4=;
        b=WQ+kQwXpmiMbmM++3SGStKdu8DfotRMOpqrwA5q4bHtdJy9QMoEuJc5j/DKPN9esfh
         TQnNtWcPdvtjlOGXk6lMbGAWO97Q/B3oTIbShRS2KU7mN9bF8pwNxjqtEEOpNgKeeSoF
         5vPV4E1GH8dyf6dZN4nLeM4NYT2aVDd9zvoKiIUgsLohC+8JbQ22SJbx9wnjSbkj7xL8
         JsM/O3Q//97AjUOmNmXAzlIbuCSjbi/qQVWHYr3mood8wfSt8Zo60+0PYH3nWBUC9yct
         FTmh/ZE20RiJD40hlQlzblmlJbQWUdiyrAwwuV/0mkrVPnqhO7ph2zS10dQORe/iAwGQ
         yyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJzUeSF+5rfhIEqW5Y3fudwXDrc2+BNzuQkwiBNzFL4=;
        b=TQzCgYNVPTvzPiZs48WoRjRP+utVS3TsqGPlozK1TVwJrT1wXhmbKHOA5jbzOIk/4+
         Bu2c8hn9NckgibCbaxmyWaHNtmEEyBRhoe9xsFfcQPRjObHFN4wrtIYvQ1nxxQrpv4fq
         DEtZRB5ckPoFqyvosMdkVPAR8IqhQjWcoodBOs/oX7DXxqipwdBD3KlWRRAKtc+Ny9U/
         BVEbRkAd/nnPoy5vO7QvPAvKgmz3x+JrYx1LlBeJrFWq6EVFgzUTncUBauVhcSP/zqa9
         8I+SeiABKmwfzUSuP5DrEDenb+IVFPO7Zci/KIalqPbNhY8Qg5CXPMrwsgzU91sOLfMr
         5lcw==
X-Gm-Message-State: AOAM530+cBHn8Y5a+vVg3uyhe6zvsRdY7ijk0fvPAA/je51QGRZZi0fO
        fTtccbdjrqzykTVYt9vgIB1sO6mmtE046n2GB+ku7w==
X-Google-Smtp-Source: ABdhPJyhJYTVm/R+GBYtGPEgC6V5+EOBdX93qBkeA616egxMMvQgh3s57gjKKHh0bsOtxZckjPPEU7gVSF32drfco5E=
X-Received: by 2002:ab0:2848:: with SMTP id c8mr4291207uaq.15.1599037433179;
 Wed, 02 Sep 2020 02:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200831102324.12566-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200831102324.12566-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 11:03:16 +0200
Message-ID: <CAPDyKFpmfjuGcLTxCDdCvp5j_yaJzySENBEcgC_w1tvkK1Gz4g@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: use wrapper to avoid accessing internal vars
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 31 Aug 2020 at 12:23, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


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
>         val |= ADJUST_ADJ_EN;
>         writel(val, host->regs + host->data->adjust);
>
> -       if (mmc->doing_retune)
> +       if (mmc_doing_retune(mmc))
>                 dly = FIELD_GET(ADJUST_ADJ_DELAY_MASK, val) + 1;
>         else
>                 dly = 0;
> --
> 2.20.1
>
