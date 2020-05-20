Return-Path: <SRS0=coTY=7C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA58BC433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 11:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A332620671
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 11:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Du9Tc0gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgETLfz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 May 2020 07:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgETLfy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 May 2020 07:35:54 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E74DC05BD43
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2020 04:35:54 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id 134so679399vky.2
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2020 04:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+aE0A0M5Qg9SXZIcPPNRj5FWijxTBxGrBtlS/gFGoT8=;
        b=Du9Tc0gw3O1YUeg9tnkrby1f5eTFb+hNUB1RByKvkiome1cXOHOM5qzZUryjXpVUxa
         6kpvbc+O0h1MXl3xvOFaIZ7+iH42J9cU6mkwiso8AFh4SSuHKqYxAimOu9DlrSZwSg6H
         KppqevnNhBUBMW50+4GkcKSFwyzQ38Dp8ADdAUcyo//bO3IMnOt+5hpCm7+nlZSfw8aV
         t845chc788hXfV4rKOznpkRia59Cc5nwXCd4Sn3UGVqZ2tD2pvcHYfMyRzJNYtbrF9v6
         JmG7b3BuxQIVjXjqFYDOCMOuC/zL0uPvAFRS/IVMX9kCqT1alr/+zylPG6wZV/m1fHk5
         +6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+aE0A0M5Qg9SXZIcPPNRj5FWijxTBxGrBtlS/gFGoT8=;
        b=f1Gp3GljQ0q9/g4xplz4G6QxRf/gbVlNjw+uFvPHmeQNXseEmTtNHjmw+bjTuedinN
         2hmj9+iFBpHBw1TTfsN3KT6NbIVOZLyNgRTJZ9AzA5hIbG7q8j9lIGVKdZkrrkkEIckN
         BI1/gzMa2OC+L1aWzu2k5Od1DspswOzUHM4IwxebXIZCOqAVGb4CQ0DE70yC40Ey3VM8
         2lt8QpS0GHPilGOxxJWOrJ7HQ15vh9b7EDbY/KlwckIWptlruCkApASPSP9sa+ykKtNS
         EKiSj4kCqGq5P6p0zaU4YwCok0IotRPes0c1CpZdTI9OypsGv+TtmRRAOTn+UCL20o5Q
         SRIQ==
X-Gm-Message-State: AOAM531ivZ0dgsPqO4eI07C09gReRnVVh+0isrzCO4VIZ8jMwECaMu2m
        fxSf7QP/13qUEDb0aKL0+JoGgFqx6+eToFyqC9jxng==
X-Google-Smtp-Source: ABdhPJypO0qOnBkxx9iB9RyuzTNifOfMDcbFFlvy37TuGrWiaK0Fb8LAeMN0es2fOho+sfGVkw1OoCf49fFnDYoMWto=
X-Received: by 2002:ac5:cded:: with SMTP id v13mr3321768vkn.59.1589974553603;
 Wed, 20 May 2020 04:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200519164251.5430-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200519164251.5430-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 May 2020 13:35:17 +0200
Message-ID: <CAPDyKFq0TuCfnNE3i2reSzsO7=ex+2-JUDn1XEVxT52GMM3JLQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: renesas_sdhi: remove manual clk handling
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 19 May 2020 at 18:42, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> The SDHI driver en-/disabled its main clock on its own, e.g. during
> probe() and remove(). Now, we leave all handling to RPM.
>
> clk_summary before:
> sd0                   1        1        0    12480000          0     0  50000
>    sdif0              2        2        0    12480000          0     0  50000
>
> clk_summary after:
> sd0                   1        1        0    12480000          0     0  50000
>    sdif0              1        1        0    12480000          0     0  50000
>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Depends on mmc/next + "[PATCH 2/2] mmc: tmio: Make sure the PM domain is
> 'started' while probing" from Ulf
>
> Changes since v1:
>
> * reworded commit message
> * don't remove the en-/disable calls themselves but only the clk_* calls
>   to the main clock
>
>
>  drivers/mmc/host/renesas_sdhi_core.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index dcba9ad35dd1..15e21894bd44 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -83,16 +83,11 @@ static int renesas_sdhi_clk_enable(struct tmio_mmc_host *host)
>  {
>         struct mmc_host *mmc = host->mmc;
>         struct renesas_sdhi *priv = host_to_priv(host);
> -       int ret = clk_prepare_enable(priv->clk);
> -
> -       if (ret < 0)
> -               return ret;
> +       int ret;
>
>         ret = clk_prepare_enable(priv->clk_cd);
> -       if (ret < 0) {
> -               clk_disable_unprepare(priv->clk);
> +       if (ret < 0)
>                 return ret;
> -       }
>
>         /*
>          * The clock driver may not know what maximum frequency
> @@ -198,7 +193,6 @@ static void renesas_sdhi_clk_disable(struct tmio_mmc_host *host)
>  {
>         struct renesas_sdhi *priv = host_to_priv(host);
>
> -       clk_disable_unprepare(priv->clk);
>         clk_disable_unprepare(priv->clk_cd);
>  }
>
> --
> 2.20.1
>
