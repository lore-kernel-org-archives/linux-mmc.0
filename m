Return-Path: <SRS0=dyeO=7K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CD8C433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 10:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B1FC208DB
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 10:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CNJPDqLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbgE1KP0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 May 2020 06:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbgE1KPN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 May 2020 06:15:13 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAA3C08C5CA
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 03:15:10 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id a68so4586420vsd.8
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 03:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wYvD4r1ulJrSPmdQw9SLGgFwZG+MxRo/QXyqHRDFej0=;
        b=CNJPDqLTi/IuZgQRPBMg2yxNxoePxYEAJVmhhtvE8OlJJFcBDQUOzDfbOfCRdSnmBm
         8uF8pKL4NTg9pkrglxDWZ43R5v8xOCf957HqPBm7Bhn60M/lvAwLr57p/Ec04gy7abhj
         /4Wr/kJ4dMPeVI264fensIP3MSNHMEexAFLX3Fzf3Lqf4WhgcXpcxmCS/Y7xgUxfTSxt
         jnKX1AM4ntK+UBYh2R3qgH0oZ8b7BSt6ccIfacVMJQzsWFM53tYNbs20i6aBM9XbeD/l
         DzQTZ3GEGyBcv9KYZSRZ+eLQTQgn6dhHS78QePY5HrkiMK0pbfisPhLL747if5W6pPEN
         SyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wYvD4r1ulJrSPmdQw9SLGgFwZG+MxRo/QXyqHRDFej0=;
        b=s/EHa15CRywAvHyqUWlF9LkqRFOi8JuyUIALm4WgwmKha/kRV9MvtwMzmgglHkAnZ6
         TmVKGfbHe0zLpGp+xjqC9OCR6XMadhgFXiQQFtzGKnmeI4eX/K8Emo6mDX8IN9kRwicL
         BJOWW7AUFsHJ2Lj/xC2SDh6gWvrAvYcMYKdRaiqdVMlx8fIBEFHP90srglADZNvgOIM1
         GP9/BfUvLHIisNBHziVvqkWVCbXU/aezWA41BVS0d/FK9S5t4PJ2uYL5kivbQKeFsoqq
         0rkLhGTYrAmfxln9xezvFNngOxDA1q8vYdjONVA5k9AcmOGjIfuiIasfj0zezeiCaRYN
         QFnw==
X-Gm-Message-State: AOAM531Q0fPkheX6186Yo1QAdRF4/92DjdlbJzO3ym+iGu+V2cv5Z4K5
        43pb6+QpSeDlSSHTBKW+ZUnV78nYimK+wbffKpOD6QCzlmA=
X-Google-Smtp-Source: ABdhPJxb2WnpVRS9U3plDTUUei62NNTnraVpSBNhYL/j1TslMciPD++P7b1aKtf45q8ShwLdi/3Vrx+gxW3AtR2NmzM=
X-Received: by 2002:a67:be05:: with SMTP id x5mr1263018vsq.35.1590660909658;
 Thu, 28 May 2020 03:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <1590547175-15070-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1590547175-15070-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 May 2020 12:14:33 +0200
Message-ID: <CAPDyKFrJMcKA89t7wMa8knOz4DwJ=ZPUf=RCeGcJK==UHjNQvw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: host: sdhci-esdhc-imx: add wakeup feature for
 GPIO CD pin
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 27 May 2020 at 04:50, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> When use the specific GPIO to detect the card insert/remove, we can
> also add the GPIO as a wakeup source. When system suspend, insert or
> remove the card can wakeup the system.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 5398af4824c3..5a27511438c8 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1599,6 +1599,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>         if (esdhc_is_usdhc(imx_data)) {
>                 host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
>                 host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
> +
> +               /* GPIO CD can be set as a wakeup source */
> +               host->mmc->caps |= MMC_CAP_CD_WAKE;
> +
>                 if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
>                         host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
>
> @@ -1734,8 +1738,14 @@ static int sdhci_esdhc_suspend(struct device *dev)
>                 mmc_retune_needed(host->mmc);
>
>         ret = sdhci_suspend_host(host);
> -       if (!ret)
> -               return pinctrl_pm_select_sleep_state(dev);
> +       if (ret)
> +               return ret;
> +
> +       ret = pinctrl_pm_select_sleep_state(dev);
> +       if (ret)
> +               return ret;
> +
> +       ret = mmc_gpio_set_cd_wake(host->mmc, true);
>
>         return ret;
>  }
> @@ -1759,6 +1769,9 @@ static int sdhci_esdhc_resume(struct device *dev)
>         if (host->mmc->caps2 & MMC_CAP2_CQE)
>                 ret = cqhci_resume(host->mmc);
>
> +       if (!ret)
> +               ret = mmc_gpio_set_cd_wake(host->mmc, false);
> +
>         return ret;
>  }
>  #endif
> --
> 2.17.1
>
