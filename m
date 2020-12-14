Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CD7C2BB9A
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Dec 2020 16:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC1022512
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Dec 2020 16:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440309AbgLNQnf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440307AbgLNQne (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2020 11:43:34 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09766C0617B0
        for <linux-mmc@vger.kernel.org>; Mon, 14 Dec 2020 08:42:53 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id f16so16305495otl.11
        for <linux-mmc@vger.kernel.org>; Mon, 14 Dec 2020 08:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IDItWI1H2zdgCBJ7qsVj/mCH0/hwotw5iRObk/6BRmY=;
        b=My+W/dX9eBu8xcYiKOkUoLAlw3/6Qk01Ygt3/jXQ8PcrRurADrJmnUseiDYLXNLlAM
         fxno7RXRJ+mTkIbtUew8jGSJvqhMKoUaNEpFrGE/G832pxltTkqSDHZ39wYiSTGeRBm/
         3RX3qHplnrro0XaY8EMXsb4cHNl/hb5UAO8m7tlkNV7oJSDM4yd44iCr0G3z6U2/xRf+
         q5nVpytP6OXc7o/fD4NjymjF0vV6PAab478J50mzT+utp7t72FjyEemoooCnzHMCf6nA
         YdoWRjgQYOXYhaNAUYKoEy+foitkmUyrCALH/2bQE03pzFtdQzZ7pi0d/DAqEkLzzqxN
         kZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IDItWI1H2zdgCBJ7qsVj/mCH0/hwotw5iRObk/6BRmY=;
        b=Xgm5KCmL727Ju9bvf8YAFQYWXF3zVIdbbrMoOYDwfOcNrVt3St3urdaX5AhuQ0ISw9
         73fUIOY0Ao75DquZUd+BHKJ86RVLJ3HcmhBtoiJz6a5/6t5uxj960kZysnRWcZg9euT7
         IsOpl9M5PAKjLMl3vwCsNNf+UhQCRky/5fZ24wNHDgnQHcw9FJ1GtGTK3FcngouL1bzf
         KZKuqUNWUZNwlqj/FywAjphrIz3w/MiCpKwUZeCo5+LrPptZmQMr76krGDluQA4/WOUg
         TQAG+Rq+rqncW7a9vBdwYj3SExZbNTKBNdeix0scNLstxjAP9HzvSi9nuBFz8X9mytPC
         dtKg==
X-Gm-Message-State: AOAM530ytMptWdxAmVTUUmnm5QX0r9S42v2Dk2Vys43QdOv4a8pwyUKy
        6uQmxhSshs2dEf+xVWG+Jy6HvA==
X-Google-Smtp-Source: ABdhPJxMIWMsvyGFX+dDibExUl/E6x14Cs8oKnJCYdgnOLdiI5EZfYeTGh9q+cw1YUYGAA5q4utOvw==
X-Received: by 2002:a05:6830:1482:: with SMTP id s2mr20405867otq.296.1607964172184;
        Mon, 14 Dec 2020 08:42:52 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w21sm3963794ooj.32.2020.12.14.08.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 08:42:51 -0800 (PST)
Date:   Mon, 14 Dec 2020 10:42:49 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Taniya Das <tdas@codeaurora.org>, vbadigan@codeaurora.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mmc: sdhci-msm: Actually set the actual clock
Message-ID: <X9eWCf3KNxGpvtYO@builder.lan>
References: <20201211091150.v4.1.Iec3430c7d3c2a29262695edef7b82a14aaa567e5@changeid>
 <20201211091150.v4.2.I7564620993acd4baa63fa0e3925ca879a86d3ee3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211091150.v4.2.I7564620993acd4baa63fa0e3925ca879a86d3ee3@changeid>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri 11 Dec 11:12 CST 2020, Douglas Anderson wrote:

> The MSM SDHCI driver always set the "actual_clock" field to 0.  It had
> a comment about it not being needed because we weren't using the
> standard SDHCI divider mechanism and we'd just fallback to
> "host->clock".  However, it's still better to provide the actual
> clock.  Why?
> 
> 1. It will make timeout calculations slightly better.  On one system I
>    have, the eMMC requets 200 MHz (for HS400-ES) but actually gets 192
>    MHz.  These are close, but why not get the more accurate one.
> 
> 2. If things are seriously off in the clock driver and it's missing
>    rates or picking the wrong rate (maybe it's rounding up instead of
>    down), this will make it much more obvious what's going on.
> 
> NOTE: we have to be a little careful here because the "actual_clock"
> field shouldn't include the multiplier that sdhci-msm needs
> internally.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
> Changes in v4:
> - ("mmc: sdhci-msm: Actually set the actual clock") new for v4.
> 
>  drivers/mmc/host/sdhci-msm.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 50beb407dbe9..08a3960001ad 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -328,7 +328,7 @@ static void sdhci_msm_v5_variant_writel_relaxed(u32 val,
>  	writel_relaxed(val, host->ioaddr + offset);
>  }
>  
> -static unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *host,
> +static unsigned int msm_get_clock_mult_for_bus_mode(struct sdhci_host *host,
>  						    unsigned int clock)
>  {
>  	struct mmc_ios ios = host->mmc->ios;
> @@ -342,8 +342,8 @@ static unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *host,
>  	    ios.timing == MMC_TIMING_MMC_DDR52 ||
>  	    ios.timing == MMC_TIMING_MMC_HS400 ||
>  	    host->flags & SDHCI_HS400_TUNING)
> -		clock *= 2;
> -	return clock;
> +		return 2;
> +	return 1;
>  }
>  
>  static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
> @@ -354,14 +354,16 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
>  	struct mmc_ios curr_ios = host->mmc->ios;
>  	struct clk *core_clk = msm_host->bulk_clks[0].clk;
>  	unsigned long achieved_rate;
> +	unsigned int desired_rate;
> +	unsigned int mult;
>  	int rc;
>  
> -	clock = msm_get_clock_rate_for_bus_mode(host, clock);
> -	rc = dev_pm_opp_set_rate(mmc_dev(host->mmc), clock);
> +	mult = msm_get_clock_mult_for_bus_mode(host, clock);
> +	desired_rate = clock * mult;
> +	rc = dev_pm_opp_set_rate(mmc_dev(host->mmc), desired_rate);
>  	if (rc) {
>  		pr_err("%s: Failed to set clock at rate %u at timing %d\n",
> -		       mmc_hostname(host->mmc), clock,
> -		       curr_ios.timing);
> +		       mmc_hostname(host->mmc), desired_rate, curr_ios.timing);
>  		return;
>  	}
>  
> @@ -371,11 +373,12 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
>  	 * encounter it.
>  	 */
>  	achieved_rate = clk_get_rate(core_clk);
> -	if (achieved_rate > clock)
> +	if (achieved_rate > desired_rate)
>  		pr_warn("%s: Card appears overclocked; req %u Hz, actual %lu Hz\n",
> -			mmc_hostname(host->mmc), clock, achieved_rate);
> +			mmc_hostname(host->mmc), desired_rate, achieved_rate);
> +	host->mmc->actual_clock = achieved_rate / mult;
>  
> -	msm_host->clk_rate = clock;
> +	msm_host->clk_rate = desired_rate;
>  	pr_debug("%s: Setting clock at rate %lu at timing %d\n",
>  		 mmc_hostname(host->mmc), achieved_rate, curr_ios.timing);
>  }
> @@ -1756,13 +1759,6 @@ static unsigned int sdhci_msm_get_min_clock(struct sdhci_host *host)
>  static void __sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	u16 clk;
> -	/*
> -	 * Keep actual_clock as zero -
> -	 * - since there is no divider used so no need of having actual_clock.
> -	 * - MSM controller uses SDCLK for data timeout calculation. If
> -	 *   actual_clock is zero, host->clock is taken for calculation.
> -	 */
> -	host->mmc->actual_clock = 0;
>  
>  	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>  
> @@ -1785,7 +1781,7 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>  
>  	if (!clock) {
> -		msm_host->clk_rate = clock;
> +		host->mmc->actual_clock = msm_host->clk_rate = 0;
>  		goto out;
>  	}
>  
> -- 
> 2.29.2.576.ga3fc446d84-goog
> 
