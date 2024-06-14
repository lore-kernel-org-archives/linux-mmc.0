Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B201922C1;
	Fri, 14 Jun 2024 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718362359; cv=none; b=i7wj/V6ZyolW6Elw1xTKX3dRdnXlPaosnBonNek+N+vaHvNZfKZ00toMTVHRiS6FPjIyU2JD/Xmy1fB+N0gcit+wkhLvVa+0H/sEIKwkZXIhJD16CmS2N9rCQ8NB3/4dP+wrk84xrBeP0i++Cs/Xd4+NmbEDcmGOhEnwGn4SEp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718362359; c=relaxed/simple;
	bh=bjdAe8262D+RJHgD3sLoIDowspHJbi+XMGtijIFkaJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2xpQP6/QYq2u2tHTn9nYJTlJLrNWkmHrd6rhttmCjoAbx/VmBYCIuEs8UaBfn7jicXLKxBT4OPSylAevKR82RpMo9WmvRXu/ytWiNA9qZfEYfqFAOwFjvUVySREw71/FOA/3ioPzY0ZMrljvYqipWqnxk0dhhD6ic8FrUAVZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MWfBA2WP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWfBA2WP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718362357; x=1749898357;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bjdAe8262D+RJHgD3sLoIDowspHJbi+XMGtijIFkaJs=;
  b=MWfBA2WPqj6lKIyTrKhqC1Y6OB84gHaVJWZ4U+H4cd4RPBmCPh8j0U0N
   51j0M6nixNfZXlFZoDc4PyQHKrp6XKL7qqmSGB46i4uwq5J5+9hi8Roe4
   E0sPCRnwkWzI8Z4pZq3+EDI3KxTQzagZFH6aluYWueAGUAVNZLdwKjVBb
   ItKC4qvhQHl7XycBvtgi3SlbKmOZ21hacizT3YbQvvNJNAIrb0olUUItK
   qidE+NhVuN6+wPe3CVLCUbYZV/zXQUrM2PJtXD8bsOXllp24wretm4P+Y
   jmoATsV/pTVsTpG3F3PdQIqn9blDmDbWyIJAQvSPjEs4036LCSWvmOseg
   g==;
X-CSE-ConnectionGUID: 673lghAFTE+EZALgAncCoA==
X-CSE-MsgGUID: KKEhE3NvSte+YHx/y4VX1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15073006"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15073006"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 03:52:36 -0700
X-CSE-ConnectionGUID: C8zURk45ToGR4ElJ0KUZug==
X-CSE-MsgGUID: 5jx/nXZaQyaLXG7UOHdIwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="44836839"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.248.10])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 03:52:31 -0700
Message-ID: <25910cae-b29e-49a5-86d2-6da571664b4a@intel.com>
Date: Fri, 14 Jun 2024 13:52:26 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mmc: sdhci-of-dwcmshc: add callback functions for
 dwcmshc
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
 <2182f65bad83e394a7ffb9259b2c1aa130912961.1718241495.git.unicorn_wang@outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <2182f65bad83e394a7ffb9259b2c1aa130912961.1718241495.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/06/24 04:43, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> The current framework is not easily extended to support new SOCs.
