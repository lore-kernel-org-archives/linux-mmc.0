Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFE57E9
	for <linux-mmc@vger.kernel.org>; Tue, 26 Nov 2024 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732620924; cv=none; b=szU2voKDYEbphufZdIZ5q2JqYrxWPj+fmMS2KUVENyCJogffflLsvDPuNN/PO9XmX57Il43F0vtSbKi+xFbhEO8ahtM8fGBNq1qJO0Jjpk0EPDb8ArhIYwMeZNR+aBGro1q2tVWTl99vQPKH3x8fxObZYuIKSMhQThXvl3XZGr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732620924; c=relaxed/simple;
	bh=bF5b26M8pzRgYqkj4JR94qllcx+NlQr0QLIFrLOiXTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHSOIU/jpDIBQlbFgjsmCrQzZDHYXIoEU/FWQVojyLjncGL3x53rbTjEHCANtUt6iEZE9XhiZWkJIidPdZe2EDZg0AjG4pTBXilnNFmgB44ruH3/7Pt2qogK2NU0rpT2p8ILAa0aYEsu9K3aDZLcKeGfiTM2+DlxEAve55coz34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ytwrw4sI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ytwrw4sI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732620922; x=1764156922;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bF5b26M8pzRgYqkj4JR94qllcx+NlQr0QLIFrLOiXTg=;
  b=Ytwrw4sI1IlAW5tpRelkayx83c46BgRKGo49Yowc+FHulAgVR1iHOM+R
   Q16J3LHIaj/UXqJ6xfj8Lv7+wWhcjuxn5G5tJPVRYUcGR0CN6hIeYRW+3
   +4a477urRW+CHbFzbxRJDuLFo64CCI6gUBvJLBfxd10gjmLpDP3Qa8riM
   Emf9XBHdKLIaV3oIXVyfb01BYs0ENO/2o3p0QqQV3jFvSwfbc5I1iPny+
   8NgnQFQ/lpBzqkfR3LMUU4GCHUDkXOevclq9FjSPqL34jpcZB4vc10BZ8
   KupBE6dFeGrpG7qxY2OM7AaZQJRLATaJFFW1qeyekv6gCjDjHoVc3yv95
   Q==;
X-CSE-ConnectionGUID: JnafCHGIQ3OWFAcBxgmhrw==
X-CSE-MsgGUID: S+aH61CmQ/2Vd8hJOnehWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="55274567"
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="55274567"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 03:35:21 -0800
X-CSE-ConnectionGUID: qjDhpS3DTHmYi/oVK+1EOw==
X-CSE-MsgGUID: RTVar3xLSIytXs+upa7CwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="91206500"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.81])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 03:35:18 -0800
Message-ID: <bd3166b6-dbaf-4fab-ba96-9f10955ff4b1@intel.com>
Date: Tue, 26 Nov 2024 13:35:11 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Restore missing regs for RK3576
 platform
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: YiFeng Zhao <zyf@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org
References: <1732267448-72548-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1732267448-72548-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/11/24 11:24, Shawn Lin wrote:
> DECMSHC_EMMC_MISC_CON is introduced from RK3576 which need to be
> saved and restore after .reset() with SDHCI_RESET_ALL is called,
> because we assert the reset line. Otherwise the entire controller
> is broken anyway.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 8999b97..aa46655 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -81,6 +81,8 @@
>  #define DWCMSHC_EMMC_DLL_TXCLK		0x808
>  #define DWCMSHC_EMMC_DLL_STRBIN		0x80c
>  #define DECMSHC_EMMC_DLL_CMDOUT		0x810
> +#define MISC_INTCLK_EN			BIT(1)
> +#define DECMSHC_EMMC_MISC_CON		0x81c
>  #define DWCMSHC_EMMC_DLL_STATUS0	0x840
>  #define DWCMSHC_EMMC_DLL_START		BIT(0)
>  #define DWCMSHC_EMMC_DLL_LOCKED		BIT(8)
> @@ -213,6 +215,7 @@ enum dwcmshc_rk_type {
>  struct rk35xx_priv {
>  	struct reset_control *reset;
>  	enum dwcmshc_rk_type devtype;
> +	bool has_misc_con;
>  	u8 txclk_tapnum;
>  };
>  
> @@ -720,6 +723,7 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
>  	struct rk35xx_priv *priv = dwc_priv->priv;
> +	int misc_con;
>  
>  	if (mask & SDHCI_RESET_ALL && priv->reset) {
>  		reset_control_assert(priv->reset);
> @@ -728,6 +732,12 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>  	}
>  
>  	sdhci_reset(host, mask);
> +
> +	/* Restore DECMSHC_EMMC_MISC_CON */
> +	if (priv->has_misc_con) {
> +		misc_con = sdhci_readl(host, DECMSHC_EMMC_MISC_CON);
> +		sdhci_writel(host, misc_con | MISC_INTCLK_EN, DECMSHC_EMMC_MISC_CON);
> +	}
>  }
>  
>  static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
> @@ -735,7 +745,7 @@ static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
>  {
>  	static const char * const clk_ids[] = {"axi", "block", "timer"};
>  	struct rk35xx_priv *priv;
> -	int err;
> +	int err, misc_con;
>  
>  	priv = devm_kzalloc(dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
>  	if (!priv)
> @@ -746,6 +756,9 @@ static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
>  	else
>  		priv->devtype = DWCMSHC_RK3568;
>  
> +	if (of_device_is_compatible(dev->of_node, "rockchip,rk3576-dwcmshc"))
> +		priv->has_misc_con = true;

Not needed for this patch, but instead of keeping on adding
'if (of_device_is_compatible())', it would be nicer to get parameters
from a table.  Using sdhci_dwcmshc_dt_ids[] might be overkill, but
dwcmshc_rk35xx could have its own little table for has_misc_con and
whatever devtype is for, read using of_match_node() for example.

> +
>  	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
>  	if (IS_ERR(priv->reset)) {
>  		err = PTR_ERR(priv->reset);
> @@ -767,6 +780,10 @@ static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
>  	/* Reset previous settings */
>  	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
>  	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
> +	if (priv->has_misc_con) {
> +		misc_con = sdhci_readl(host, DECMSHC_EMMC_MISC_CON);
> +		sdhci_writel(host, misc_con | MISC_INTCLK_EN, DECMSHC_EMMC_MISC_CON);
> +	}

Probably a bit neater to put that in a separate function since it
is the same code as in rk35xx_sdhci_reset()

>  
>  	dwc_priv->priv = priv;
>  

