Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FFE188CBC;
	Thu,  8 Aug 2024 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101566; cv=none; b=FroyeV2IIMW2DVpU20G//Nl/8375IIZhO6RUADHNEruLQ2H3atGVqjPInWildtCUkl6QneNcHY1ElZzPbnMfaTy9tyAa29cfnllw0fwR3FDEN+7EHFgXkeY0wcmGTtXxgpAOHZXpnZcoxz4i/GgQdGAzxQKWGG4Pwd1rMusIRqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101566; c=relaxed/simple;
	bh=9Nbhk6CfRrxq7qd08hKcyo0cO/UojxpBoqL9e0BRuqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlIUlVsEiT+CLSCczEpAqFgUwHQJEdTuDFAeEzF+41nGFXbEZuJjBHFTtz0XpjAgoYmkhv4NSbIJpJ3Rf1fZYVsOofhoSDw3uVU3BlcGqj1HZ/b4LxvsYM/ORWal0Vj19cBr/5IXUsf+KQBZLN9cW53l7T7kV/kAT3HoZ1jHJ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbOmeOly; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbOmeOly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723101566; x=1754637566;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9Nbhk6CfRrxq7qd08hKcyo0cO/UojxpBoqL9e0BRuqo=;
  b=fbOmeOlybPZqMYs5s24xKSqo95XJGd8ZNk1oCeRZXGwWTXOw7YpIqQKp
   F5twH9Ey2O1BVSdWmkax73S4xp0Ul+WxH844Qj8z9WmnpbOktEHsgqQkg
   VV5gmNINvz62Sazl1OXB81+dys3PBAut0hw7JVnagB+RRr9SVGc4HwGTs
   GXQa8zHCM1+e17+qxEqwPJYRBJiwPyECvkZkyYCOJLO2xz8CTTxvxsZtK
   ZchQIfFF6CKDTHG7qHPepCcAQGhF2N+kCagQHS0pbGXGxLFh9VzMTFSTa
   omNKzj11Ai8NcxnPFFsyD/V4i4LdxBhhD3E1miLpqF5jTHCsaNekd/8tC
   A==;
X-CSE-ConnectionGUID: Y80RILrPQeKEsCDjt1mtCQ==
X-CSE-MsgGUID: LImpsg7xS/mTHHj76gm8cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21352345"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21352345"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 00:19:25 -0700
X-CSE-ConnectionGUID: CmF79l6JRrC3hhHl10QrTQ==
X-CSE-MsgGUID: LKuBe3YdQCGqBCxG5kIgLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="80357473"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.150.149])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 00:19:17 -0700
Message-ID: <b87fb5fe-63e1-4f4e-bc7c-92a91becf61e@intel.com>
Date: Thu, 8 Aug 2024 10:19:10 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/8] mmc: sdhci-of-dwcmshc: factor out code into
 dwcmshc_rk35xx_init
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
 conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
 jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
 tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>, Drew Fustini <drew@pdp7.com>
References: <cover.1722847198.git.unicorn_wang@outlook.com>
 <4f1f2fa403ce7f0b4d79afb7d7e8a1690cde5d6c.1722847198.git.unicorn_wang@outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <4f1f2fa403ce7f0b4d79afb7d7e8a1690cde5d6c.1722847198.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/08/24 12:18, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Continue factor out code fron probe into dwcmshc_rk35xx_init.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> Tested-by: Drew Fustini <drew@pdp7.com> # TH1520
> Tested-by: Inochi Amaoto <inochiama@outlook.com> # Duo and Huashan Pi

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 34 ++++++++++++++---------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index b272ec2ab232..55fba5ef37ba 100644
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
> +	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata)
>  		dwcmshc_rk35xx_postinit(host, priv);
>  
>  	err = __sdhci_add_host(host);

