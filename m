Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6518AC7EE32
	for <linux-mmc@archiver.kernel.org>; Wed, 24 May 2023 13:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbjEXNLq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 May 2023 09:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbjEXNLl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2023 09:11:41 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B592191
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 06:11:29 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b9e6ec482b3so1372847276.3
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684933888; x=1687525888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+G97VBJPtAt8CHwV2HaOHsd8x3Lwotzyrrnqu+N33c0=;
        b=LRL29ZMyKHae8JeDF1YwMikul+6J6kI6a12AQry6/TKFingBsUjglbr7vvI/9gjR4Z
         lCQbohhqSFaqtwd82qv2gtWgoTrNwdDk6CNVxTm0Hd1iTHr16OCmQu5xm/gb9bcY1+N4
         yychFm/qcnOxC8HztcuG6zrNZ8LOepiMVuzo0ea9wPFvsCAyXL/mPvs4+NGK8tZG9r0e
         QVcrd+26oM6abhjOpWJagcSt4jZajQlnMbXzGpjYZFWrf/QT4Mz823WmHf0XBBbwwn8s
         w5MaVWs58dwcpMlags4mjAWP5J7TcALzC9LCmYRRNVHev5466A3mgukZDpKgSQPo65Ri
         d2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684933888; x=1687525888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+G97VBJPtAt8CHwV2HaOHsd8x3Lwotzyrrnqu+N33c0=;
        b=PTPRECC5BFX230CLzJemGpROFwTKnzapNL7yFAGxPtTHfROo7qNo5IV+/jTvh5snEA
         dIFGggRCsUwH01kdzEm5/KrhxpnNdqRlvsQp+ueDkHxfrnj/lmIUYAJ4J+UreXpI7HnX
         gLXVofMk49TmLlXkKqN2yFb29k9/pm8Zhw3tV5AfqvMPhZFh9fJJQHJPfj+/oMsBk3/t
         iUTjasnWNU9l2lnAzmDsRCONObqeLP7GmC2sulEHLqcVI+KN6UJMXcPhKtb9EJXaKUMU
         fHPUwu9Gfjf9IHxP6Xsu/XqX/xFvobrbf+uOkIJEdN+k6qPnU9tlh/ZzB9qrlpUqzj2n
         lyiw==
X-Gm-Message-State: AC+VfDxufPE9/lFzxJj+BiikXYbyFHQ2St6AAEd4qcO2xtCtF4QSvl5n
        kQB5rIPOIyMPMjSoNg4RCxQ+6UjbKeogdoTVYbDFgw==
X-Google-Smtp-Source: ACHHUZ5DF86SZng/GhDzZtTxxFwplg5RHHzN3SvLkHxKkBKyR6G9WpXpyjxNVZgWlc+/CS7crUNtSGjTsPZjwjDWWGM=
X-Received: by 2002:a25:d110:0:b0:b9d:e253:d25 with SMTP id
 i16-20020a25d110000000b00b9de2530d25mr20701860ybg.11.1684933888365; Wed, 24
 May 2023 06:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230513192352.479627-1-marex@denx.de>
