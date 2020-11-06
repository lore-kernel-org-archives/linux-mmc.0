Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F880C55178
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 11:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14D2C206CB
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 11:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="ip/e5/u+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgKFLbb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Nov 2020 06:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgKFLbb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Nov 2020 06:31:31 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AD8C0613D2
        for <linux-mmc@vger.kernel.org>; Fri,  6 Nov 2020 03:31:30 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 11so1022693ljf.2
        for <linux-mmc@vger.kernel.org>; Fri, 06 Nov 2020 03:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hif1CZpMrYGPnFgjUhQLDUvAxi2xjeaezyOfQgkstsM=;
        b=ip/e5/u++h2rXLikKFrTQSqmIo1HDreDxy8nzHlOBWQKhE4wg3ui0uSw4PoWePAX4F
         YIakG+kuGJrgJgmPV8MsBzMXEXUDPFFmxiczeGWBsVAdf4o7NsonRyG66TLe54edmDaD
         E2NItGZf8QggDH14V9QbcV3E/7/qRg+X5Iw0yzRU1+kUp6FmhWC82KYlHirPhwoDJSju
         6Rh2OwaP9nkBJ5/D3Td8carQISBo3YhzNOEp8EkQPut+6itn1kFQU4lU1o/webG4VSZ8
         rav1BhPeBLOKbBTfRPUiB0I3iklnJ1sGz9gMKwnsZIp5orPY26gHlKqgdfS1/VOA5fHb
         hRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hif1CZpMrYGPnFgjUhQLDUvAxi2xjeaezyOfQgkstsM=;
        b=aFwMs/PSh5+nUkyoUa+S2wblfYwa3ks5vyTEAod751kCcssKzB3fmJ6gKKHly/gldn
         IT5rucEA662rOSsuJSsq6sxFMWUw7/6mXD1KtpIDD9HTMT/fVeSldA/5NhdspY08ZYoF
         ekdKXDp6G38+lz5o2vK6PM9RHsQhJTRUhG8n7bYQ2qc49rc+hqYhICtO4dDxi1ABJ5eC
         YYYF8BMiTkjc8Tu7G4v425mj2TfSY3ALOFq83+uaPs9q7Mzf3EeHAxtsWd+DoICsbFXc
         G176OWgLwgoKT/fj6ZJTvTux9TmvIwe+CW3sBQXcH54oOcsUSxSq7zjGcmCqPEedL2m1
         4nLg==
X-Gm-Message-State: AOAM532mdqgRCeYAysDs8xrVl0XfrwjdeOPIeTGHNTqZGjfmIgY404zz
        tK4JePDkBRRFuV0vknfsy/Usqw==
X-Google-Smtp-Source: ABdhPJxE3GzXs+vGJ85CuDuIPZqmAF9AVZ0xVJMZ6+bflinVahMWz77YFam7wWMEb21B9VP3s3xO0w==
X-Received: by 2002:a2e:3c10:: with SMTP id j16mr550600lja.236.1604662289177;
        Fri, 06 Nov 2020 03:31:29 -0800 (PST)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id t14sm128278lfk.221.2020.11.06.03.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 03:31:28 -0800 (PST)
Date:   Fri, 6 Nov 2020 12:31:27 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com,
        kuninori.morimoto.gx@renesas.com, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] mmc: host: renesas_sdhi_core: Missing
 tmio_mmc_host_free() in renesas_sdhi_remove()
Message-ID: <20201106113127.GA3195686@oden.dyn.berto.se>
References: <1604654730-29914-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1604654730-29914-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Shimoda-san,

Thanks for your patch.

On 2020-11-06 18:25:30 +0900, Yoshihiro Shimoda wrote:
> The commit 94b110aff867 ("mmc: tmio: add tmio_mmc_host_alloc/free()")
> added tmio_mmc_host_free(), but missed the function calling in
> the sh_mobile_sdhi_remove() at that time. So, fix it. Otherwise,
> we cannot rebind the sdhi/mmc devices when we use aliases of mmc.
> 
> Fixes: 94b110aff867 ("mmc: tmio: add tmio_mmc_host_alloc/free()")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 4143141..03c905a 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -1160,6 +1160,7 @@ int renesas_sdhi_remove(struct platform_device *pdev)
>  
>  	tmio_mmc_host_remove(host);
>  	renesas_sdhi_clk_disable(host);
> +	tmio_mmc_host_free(host);
>  
>  	return 0;
>  }
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund
