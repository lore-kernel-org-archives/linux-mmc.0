Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866DDC352A1
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Dec 2022 11:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiLGLtg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Dec 2022 06:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLGLtf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2022 06:49:35 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F4A100F
        for <linux-mmc@vger.kernel.org>; Wed,  7 Dec 2022 03:49:33 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y4so16796738plb.2
        for <linux-mmc@vger.kernel.org>; Wed, 07 Dec 2022 03:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YwYF2eDaYLTm53Xs+R7d9V7l64YVNVdwGuTGD/zIqOA=;
        b=mlPqJZ+sORxjGQ+PW/ncCBZa6pM84rcC5DAQQrVqF0uRcder2q5jSxEELYoQNaOqJp
         41Dkoll+2g1lQrGsfHO1VPf+v10ZlGLetErfI6myyxJSd2pSURzYQ5T1186meAm3V4p5
         ZOM+e3uCr+aaTSQf6NOig8rcXS9cru3lXVsrXwq+xjDRRNbNUOkPlmAAMVPK1VQ6i9wz
         P0JyUBa3U53Vk7mXvmTy5Zo/xaQH0xsS/S/H+yqtn6NvfMsXz8kSOeHGoz4z42RpmiDJ
         xAhbQ8oOiyRXynmgJ13s9SCOlEih9VjbR2GjjucyN6kJyv7QWKmf0tXrMLvC3KfssBMW
         tvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwYF2eDaYLTm53Xs+R7d9V7l64YVNVdwGuTGD/zIqOA=;
        b=ovQKhcXqdD0r2Ob3pU6F04NYpqOw7V2WAqrVNSpOClyGAMSzI8Mfc4ppQFfpsYKHeY
         RK11otfYykx6a+Bouf5jqjlKqqsPvoQH6jGeu36dOP3i77qU86u2hrK+jH8hkK1xvlIC
         z9D+YssROUzmOFsZX/S86zChqdKRlROTF1AOkuEc9Hk68aruLDRblOoTQZS7S5vvHwG2
         ZukTIoLk747iwH0QGLoTY1Ev56VKgJAeassrEMTc09LQnV27/v7/2ahZXwS/qJrC/r39
         xOBBuXtWfg9Z4PCxIhF5Z3/7bWhoCc8NCjIuDE40nbU3scCf+h7ZVkCQXS72RrY2WTh5
         O19A==
X-Gm-Message-State: ANoB5pnHKYKzGGhw6onhmw+H6R36sbo6uchbEQS5gR3l/iRSRj8/8X6R
        S4f2xt1UgKHiOchqyZNKZ3Kct9jcxsjNtRRWK6s=
X-Google-Smtp-Source: AA0mqf6aa4oc5VzPnJDoJuHF7MjVrbPjoxmalIQnH8JxKUeEXEw061r01kIElJeqRTzOQCYtx11M7z+nro5RwzEQ1Lg=
X-Received: by 2002:a17:90b:60a:b0:219:c691:9933 with SMTP id
 gb10-20020a17090b060a00b00219c6919933mr16950747pjb.195.1670413773270; Wed, 07
 Dec 2022 03:49:33 -0800 (PST)
MIME-Version: 1.0
References: <20221207112315.1812222-1-haibo.chen@nxp.com>
In-Reply-To: <20221207112315.1812222-1-haibo.chen@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 7 Dec 2022 08:49:17 -0300
Message-ID: <CAOMZO5A8uC3hz6=5uG=xKSdqqStypqvJq+nNcR3BORv9JvyaWg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: correct the tuning start tap and
 step setting
To:     haibo.chen@nxp.com, Kevin Groeneveld <KGroeneveld@lenbrook.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[Adding Kevin]

Not sure if this solve the -84 write error when using ath10k that
Kevin reported.

On Wed, Dec 7, 2022 at 8:23 AM <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Current code logic may be impacted by the setting of ROM/Bootloader,
> so unmask these bits first, then setting these bits accordingly.
>
> Fixes: 2b16cf326b70 ("mmc: sdhci-esdhc-imx: move tuning static configuration into hwinit function")
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 89ef0c80ac37..9e73c34b6401 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -107,6 +107,7 @@
>  #define ESDHC_TUNING_START_TAP_DEFAULT 0x1
>  #define ESDHC_TUNING_START_TAP_MASK    0x7f
>  #define ESDHC_TUNING_CMD_CRC_CHECK_DISABLE     (1 << 7)
> +#define ESDHC_TUNING_STEP_DEFAULT      0x1
>  #define ESDHC_TUNING_STEP_MASK         0x00070000
>  #define ESDHC_TUNING_STEP_SHIFT                16
>
> @@ -1368,7 +1369,7 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>         struct cqhci_host *cq_host = host->mmc->cqe_private;
> -       int tmp;
> +       u32 tmp;
>
>         if (esdhc_is_usdhc(imx_data)) {
>                 /*
> @@ -1423,17 +1424,24 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
>
>                 if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
>                         tmp = readl(host->ioaddr + ESDHC_TUNING_CTRL);
> -                       tmp |= ESDHC_STD_TUNING_EN |
> -                               ESDHC_TUNING_START_TAP_DEFAULT;
> -                       if (imx_data->boarddata.tuning_start_tap) {
> -                               tmp &= ~ESDHC_TUNING_START_TAP_MASK;
> +                       tmp |= ESDHC_STD_TUNING_EN;
> +
> +                       /*
> +                        * ROM code or bootloader may config the start tap
> +                        * and step, unmask them first.
> +                        */
> +                       tmp &= ~(ESDHC_TUNING_START_TAP_MASK | ESDHC_TUNING_STEP_MASK);
> +                       if (imx_data->boarddata.tuning_start_tap)
>                                 tmp |= imx_data->boarddata.tuning_start_tap;
> -                       }
> +                       else
> +                               tmp |= ESDHC_TUNING_START_TAP_DEFAULT;
>
>                         if (imx_data->boarddata.tuning_step) {
> -                               tmp &= ~ESDHC_TUNING_STEP_MASK;
>                                 tmp |= imx_data->boarddata.tuning_step
>                                         << ESDHC_TUNING_STEP_SHIFT;
> +                       } else {
> +                               tmp |= ESDHC_TUNING_STEP_DEFAULT
> +                                       << ESDHC_TUNING_STEP_SHIFT;
>                         }
>
>                         /* Disable the CMD CRC check for tuning, if not, need to
> --
> 2.34.1
>
