Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B836C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 17 May 2022 20:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352936AbiEQU3k (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 May 2022 16:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiEQU3j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 May 2022 16:29:39 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA3552B08;
        Tue, 17 May 2022 13:29:38 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id x12so245065pgj.7;
        Tue, 17 May 2022 13:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=65h11tGj1iWpBlAz3WOrhUCPRsx45J5QDY1+WaKKjvs=;
        b=Ya2CJNcEq/WE5/MB9aSGfgmnTFc9FO+paOQnawgbV6G9r9hqPJUM6TKjOnly0vbJwl
         HrYQoQlepYyawN364LM7Y+xDSVunP+aSq2PQmo2lHYs+3FEfN/xpbtwWmDWkRsRe9tFx
         w/awtT4sxEbcIC/cMmAbdarmLYf/xcuoEZ3UMzetg0xkToZ9rGnVX5vunKEKQm+Uy+mP
         n/OPSLvkQf2tlXKSFEzC9Lrn3TzFnHfJS4vG10PB5VXlw7ygeFe3H0Ki5cX/PWnHnW6n
         BikinXcQhJKAsR1dwbk2TOi8vanlkQYB76EDigPlayIdHzN4ulV+E++QN3RwoINUrK3T
         jrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=65h11tGj1iWpBlAz3WOrhUCPRsx45J5QDY1+WaKKjvs=;
        b=WXC35SNwFh/OpapjNxz9iuET7LvmbgBLHMpyiWJ8LSmP6Fa3zeRdVmTQHbkZSWNI4R
         vTdEncIKU+BrwAGhijDv71bP+Dcxz90KggKuph5QyVJ53klV3N5aGscpguYQFSswZcli
         2mirJNbeEZE9s1Npkf9s9cD5t22V3ddNE/ODf+rWeNSRSI79OhUsmUwqp9IRLvVUqLIq
         EtnXAgMPMyxKH4nEaPSBj/lzoyRbD2Hg3o8CoZJAPmLOf4twNaK1twC0MF2OooRrlRqM
         zs6K1r+11xyLc0K+Qzhfot5qhhJmeW+xlHCtvNQYQuE82niLZCbha8e55iF8Hhy0v/R9
         e92Q==
X-Gm-Message-State: AOAM530ziwqI0K911+eqihf/vHHRA/9jZV0vFf5ThWIE7/BcTr+3b6Sz
        9Y4vxsAGGxZYihknKwX9yqlIlP4TLjA=
X-Google-Smtp-Source: ABdhPJxzTzusNzfBW0Cq/DEdmC++0N4V6Fzn1SbBka5eA7h92x6Imd7X9QLuZ6uQ24LCWEuG61ywYg==
X-Received: by 2002:a63:d301:0:b0:3c1:7361:b260 with SMTP id b1-20020a63d301000000b003c17361b260mr21186445pgg.367.1652819377688;
        Tue, 17 May 2022 13:29:37 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id b19-20020a17090a991300b001df4a0e9357sm39788pjp.12.2022.05.17.13.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 13:29:37 -0700 (PDT)
Message-ID: <146fb86f-c66d-4c72-d953-a73271d855f4@gmail.com>
Date:   Tue, 17 May 2022 13:29:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] mmc: sdhci-brcmstb: Add ability to increase max
 clock rate for 72116b0
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, alcooperx@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220517180435.29940-1-kdasu.kdev@gmail.com>
 <20220517180435.29940-3-kdasu.kdev@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220517180435.29940-3-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Kamal,

On 5/17/2022 11:04 AM, Kamal Dasu wrote:
> From: Al Cooper <alcooperx@gmail.com>
> 
> The 72116B0 has improved SDIO controllers that allow the max clock
> rate to be increased from a max of 100MHz to a max of 150MHz. The
> driver will need to get the clock and increase it's default rate
> and override the caps register, that still indicates a max of 100MHz.
> The new clock will be named "sdio_freq" in the DT node's "clock-names"
> list. The driver will use a DT property, "max-frequency", to
> enable this functionality and will get the actual rate in MHz
> from the property to allow various speeds to be requested.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>   drivers/mmc/host/sdhci-brcmstb.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 8eb57de48e0c..bb614a5e1ea4 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -250,6 +250,8 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>   	struct sdhci_pltfm_host *pltfm_host;
>   	const struct of_device_id *match;
>   	struct sdhci_brcmstb_priv *priv;
> +	struct clk *master_clk;
> +	u32 actual_clock_mhz;
>   	struct sdhci_host *host;
>   	struct resource *iomem;
>   	struct clk *clk;
> @@ -330,6 +332,32 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>   	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
>   		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>   
> +	/* Change the base clock frequency if the DT property exists */
> +	if (!(host->mmc->f_max))
> +		goto add_host;
> +
> +	master_clk = devm_clk_get(&pdev->dev, "sdio_freq");

This looks like a candidate for devm_clk_get_optional() since the clock 
is optional. Then you can call clk_prepare_enable() unconditionally even 
if it is NULL/non-existent.

> +	if (IS_ERR(master_clk)) {
> +		dev_warn(&pdev->dev, "Clock for \"sdio_freq\" not found\n");
> +		goto add_host;
> +	} else {
> +		res = clk_prepare_enable(master_clk);
> +		if (res)
> +			goto err;

It looks like we may be leaving the clock enabled even when we did not 
want to (e.g.: error path) and do not we need to turn if off, 
respectively turn it back on in .suspend() and .resume()?

> +	}
> +
> +	/* set improved clock rate */
> +	clk_set_rate(master_clk, host->mmc->f_max);
> +	actual_clock_mhz = clk_get_rate(master_clk) / 1000000;
> +
> +	host->caps &= ~SDHCI_CLOCK_V3_BASE_MASK;
> +	host->caps |= (actual_clock_mhz << SDHCI_CLOCK_BASE_SHIFT);
> +	/* Disable presets because they are now incorrect */
> +	host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> +	dev_dbg(&pdev->dev, "Base Clock Frequency changed to %dMHz\n",
> +		actual_clock_mhz);
> +
> +add_host:
>   	res = sdhci_brcmstb_add_host(host, priv);
>   	if (res)
>   		goto err;

It looks like we would need to unwind the clk_prepare_enable(master_clk) 
in case of failures here.
-- 
Florian
