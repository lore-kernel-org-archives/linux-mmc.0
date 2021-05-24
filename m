Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2351CC2B9F7
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06DF561370
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhEXOM2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 10:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbhEXOM2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 10:12:28 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27794C061756
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:10:59 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id f1so9355469uaj.10
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RpIF5xyKVymbV0kdJLrnlDUYIKLQJeip1Z/LyLzk92o=;
        b=pSCN5jWDfXPNWvYxUILl8ege4uHm8OyAku+xX7KzGiKCMElPZXmH7kF9ZRqe2PI+4W
         fKWNNeNgvKWqcavB6j6zeXLHIlvyAusKwKBtjmjNjwmFVdxphTdSa2NQfdBU80hx1BRm
         RhXaHkOYPmaQvqtnf0upbVJsx6Fp3m18R4rFdDlP7Nn7dK6FrzX7rUYON3NL3esygsTZ
         Hu+tO64U9e+m3rIRxfPfqunPlOP4imHopp3xFqsrHThZbrht7fKOuHSO7d2Y7RYZEb6P
         cx/pW5mMpHzY4qwbhMOz81Py2YsmlHW6/tUvmSnIVzXkCxVYcZxjLOkD3sl99ZpTCa1n
         cLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RpIF5xyKVymbV0kdJLrnlDUYIKLQJeip1Z/LyLzk92o=;
        b=mw5jtubVAb4F3XAI+gPQQLH19rG79EfcEKra4gO4pvGzDp4XL2yeIlEZgckEgn4fHa
         I5nFJknrdKiuDgrAfbC72tt3En5nXuVgRcu7TWR0DeARgKh8duXXZyAA2GAWs+/KAAl3
         V/nOZdgBoTs9tFaYEDouoWhCsHguoeVOLZw+Kog5DhIBw/fZP0buDCCJhLTOfme6Z7FX
         uEPULUYGmJzuiTw1L9yJOZikqFbnJLyeOTzL+oipV/+gLBgxlZWjyMceTh3OvlWYJCLY
         HvOEUBdSq06iJKzzeKFRYfS0TevKPjqKjfZPar6rotG3U3Bqkt+PCPd/abn3PrYxkJde
         2EdA==
X-Gm-Message-State: AOAM531xv/V8Rr93jxp5dx/XJDM23wUmbXBaicpsqw1G/sAnk42NQhks
        4H3d8kz+bcWOvYPRZsO0TLll505wAdkkM3AvM4anZw==
X-Google-Smtp-Source: ABdhPJw73/f++J0i/T4ayGVFRfYhSzvmCHSgspt8PqKX7pRabXH3i/vkuFvAu4togdjbYVDxLhkgXF5M3vJLtuSfgFk=
X-Received: by 2002:a9f:35b3:: with SMTP id t48mr21997689uad.129.1621865458228;
 Mon, 24 May 2021 07:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210510190400.105162-1-l.stach@pengutronix.de> <20210510190400.105162-2-l.stach@pengutronix.de>
In-Reply-To: <20210510190400.105162-2-l.stach@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:10:19 +0200
Message-ID: <CAPDyKFoep9zPwzAU-1yghyMmZF7PVwam0_rN0hgxB0yZbhxDqw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: sdhci-esdhc-imx: advertise HS400 mode through
 MMC caps
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 10 May 2021 at 21:04, Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Instead of having an indirection through the SDHCI layer and emulating
> a capability bit, that isn't there in hardware, do the same same thing
> as with HS400_ES and advertise the support for HS400 directly through
> the MMC caps.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index a20459744d21..65a52586db36 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -427,9 +427,6 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>                                         | FIELD_PREP(SDHCI_RETUNING_MODE_MASK,
>                                                      SDHCI_TUNING_MODE_3);
>
> -                       if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
> -                               val |= SDHCI_SUPPORT_HS400;
> -
>                         /*
>                          * Do not advertise faster UHS modes if there are no
>                          * pinctrl states for 100MHz/200MHz.
> @@ -1603,7 +1600,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>                 host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
>
>         if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
> -               host->quirks2 |= SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400;
> +               host->mmc->caps2 |= MMC_CAP2_HS400;
>
>         if (imx_data->socdata->flags & ESDHC_FLAG_BROKEN_AUTO_CMD23)
>                 host->quirks2 |= SDHCI_QUIRK2_ACMD23_BROKEN;
> --
> 2.31.1
>
