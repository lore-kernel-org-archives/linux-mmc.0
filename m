Return-Path: <SRS0=5xTW=4I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBE6C11D05
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Feb 2020 15:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678482071E
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Feb 2020 15:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fh3smCJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgBTPpc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:45:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45738 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgBTPpb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Feb 2020 10:45:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so2111303pgk.12
        for <linux-mmc@vger.kernel.org>; Thu, 20 Feb 2020 07:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CwUtQG3ysdjtoTwY2Er+T+4K6J2ZCQx9iACvDy/itGY=;
        b=fh3smCJZVlzJ+zKEK1STSDsQr2MUvxqPxp+V4hZs1mLi9cW1cA1De7jQCu/XYaLFv5
         h3/BIQGd/PnZ9WZrW3lrqnlZ7+kfrw84qy4pZgzB9HD/wqHFDqZIYhvr148g1Lum7fz7
         ikzS0lWugw5jN3RBadxu9U3WIBSlOq6wxgunFzWBD27l1oFfKj2YtSSQN4nB6KLzwqE6
         ApU8m+KQsJCH7VorbPl/uyWpq/3yFCNh1YaTP7SSU9tyYfvYoYUc3oqrv6eM/bYP70KK
         8lX6gJ5+zFt9Qwy9SAdrd2wthxXSyW8i7FauH2OgBcsAuTbSJx5y/lyYfe+Mp8Xj4Llt
         FjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CwUtQG3ysdjtoTwY2Er+T+4K6J2ZCQx9iACvDy/itGY=;
        b=cO8LbEzzYdsuxYMnpPLJzaddbPRXpKfXQKXvCUotSYGW2h83MNn2Dkeojfr8/LlZKg
         TGooYW52kkn9tFDhyZUGipphnLNBaygrEooP2UvEm8Wvkh3jAh2RdqnABaLAbu00mivp
         jinnC+mU5zCq4vcL88J+QWNl8ckRUB6J4qKYPv3qk1ghMPrzaVPBcaB2sCZeKqtp6Vlu
         65ysAqrTeFZm+TPRhdPrOz95gV7cZvoNepFyKqqcvoUlGbThUGr8e2rljnah5NAWj1U1
         kZZDVderH8GJAZYE8txPvXOYYMdkrELsG7/miJCvSrccYdkSyjixxI/xvJWCzqpS7u1g
         h1ZQ==
X-Gm-Message-State: APjAAAWL22ytlJ1HNHcvpI8SmJ3eQACDU1no9Jl4mOK9bPHpaKvWCdLb
        NmHRaGeA6B/mkFyY3DJOu85dwg==
X-Google-Smtp-Source: APXvYqxjPjf7mAWjfTxykHdMiP9gdlPASYKiphcSgbc+VtRyHB9Kt/+CXzy72wijKoU2NbNFfhuppw==
X-Received: by 2002:a63:de0d:: with SMTP id f13mr34823815pgg.12.1582213530706;
        Thu, 20 Feb 2020 07:45:30 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i2sm3888292pjs.21.2020.02.20.07.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:45:29 -0800 (PST)
Date:   Thu, 20 Feb 2020 07:44:34 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sayali Lokhande <sayalil@codeaurora.org>
Cc:     adrian.hunter@intel.com, robh+dt@kernel.org,
        ulf.hansson@linaro.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, ppvk@codeaurora.org,
        rampraka@codeaurora.org, vbadigan@codeaurora.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, mka@chromium.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-mmc-owner@vger.kernel.org
Subject: Re: [PATCH RFC] mmc: sdhci-msm: Toggle fifo write clk after ungating
 sdcc clk
Message-ID: <20200220154434.GB955802@ripper>
References: <1582190446-4778-1-git-send-email-sayalil@codeaurora.org>
 <1582190446-4778-2-git-send-email-sayalil@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582190446-4778-2-git-send-email-sayalil@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu 20 Feb 01:20 PST 2020, Sayali Lokhande wrote:

