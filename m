Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A861187FFE;
	Thu,  8 Aug 2024 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101585; cv=none; b=MgXx4A9pPJbYr09YgZWkADrVUmXjJQKJblABz/M2hCM8AXDtqGII0Pom+q/DEAQkIKSSSq1TBJj9IPSGriDo9drkTs3r7R9oko30gs/q3UxtWhEhReilV3tIXSlO0qHtYIkrR4zBYv12CK6pexWtHFgwilfYnr9Ex4y+fvlML8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101585; c=relaxed/simple;
	bh=PVtOav9zUh20di99gvdMdPF1Gj/k3H6ZvBRF5Axq+SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIEXD64EE+Ns2EpL3Uxbs6SdEmbfPzP9kzfaGJTwKZ6dhZsCC1swZ/FDKXDTOe7JGlsCS5kx65ccMadWous+njp91l9zfepBY29Pzps6g8NLI7ecFFqZtnTf2HAdvQyO6W9cAIdBuncXZQwgnslRcT7i+ApNmku39Av56Sjfc4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0m3n93N; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0m3n93N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723101581; x=1754637581;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PVtOav9zUh20di99gvdMdPF1Gj/k3H6ZvBRF5Axq+SM=;
  b=k0m3n93Na7qepdv5sYnnlEVxuWH5eP1RKBKK0IAmjrYBLyK2uGgZs1kb
   5pZv1YKA4S3dMX28HT0lfBXxjE/gg8nY93qRJub9B2MvdGTJg3aBg1cQE
   jkTxQgVNIZFmB2R9NH4dcEk5exVaXhicpxZsbW4Y8nB+6W5M7EvyCrn3R
   B+/qzijj8cPIT0sC8pXtdjdqLL87zG9X57B67r4L6bm1tLJfiCIvx6m0D
   u+5p7f2VnmRWyWVSB0XPXGqQhHi/sNtga5X11BX4RvbDL+JfgSOACpgO6
   wVBy3NTNLrOTumUDnFDiIFki0UCF6yBAxRQX8zdGXH3w4h9x4FhxzIElz
   Q==;
X-CSE-ConnectionGUID: p8QpSTzLQ16zhD+VCyrAgw==
X-CSE-MsgGUID: p+/iJ2pnR0iyiU6TufEfxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21352469"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21352469"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 00:19:38 -0700
X-CSE-ConnectionGUID: UtC07s92R2WspH7mozGuaQ==
X-CSE-MsgGUID: A6mLcPBsTX6rDCVjTqxIsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="80357595"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.150.149])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 00:19:29 -0700
Message-ID: <787c7de4-04a3-42ac-97c5-ab0d9a71c07f@intel.com>
Date: Thu, 8 Aug 2024 10:19:25 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/8] mmc: sdhci-of-dwcmshc: add dwcmshc_pltfm_data
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
 <cb2c68c594286e9588c53acb76163e60c140c02b.1722847198.git.unicorn_wang@outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <cb2c68c594286e9588c53acb76163e60c140c02b.1722847198.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/08/24 12:18, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Abstract dwcmshc_pltfm_data to hold the sdhci_pltfm_data
