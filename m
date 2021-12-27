Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5843FC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Dec 2021 04:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbhL0EQF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 26 Dec 2021 23:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbhL0EQF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Dec 2021 23:16:05 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1151BC06173E
        for <linux-mmc@vger.kernel.org>; Sun, 26 Dec 2021 20:16:05 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id a23so12634978pgm.4
        for <linux-mmc@vger.kernel.org>; Sun, 26 Dec 2021 20:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UL6RjoyyuUYFB9MVmpYBVdopbDnzvy3y199tA/0p/VY=;
        b=RWnxdizFq/GhZkWU5hrJWcL3Xx99nPoJecvUafo9eswaerQoa/qt0UWcfa1sRZ7Wln
         PEVZ0ERk9WZH3UBst6W7W+Z5QfvXX+z9PDkEH9MgdoohQHcR5f4M/UJ4XhWCI/wBj+SH
         UXDxlSF5NUNJA92xRuq5iMwhrDAbOcKWqjmJK6bJ189Dc8UyQFfjBpiApo+e9gn0RJfD
         Meo+Yajj0071xHR2GQaFzfb0RPWg27NWmAc9Q2ozRdndKNd7zWtx4CgN49jQFlHrAlB+
         mfX9bgpjQBICXRU293suKBZKl8jrbCLCmzGmItxYnos72PZa6b6ziop+8Zgq7+pLyhiZ
         IcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UL6RjoyyuUYFB9MVmpYBVdopbDnzvy3y199tA/0p/VY=;
        b=3e3CVqX5Uhh793YkmtOvuSigVvLhl8ysqMiA7lQBh8QjendtaN+ZToaWhtjJyRdDeb
         r2mtjtsF47tVgOzQpu9o7thxWJIjt6/erVzWpI8wmmAD2Cj9507NPuLe+aCQw70xLdCf
         WRma9obQ4KF6VUb6y/jf/qgUnkCQQOA8/WekFMUXWUwDopqOyi1LwaaMnheNiQ0Wl4EZ
         JodSEV2oautHKxLETCaOKadA2vnwYVV9ohKypW6S4bk3duV77BEMTafuOvvjMK6QmLB5
         smV8M16EQxA5zyVTi26DCxyjXh+MKNJo3KFIKVg/6SoCbkbZ65/e3C+bgvbqkMUY/y28
         Lolw==
X-Gm-Message-State: AOAM533NSctaSWXcArLdqXFaPO9OTuWnivz8dgQ1PKAZv3z12gxMD2XX
        6fVSEHJYT5sj77fCwQRhIUyeSQ==
X-Google-Smtp-Source: ABdhPJxPxtwqNbejr6EXdhr5b/1xa1TUz6uESBg5CXlx2/dzkOQaTxiw9+g24JT/E5Y+OYZaydcOGA==
X-Received: by 2002:a05:6a00:8cf:b0:4a8:3ae:1a78 with SMTP id s15-20020a056a0008cf00b004a803ae1a78mr16200301pfu.7.1640578564568;
        Sun, 26 Dec 2021 20:16:04 -0800 (PST)
Received: from localhost ([106.201.42.111])
        by smtp.gmail.com with ESMTPSA id d185sm13114821pgc.58.2021.12.26.20.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 20:16:04 -0800 (PST)
Date:   Mon, 27 Dec 2021 09:46:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH RFC 10/13] mmc: sdhci-spear: fix deferred probing
Message-ID: <20211227041602.3migpqppbehvsgld@vireshk-i7>
References: <20211223171202.8224-1-s.shtylyov@omp.ru>
 <20211223171202.8224-11-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223171202.8224-11-s.shtylyov@omp.ru>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23-12-21, 20:11, Sergey Shtylyov wrote:
> The driver overrides the error codes and IRQ0 returned by platform_get_irq()
> to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
> permanently instead of the deferred probing. Switch to propagating the error
> codes upstream. IRQ0 is no longer returned by platform_get_irq(), so we now
> can safely ignore it...
> 
> Fixes: 682798a596a6 ("mmc: sdhci-spear: Handle return value of platform_get_irq")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
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