> From: Ram Prakash Gupta <rampraka@codeaurora.org>
> 
> During GCC level clock gating of MCLK, the async FIFO
> gets into some hang condition, such that for the next
> transfer after MCLK ungating, first bit of CMD response
> doesn't get written in to the FIFO. This cause the CPSM
> to hang eventually leading to SW timeout.

Does this always happen, on what platforms does this happen? How does
this manifest itself? Can you please elaborate.

> 
> To fix the issue, toggle the FIFO write clock after
> MCLK ungated to get the FIFO pointers and flags to
> valid states.
> 
> Change-Id: Ibef2d1d283ac0b6983c609a4abc98bc574d31fa6

Please drop the Change-Id and please add

Cc: stable@vger.kernel.org

If this is a bug fix that should be backported to e.g. 5.4.

> Signed-off-by: Ram Prakash Gupta <rampraka@codeaurora.org>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index c3a160c..eaa3e95 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -127,6 +127,8 @@
>  #define CQHCI_VENDOR_CFG1	0xA00
>  #define CQHCI_VENDOR_DIS_RST_ON_CQ_EN	(0x3 << 13)
>  
> +#define RCLK_TOGGLE 0x2

Please use BIT(1) instead.

> +
>  struct sdhci_msm_offset {
>  	u32 core_hc_mode;
>  	u32 core_mci_data_cnt;
> @@ -1554,6 +1556,43 @@ static void __sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  	sdhci_enable_clk(host, clk);
>  }
>  
> +/*
> + * After MCLK ugating, toggle the FIFO write clock to get
> + * the FIFO pointers and flags to valid state.
> + */
> +static void sdhci_msm_toggle_fifo_write_clk(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	const struct sdhci_msm_offset *msm_offset =
> +					msm_host->offset;

This doesn't look to be > 80 chars, please unwrap.

> +	struct mmc_card *card = host->mmc->card;
> +
> +	if (msm_host->tuning_done ||
> +			(card && card->ext_csd.strobe_support &&
> +			card->host->ios.enhanced_strobe)) {
> +		/*
> +		 * set HC_REG_DLL_CONFIG_3[1] to select MCLK as
> +		 * DLL input clock

You can shorten this to /* Select MCLK as DLL input clock */ if you make
the below readl/writel a little bit easier to read.

> +		 */
> +		writel_relaxed(((readl_relaxed(host->ioaddr +
> +			msm_offset->core_dll_config_3))
> +			| RCLK_TOGGLE), host->ioaddr +
> +			msm_offset->core_dll_config_3);

Please use a local variable and write this out as:
		val = readl(addr);
		val |= RCLK_TOGGLE;
		writel(val, addr);

> +		/* ensure above write as toggling same bit quickly */
> +		wmb();

This ensures ordering of writes, if you want to make sure the write has
hit the hardware before the delay perform a readl() on the address.

> +		udelay(2);
> +		/*
> +		 * clear HC_REG_DLL_CONFIG_3[1] to select RCLK as
> +		 * DLL input clock
> +		 */

		/* Select RCLK as DLL input clock */

> +		writel_relaxed(((readl_relaxed(host->ioaddr +
> +			msm_offset->core_dll_config_3))
> +			& ~RCLK_TOGGLE), host->ioaddr +
> +			msm_offset->core_dll_config_3);

Same as above, readl(); val &= ~RCLK_TOGGLE; writel(); will make this
easier on the eyes.

> +	}
> +}
> +
>  /* sdhci_msm_set_clock - Called with (host->lock) spinlock held. */
>  static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
> @@ -2149,6 +2188,10 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
>  				       msm_host->bulk_clks);
>  	if (ret)
>  		return ret;

An empty line please.

> +	if (host->mmc &&

Afaict host->mmc can't be NULL, can you please confirm that you need
this check.

> +			(host->mmc->ios.timing == MMC_TIMING_MMC_HS400))
> +		sdhci_msm_toggle_fifo_write_clk(host);
> +

Regards,
Bjorn

>  	/*
>  	 * Whenever core-clock is gated dynamically, it's needed to
>  	 * restore the SDR DLL settings when the clock is ungated.
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
