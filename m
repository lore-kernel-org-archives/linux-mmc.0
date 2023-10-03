Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F961E7544A
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Oct 2023 11:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbjJCLNY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Oct 2023 07:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239928AbjJCLNT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Oct 2023 07:13:19 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CC2FC
        for <linux-mmc@vger.kernel.org>; Tue,  3 Oct 2023 04:13:11 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d8164e661abso812802276.1
        for <linux-mmc@vger.kernel.org>; Tue, 03 Oct 2023 04:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696331590; x=1696936390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xMzuAMLC8oWHrefC2Cvtktz7gTrG3/X+VCGWjMzxEXs=;
        b=c/E8QEN/NoZ+SbV3q/ndWAX+h/+Sj3sJeK68SBG9eGANVyOlghb9MCI5v5RSJ2daFx
         sNKX4TJtUXjJxDoChcXEiVPJQCsQUjS6BOMeL+MTTM1XFnS136JXHRVFw2uGifZBNYOV
         9xbfpzW01YJTREEjLMiFmTrpDklkGV6bOi9QWHcGdWwji9nCP5lLPb43NIASc/i7b6WA
         5ExMVW1QatQxoJhpigDb9UBRKUgTaLo5/Sz5tWvxUKRmFI43c2KFk65uCLsAcjvveT2A
         XUXb2clHb0uO9eX1UQmPanoVwOyjtG8qVeX0zWfc9kH8w1+Edd1Eabg5cO7yquyGBj/P
         RGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696331590; x=1696936390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMzuAMLC8oWHrefC2Cvtktz7gTrG3/X+VCGWjMzxEXs=;
        b=r2x8v+mvE5A4bU0x6KssBJek4NuMLAsh77YYE3sOpoeYtvk3EDdu8T+P0PZCmE+sDh
         LaYenflFkD/PEeNQR2i7T6oKzLazOI2VTnxR167P1u1mKJ62hOf/AFJMSXPrrS1l42N9
         vqYfTCpzlRfBgljeKV/eyeg5uMr6oOQiG1hV+WH46uWf50nSY1CO5I/ozFHutbDbhw4s
         thKyn0O0zj1svvgclvvKLR+xTEDW2Hy79tf+QynXV2xzaQsS7s9W3uU0hyzqtu7O3Szu
         UtXHLHygJG+JAn72P5RhAapOM77QPMg1Qi9mt+8zVlcuCmLAwlGccOz0zUita/uQbMQw
         86Ww==
X-Gm-Message-State: AOJu0Yxv6Br5udGKFYWFcUkzlUGU6q8Gydqivf6E16dZD9wv9zsIsEEj
        Y/MCvI8ktq8h1KpXhOrMarYRkPS8JdaBr/5HXzGUGA==
X-Google-Smtp-Source: AGHT+IG/CW1SUwPYpkSqEtrqM5VVydbWqWOLLufX/qlAlZ9PiUj8iLVWSpIrGDx7A/McbCUwf/mo0BZopftgLh+iXwM=
X-Received: by 2002:a25:9f85:0:b0:d4a:4b59:367e with SMTP id
 u5-20020a259f85000000b00d4a4b59367emr12576425ybq.38.1696331590107; Tue, 03
 Oct 2023 04:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com> <20230915094351.11120-17-victorshihgli@gmail.com>
In-Reply-To: <20230915094351.11120-17-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Oct 2023 13:12:33 +0200
Message-ID: <CAPDyKFoeBgoEyCg8GmZB718g1dg8dqi_kdLr-jLqWdEE5q4Oyg@mail.gmail.com>
Subject: Re: [PATCH V12 16/23] mmc: sdhci-uhs2: add clock operations
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> This is a sdhci version of mmc's uhs2_[enable|disable]_clk operations.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

The similar comments as posted for patch 15 applies to $subject patch
too. Please have a look at those and fix these for the $subject patch
too.

> ---
>
> Updates in V8:
>  - Remove unnecessary include file.
>  - read_poll_timeout() to instead of read_poll_timeout_atomic()
>    in sdhci_uhs2_enable_clk().
>  - Put the comment on the end and put the lines in descending
>    line length in sdhci_uhs2_enable_clk().
>  - Modify return value in sdhci_uhs2_enable_clk().
>
> Updates in V6:
>  - Remove unnecessary functions.
>
> ---
>
>  drivers/mmc/host/sdhci-uhs2.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 4c2a56629ab3..af1b0c5e48fd 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -329,6 +329,36 @@ static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         return 0;
>  }
>
> +static int sdhci_uhs2_disable_clk(struct mmc_host *mmc)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +       clk &= ~SDHCI_CLOCK_CARD_EN;
> +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +       return 0;
> +}
> +
> +static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       int timeout_us = 20000; /* 20ms */
> +       u32 val;
> +
> +       clk |= SDHCI_CLOCK_CARD_EN;
> +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +       if (read_poll_timeout(sdhci_readw, val, (val & SDHCI_CLOCK_INT_STABLE),
> +                             10, timeout_us, true, host, SDHCI_CLOCK_CONTROL)) {
> +               pr_err("%s: Internal clock never stabilised.\n", mmc_hostname(host->mmc));
> +               sdhci_dumpregs(host);
> +               return -EIO;
> +       }
> +       return 0;
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *

Kind regards
Uffe
