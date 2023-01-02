Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CF5C3DA7A
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Jan 2023 15:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjABPG7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Jan 2023 10:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbjABPG4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jan 2023 10:06:56 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1940CB4D
        for <linux-mmc@vger.kernel.org>; Mon,  2 Jan 2023 07:06:54 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id a30so3201041pfr.6
        for <linux-mmc@vger.kernel.org>; Mon, 02 Jan 2023 07:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LoMc9pQ872B3tkICAMISF8J7bmxsn99eD6Cqj3bIdps=;
        b=jInaRD9Zshal7P5+zlWcHY7dsmKd2EtvhhVTxlzsVkhyX97W/9PobgpdhB0OvEHyOT
         I21Op535arLNrJthA+F2xKMCJCRJg9UsKBotbJES92nwL2KlenZhjrfniKULdbADznU6
         8p9AAaF9i6gSyDTrAMqHETD5pGHwtmw3u9D5myAlKUzrrvijanp2Vkl5P6O5hqEzsySI
         NE9YKn8YTa5Rfyy+3S8sq2rvaFqihVERJVBRTdQQHNOiNDc4zwxdMJtcv07zLzticKS3
         ubcYRSnZ60IDggb/r+SGaIbbl5L86Pt9tthXrbQKnrZiyPZlbeAnKxlSD1oV5yHxINS8
         YHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoMc9pQ872B3tkICAMISF8J7bmxsn99eD6Cqj3bIdps=;
        b=EKw0Jmv+V9GXHluKypMdF7t8D3/EY0CxhSkc1vZDIa76qwAhdbpK0R6Nk7BrlYfhX1
         EJrPSGCQdIwYAfj6IU0d4ilBW6QJ9owHmjlnId8V2GqResnyMkG3U2D2a+fkFLA1P8RX
         OEnWeu9+A8GORtwiCJ7di7In61oZzJsYkpyiXKauChErmhbTGyG7DJDIlY6t3kan8bs8
         8WJRMAHVFHqEfkA1xVWhHU+gSH3+Ut7v0Bx7LgYnxwejrDClHfOJAiT+qzPdwHJJT7Tl
         se9CYdOX4CVd2jNYEYswj7jwSNDrHuA5kH8Ygez/k0uams+kbI7BrSKDRgQpIZVq2wuw
         6AVg==
X-Gm-Message-State: AFqh2koT9rBDpgxSxz/NgyGtYOjG3VxBGtqNzw0FSK26KhQOJGG1cuCJ
        DD/0hx3ShbX5NSyLzqT/pya7FsJ0W9MGovcDhD7MBZZR2TbpHw==
X-Google-Smtp-Source: AMrXdXsq/5u3UiD9glOis+YuFMt5vj9rwkfxHA/n0B/g+6plRm0o5dcGOYNZHUXyUK5PoA8G7cYbX4cmHrXGYOA0MC4=
X-Received: by 2002:a63:5841:0:b0:477:b650:494b with SMTP id
 i1-20020a635841000000b00477b650494bmr2406661pgm.434.1672672013917; Mon, 02
 Jan 2023 07:06:53 -0800 (PST)
MIME-Version: 1.0
References: <20221207112315.1812222-1-haibo.chen@nxp.com>
In-Reply-To: <20221207112315.1812222-1-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jan 2023 16:06:17 +0100
Message-ID: <CAPDyKFqR9uGXWXTJivH1xoPS2yMQXrD8TLGH509rpELKoiSXYw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: correct the tuning start tap and
 step setting
To:     haibo.chen@nxp.com
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-imx@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 7 Dec 2022 at 12:23, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Current code logic may be impacted by the setting of ROM/Bootloader,
> so unmask these bits first, then setting these bits accordingly.
>
> Fixes: 2b16cf326b70 ("mmc: sdhci-esdhc-imx: move tuning static configuration into hwinit function")
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


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
