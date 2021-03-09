Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AE6C433DB
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 09:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB34C64F73
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 09:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhCIJDB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Mar 2021 04:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCIJCd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Mar 2021 04:02:33 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E67C06174A
        for <linux-mmc@vger.kernel.org>; Tue,  9 Mar 2021 01:02:32 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id 101so4303565uag.1
        for <linux-mmc@vger.kernel.org>; Tue, 09 Mar 2021 01:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r0xnm0+GPRG6xm7UmnAIp8FML6si7jNaq0GBV1Vgnz4=;
        b=KfhH7Ad/IWsNt5oMg8fzCkmW8ltKpC/YCMD9deToYJRMrwTuKt/rCOauW6AVHdJcxH
         ZmVmq0D6Yzbvg9iegOaRf1iwW+a2Vz8A1666noloVpp1CE6aq1eR7ugOtZwPTl8R3AEj
         YjTg/wmeM9g/MMUSfVHEuE2Wr/0Ak44JPxUGDwMNQ+MzfQamqeDYtizrvLfIv/jADnIi
         UaJrl3asxSpy1bewCxtrcdv9Z5ZBd/waT9Ug3mjptBjZ90Xo8W0/mZV8/Mj/zxaDHEqG
         /Wt9+xLTzkDVu5ikt04peK8DLZfVlJce7ctRaW5I5IkkD7BnZw+eKiydPK2tOV20Tasd
         v+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0xnm0+GPRG6xm7UmnAIp8FML6si7jNaq0GBV1Vgnz4=;
        b=ZO1GMvTKmN1gBh5xzJKcPGZpU/82Ru4ZlQE8gqXdJe+MxsbMZC4hzt2ylrIY5QLDOe
         68InZeNnEEcKFVWx7kc5taYwgZpS9vQSGGLo+3ssu43wY/mNei5XIv+uAU2VgRw5F2fR
         mIQipMWA4Dd5QcSEIFHLiGfs4ywZJrHt/2pVPP1qh+6EWWged+ltTzXCGI3UmzuqRdHi
         T7e24JXaFaeQfui36S95BaJ6OcpQNLM25/4RDfH426C7on/7h/GIv2OapJn1SBEivT3s
         wWY0F5SzG60/oLrDoRoq/V27ORxDLltPMbg6JLuw7/y2ouLzMIU4w6KMLx6ZNBPXxofA
         oqzg==
X-Gm-Message-State: AOAM532OiN4HdKbuHdUJE/vvO3KPxBbIuSNXMPp7HqT6+/QVAkHpS/y0
        R/pyPXjxCTkUhUNuOJ5/swKSYVaM36X3GCJoXupaRQ==
X-Google-Smtp-Source: ABdhPJz46+awTIhV0y9pKZODPaQva2bWW6X1xuqUKvN1EGJ2TgDxjB7ETkLR97+NB+2nY3ccumucJR7PAxORHXNjOx8=
X-Received: by 2002:a9f:3546:: with SMTP id o64mr16115394uao.129.1615280551400;
 Tue, 09 Mar 2021 01:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20210305090827.19124-1-p.zabel@pengutronix.de>
In-Reply-To: <20210305090827.19124-1-p.zabel@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Mar 2021 10:01:54 +0100
Message-ID: <CAPDyKFp7d5cfgMdyVXZt2HkZkttBpB89b9cZqU=hcwakjPhCKA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-st: simplify optional reset handling
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 5 Mar 2021 at 10:08, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> As of commit bb475230b8e5 ("reset: make optional functions really
> optional"), the reset framework API calls use NULL pointers to describe
> optional, non-present reset controls.
>
> This allows to return errors from devm_reset_control_get_optional and to
> call reset_control_(de)assert unconditionally.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-st.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index 962872aec164..78941ac3a1d6 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -362,11 +362,10 @@ static int sdhci_st_probe(struct platform_device *pdev)
>         if (IS_ERR(icnclk))
>                 icnclk = NULL;
>
> -       rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +       rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
>         if (IS_ERR(rstc))
> -               rstc = NULL;
> -       else
> -               reset_control_deassert(rstc);
> +               return PTR_ERR(rstc);
> +       reset_control_deassert(rstc);
>
>         host = sdhci_pltfm_init(pdev, &sdhci_st_pdata, sizeof(*pdata));
>         if (IS_ERR(host)) {
> @@ -432,8 +431,7 @@ static int sdhci_st_probe(struct platform_device *pdev)
>  err_of:
>         sdhci_pltfm_free(pdev);
>  err_pltfm_init:
> -       if (rstc)
> -               reset_control_assert(rstc);
> +       reset_control_assert(rstc);
>
>         return ret;
>  }
> @@ -450,8 +448,7 @@ static int sdhci_st_remove(struct platform_device *pdev)
>
>         clk_disable_unprepare(pdata->icnclk);
>
> -       if (rstc)
> -               reset_control_assert(rstc);
> +       reset_control_assert(rstc);
>
>         return ret;
>  }
> @@ -471,8 +468,7 @@ static int sdhci_st_suspend(struct device *dev)
>         if (ret)
>                 goto out;
>
> -       if (pdata->rstc)
> -               reset_control_assert(pdata->rstc);
> +       reset_control_assert(pdata->rstc);
>
>         clk_disable_unprepare(pdata->icnclk);
>         clk_disable_unprepare(pltfm_host->clk);
> @@ -498,8 +494,7 @@ static int sdhci_st_resume(struct device *dev)
>                 return ret;
>         }
>
> -       if (pdata->rstc)
> -               reset_control_deassert(pdata->rstc);
> +       reset_control_deassert(pdata->rstc);
>
>         st_mmcss_cconfig(np, host);
>
> --
> 2.29.2
>
