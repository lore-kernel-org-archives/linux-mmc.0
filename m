Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DBCC43219
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Apr 2022 06:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358236AbiD0Grv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Apr 2022 02:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352922AbiD0Grt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2022 02:47:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693AF14AAEF;
        Tue, 26 Apr 2022 23:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651041879; x=1682577879;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dfbzGwxMcxqDQxAnX1Q+XbxyZ3B+iPmy3T4l8TkYrZw=;
  b=ldeIxM+HxuSZA6/SoXcj9y63pl3UkkLKvUv9JsFopAkioOhDDYvdExwY
   1RLkbmOc+6S8R//t88RWgAStXsa31JZD/p521qXXYeXkT81JOSnNySHk9
   Nhit+hECcAw6/kWIvunf3qYZog8PhTFPbkGKJGeggoClf5rAVoLh2whZR
   u7KzmwXOASB0DuIo7duP1V5eeR/KZ8BlU3+W/C01RWHVy1ZUBvr6mwHHE
   dtenNGZK4qGrJgZMZ7vKzY4NvYH4ivk3WQi7quQWVj2/xtrZaH7M1coE8
   PWY+TUsRPMw8SLzRTIE+QODHHE410kDLMsZ6AjGcdXthYl8pr4BDAIEMa
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="247764291"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="247764291"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 23:44:38 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="580413988"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 23:44:36 -0700
Message-ID: <af7d438f-914b-e93c-5dd4-b046156d7e2e@intel.com>
Date:   Wed, 27 Apr 2022 09:44:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH 3/5] mmc: sdhci-brcmstb: Enable Clock Gating to save power
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220421182803.6495-1-kdasu.kdev@gmail.com>
 <20220421182803.6495-4-kdasu.kdev@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220421182803.6495-4-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21/04/22 21:28, Kamal Dasu wrote:
> From: Al Cooper <alcooperx@gmail.com>
> 
> Enabling this feature will allow the controller to stop the bus
> clock when the bus is idle. The feature is not part of the standard
> and is unique to newer Arasan cores and is enabled with a bit in a
> vendor specific register. This feature will only be enabled for
> non-removable devices because they don't switch the voltage and
> clock gating breaks SD Card volatge switching.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 35 +++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index f32aa045c26d..d5cb3e8978b2 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -17,11 +17,14 @@
>  
>  #define SDHCI_VENDOR 0x78
>  #define  SDHCI_VENDOR_ENHANCED_STRB 0x1
> +#define  SDHCI_VENDOR_GATE_SDCLK_EN 0x2
>  
>  #define BRCMSTB_MATCH_FLAGS_NO_64BIT		BIT(0)
>  #define BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT	BIT(1)
> +#define BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE	BIT(2)
>  
>  #define BRCMSTB_PRIV_FLAGS_HAS_CQE		BIT(0)
> +#define BRCMSTB_PRIV_FLAGS_GATE_CLOCK		BIT(1)
>  
>  #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
>  
> @@ -36,6 +39,27 @@ struct brcmstb_match_priv {
>  	const unsigned int flags;
>  };
>  
> +static inline void enable_clock_gating(struct sdhci_host *host)
> +{
> +	u32 reg;
> +
> +	reg = sdhci_readl(host, SDHCI_VENDOR);
> +	reg |= SDHCI_VENDOR_GATE_SDCLK_EN;
> +	sdhci_writel(host, reg, SDHCI_VENDOR);
> +}
> +
> +void brcmstb_reset(struct sdhci_host *host, u8 mask)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	sdhci_reset(host, mask);
> +
> +	/* Reset will clear this, so re-enable it */
> +	if (priv->flags & BRCMSTB_PRIV_FLAGS_GATE_CLOCK)
> +		enable_clock_gating(host);
> +}
> +
>  static void sdhci_brcmstb_hs400es(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> @@ -131,7 +155,7 @@ static struct sdhci_ops sdhci_brcmstb_ops = {
>  static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
>  	.set_clock = sdhci_brcmstb_set_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> -	.reset = sdhci_reset,
> +	.reset = brcmstb_reset,
>  	.set_uhs_signaling = sdhci_brcmstb_set_uhs_signaling,
>  };
>  
> @@ -147,6 +171,7 @@ static struct brcmstb_match_priv match_priv_7445 = {
>  };
>  
>  static const struct brcmstb_match_priv match_priv_7216 = {
> +	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
>  	.hs400es = sdhci_brcmstb_hs400es,
>  	.ops = &sdhci_brcmstb_ops_7216,
>  };
> @@ -273,6 +298,14 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  	if (res)
>  		goto err;
>  
> +	/*
> +	 * Automatic clock gating does not work for SD cards that may
> +	 * voltage switch so only enable it for non-removable devices.
> +	 */
> +	if ((match_priv->flags & BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE) &&
> +	    (host->mmc->caps & MMC_CAP_NONREMOVABLE))
> +		priv->flags |= BRCMSTB_PRIV_FLAGS_GATE_CLOCK;
> +
>  	/*
>  	 * If the chip has enhanced strobe and it's enabled, add
>  	 * callback

