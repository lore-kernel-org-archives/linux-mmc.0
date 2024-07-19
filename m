Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E426824211;
	Fri, 19 Jul 2024 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721395428; cv=none; b=kvW2eYQxl2Bw36Dxh1p3y4X0J8C3L9OTCRLYsZQwEBqRUgZmYDN6Qm9ANrJFqjUZDeE8NflrsOpjPQUK/9oEbN/PnK5oXqYGHsagLhwpbmkdEdPFLjgmFQlhRfmUbEtY2tf8DPEga+mfuL9+ncCBMxDHpFxYY4WQ3fAkxS8TchA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721395428; c=relaxed/simple;
	bh=rL0qQz3bf5sQLGtti36JxstdaTgsUAOfAw64mFDeiLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2CY5L0cmxALCqcNwhstTWYzvW7rhxQpbsjGehK02kzFHuyxjhBaOyr0mVvXZH/PQi4s7vMiZEbFgQQ0LSt+MgWjwLoGBgO8cVU5RrfGjTLk2zDTRuj+WfLflFR/l5fgTA47yAzWwzXdHJxK1tVsJeQYaLBPx3yPlSJ3DkO/OP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=afVypRHI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afVypRHI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721395427; x=1752931427;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rL0qQz3bf5sQLGtti36JxstdaTgsUAOfAw64mFDeiLc=;
  b=afVypRHI/qGWfpW8vD26M+Ovll+TG/tIM4AyKxKeRtXELKN8G3loxRzn
   RQfz77jWKE7AYUfKA17m1r2btzaHq6XkoBj8cGJZbZBrBlShtst6fzHSp
   8iZdXGVn4CtTbTQ7eTBGNT1WZtVip6xtGNWSFmJGOXutTVnJocs+4zrqD
   d67ICvxknDtnsigUU9zowKB12hnc8zPCMRI6u/aN+BbmqG0f1+3mAvwhE
   wByaMmV7n+anuDHrwx0fFSd6EV0GkVj2rfRSdOH4Wv03OY3WjSrDYEhSD
   gva6CIEQVdZjigN3z4MZzwgCznbu6ui+RBJM0xhpbemOHUgiXuL8KevVR
   g==;
X-CSE-ConnectionGUID: T3y7IBj9Rnizmlw9lZWsfg==
X-CSE-MsgGUID: W2eMPoAXTJGAuEKQeWxMsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="30158874"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="30158874"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 06:23:46 -0700
X-CSE-ConnectionGUID: R9lYcB/vSpyJrOmZemS+0Q==
X-CSE-MsgGUID: 9oXb3w/UQze62qk/h+2wcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="51171213"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.150.149])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 06:23:39 -0700
Message-ID: <9d87c796-ae47-4f5a-8506-f0723be9c989@intel.com>
Date: Fri, 19 Jul 2024 16:23:32 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] mmc: sdhci-of-dwcmshc: factor out code into
 dwcmshc_rk35xx_init
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
 conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
 jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
 tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>
References: <cover.1721377374.git.unicorn_wang@outlook.com>
 <1bb79db9f05ade17d269acefb6dcdce455236b92.1721377374.git.unicorn_wang@outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1bb79db9f05ade17d269acefb6dcdce455236b92.1721377374.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/07/24 11:46, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Continue factor out code fron probe into dwcmshc_rk35xx_init.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 34 ++++++++++++++---------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index bb0adc2ee325..30e4cea8a058 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -711,12 +711,22 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>  	sdhci_reset(host, mask);
>  }
>  
> -static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> +static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
> +			       struct dwcmshc_priv *dwc_priv)
>  {
>  	static const char * const clk_ids[] = {"axi", "block", "timer"};
> -	struct rk35xx_priv *priv = dwc_priv->priv;
> +	struct rk35xx_priv *priv;
>  	int err;
>  
> +	priv = devm_kzalloc(dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	if (of_device_is_compatible(dev->of_node, "rockchip,rk3588-dwcmshc"))
> +		priv->devtype = DWCMSHC_RK3588;
> +	else
> +		priv->devtype = DWCMSHC_RK3568;
> +
>  	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
>  	if (IS_ERR(priv->reset)) {
>  		err = PTR_ERR(priv->reset);
> @@ -739,6 +749,8 @@ static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
>  	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
>  	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
>  
> +	dwc_priv->priv = priv;
> +
>  	return 0;
>  }
>  
> @@ -1184,7 +1196,6 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_host *host;
>  	struct dwcmshc_priv *priv;
> -	struct rk35xx_priv *rk_priv = NULL;
>  	const struct sdhci_pltfm_data *pltfm_data;
>  	int err;
>  	u32 extra, caps;
> @@ -1241,20 +1252,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
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
> -		err = dwcmshc_rk35xx_init(host, priv);
> +		err = dwcmshc_rk35xx_init(dev, host, priv);
>  		if (err)
>  			goto err_clk;
>  	}
> @@ -1290,7 +1288,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  		dwcmshc_cqhci_init(host, pdev);
>  	}
>  
> -	if (rk_priv)
> +	if (priv->priv)

It would be clearer here to use

	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata)

>  		dwcmshc_rk35xx_postinit(host, priv);
>  
>  	err = __sdhci_add_host(host);

