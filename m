Return-Path: <SRS0=/Wn+=DB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92ADC4363D
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 12:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E2020BED
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 12:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mH/Z53Qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgIXMui (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbgIXMuZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Sep 2020 08:50:25 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F23C0613CE
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 05:50:25 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id q124so860697vkb.8
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 05:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A50fDOOKNyv2Ev8Swfae1dGr9M1g0YMVi9mWla00hDU=;
        b=mH/Z53QrMi2Xxfu7rCBEG6DOGtq2gtzu9Xn0Hx+4OL9nQx6uwaYCgiHXjfYK90Ykg/
         J8YUH4CIMYujQkPNcAXlbaF/6+naibYcfpzjyElE48ZF6n+gxIXDZFi1wAyVKqWUOSKU
         4unnizW7zqZtWZYTZ4GQFi9ruDFR5SZ5el40dikPUlB3Vitq2o0Pc5E34itX8N0ozD12
         lCw+VSVaZEJ3bPzXofaU+a031VPfa6wE6OF2Id7qtCU0WuMmKO1QqkO/3lGg1Xhm+v3k
         vZip/y1gRqCA1T03Kz8DvJfIC+CbznA5s31kf9raarwVM4MPPRLGJzu7N8rnPDDJMOLN
         aJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A50fDOOKNyv2Ev8Swfae1dGr9M1g0YMVi9mWla00hDU=;
        b=fQBuFs+7w/7zDlf0qn11lD+7yK5Mq2qAQi+25LF2x9ZCySmbtUaFU2p7xsdRcpBd9t
         VJ8SeYP76ykv4nZsR1f9Br3r6MOAw/THI0MG5RnULSqjsoRMM+faK1PO65d0lNKQVRRI
         BopN6QZW1DKCCMm8wFcO5x0ZE6jxWfoJEPfqHCGt+JbGRed2CDzOcj+1vlEKpUf/aTWF
         dzDANNzo1kK3palCUyxYZ+anWw11Ki7q1GeNgKQcI3i9ZjFTJPqSXEoLG494KEflcWY/
         vj93RktZvEFubBqRa4tLzELF+ojqRllWRADe+74xDR7DZ+D5PMlIJcM8/i1qMtSdPrpP
         n1Dg==
X-Gm-Message-State: AOAM530xAlslPjLEbdyAuub3broD9g6svinwE2PMkCaeSlAlk+eypv9+
        EVBr3LZrDcI+My5c4tBkM9s5DGr5U4Demn2IEQuvtA==
X-Google-Smtp-Source: ABdhPJzBZQnxDcw00NSOe5PSltkjWOUHMAqt22WMd4hPdzgfhIVbjk6GXULijUmodg8Oj8sULI8TLw7M3coSTsqSS7E=
X-Received: by 2002:a1f:6ec4:: with SMTP id j187mr3431849vkc.15.1600951824397;
 Thu, 24 Sep 2020 05:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200922172253.4458-1-wsa@kernel.org>
In-Reply-To: <20200922172253.4458-1-wsa@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Sep 2020 14:49:45 +0200
Message-ID: <CAPDyKFpdvHt06awMy2FQzd2Lk81ZwsmW1AXVTdf2F7BX=iAfMA@mail.gmail.com>
Subject: Re: [PATCH RFT] mmc: renesas_sdhi: drop local flag for tuning
To:     Wolfram Sang <wsa@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 22 Sep 2020 at 19:23, Wolfram Sang <wsa@kernel.org> wrote:
>
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> The MMC core has now a generic check if some tuning is in progress. Its
> protected area is a bit larger than the custom one in this driver but we
> concluded that this works equally well for the intended case. So, drop
> the local flag and switch to the generic one.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> I had this patch applied while working on other SDHI topics and
> experienced no regressions. But I'd like to give Shimoda-san and the BSP
> team some time for testing. We agreed on the approach already.
>
>  drivers/mmc/host/renesas_sdhi.h      | 1 -
>  drivers/mmc/host/renesas_sdhi_core.c | 4 +---
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
> index 24958de274c1..cb962c7883dc 100644
> --- a/drivers/mmc/host/renesas_sdhi.h
> +++ b/drivers/mmc/host/renesas_sdhi.h
> @@ -63,7 +63,6 @@ struct renesas_sdhi {
>         u32 scc_tappos_hs400;
>         const u8 *adjust_hs400_calib_table;
>         bool needs_adjust_hs400;
> -       bool doing_tune;
>
>         /* Tuning values: 1 for success, 0 for failure */
>         DECLARE_BITMAP(taps, BITS_PER_LONG);
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index d621a4af8e87..20e5eb63caf8 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -581,7 +581,6 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
>         unsigned int taps_size = priv->tap_num * 2, min_tap_row;
>         unsigned long *bitmap;
>
> -       priv->doing_tune = false;
>         sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSREQ, 0);
>
>         /*
> @@ -656,7 +655,6 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                 return -EINVAL;
>         }
>
> -       priv->doing_tune = true;
>         bitmap_zero(priv->taps, priv->tap_num * 2);
>         bitmap_zero(priv->smpcmp, priv->tap_num * 2);
>
> @@ -765,7 +763,7 @@ static bool renesas_sdhi_check_scc_error(struct tmio_mmc_host *host)
>             !(host->mmc->ios.timing == MMC_TIMING_MMC_HS400 && !use_4tap))
>                 return false;
>
> -       if (mmc_doing_retune(host->mmc) || priv->doing_tune)
> +       if (mmc_doing_tune(host->mmc))
>                 return false;
>
>         if (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL) &
> --
> 2.20.1
>
