Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966F7C4338F
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 12:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 787AE60F22
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 12:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbhHDMdk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Aug 2021 08:33:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:59932 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237177AbhHDMdj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 4 Aug 2021 08:33:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="194190292"
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="194190292"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 05:33:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="480146226"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga008.fm.intel.com with ESMTP; 04 Aug 2021 05:33:23 -0700
Subject: Re: [PATCH v4 4/5] mmc: sdhci: move
 SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN frequency limit
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Michal Simek <michal.simek@xilinx.com>,
        Kevin Liu <kliu5@marvell.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>
References: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
 <ff3907df3aa91f83a4a0a22b63d51bfe491ed039.1627204633.git.mirq-linux@rere.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2cdb95f3-8943-715a-d3d7-804953e49786@intel.com>
Date:   Wed, 4 Aug 2021 15:33:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <ff3907df3aa91f83a4a0a22b63d51bfe491ed039.1627204633.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/07/21 12:20 pm, Michał Mirosław wrote:
> Push handling of clock frequency dependence for
> SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN quirk to the drivers that use it.

What is the max_clk dependency for, and why push it down?

> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
> v4: fix build issue reported by kernel test robot
> v3: rebased on v5.14-rc2 and reworded commitmsg
> v2: reworded commitmsg
> ---
>  drivers/mmc/host/sdhci-of-arasan.c  | 11 ++++-------
>  drivers/mmc/host/sdhci-of-dwcmshc.c |  8 +++++---
>  drivers/mmc/host/sdhci.c            |  3 +--
>  3 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 737e2bfdedc2..f2a6441ab540 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -452,8 +452,7 @@ static const struct sdhci_ops sdhci_arasan_cqe_ops = {
>  static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
>  	.ops = &sdhci_arasan_cqe_ops,
>  	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -1118,7 +1117,6 @@ static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
>  	.ops = &sdhci_arasan_ops,
>  	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
>  			SDHCI_QUIRK2_STOP_WITH_TC,
>  };
>  
> @@ -1141,7 +1139,6 @@ static const struct sdhci_pltfm_data sdhci_keembay_emmc_pdata = {
>  		SDHCI_QUIRK_32BIT_DMA_SIZE |
>  		SDHCI_QUIRK_32BIT_ADMA_SIZE,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -		SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
>  		SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 |
>  		SDHCI_QUIRK2_STOP_WITH_TC |
>  		SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
> @@ -1156,7 +1153,6 @@ static const struct sdhci_pltfm_data sdhci_keembay_sd_pdata = {
>  		SDHCI_QUIRK_32BIT_DMA_SIZE |
>  		SDHCI_QUIRK_32BIT_ADMA_SIZE,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -		SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
>  		SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
>  		SDHCI_QUIRK2_STOP_WITH_TC |
>  		SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
> @@ -1171,7 +1167,6 @@ static const struct sdhci_pltfm_data sdhci_keembay_sdio_pdata = {
>  		SDHCI_QUIRK_32BIT_DMA_SIZE |
>  		SDHCI_QUIRK_32BIT_ADMA_SIZE,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -		SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
>  		SDHCI_QUIRK2_HOST_OFF_CARD_ON |
>  		SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
>  };
> @@ -1197,7 +1192,6 @@ static struct sdhci_arasan_of_data intel_lgm_sdxc_data = {
>  static const struct sdhci_pltfm_data sdhci_arasan_zynqmp_pdata = {
>  	.ops = &sdhci_arasan_ops,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
>  			SDHCI_QUIRK2_STOP_WITH_TC,
>  };
>  
> @@ -1502,6 +1496,9 @@ static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
>  	bool dma64;
>  	int ret;
>  
> +	if (sdhci_pltfm_clk_get_max_clock(host) <= 25000000)
> +		host->quirks2 |= SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN;
> +
>  	if (!sdhci_arasan->has_cqe)
>  		return sdhci_add_host(host);
>  
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index bac874ab0b33..b6b7c4068e90 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -283,14 +283,13 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_rk3568_pdata = {
>  	.ops = &sdhci_dwcmshc_rk3568_ops,
>  	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>  		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>  
>  static int dwcmshc_rk3568_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
>  {
> -	int err;
>  	struct rk3568_priv *priv = dwc_priv->priv;
> +	int err;
>  
>  	priv->rockchip_clks[0].id = "axi";
>  	priv->rockchip_clks[1].id = "block";
> @@ -318,6 +317,9 @@ static int dwcmshc_rk3568_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
>  	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
>  	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
>  
> +	if (sdhci_pltfm_clk_get_max_clock(host) <= 25000000)
> +		host->quirks2 |= SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN;
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0993f7d0ce8e..cfa314e659bc 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1905,8 +1905,7 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  			/* Version 3.00 divisors must be a multiple of 2. */
>  			if (host->max_clk <= clock) {
>  				div = 1;
> -				if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
> -					&& host->max_clk <= 25000000)
> +				if (host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
>  					div = 2;
>  			} else {
>  				for (div = 2; div < SDHCI_MAX_DIV_SPEC_300;
> 

