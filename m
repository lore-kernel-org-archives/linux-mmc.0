Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191682AEE9;
	Fri, 14 Jun 2024 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361205; cv=none; b=WYFqlK6worFwvrdHOTgbxVZzOTEeG4MIk6deTvXwFQVrLQXiJ9nX8tkiaxA9Smx69jVOaKXao4s9CqYnmPsZhaYT1SUhrVlIbEK/bY6vVDZ6R73OK6I5Cs6sXlFmiIWCcSga0eR1dRwg3rcmeMrmgt7OrJuFMHUx4jaCNdVRFDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361205; c=relaxed/simple;
	bh=E/xEtRlIojGJ4rk2DeNsa98B5Haa8Oxs9KK7LwLX9Lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnmjQEs0/OtrRp44VTMNrG3vAl7x0g1fFtwF5bbYPJJf5coVdAWoZN58pZ4ztsT9FRUxs2ZqHSqBQU1SE+lNiVyjpBgZS65TJzM0J4e59HR+3Juy2sdwMcn6tfcZMxG3xv5NBmetIjzk67IYtvAowQFHMJlAZtc7z3hXY+0b+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JzMQl+Yc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JzMQl+Yc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718361204; x=1749897204;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E/xEtRlIojGJ4rk2DeNsa98B5Haa8Oxs9KK7LwLX9Lw=;
  b=JzMQl+YcbmvpM7b8YxZcBMhvm/JAf8QT5w6bNTIKY2nX9nw/Q5GhJBMz
   QQICgePbpXHhW+BVJWZzn+DIqo8yFx+YKiGw6aIS5VbpnK6Pj8RrA+CO7
   JtHWIv8FLZvUc2e+nx50mQWhLAEMuF4Xc5mAmAkev70akr5nX2OM4FJtU
   /M82Lrk69tUBHfoahU3eTERPVtzgW3EPKfPbbVTD+GzWb1NnbCtM8fYCw
   MOtOGGgEwb/Ar9jTOJRJ+KhsRrtqfnp6QFEGeH9/896SBD7ujSUdkDD0d
   GZorR8B8dGN3fU+EmXQEfCkTtH65kMPqyVf2KtuM0UNilvv5Myf7fwY4N
   w==;
X-CSE-ConnectionGUID: aLZVAuHOSpa4maGK/bw98A==
X-CSE-MsgGUID: rEx88AWFQQOnkIwIGKJmlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="25815875"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="25815875"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 03:33:23 -0700
X-CSE-ConnectionGUID: akj9vkTiR5SLcyTW/t0a8A==
X-CSE-MsgGUID: q5T9PPhnScCPeBNgyLGWuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="71230947"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.248.10])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 03:33:15 -0700
Message-ID: <9490cba1-1fa3-4a00-bab8-aa4a07a418f5@intel.com>
Date: Fri, 14 Jun 2024 13:33:10 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] mmc: sdhci-of-dwcmshc: extract init function for
 rk35xx/th1520
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
 conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
 jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
 tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>
References: <cover.1718241495.git.unicorn_wang@outlook.com>
 <459e341a32128ffbae5acdc77a1c835cbee582e6.1718241495.git.unicorn_wang@outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <459e341a32128ffbae5acdc77a1c835cbee582e6.1718241495.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/06/24 04:43, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Extract init function for rk35xx/th1520, which is an intermediate
