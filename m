Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A169C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Nov 2021 09:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C6161107
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Nov 2021 09:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhKKJwE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Nov 2021 04:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhKKJwD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Nov 2021 04:52:03 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE58BC061767
        for <linux-mmc@vger.kernel.org>; Thu, 11 Nov 2021 01:49:14 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id u22so4001435lju.7
        for <linux-mmc@vger.kernel.org>; Thu, 11 Nov 2021 01:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OCREGG06PLhapCFom87STE1uw55Yr5x9ePMRWOvmT3k=;
        b=J/P1hPH6j7wvhRvFyZd3TqxaZ6OSx5WqY79nSlVHc4q6aeCj4OCVN+lpKr5aO4eqav
         IPFsV0kv/g4BObRIKl9w8qk9UoqVi/8vR/0nRghSEKV4z0cZMzgvCU/vUJ7HbB4o2Y3d
         1qSTNUQddXh+8wvVo08Dz/WCCuaeIEfsODFVrgBdmxHrNzPpnF8nAwkGfo1be2/P1DNp
         Xa6sgTl0U0KkhVEVBO6ghGt/4WR1iUFpPVd4/CI3RhmNeK8iTFleaaIdQB3M8BFB9yx7
         1HSWsHio+2uDFqg0+fkcemqvzpCwM+W5Cjtt7mdn76KfyXVA1YsmlqpdRaqlvEfNuY4x
         j7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCREGG06PLhapCFom87STE1uw55Yr5x9ePMRWOvmT3k=;
        b=bkNUKfXYLfQ2jR13ZEOGrOpksuYTa4Vut4p5ugCK6iXkJy/tUVkwn08e4A9PmS0kRt
         UoUGi89wxfwm8rklKrqzwn9CfLz/5R8459Lby8OC0qFzQm8o6iVPu9Zg4bjdyGJnWlnd
         z1+pCdTTojZzYHBDARYs+XePCsST3FDcFvADdox/AKMVxqd5OWEL5dzF1Td+sYVdq/Am
         uf/MrNvXY/nVc/3YuvijwPAc4CaZA8kK1RiUiDHav/JagE18ZFEAGa9FD9Bv2alUaJpb
         6YStstfCRP+3Q920vTxpsOkrPWMBO+lyx1B6+pvNF/vu2bEaIX3zU3Gjl7b2xU2EDmoB
         yFDA==
X-Gm-Message-State: AOAM532xOZZEltZQkJFn3Yu9Mu5AhyPY0CemaMH9AzygDc+epa1Yj6lU
        h5yZm2J8sNQn7pWvHaTk9LZedfFEXdxM/Crr+tOxzA==
X-Google-Smtp-Source: ABdhPJxkX3V93M0k93HKNu7+qIoL9WfO3AxPfyLW/zo4eZiEbynnSydtnx20bP3Pjol+PTMrmXAci3syYf02ZC4ce3U=
X-Received: by 2002:a2e:7114:: with SMTP id m20mr5714665ljc.229.1636624153256;
 Thu, 11 Nov 2021 01:49:13 -0800 (PST)
MIME-Version: 1.0
References: <20211110191610.5664-1-wsa+renesas@sang-engineering.com> <20211110191610.5664-21-wsa+renesas@sang-engineering.com>
In-Reply-To: <20211110191610.5664-21-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Nov 2021 10:48:36 +0100
Message-ID: <CAPDyKFrW1T-4UeS6R2j8+2LKJ5D0iELXJ_Q+Mmq=Mk6CfjDPQA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 20/21] mmc: sdhi: parse DT for SDnH
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 10 Nov 2021 at 20:16, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> If there is a SDnH clock provided in DT, let's use it instead of relying
> on the fallback.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>
> Changes since RFC v1:
> * added tag from Geert
> * use dev_err_probe()
>
>  drivers/mmc/host/renesas_sdhi_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 230182de5e88..db053fba5330 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -919,6 +919,10 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>         if (IS_ERR(priv->clk))
>                 return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk), "cannot get clock");
>
> +       priv->clkh = devm_clk_get_optional(&pdev->dev, "clkh");
> +       if (IS_ERR(priv->clkh))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(priv->clkh), "cannot get clkh");
> +
>         /*
>          * Some controllers provide a 2nd clock just to run the internal card
>          * detection logic. Unfortunately, the existing driver architecture does
> @@ -957,7 +961,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>                 dma_priv->dma_buswidth = of_data->dma_buswidth;
>                 host->bus_shift = of_data->bus_shift;
>                 /* Fallback for old DTs */
> -               if (of_data->sdhi_flags & SDHI_FLAG_NEED_CLKH_FALLBACK)
> +               if (!priv->clkh && of_data->sdhi_flags & SDHI_FLAG_NEED_CLKH_FALLBACK)
>                         priv->clkh = clk_get_parent(clk_get_parent(priv->clk));
>
>         }
> --
> 2.30.2
>
