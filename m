Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3B4C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 22:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD182610A2
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 22:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbhI0WeP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237918AbhI0WeO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2021 18:34:14 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B23BC061769
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 15:32:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t10so83887298lfd.8
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 15:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SWtpZ8PO1D/9eZFX8nceZYsmLHQWGmkDYyw8clyIoeQ=;
        b=nsv+9QbYaiqvtpvL0wrJuH7G7mw8h6nMh5mofTyXGGAeKDE8SUGersA+a/Yo3NkFAr
         aniIIzDZ6Jbf0clUsu2XlJdS32IPCPd9V3FHvw5WnG5PidLr41vu5a16BeAd0ww2ZLyh
         RgWN54kjzvAjvFPaejwwXJaYwsdpZqxPr3YBK3CaBn/dylvTLV2OOnsH/w+oaaKIdd7E
         +F2HXqZgxbqkizIt2ZzKQOpzx94qj5/yKPko8l3qUfJ8V4Q6hC8w8RzN8k2uxmCZpxHq
         WhgAGDzMaiMWranShw8/gsrbRLnRvabX3luVEEkOmMZy0v32tnx/xDK3duThElp/r9Zq
         WArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWtpZ8PO1D/9eZFX8nceZYsmLHQWGmkDYyw8clyIoeQ=;
        b=2KB0yZeVFqNeBpCkdh0i7s+zDk+Cc/TEDhHaYKlo+WCMXDktPfwGKUgHfZZJt6UoSz
         tg7UmiGzgM/wtBebgoLB7LP3gH6lO6hU7XHwUbqb2mRtPgCzifgfd8GCfsovsyqw+vM/
         AmPyzi0fVn0JvCCmTtp1Ffu+Fin9aNzXCFDiI9SEhOo64Vs+zWyIImk4MeUjaER9q7W5
         gNj13qUGBESpkzksXW69JCV3NnetY9DccrP0abcCQ+ytVzaBYag0TlH7s2xyAeeh63vm
         cJCIcypEPRZivSzOCHWXhZTNGjbJdcbrF5COnguM3MpbibX4USGp25S6UdeBR7ooZDQa
         wOUA==
X-Gm-Message-State: AOAM532SPP5Zoq4vABFziAi4gGZy9T7Rfay9+o4ijKcWQTB9XxBlg2p5
        ZHVHYTcMY4cJSoOso+z230Mm/e+XM2ULyiW9PmDYyI0AviI=
X-Google-Smtp-Source: ABdhPJyEXb/yQ9/a6K8aBzhJdUYb10ZUYNoy2vlteyYKNJZtPx8j46XiOXQmIJRCjJRs1TQZhUKudUPzSmNoSz+Gk+Y=
X-Received: by 2002:a05:6512:3fa5:: with SMTP id x37mr2271959lfa.233.1632781953710;
 Mon, 27 Sep 2021 15:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210924133257.112017-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210924133257.112017-1-krzysztof.kozlowski@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Sep 2021 00:31:56 +0200
Message-ID: <CAPDyKFr6tEEm0j7qBrA3dqqEZxF-5+DXrau3TKTK8RRuYeL5yA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: Describe driver in KConfig
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 24 Sept 2021 at 15:33, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Describe better which driver applies to which SoC, to make configuring
> kernel for Samsung SoC easier.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 71313961cc54..e4c1648e364e 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -315,15 +315,17 @@ config MMC_SDHCI_TEGRA
>           If unsure, say N.
>
>  config MMC_SDHCI_S3C
> -       tristate "SDHCI support on Samsung S3C SoC"
> +       tristate "SDHCI support on Samsung S3C/S5P/Exynos SoC"
>         depends on MMC_SDHCI
>         depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
>           often referrered to as the HSMMC block in some of the Samsung S3C
> -         range of SoC.
> +         (S3C2416, S3C2443, S3C6410), S5Pv210 and Exynos (Exynso4210,
> +         Exynos4412) SoCs.
>
> -         If you have a controller with this interface, say Y or M here.
> +         If you have a controller with this interface (thereforeyou build for
> +         such Samsung SoC), say Y or M here.
>
>           If unsure, say N.
>
> --
> 2.30.2
>