> For example, in the current code we see that the SOC-level
> structure `rk35xx_priv` and related logic are distributed in
> functions such as dwcmshc_probe/dwcmshc_remove/dwcmshc_suspend/......,
> which is inappropriate.
> 
> The solution is to abstract some possible common operations of soc
> as dwcmshc platform data. Each soc implements the corresponding callback
> function according to its own needs.
> dwcmshc framework is responsible for calling these callback functions
> in those dwcmshc_xxx functions at proper positions.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 143 +++++++++++++++++++---------
>  1 file changed, 99 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 38ab755aa044..ebae461019f9 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -206,6 +206,7 @@ struct rk35xx_priv {
>  	u8 txclk_tapnum;
>  };
>  
> +struct dwcmshc_ops;
>  struct dwcmshc_priv {
>  	struct clk	*bus_clk;
>  	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA1 reg */
> @@ -214,6 +215,20 @@ struct dwcmshc_priv {
>  	void *priv; /* pointer to SoC private stuff */
>  	u16 delay_line;
>  	u16 flags;
> +
> +	const struct dwcmshc_ops *ops;

	const struct dwcmshc_data *data;

> +};
> +
> +struct dwcmshc_ops {
> +	int (*init)(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
> +	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
> +	int  (*clks_enable)(struct dwcmshc_priv *dwc_priv);
> +	void (*clks_disable)(struct dwcmshc_priv *dwc_priv);
> +};
> +
> +struct dwcmshc_data {
> +	const struct sdhci_pltfm_data *pdata;
> +	const struct dwcmshc_ops *ops;
>  };

Currently, ops and pdata values are unique to an individual
dwcmshc_data, so it is simpler to put it altogether i.e.

struct dwcmshc_data {
	const struct sdhci_pltfm_data pdata;
	int (*init)(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
	int  (*clks_enable)(struct dwcmshc_priv *dwc_priv);
	void (*clks_disable)(struct dwcmshc_priv *dwc_priv);
};

>  
>  /*******************************************************************************
> @@ -815,6 +830,25 @@ static void rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_pr
>  	}
>  }
>  
> +static int rk35xx_clks_enable(struct dwcmshc_priv *dwc_priv)
> +{
> +	struct rk35xx_priv *priv = dwc_priv->priv;
> +	int ret = 0;
> +
> +	if (priv)
> +		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS, priv->rockchip_clks);
> +	return ret;
> +}
> +
> +static void rk35xx_clks_disable(struct dwcmshc_priv *dwc_priv)
> +{
> +	struct rk35xx_priv *priv = dwc_priv->priv;
> +
> +	if (priv)
> +		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> +					   priv->rockchip_clks);
> +}
> +
>  static void th1520_sdhci_set_phy(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1167,30 +1201,65 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_cv18xx_pdata = {
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>  
> +static const struct dwcmshc_ops dwcmshc_rk35xx_ops = {
> +	.init = rk35xx_init,
> +	.postinit = rk35xx_postinit,
> +	.clks_enable = rk35xx_clks_enable,
> +	.clks_disable = rk35xx_clks_disable,
> +};

So this becomes:

static const struct dwcmshc_data sdhci_dwcmshc_rk35xx_pdata = {
	.pdata = {
		.ops = &sdhci_dwcmshc_rk35xx_ops,
		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
	},
	.init = rk35xx_init,
	.postinit = rk35xx_postinit,
	.clks_enable = rk35xx_clks_enable,
	.clks_disable = rk35xx_clks_disable,
};

etc

> +
> +static const struct dwcmshc_ops dwcmshc_th1520_ops = {
> +	.init = th1520_init,
> +};
> +
> +static const struct dwcmshc_data dwcmshc_cv18xx_data = {
> +	.pdata = &sdhci_dwcmshc_cv18xx_pdata,
> +};
> +
> +static const struct dwcmshc_data dwcmshc_generic_data = {
> +	.pdata = &sdhci_dwcmshc_pdata,
> +};
> +
> +static const struct dwcmshc_data dwcmshc_rk35xx_data = {
> +	.pdata = &sdhci_dwcmshc_rk35xx_pdata,
> +	.ops = &dwcmshc_rk35xx_ops,
> +};
> +
> +static const struct dwcmshc_data dwcmshc_th1520_data = {
> +	.pdata = &sdhci_dwcmshc_th1520_pdata,
> +	.ops = &dwcmshc_th1520_ops,
> +};
> +
> +#ifdef CONFIG_ACPI
> +static const struct dwcmshc_data dwcmshc_bf3_data = {
> +	.pdata = &sdhci_dwcmshc_bf3_pdata,
> +};
> +#endif
> +
>  static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>  	{
>  		.compatible = "rockchip,rk3588-dwcmshc",
> -		.data = &sdhci_dwcmshc_rk35xx_pdata,
> +		.data = &dwcmshc_rk35xx_data,
>  	},
>  	{
>  		.compatible = "rockchip,rk3568-dwcmshc",
> -		.data = &sdhci_dwcmshc_rk35xx_pdata,
> +		.data = &dwcmshc_rk35xx_data,
>  	},
>  	{
>  		.compatible = "snps,dwcmshc-sdhci",
> -		.data = &sdhci_dwcmshc_pdata,
> +		.data = &dwcmshc_generic_data,
>  	},
>  	{
>  		.compatible = "sophgo,cv1800b-dwcmshc",
> -		.data = &sdhci_dwcmshc_cv18xx_pdata,
> +		.data = &dwcmshc_cv18xx_data,
>  	},
>  	{
>  		.compatible = "sophgo,sg2002-dwcmshc",
> -		.data = &sdhci_dwcmshc_cv18xx_pdata,
> +		.data = &dwcmshc_cv18xx_data,
>  	},
>  	{
>  		.compatible = "thead,th1520-dwcmshc",
> -		.data = &sdhci_dwcmshc_th1520_pdata,
> +		.data = &dwcmshc_th1520_data,
>  	},
>  	{},
>  };
> @@ -1200,7 +1269,7 @@ MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
>  static const struct acpi_device_id sdhci_dwcmshc_acpi_ids[] = {
>  	{
>  		.id = "MLNXBF30",
> -		.driver_data = (kernel_ulong_t)&sdhci_dwcmshc_bf3_pdata,
> +		.driver_data = (kernel_ulong_t)&dwcmshc_bf3_data,
>  	},
>  	{}
>  };
> @@ -1213,18 +1282,17 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_host *host;
>  	struct dwcmshc_priv *priv;
> -	struct rk35xx_priv *rk_priv = NULL;
> -	const struct sdhci_pltfm_data *pltfm_data;
> +	const struct dwcmshc_data *data;
>  	int err;
>  	u32 extra, caps;
>  
> -	pltfm_data = device_get_match_data(&pdev->dev);
> -	if (!pltfm_data) {
> +	data = device_get_match_data(&pdev->dev);
> +	if (!data) {
>  		dev_err(&pdev->dev, "Error: No device match data found\n");
>  		return -ENODEV;
>  	}
>  
> -	host = sdhci_pltfm_init(pdev, pltfm_data,
> +	host = sdhci_pltfm_init(pdev, data->pdata,
>  				sizeof(struct dwcmshc_priv));
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
> @@ -1239,6 +1307,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  
>  	pltfm_host = sdhci_priv(host);
>  	priv = sdhci_pltfm_priv(pltfm_host);
> +	priv->ops = data->ops;

Becomes:

	priv->data = data;

>  
>  	if (dev->of_node) {
>  		pltfm_host->clk = devm_clk_get(dev, "core");
> @@ -1269,20 +1338,14 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.hs400_enhanced_strobe = dwcmshc_hs400_enhanced_strobe;
>  	host->mmc_host_ops.execute_tuning = dwcmshc_execute_tuning;
>  
> -	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
> -		err = rk35xx_init(&pdev->dev, host, priv);
> -		if (err)
> -			goto err_clk;
> -	}
> -
> -	if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
> -		err = th1520_init(&pdev->dev, host, priv);
> +	if (data->ops && data->ops->init) {

Becomes:

	if (data->init) {

etc

> +		err = data->ops->init(&pdev->dev, host, priv);
>  		if (err)
>  			goto err_clk;
>  	}
>  
>  #ifdef CONFIG_ACPI
> -	if (pltfm_data == &sdhci_dwcmshc_bf3_pdata)
> +	if (data == &dwcmshc_bf3_data)
>  		sdhci_enable_v4_mode(host);
>  #endif
>  
> @@ -1308,8 +1371,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  		dwcmshc_cqhci_init(host, pdev);
>  	}
>  
> -	if (rk_priv)
> -		rk35xx_postinit(host, priv);
> +	if (data->ops && data->ops->postinit)
> +		data->ops->postinit(host, priv);
>  
>  	err = __sdhci_add_host(host);
>  	if (err)
> @@ -1327,9 +1390,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  err_clk:
>  	clk_disable_unprepare(pltfm_host->clk);
>  	clk_disable_unprepare(priv->bus_clk);
> -	if (rk_priv)
> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> -					   rk_priv->rockchip_clks);
> +	if (data->ops && data->ops->clks_disable)
> +		data->ops->clks_disable(priv);
>  free_pltfm:
>  	sdhci_pltfm_free(pdev);
>  	return err;
> @@ -1340,7 +1402,6 @@ static void dwcmshc_remove(struct platform_device *pdev)
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	struct rk35xx_priv *rk_priv = priv->priv;
>  
>  	pm_runtime_get_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> @@ -1352,9 +1413,8 @@ static void dwcmshc_remove(struct platform_device *pdev)
>  
>  	clk_disable_unprepare(pltfm_host->clk);
>  	clk_disable_unprepare(priv->bus_clk);
> -	if (rk_priv)
> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> -					   rk_priv->rockchip_clks);
> +	if (priv->ops && priv->ops->clks_disable)
> +		priv->ops->clks_disable(priv);
>  	sdhci_pltfm_free(pdev);
>  }
>  
> @@ -1364,7 +1424,6 @@ static int dwcmshc_suspend(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	struct rk35xx_priv *rk_priv = priv->priv;
>  	int ret;
>  
>  	pm_runtime_resume(dev);
> @@ -1383,9 +1442,8 @@ static int dwcmshc_suspend(struct device *dev)
>  	if (!IS_ERR(priv->bus_clk))
>  		clk_disable_unprepare(priv->bus_clk);
>  
> -	if (rk_priv)
> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> -					   rk_priv->rockchip_clks);
> +	if (priv->ops && priv->ops->clks_disable)
> +		priv->ops->clks_disable(priv);
>  
>  	return ret;
>  }
> @@ -1395,7 +1453,6 @@ static int dwcmshc_resume(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	struct rk35xx_priv *rk_priv = priv->priv;
>  	int ret;
>  
>  	ret = clk_prepare_enable(pltfm_host->clk);
> @@ -1408,29 +1465,27 @@ static int dwcmshc_resume(struct device *dev)
>  			goto disable_clk;
>  	}
>  
> -	if (rk_priv) {
> -		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS,
> -					      rk_priv->rockchip_clks);
> +	if (priv->ops && priv->ops->clks_enable) {
> +		ret = priv->ops->clks_enable(priv);
>  		if (ret)
>  			goto disable_bus_clk;
>  	}
>  
>  	ret = sdhci_resume_host(host);
>  	if (ret)
> -		goto disable_rockchip_clks;
> +		goto disable_soc_clks;
>  
>  	if (host->mmc->caps2 & MMC_CAP2_CQE) {
>  		ret = cqhci_resume(host->mmc);
>  		if (ret)
> -			goto disable_rockchip_clks;
> +			goto disable_soc_clks;
>  	}
>  
>  	return 0;
>  
> -disable_rockchip_clks:
> -	if (rk_priv)
> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> -					   rk_priv->rockchip_clks);
> +disable_soc_clks:
> +	if (priv->ops && priv->ops->clks_disable)
> +		priv->ops->clks_disable(priv);
>  disable_bus_clk:
>  	if (!IS_ERR(priv->bus_clk))
>  		clk_disable_unprepare(priv->bus_clk);