> plus some comoon operations of soc such as init/postinit.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> Tested-by: Drew Fustini <drew@pdp7.com> # TH1520
> Tested-by: Inochi Amaoto <inochiama@outlook.com> # Duo and Huashan Pi

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 81 +++++++++++++++++------------
>  1 file changed, 48 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 55fba5ef37ba..16f420994519 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -218,6 +218,12 @@ struct dwcmshc_priv {
>  	u16 flags;
>  };
>  
> +struct dwcmshc_pltfm_data {
> +	const struct sdhci_pltfm_data pdata;
> +	int (*init)(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
> +	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
> +};
> +
>  static int dwcmshc_get_enable_other_clks(struct device *dev,
>  					 struct dwcmshc_priv *priv,
>  					 int num_clks,
> @@ -1048,39 +1054,52 @@ static const struct sdhci_ops sdhci_dwcmshc_cv18xx_ops = {
>  	.platform_execute_tuning = cv18xx_sdhci_execute_tuning,
>  };
>  
> -static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
> -	.ops = &sdhci_dwcmshc_ops,
> -	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +static const struct dwcmshc_pltfm_data sdhci_dwcmshc_pdata = {
> +	.pdata = {
> +		.ops = &sdhci_dwcmshc_ops,
> +		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	},
>  };
>  
>  #ifdef CONFIG_ACPI
> -static const struct sdhci_pltfm_data sdhci_dwcmshc_bf3_pdata = {
> -	.ops = &sdhci_dwcmshc_ops,
> -	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -		   SDHCI_QUIRK2_ACMD23_BROKEN,
> +static const struct dwcmshc_pltfm_data sdhci_dwcmshc_bf3_pdata = {
> +	.pdata = {
> +		.ops = &sdhci_dwcmshc_ops,
> +		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +			   SDHCI_QUIRK2_ACMD23_BROKEN,
> +	},
>  };
>  #endif
>  
> -static const struct sdhci_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
> -	.ops = &sdhci_dwcmshc_rk35xx_ops,
> -	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> -		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
> +	.pdata = {
> +		.ops = &sdhci_dwcmshc_rk35xx_ops,
> +		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +	},
> +	.init = dwcmshc_rk35xx_init,
> +	.postinit = dwcmshc_rk35xx_postinit,
>  };
>  
> -static const struct sdhci_pltfm_data sdhci_dwcmshc_th1520_pdata = {
> -	.ops = &sdhci_dwcmshc_th1520_ops,
> -	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +static const struct dwcmshc_pltfm_data sdhci_dwcmshc_th1520_pdata = {
> +	.pdata = {
> +		.ops = &sdhci_dwcmshc_th1520_ops,
> +		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	},
> +	.init = th1520_init,
>  };
>  
> -static const struct sdhci_pltfm_data sdhci_dwcmshc_cv18xx_pdata = {
> -	.ops = &sdhci_dwcmshc_cv18xx_ops,
> -	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +static const struct dwcmshc_pltfm_data sdhci_dwcmshc_cv18xx_pdata = {
> +	.pdata = {
> +		.ops = &sdhci_dwcmshc_cv18xx_ops,
> +		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	},
>  };
>  
>  static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
> @@ -1196,7 +1215,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_host *host;
>  	struct dwcmshc_priv *priv;
> -	const struct sdhci_pltfm_data *pltfm_data;
> +	const struct dwcmshc_pltfm_data *pltfm_data;
>  	int err;
>  	u32 extra, caps;
>  
> @@ -1206,7 +1225,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	host = sdhci_pltfm_init(pdev, pltfm_data,
> +	host = sdhci_pltfm_init(pdev, &pltfm_data->pdata,
>  				sizeof(struct dwcmshc_priv));
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
> @@ -1251,16 +1270,12 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.hs400_enhanced_strobe = dwcmshc_hs400_enhanced_strobe;
>  	host->mmc_host_ops.execute_tuning = dwcmshc_execute_tuning;
>  
> -	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
> -		err = dwcmshc_rk35xx_init(dev, host, priv);
> +	if (pltfm_data->init) {
> +		err = pltfm_data->init(&pdev->dev, host, priv);
>  		if (err)
>  			goto err_clk;
>  	}
>  
> -	if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
> -		th1520_init(dev, host, priv);
> -	}
> -
>  #ifdef CONFIG_ACPI
>  	if (pltfm_data == &sdhci_dwcmshc_bf3_pdata)
>  		sdhci_enable_v4_mode(host);
> @@ -1288,8 +1303,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  		dwcmshc_cqhci_init(host, pdev);
>  	}
>  
> -	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata)
> -		dwcmshc_rk35xx_postinit(host, priv);
> +	if (pltfm_data->postinit)
> +		pltfm_data->postinit(host, priv);
>  
>  	err = __sdhci_add_host(host);
>  	if (err)

