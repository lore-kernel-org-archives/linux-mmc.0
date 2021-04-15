Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0085AC433B4
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 12:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5D561139
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 12:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhDOMDs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Apr 2021 08:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbhDOMDs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Apr 2021 08:03:48 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBF9C061574
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 05:03:24 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id s184so1639270vss.5
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 05:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AZ/CmfyaGab+l+WyFNzgUeLSKY2tfAn1QupKfFArkRQ=;
        b=R+76awsElsah6WNalavZ7hLNWaO+E10YGAjuyakv3/xLiTgglzvo5GVQ+20WDOxeUA
         hY/Y3rVmxpqnNJfebMHDFERD5AT1yMTyfEiaR0iq+hMIALzG+hnXTcCrkFtznMWK1w+s
         hAy4rzohvnlZ9XN/hWRbc3FY2YPNfjcdnFjR1TlqRrsZkXVXRTokGTz2367czZryEAZB
         8rmD+mFvIHUH/dxpa0ne7dLtqsClLUkDhxI7PYyGEDY8OQ3pzuMtJueyTNCEuW4Q6f+x
         /ysEiIW5Z0+6IrTqcFOnruPNdX5PlVn+gOl4CkxoYEtwwT9q0wp78YVv/P3KKxQwFmdL
         XV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AZ/CmfyaGab+l+WyFNzgUeLSKY2tfAn1QupKfFArkRQ=;
        b=Tw0wGqg6tOVvES1JBhB9mgRQCaJDhp934ozl0L/uxLeWkM43rpcXscMhJkdk5nPm03
         U2L1knOuS7T1n95LhqM3jbGeXTGSFU1GEXAYBv4fvzJ99ly8pvI06WXqhjH3bk79sHUr
         qWpEEvpVnL/5bTTbLOULE+KOB4p+wg6Tj62mpRQ2kNFTsl4qqP73tEAbiT3X3hg/QJl8
         xeNrBPXiwfMiuWQY2cLW0A+BK923USZlHMqgFWKYwC8oPuju29e6G11v56Z/Dk1K+bKp
         zRf2Yb1e/2UFgm8fksDM5LeCbG2gEbw8re53amAVflu1uf0lUgocVVM5xjnGs2qih01q
         /fmA==
X-Gm-Message-State: AOAM5315VWDm4RVQBQXNrL7oXoW3VfAdnFNPYQYtlCpeb3BPa4NZXkjq
        TQTWc/wNgxX7cs79TDWScaPcIUSAJxM8JLCm47Y70Q==
X-Google-Smtp-Source: ABdhPJyKyiIGOYggCtuQ11xjMUhJI8TyNZkDWwIl/wi/1huOMEvDeXaHM1Pb0wZb9y5MllZ/mGlEgG2WZpTPn+bKjr0=
X-Received: by 2002:a67:ec51:: with SMTP id z17mr1708649vso.34.1618488203555;
 Thu, 15 Apr 2021 05:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com> <20210415084412.51125-3-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210415084412.51125-3-krzysztof.kozlowski@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Apr 2021 14:02:46 +0200
Message-ID: <CAPDyKFqngqc9Rc6Efx0bLgoh3zo0siiNBho-A_ZB=O6+yBNR+A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: sdhci-s3c: constify uses of driver/match data
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 15 Apr 2021 at 10:44, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The driver data (struct sdhci_s3c_drv_data) stored in of_device_id
> table is allocated as const and used only in const-way.  Skip
> unnecessary const-away casts and convert all users to work with pointer
> to const.  This is both more logical and safer.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes since v1:
> 1. None
> ---
>  drivers/mmc/host/sdhci-s3c.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index a07a8f011741..862f033d235d 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -462,21 +462,21 @@ static int sdhci_s3c_parse_dt(struct device *dev,
>  }
>  #endif
>
> -static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
> +static inline const struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
>                         struct platform_device *pdev)
>  {
>  #ifdef CONFIG_OF
>         if (pdev->dev.of_node)
> -               return (struct sdhci_s3c_drv_data *)of_device_get_match_data(&pdev->dev);
> +               return of_device_get_match_data(&pdev->dev);
>  #endif
> -       return (struct sdhci_s3c_drv_data *)
> +       return (const struct sdhci_s3c_drv_data *)
>                         platform_get_device_id(pdev)->driver_data;
>  }
>
>  static int sdhci_s3c_probe(struct platform_device *pdev)
>  {
>         struct s3c_sdhci_platdata *pdata;
> -       struct sdhci_s3c_drv_data *drv_data;
> +       const struct sdhci_s3c_drv_data *drv_data;
>         struct device *dev = &pdev->dev;
>         struct sdhci_host *host;
>         struct sdhci_s3c *sc;
> @@ -761,7 +761,7 @@ static const struct platform_device_id sdhci_s3c_driver_ids[] = {
>  MODULE_DEVICE_TABLE(platform, sdhci_s3c_driver_ids);
>
>  #ifdef CONFIG_OF
> -static struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
> +static const struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
>         .no_divider = true,
>  };
>
> --
> 2.25.1
>