> process before further optimization.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 83 ++++++++++++++++-------------
>  1 file changed, 46 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 346d2d323a05..38ab755aa044 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -749,10 +749,19 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>  	sdhci_reset(host, mask);
>  }
>  
> -static int rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> +static int rk35xx_init(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
>  {
>  	int err;
> -	struct rk35xx_priv *priv = dwc_priv->priv;
> +	struct rk35xx_priv *priv;
> +
> +	priv = devm_kzalloc(dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	if (of_device_is_compatible(dev->of_node, "rockchip,rk3588-dwcmshc"))
> +		priv->devtype = DWCMSHC_RK3588;
> +	else
> +		priv->devtype = DWCMSHC_RK3568;
>  
>  	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
>  	if (IS_ERR(priv->reset)) {
> @@ -787,6 +796,8 @@ static int rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
>  	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
>  	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
>  
> +	dwc_priv->priv = priv;
> +
>  	return 0;
>  }
>  
> @@ -915,6 +926,35 @@ static void th1520_sdhci_reset(struct sdhci_host *host, u8 mask)
>  	}
>  }
>  
> +static int th1520_init(struct device *dev,
> +		       struct sdhci_host *host,
> +		       struct dwcmshc_priv *dwc_priv)
> +{
> +	dwc_priv->delay_line = PHY_SDCLKDL_DC_DEFAULT;
> +
> +	if (device_property_read_bool(dev, "mmc-ddr-1_8v") ||
> +	    device_property_read_bool(dev, "mmc-hs200-1_8v") ||
> +	    device_property_read_bool(dev, "mmc-hs400-1_8v"))
> +		dwc_priv->flags |= FLAG_IO_FIXED_1V8;
> +	else
> +		dwc_priv->flags &= ~FLAG_IO_FIXED_1V8;
> +
> +	/*
> +	 * start_signal_voltage_switch() will try 3.3V first
> +	 * then 1.8V. Use SDHCI_SIGNALING_180 rather than
> +	 * SDHCI_SIGNALING_330 to avoid setting voltage to 3.3V
> +	 * in sdhci_start_signal_voltage_switch().
> +	 */
> +	if (dwc_priv->flags & FLAG_IO_FIXED_1V8) {
> +		host->flags &= ~SDHCI_SIGNALING_330;
> +		host->flags |=  SDHCI_SIGNALING_180;
> +	}
> +
> +	sdhci_enable_v4_mode(host);
> +
> +	return 0;
> +}
> +
>  static void cv18xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1230,46 +1270,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.execute_tuning = dwcmshc_execute_tuning;
>  
>  	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
> -		rk_priv = devm_kzalloc(&pdev->dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
> -		if (!rk_priv) {
> -			err = -ENOMEM;
> -			goto err_clk;
> -		}
> -
> -		if (of_device_is_compatible(pdev->dev.of_node, "rockchip,rk3588-dwcmshc"))
> -			rk_priv->devtype = DWCMSHC_RK3588;
> -		else
> -			rk_priv->devtype = DWCMSHC_RK3568;
> -
> -		priv->priv = rk_priv;
> -
> -		err = rk35xx_init(host, priv);
> +		err = rk35xx_init(&pdev->dev, host, priv);

rk_priv is used further on, but it is not assigned anymore.

>  		if (err)
>  			goto err_clk;
>  	}
>  
>  	if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
> -		priv->delay_line = PHY_SDCLKDL_DC_DEFAULT;
> -
> -		if (device_property_read_bool(dev, "mmc-ddr-1_8v") ||
> -		    device_property_read_bool(dev, "mmc-hs200-1_8v") ||
> -		    device_property_read_bool(dev, "mmc-hs400-1_8v"))
> -			priv->flags |= FLAG_IO_FIXED_1V8;
> -		else
> -			priv->flags &= ~FLAG_IO_FIXED_1V8;
> -
> -		/*
> -		 * start_signal_voltage_switch() will try 3.3V first
> -		 * then 1.8V. Use SDHCI_SIGNALING_180 rather than
> -		 * SDHCI_SIGNALING_330 to avoid setting voltage to 3.3V
> -		 * in sdhci_start_signal_voltage_switch().
> -		 */
> -		if (priv->flags & FLAG_IO_FIXED_1V8) {
> -			host->flags &= ~SDHCI_SIGNALING_330;
> -			host->flags |=  SDHCI_SIGNALING_180;
> -		}
> -
> -		sdhci_enable_v4_mode(host);
> +		err = th1520_init(&pdev->dev, host, priv);
> +		if (err)
> +			goto err_clk;
>  	}
>  
>  #ifdef CONFIG_ACPI

