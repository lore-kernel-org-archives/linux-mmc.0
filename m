Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46ADC433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 12:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B618461261
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 12:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhKQMkP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Nov 2021 07:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhKQMkP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Nov 2021 07:40:15 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CED0C061764
        for <linux-mmc@vger.kernel.org>; Wed, 17 Nov 2021 04:37:16 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id t26so7664224lfk.9
        for <linux-mmc@vger.kernel.org>; Wed, 17 Nov 2021 04:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UmgNinn2XG0l2TpUWf4rIjZei+iMCEFikabmRp2Oijw=;
        b=VIcyXUUnkhvAZoaEKNOq2M/yKqEWjaYjpRjMRTdrb9sWFn0NWiRt44NaqXp+dmCGGl
         5oUbEOay7eRM+/h+SP+th8Dm/VSVD5NlKhMZnO/Sd9TZYC426S2x2fz1N5TbUy7jk6Zj
         /0CdXr8OUfuuxUYRgB0n7H9nzbajOOt995rKyGUyJVxRI0gN2KzjoNNBoQI0Mt3qJqvn
         wyiXeEGSVrkYUsdHiGcImABne+uLWNrLN2kLiWqNJc8f3hyVcWRadwRQNQo4Pdkm4WJy
         doZbiWqjsOOT2cBvTBL1fG/iHyDInhU1jza6HuHRkgwOfYphFGtQafxBO8FlkQRVYqNR
         Q9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UmgNinn2XG0l2TpUWf4rIjZei+iMCEFikabmRp2Oijw=;
        b=KgPDxfr3LyZ7n3gB9m4DxfGL3nDepQOgmqSMQr4WVtMYAcNmWeYY27YkQxswhEfSqv
         eu6wCXZC/BNfJYd68KRS+Q0+jDS1kQLEt9hwdk10qwNi9iJ4O016rcdWWIHgdtJRm5kO
         1c9/2rDBWH9huhz4wIVPnJAAJ+gKwIddvXhUFrrXfDuPgQgTrPapDSQAJMP9Vz9Jgl9V
         XEOqXSF1oOA64wp6GH3rHrrYpQSNtFpu1yHwUYU3CKTqtLsx2HUhq4MBlIl53rG4S9nX
         VR/6Na+BvVq6ZL+5fhOvkQbzMFpLiQ8Dvu+UWPvQcF454xxvQ+BNLmZqDgunK/r/Zi4T
         ja4A==
X-Gm-Message-State: AOAM5313Y4lWy+zVOws8jU2DK1Ml2RWbI5imZiJsbWzQOqq1PcAy0D3K
        7Wpj7HRMDciY6moXZscttvg92w==
X-Google-Smtp-Source: ABdhPJx8dnn1MWVaLvGvat9pWvPezRMJtiUeuocTmxk6ejL4s0ulJIeu/Gt9DwFiczdwPMXzkEnTmA==
X-Received: by 2002:a19:c30e:: with SMTP id t14mr15152912lff.375.1637152634425;
        Wed, 17 Nov 2021 04:37:14 -0800 (PST)
Received: from localhost (h-46-59-88-219.A463.priv.bahnhof.se. [46.59.88.219])
        by smtp.gmail.com with ESMTPSA id x17sm2133612ljp.95.2021.11.17.04.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 04:37:13 -0800 (PST)
Date:   Wed, 17 Nov 2021 13:37:13 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] mmc: renesas_sdhi: simplify an expression
Message-ID: <YZT3eQKg8AIzMIPC@oden.dyn.berto.se>
References: <20211117103850.28397-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211117103850.28397-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

Nice fix.

On 2021-11-17 11:38:50 +0100, Wolfram Sang wrote:
> We already have 'quirks', no need to go via 'priv'.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index a4407f391f66..29bc086f6cb5 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -1044,7 +1044,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>  	     host->mmc->caps2 & (MMC_CAP2_HS200_1_8V_SDR |
>  				 MMC_CAP2_HS400_1_8V))) {
>  		const struct renesas_sdhi_scc *taps = of_data->taps;
> -		bool use_4tap = priv->quirks && priv->quirks->hs400_4taps;
> +		bool use_4tap = quirks && quirks->hs400_4taps;
>  		bool hit = false;
>  
>  		for (i = 0; i < of_data->taps_num; i++) {
> -- 
> 2.30.2
> 

-- 
Kind Regards,
Niklas Söderlund
