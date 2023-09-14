Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24A5CA553D
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Sep 2023 13:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbjINND3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Sep 2023 09:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238598AbjINND2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Sep 2023 09:03:28 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EEF1FD5
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 06:03:24 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59bdad64411so10539217b3.3
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694696603; x=1695301403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sih+Lp0+OIcaOowp2CPZDGuoLMawt2QTFidb3Rx2/a8=;
        b=ptKoNDxIXrpDt3ZFiT1Mc6z5ERNAEbiOtZ9oLKOIp7kyetwsKIq0gbgloIRP9o3S+C
         nHJMp8solny9P1baqn0fkrKsfx+5+mKXY5eco6Cr1+j54YaXYbWABsn8h7blBJvfZvKW
         zPLKPudOZIDxughgqInfi/OWEI2xNyOvwS+GnwpUmc+msVgwrQyPQHuLBOv6p807UZH0
         3KewhFLh6mg0PU2HaYdDoyefiBWjXLNnKr2ZciF9n6H2eAiwH+eSjHdhKZPmdOuf2FE8
         ndcIVlXpi3ju0ONgqDFUUQ5b2xIjjV+iAbZhYPtzL7fLyRapZD6OnNQHqrPGZSAoBWyI
         BHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694696603; x=1695301403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sih+Lp0+OIcaOowp2CPZDGuoLMawt2QTFidb3Rx2/a8=;
        b=h1xkVcE7cG8fzFBGvPYhxBDUD204Kl3Eej66NmsWyo86uHbm5750l0KDbGps8Cd3ha
         AVmunKGlExMhesGTCwNjQFDWpnjLGWH8ZXAuVE2GzeX7wOYYa+MERcbEqu3YKoobv2Kj
         t6L1zgu/bgcQ8BfbGCxnUO7rOOTlLRIlkZTLuNw/mJsnXZcVQh2G8y9IuRhveUca5XF5
         xqJ6jJFaIv9ziu37EahZjhgDQNnZUVDH4Ojws6wLyS3eldZeAzylOdD1lR97xrdTzCP1
         ezQzYMDt+EbW9YP4Yy2NQIF+Uc8rF+7LDYMfCfL2Yb6ZFVaxiFwCCchjI/U2peBmx/eR
         MFDA==
X-Gm-Message-State: AOJu0YxAsKnNu50tZf8FCbJPlD3H3HpEjY3kEvyEX1woxog6zfhit+/C
        K61ixGz8hc89PmPV45lArOQEc6NHH8wrRCFid1VbGw==
X-Google-Smtp-Source: AGHT+IFHR9S7W95gv7Y5JTdJBqtNa25F1bo5zllDbVUtxRROVgr0y66x0fdxDqHyKmHW/K4Y5tgggF5TIgpN20blvjc=
X-Received: by 2002:a25:42ca:0:b0:d72:80bc:d3b2 with SMTP id
 p193-20020a2542ca000000b00d7280bcd3b2mr5149440yba.32.1694696603267; Thu, 14
 Sep 2023 06:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230830093922.3095850-1-haibo.chen@nxp.com>
In-Reply-To: <20230830093922.3095850-1-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 15:02:47 +0200
Message-ID: <CAPDyKFpTP-r-eg2L1BoAG5ia2N2640VR2s2Vtbemyyu4MuKS=w@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: sdio: hold retuning if sdio in 1-bit mode
To:     haibo.chen@nxp.com
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-imx@nxp.com, hkallweit1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 30 Aug 2023 at 11:35, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> tuning only support in 4-bit mode or 8 bit mode, so in 1-bit mode,
> need to hold retuning.
>
> Find this issue when use manual tuning method on imx93. When system
> resume back, SDIO WIFI try to switch back to 4 bit mode, first will
> trigger retuning, and all tuning command failed.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for fixes and by adding a fixes tag (Fixes: dfa13ebbe334
("mmc: host: Add facility to support re-tuning")) and a stable tag,
thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sdio.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index f64b9ac76a5c..5914516df2f7 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -1089,8 +1089,14 @@ static int mmc_sdio_resume(struct mmc_host *host)
>                 }
>                 err = mmc_sdio_reinit_card(host);
>         } else if (mmc_card_wake_sdio_irq(host)) {
> -               /* We may have switched to 1-bit mode during suspend */
> +               /*
> +                * We may have switched to 1-bit mode during suspend,
> +                * need to hold retuning, because tuning only supprt
> +                * 4-bit mode or 8 bit mode.
> +                */
> +               mmc_retune_hold_now(host);
>                 err = sdio_enable_4bit_bus(host->card);
> +               mmc_retune_release(host);
>         }
>
>         if (err)
> --
> 2.34.1
>