In-Reply-To: <20230513192352.479627-1-marex@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 May 2023 15:10:52 +0200
Message-ID: <CAPDyKFppH5WiE8DxPFJHkDw0JL7rMsqGGF7MMb7zU6Q6nNMYkw@mail.gmail.com>
Subject: Re: [PATCH] mmc: pwrseq: sd8787: Fix WILC CHIP_EN and RESETN toggling order
To:     Marek Vasut <marex@denx.de>
Cc:     linux-mmc@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 13 May 2023 at 21:24, Marek Vasut <marex@denx.de> wrote:
>
> Chapter "5.3 Power-Up/Down Sequence" of WILC1000 [1] and WILC3000 [2]
> states that CHIP_EN must be pulled HIGH first, RESETN second. Fix the
> order of these signals in the driver.
>
> Use the mmc_pwrseq_ops as driver data as the delay between signals is
> specific to SDIO card type anyway.
>
> [1] https://ww1.microchip.com/downloads/aemDocuments/documents/WSG/ProductDocuments/DataSheets/ATWILC1000-MR110XB-IEEE-802.11-b-g-n-Link-Controller-Module-DS70005326E.pdf
> [2] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/IEEE-802.11-b-g-n-Link-Controller-Module-with-Integrated-Bluetooth-5.0-DS70005327B.pdf
>
> Fixes: b2832b96fcf5 ("mmc: pwrseq: sd8787: add support for wilc1000")
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Cc: Ajay Singh <ajay.kathat@microchip.com>
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> ---
>  drivers/mmc/core/pwrseq_sd8787.c | 34 ++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq_sd8787.c b/drivers/mmc/core/pwrseq_sd8787.c
> index 2e120ad83020f..0c5f5e371e1f8 100644
> --- a/drivers/mmc/core/pwrseq_sd8787.c
> +++ b/drivers/mmc/core/pwrseq_sd8787.c
> @@ -28,7 +28,6 @@ struct mmc_pwrseq_sd8787 {
>         struct mmc_pwrseq pwrseq;
>         struct gpio_desc *reset_gpio;
>         struct gpio_desc *pwrdn_gpio;
> -       u32 reset_pwrdwn_delay_ms;
>  };
>
>  #define to_pwrseq_sd8787(p) container_of(p, struct mmc_pwrseq_sd8787, pwrseq)
> @@ -39,7 +38,7 @@ static void mmc_pwrseq_sd8787_pre_power_on(struct mmc_host *host)
>
>         gpiod_set_value_cansleep(pwrseq->reset_gpio, 1);
>
> -       msleep(pwrseq->reset_pwrdwn_delay_ms);
> +       msleep(300);
>         gpiod_set_value_cansleep(pwrseq->pwrdn_gpio, 1);
>  }
>
> @@ -51,17 +50,37 @@ static void mmc_pwrseq_sd8787_power_off(struct mmc_host *host)
>         gpiod_set_value_cansleep(pwrseq->reset_gpio, 0);
>  }
>
> +static void mmc_pwrseq_wilc1000_pre_power_on(struct mmc_host *host)
> +{
> +       struct mmc_pwrseq_sd8787 *pwrseq = to_pwrseq_sd8787(host->pwrseq);
> +
> +       /* The pwrdn_gpio is really CHIP_EN, reset_gpio is RESETN */
> +       gpiod_set_value_cansleep(pwrseq->pwrdn_gpio, 1);
> +       msleep(5);
> +       gpiod_set_value_cansleep(pwrseq->reset_gpio, 1);
> +}
> +
> +static void mmc_pwrseq_wilc1000_power_off(struct mmc_host *host)
> +{
> +       struct mmc_pwrseq_sd8787 *pwrseq = to_pwrseq_sd8787(host->pwrseq);
> +
> +       gpiod_set_value_cansleep(pwrseq->reset_gpio, 0);
> +       gpiod_set_value_cansleep(pwrseq->pwrdn_gpio, 0);
> +}
> +
>  static const struct mmc_pwrseq_ops mmc_pwrseq_sd8787_ops = {
>         .pre_power_on = mmc_pwrseq_sd8787_pre_power_on,
>         .power_off = mmc_pwrseq_sd8787_power_off,
>  };
>
> -static const u32 sd8787_delay_ms = 300;
> -static const u32 wilc1000_delay_ms = 5;
> +static const struct mmc_pwrseq_ops mmc_pwrseq_wilc1000_ops = {
> +       .pre_power_on = mmc_pwrseq_wilc1000_pre_power_on,
> +       .power_off = mmc_pwrseq_wilc1000_power_off,
> +};
>
>  static const struct of_device_id mmc_pwrseq_sd8787_of_match[] = {
> -       { .compatible = "mmc-pwrseq-sd8787", .data = &sd8787_delay_ms },
> -       { .compatible = "mmc-pwrseq-wilc1000", .data = &wilc1000_delay_ms },
> +       { .compatible = "mmc-pwrseq-sd8787", .data = &mmc_pwrseq_sd8787_ops },
> +       { .compatible = "mmc-pwrseq-wilc1000", .data = &mmc_pwrseq_wilc1000_ops },
>         {/* sentinel */},
>  };
>  MODULE_DEVICE_TABLE(of, mmc_pwrseq_sd8787_of_match);
> @@ -77,7 +96,6 @@ static int mmc_pwrseq_sd8787_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         match = of_match_node(mmc_pwrseq_sd8787_of_match, pdev->dev.of_node);
> -       pwrseq->reset_pwrdwn_delay_ms = *(u32 *)match->data;
>
>         pwrseq->pwrdn_gpio = devm_gpiod_get(dev, "powerdown", GPIOD_OUT_LOW);
>         if (IS_ERR(pwrseq->pwrdn_gpio))
> @@ -88,7 +106,7 @@ static int mmc_pwrseq_sd8787_probe(struct platform_device *pdev)
>                 return PTR_ERR(pwrseq->reset_gpio);
>
>         pwrseq->pwrseq.dev = dev;
> -       pwrseq->pwrseq.ops = &mmc_pwrseq_sd8787_ops;
> +       pwrseq->pwrseq.ops = match->data;
>         pwrseq->pwrseq.owner = THIS_MODULE;
>         platform_set_drvdata(pdev, pwrseq);
>
> --
> 2.39.2
>
