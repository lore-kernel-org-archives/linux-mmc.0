Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34A4C4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 09:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B57FE610E5
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 09:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbhHYJYS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Aug 2021 05:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbhHYJYJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Aug 2021 05:24:09 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92ADC061757
        for <linux-mmc@vger.kernel.org>; Wed, 25 Aug 2021 02:23:23 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r9so51563946lfn.3
        for <linux-mmc@vger.kernel.org>; Wed, 25 Aug 2021 02:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sGqLFkSjxAXPXJ3pyFpDdX8Y7mNP1XjKHCFIfQo/kU4=;
        b=Ky1TC26e/audnkjj3k+1b2srrwG5MStzFeAt3u5fBgV4HhZw1GwLaTi+tpt36J9Prv
         VXgNCsW7Wsia1mnspXjQji42lqepuBWA2Qit8wRgMQTDuwSuo4pQ9ov/LJq8E5Kdcm7a
         WUnAR6f+Slyg23HfZ34Pkn6OQvFd5WxFnr1GPCgDoXg9WmHkMHPYlINMZJgG9xCxLh5K
         fzo2qn7ufcY7apI4ml1miTYQKNmoV8itXPlLpvTzGBY0azlqfVoUB9yBPw/58wZ+B9Sr
         nVtFF08YXmTj0bC8mQfLQ3i2ES0qBz8Xf+kXQhufEGxjilsgRxqW7zGbEert13+ylNr4
         bb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sGqLFkSjxAXPXJ3pyFpDdX8Y7mNP1XjKHCFIfQo/kU4=;
        b=PRl6BgDcG3p1PsZAKGDnkLMC/H22g2NS+9M+OV1YKrE4HyqOeQguWaxvzO9EEelz+9
         e6fsb1rVnddW67tPRelI0lZC7mlxfeVNXWb9um1LPCHZ9PDGFkcWg8IJcbgkujp5og1W
         Ts0cn25uUBnBQ7mPlvVlqWt8rWKk3TBaQX7v0csebkAqN3DuhESuNuk3VSMV8O5T2xiy
         EUcvreWbUW+j+FkY5psVjDJcUSbkYj9kfabb/sU6the6Jo66OmMLWdT8o2OVHPsz2AUn
         cd1nZV/0vxs5MhqcZZHGxiVo3omMFhQ9dMPWoK/4StN/uzc15rqysrAB2tb+xzhPBTBT
         VHvw==
X-Gm-Message-State: AOAM532zIhm3DxBqyChq1B0QPORijYjp/Tqy94mmyE728VDL4Huq+nU1
        Ua1kySRyupicfWy9sEEXdOZyu+bu0eaktYrB0k3ovw==
X-Google-Smtp-Source: ABdhPJwj0uOPPXpW+gSXfZxRuFnAY0DpAr55Ljln0Y1dUdL3DZrrYkNkXopzzGhxpD+pa7dezns217lvgvN1k5BwJHU=
X-Received: by 2002:ac2:5b9e:: with SMTP id o30mr6773851lfn.400.1629883402164;
 Wed, 25 Aug 2021 02:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210825081931.598934-1-claudiu.beznea@microchip.com>
In-Reply-To: <20210825081931.598934-1-claudiu.beznea@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 25 Aug 2021 11:22:45 +0200
Message-ID: <CAPDyKFpuQ6STxfPb4aFS8nHFwHHL1mHfwTu34RWPJ0MKNwFCqQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: pwrseq: sd8787: fix compilation warning
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 25 Aug 2021 at 10:21, Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:
>
> Fixed compilation warning "cast from pointer to integer of
> different size [-Wpointer-to-int-cast]"
>
> Fixes: b2832b96fcf5 ("mmc: pwrseq: sd8787: add support for wilc1000")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/pwrseq_sd8787.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq_sd8787.c b/drivers/mmc/core/pwrseq_sd8787.c
> index 264e48067af2..2e120ad83020 100644
> --- a/drivers/mmc/core/pwrseq_sd8787.c
> +++ b/drivers/mmc/core/pwrseq_sd8787.c
> @@ -56,9 +56,12 @@ static const struct mmc_pwrseq_ops mmc_pwrseq_sd8787_ops = {
>         .power_off = mmc_pwrseq_sd8787_power_off,
>  };
>
> +static const u32 sd8787_delay_ms = 300;
> +static const u32 wilc1000_delay_ms = 5;
> +
>  static const struct of_device_id mmc_pwrseq_sd8787_of_match[] = {
> -       { .compatible = "mmc-pwrseq-sd8787", .data = (void *)300 },
> -       { .compatible = "mmc-pwrseq-wilc1000", .data = (void *)5 },
> +       { .compatible = "mmc-pwrseq-sd8787", .data = &sd8787_delay_ms },
> +       { .compatible = "mmc-pwrseq-wilc1000", .data = &wilc1000_delay_ms },
>         {/* sentinel */},
>  };
>  MODULE_DEVICE_TABLE(of, mmc_pwrseq_sd8787_of_match);
> @@ -74,7 +77,7 @@ static int mmc_pwrseq_sd8787_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         match = of_match_node(mmc_pwrseq_sd8787_of_match, pdev->dev.of_node);
> -       pwrseq->reset_pwrdwn_delay_ms = (u32)match->data;
> +       pwrseq->reset_pwrdwn_delay_ms = *(u32 *)match->data;
>
>         pwrseq->pwrdn_gpio = devm_gpiod_get(dev, "powerdown", GPIOD_OUT_LOW);
>         if (IS_ERR(pwrseq->pwrdn_gpio))
> --
> 2.25.1
>
