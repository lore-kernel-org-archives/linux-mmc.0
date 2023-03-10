Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B409C6FD1E
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Mar 2023 11:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCJL5o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Mar 2023 06:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjCJL5n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Mar 2023 06:57:43 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72933B775
        for <linux-mmc@vger.kernel.org>; Fri, 10 Mar 2023 03:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678449462; x=1709985462;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=DKnah2lkCe7jHy6Hgj2T8tYgTJ+V9U36AQfst+0kVpM=;
  b=HL8EximghelD+LCf45iFnA8gp2R0pM7EFW8TEdYfwO0omitEu8LG8N0t
   hOuPAZolpuoSz7t+/Nb0dU0T3D6a3zuGIZUJEI0R4da71YBn9NtgftMi2
   NPj1PVPcovo+kxH48ZT16V0hcK/Cj/TV5jh0IVeCO3E9ugBIhvO6rroJP
   Highbho2/vNOlVCGDTLGnkrq+CJm270oMDPmYv7eoNoc9IxaNmCLLrkfr
   zHZ6SLsV3NBGSb1XyW0ORGheqmHWjrA9rP8tSjm42CAP/dT5anxJhYtZW
   oh3d+D56MKNVgSt5VZV8cVyVsZqFP35pnuy7nQokyx6EZiafTtWQnZv7p
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="399309927"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="399309927"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:57:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="710260075"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="710260075"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.222])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:57:40 -0800
Message-ID: <3a0bf35d-779b-b611-aee0-57d1f926537b@intel.com>
Date:   Fri, 10 Mar 2023 13:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: properly determine max clock on
 Rockchip
Content-Language: en-US
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20230310010349.509132-1-anarsoul@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230310010349.509132-1-anarsoul@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/03/23 03:03, Vasily Khoruzhick wrote:
> Currently .get_max_clock returns the current clock rate for cclk_emmc
> on rk35xx, thus max clock gets set to whatever bootloader set it to.
> 
> In case of u-boot, it is intentionally reset to 50 MHz if it boots
> from eMMC, see mmc_deinit() in u-boot sources. As a result, HS200 and
> HS400 modes are never selected by Linux, because dwcmshc_rk35xx_postinit
> clears appropriate caps if host->mmc->f_max is < 52MHz
> 
> cclk_emmc is not a fixed clock on rk35xx, so using
> sdhci_pltfm_clk_get_max_clock is not appropriate here.
> 
> Implement rk35xx_get_max_clock that returns actual max clock for cclk_emmc.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index d1490469184b..e68cd87998c8 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -126,6 +126,13 @@ static unsigned int dwcmshc_get_max_clock(struct sdhci_host *host)
>  		return pltfm_host->clock;
>  }
>  
> +static unsigned int rk35xx_get_max_clock(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +	return clk_round_rate(pltfm_host->clk, ULONG_MAX);
> +}
> +
>  static void dwcmshc_check_auto_cmd23(struct mmc_host *mmc,
>  				     struct mmc_request *mrq)
>  {
> @@ -343,7 +350,7 @@ static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
>  	.set_clock		= dwcmshc_rk3568_set_clock,
>  	.set_bus_width		= sdhci_set_bus_width,
>  	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
> -	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
> +	.get_max_clock		= rk35xx_get_max_clock,
>  	.reset			= rk35xx_sdhci_reset,
>  	.adma_write_desc	= dwcmshc_adma_write_desc,
>  };

