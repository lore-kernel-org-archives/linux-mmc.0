Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFABCA5506
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Sep 2023 13:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbjINNDh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Sep 2023 09:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbjINNDg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Sep 2023 09:03:36 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A69F1FE1
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 06:03:27 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d7f1bc4ece3so973806276.1
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 06:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694696606; x=1695301406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mmYkjVuRaoLsE0f7fPGLJllxHG538KK2N8Bu0iEsdvY=;
        b=yIDo3z365H83ecBLmwOku4G1wI6Dr+dLLo4DpB1QUA8ooB8rCPDVDyAxvRGpaQ2DPB
         vLb7+tnEcYCPFMrL5yA1RfZa4qpatukfsHcKgaoRpiu4LnOmaoq4ym9kcj/P46XXMlji
         cOD2CQnWRFt+69CF0CfRO1K8AN0+hCBP/gCFXyeH5oeRgboHFC0hA3xW4LYvdaqRnhv8
         aqBnsVMjf9Lm/cwhxwzWohOzt1oh8GRTR7oPoRGkNZSH7tzWR+5WaYEhWLWM6VQqRVwy
         cUmR/XldluHoYyM8CD+iAM9ubunvjDhD7Hg9FwR5fzmmTJccNVFO6RTVWo1mcGWr9Cri
         Je7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694696606; x=1695301406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmYkjVuRaoLsE0f7fPGLJllxHG538KK2N8Bu0iEsdvY=;
        b=Lzy0h/LkxF/tYu7p8phVwZANQfbHIwdlaOEmsxY5+Y87OwXHtGrf8IyjGx20CVHgm4
         ceEwvdPJA9WC6HXYqp6XGonr/BxayURhnGRF15IahETMbNIEpemgbNMvpMe7XzwPz41p
         PWOXDZqJ9++hoj1tXqohkqG3JlnSlWWNZcGeT0AyAmhXjvDDNs3XpyzfLxjV3Z5ppkZm
         sofmEH6O4zXxKlTQ0gpBCKrK4ZBukYvUxhD3WLEcU/dv02vFf8Ml5RphtvQhT+FoJMg1
         loaW5iXfmaZ1Te/bCh3bucgKKn/8lHQr2oftOBLYRCna19i4+dqL6Q6eWiiE+1gl+Ec3
         5+nQ==
X-Gm-Message-State: AOJu0YyJYR4iXoQKVDzF5XS70ZM/KBLzDs4UF9/cN80oSBxuuJgEkQIy
        T7JkgXdpueoaS57qTuP4/ap6iQ5AaczCbZhOSYKQJw==
X-Google-Smtp-Source: AGHT+IHTqcY+LtkJI8cGNZIHEZEWGm9nu4RxMcaM+QIMojeXaWtWLJjh/JIpEgJBzl13lHwBhQkndRvis568r7P4Yp8=
X-Received: by 2002:a25:7905:0:b0:d18:5c77:9f2a with SMTP id
 u5-20020a257905000000b00d185c779f2amr5535759ybc.65.1694696606525; Thu, 14 Sep
 2023 06:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230831032647.3128702-1-haibo.chen@nxp.com>
In-Reply-To: <20230831032647.3128702-1-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 15:02:50 +0200
Message-ID: <CAPDyKFoRLRjCV74zCWNF3xrG5fEJu=TEATor3C3scdp+ojiGow@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: optimize the manual tuing logic to
 get the best timing
To:     haibo.chen@nxp.com
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-imx@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 31 Aug 2023 at 05:22, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Current manual tuning logic only get the first pass window, but
> this pass window maybe not the best pass window.
>
> Now find all the pass window, and chose the largest pass window,
> and use the average value of this largest pass window to get the
> best timing.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 52 +++++++++++++++++++++---------
>  1 file changed, 36 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 6170b7121f36..4cbbc0a786a0 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1154,32 +1154,52 @@ static void esdhc_post_tuning(struct sdhci_host *host)
>         writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
>  }
>
> +/*
> + * find the largest pass window, and use the average delay of this
> + * largest window to get the best timing.
> + */
>  static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
>  {
>         int min, max, avg, ret;
> +       int win_length, target_min, target_max, target_win_length;
>
> -       /* find the mininum delay first which can pass tuning */
>         min = ESDHC_TUNE_CTRL_MIN;
> -       while (min < ESDHC_TUNE_CTRL_MAX) {
> -               esdhc_prepare_tuning(host, min);
> -               if (!mmc_send_tuning(host->mmc, opcode, NULL))
> -                       break;
> -               min += ESDHC_TUNE_CTRL_STEP;
> -       }
> -
> -       /* find the maxinum delay which can not pass tuning */
> -       max = min + ESDHC_TUNE_CTRL_STEP;
> +       max = ESDHC_TUNE_CTRL_MIN;
> +       target_win_length = 0;
>         while (max < ESDHC_TUNE_CTRL_MAX) {
> -               esdhc_prepare_tuning(host, max);
> -               if (mmc_send_tuning(host->mmc, opcode, NULL)) {
> -                       max -= ESDHC_TUNE_CTRL_STEP;
> -                       break;
> +               /* find the mininum delay first which can pass tuning */
> +               while (min < ESDHC_TUNE_CTRL_MAX) {
> +                       esdhc_prepare_tuning(host, min);
> +                       if (!mmc_send_tuning(host->mmc, opcode, NULL))
> +                               break;
> +                       min += ESDHC_TUNE_CTRL_STEP;
>                 }
> -               max += ESDHC_TUNE_CTRL_STEP;
> +
> +               /* find the maxinum delay which can not pass tuning */
> +               max = min + ESDHC_TUNE_CTRL_STEP;
> +               while (max < ESDHC_TUNE_CTRL_MAX) {
> +                       esdhc_prepare_tuning(host, max);
> +                       if (mmc_send_tuning(host->mmc, opcode, NULL)) {
> +                               max -= ESDHC_TUNE_CTRL_STEP;
> +                               break;
> +                       }
> +                       max += ESDHC_TUNE_CTRL_STEP;
> +               }
> +
> +               win_length = max - min + 1;
> +               /* get the largest pass window */
> +               if (win_length > target_win_length) {
> +                       target_win_length = win_length;
> +                       target_min = min;
> +                       target_max = max;
> +               }
> +
> +               /* continue to find the next pass window */
> +               min = max + ESDHC_TUNE_CTRL_STEP;
>         }
>
>         /* use average delay to get the best timing */
> -       avg = (min + max) / 2;
> +       avg = (target_min + target_max) / 2;
>         esdhc_prepare_tuning(host, avg);
>         ret = mmc_send_tuning(host->mmc, opcode, NULL);
>         esdhc_post_tuning(host);
> --
> 2.34.1
>
