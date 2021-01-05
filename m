Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F583C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Jan 2021 19:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34B0322D5B
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Jan 2021 19:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbhAETUs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbhAETUs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jan 2021 14:20:48 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ACFC061796
        for <linux-mmc@vger.kernel.org>; Tue,  5 Jan 2021 11:20:07 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id x23so212075oop.1
        for <linux-mmc@vger.kernel.org>; Tue, 05 Jan 2021 11:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pApZtT3kUoc3iG8fxyNumTsrhIoA70XGH4vOpczgKSg=;
        b=GFG4+jX20prcNuncQrsCbCXaDE1/+gSTKbaKjfYpz+g0RCZIbl4pXANTxdKUdUTmHS
         lYnsCEF966ZB+WYWeLXJI5CTuI4zriBu1UQ4Xc02Zuuo6RUFjeJzXQazknR4gKhGe+fC
         3pPWITGRrA3Ktne+C44Q7JHlkdxng69Cw67wRXX3/ejaBneJgkyykaqaprrnUm7Tr54m
         0X3tzTP4wrhtMOt1hZFzo7MKIenhTCcdq+DUtEoXASuzsXgY4zHSi92BJ8HQdUhhbhjg
         chjSOgT7DKZBh+45Ve9DBTxsBmtYtM4IB7XZHzo3IM+dMAOuw43CyXk1+hD5ezrL2lpu
         dZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pApZtT3kUoc3iG8fxyNumTsrhIoA70XGH4vOpczgKSg=;
        b=gpth2mpVeIqJySeOIYcZ+ZUdoPARxlTzxtq2xz+pWG6qqJGI00MIQ0to3Qf6K3Ehdi
         KOqA2SeOW3EbJ6B64PTUjn8hrqOtog45O05S5LMqClmdD94kJJTPumUPz+P6aPVcXq9N
         KIUqejHvZqzKgpFTquTfSikPZtMrMriACD/RSl82oecgRruEd1zwtx4uhSJrMWfqBIPT
         T2gJ+vxwUWEbuJ0Y8nTCDCeL3rI9K39gxUzgViyiPGZPWPzRhFfqu/DoWr+Tw2J4NKfo
         J0Q8NsHSfQKeU1N3cnZQQn3ippD0JOcOMiMT3eB0efmcEvg9JNzGQOswsHZtWwh0r64D
         sRMw==
X-Gm-Message-State: AOAM531Hf5T/801ULLvO0+x7pH8WyOL77ElDumPZ50t+8/mBV6d73+mj
        ttqsKIjz73HJSywIA7o96h4P5w==
X-Google-Smtp-Source: ABdhPJzXak7VMpj8lBTjdyUrKLPtv3rchrkXI4TeIrAZmIGtz8rHTtTrm8rWH9LxaRbq0cAhEmVtRA==
X-Received: by 2002:a05:6820:441:: with SMTP id p1mr408451oou.21.1609874406662;
        Tue, 05 Jan 2021 11:20:06 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g21sm23083otj.77.2021.01.05.11.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:20:05 -0800 (PST)
Date:   Tue, 5 Jan 2021 13:20:04 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH] mmc: sdhci-msm: Fix possible NULL pointer exception
Message-ID: <X/S75LlfnMWw+seh@builder.lan>
References: <1608626913-16675-1-git-send-email-mdalam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608626913-16675-1-git-send-email-mdalam@codeaurora.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue 22 Dec 02:48 CST 2020, Md Sadre Alam wrote:

> of_device_get_match_data returns NULL when no match.
> So add the NULL pointer check to avoid dereference.
> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 9c7927b..f20e424 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2235,6 +2235,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	 * the data associated with the version info.
>  	 */
>  	var_info = of_device_get_match_data(&pdev->dev);
> +	if (!var_info)

To get this you (the SDHCI driver developer) needs to add an entry in
sdhci_msm_dt_match[] without a .data specified.

> +		goto pltfm_free;

And this will cause sdhci_msm_probe() to return 0, giving no hint to
said developer that they screwed up. Given that this can only be caused
by a developer working on this driver you should provide feedback
suitable for such developer, e.g. by:

	if (WARN_ON(!var_info))
		return -EINVAL;

But given that this is only for the developer himself, I don't see that
this adds any value over just reading the callstack you get from the
panic when the next line dereferences var_info (NULL).

Regards,
Bjorn

>  
>  	msm_host->mci_removed = var_info->mci_removed;
>  	msm_host->restore_dll_config = var_info->restore_dll_config;
> -- 
> 2.7.4
> 
