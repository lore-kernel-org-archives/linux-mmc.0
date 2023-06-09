Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EABC7EE2E
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Jun 2023 04:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjFIEkb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Jun 2023 00:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbjFIEkV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2023 00:40:21 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E617E30E8
        for <linux-mmc@vger.kernel.org>; Thu,  8 Jun 2023 21:40:14 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-39a55e706deso244799b6e.3
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2023 21:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686285613; x=1688877613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYhpGW7lSTf4XfRluyLlqvD6VJp7o0X989E+E2RGg9Y=;
        b=CeAjgcqvkmYIl98IfQkaSwG8kjKyQq991LfK7mO3bBAG+aMkbqhSTJS+/efqZUSxar
         fX1Rjv2EacR/ZBfS+VpXunzC/oVnr9Ky0howx1lexNgCc1tTN0GcO3UulL5cUJNgRGpM
         a8mFNHD6WdUJCxJNrYbJ3CfB7d+u/XwxAYEEbXmOHNXrnoWGBVyg8ba4K3VRe1Sir0gz
         Zbp40kHAB1I6deDO36pHMUe8fMpaaP4HJElho1kaxE+0vms9rrukgmdPXlB5voKWlvey
         j5zzLp6R/z9CiOxuWIQY64JgHtIY9wNSgotxrQdu4g4+p5bEHvIdWExn7KMl0jCW8Eao
         WqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686285613; x=1688877613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYhpGW7lSTf4XfRluyLlqvD6VJp7o0X989E+E2RGg9Y=;
        b=iArr+4nExEdrMYUp/yc/ds7Azcoz6SEwq9irouDe1MTkXfOuvYT4661AQQpETN3Q9S
         jo4Yuccz2gEjMHRfxCSH4Mb5e1LZHSnX5jjwfvSOtrjNUpyGzQ1DBRDZ6zz+nfoqalNx
         wPhBnxH34dfCSSvO/+XNoqMNxc0uWwrPZocX2cE8Cpcthbe+vnM5CAWO3P8mid6dOg91
         vpzDwkYl5wlRg/5M5q3Wp5cj57u5LmefQgT39rtA7ITvNS+/y5bIS86rMB8v0kr2m7B3
         i10vNiHDPl9YSfVwrzV698UpQuMwINDCtEw/P8N4c9zAak3m0uQkQNAaq5ExsChwP0ff
         QZNw==
X-Gm-Message-State: AC+VfDxFAzGNepI4YciY9zXZnNYCTbb5q7oSf+I8hPnmcNkMKTdyeHSC
        sslG0Ua9EzMJxpyXq1SwgsVfLoVpPIordjGmDh4=
X-Google-Smtp-Source: ACHHUZ5aJOgrWIs1QN27Hv7HAgu4EnFhssSRrdaM6FruM0h62dquBFQXdJnXV8SQpwRweBnR3gQ/uQ==
X-Received: by 2002:a05:6808:192a:b0:39a:b7a3:7d61 with SMTP id bf42-20020a056808192a00b0039ab7a37d61mr466996oib.28.1686285613684;
        Thu, 08 Jun 2023 21:40:13 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id h13-20020a17090a3d0d00b0025954958e06sm2156181pjc.18.2023.06.08.21.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 21:40:13 -0700 (PDT)
Date:   Fri, 9 Jun 2023 10:10:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH v2 09/12] mmc: sdhci-spear: fix deferred probing
Message-ID: <20230609044011.4jjpkzngctrf55gb@vireshk-i7>
References: <20230608194519.10665-1-s.shtylyov@omp.ru>
 <20230608194519.10665-10-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608194519.10665-10-s.shtylyov@omp.ru>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 08-06-23, 22:45, Sergey Shtylyov wrote:
> The driver overrides the error codes and IRQ0 returned by platform_get_irq()
> to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
> permanently instead of the deferred probing. Switch to propagating the error
> codes upstream.  IRQ0 is no longer returned by platform_get_irq(), so we now
> can safely ignore it...
> 
> Fixes: 682798a596a6 ("mmc: sdhci-spear: Handle return value of platform_get_irq")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
> Changes in version 2:
> - slightly reformatted the patch description.
> 
>  drivers/mmc/host/sdhci-spear.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
> index d463e2fd5b1a..c79035727b20 100644
> --- a/drivers/mmc/host/sdhci-spear.c
> +++ b/drivers/mmc/host/sdhci-spear.c
> @@ -65,8 +65,8 @@ static int sdhci_probe(struct platform_device *pdev)
>  	host->hw_name = "sdhci";
>  	host->ops = &sdhci_pltfm_ops;
>  	host->irq = platform_get_irq(pdev, 0);
> -	if (host->irq <= 0) {
> -		ret = -EINVAL;
> +	if (host->irq < 0) {
> +		ret = host->irq;
>  		goto err_host;
>  	}
>  	host->quirks = SDHCI_QUIRK_BROKEN_ADMA;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
