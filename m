Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F6310E6;
	Fri, 19 Jul 2024 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721395356; cv=none; b=qyLtMFPFl11R89mgvH/yPDdHzm0GV+61g3+drtNa6uvq4Z6rHC0RwdXAcKNBeLa2Io8+nnAnKtG7Ge1w+/fRcHsQ5YBP5vKGQKleItZ+9/CPLGSBOyMcM/RVIVq68r53/Eoo7y5lshYMrpanPU4II+3PJ8QxR/WrhI1exbkj5jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721395356; c=relaxed/simple;
	bh=9Nakq1tGJdPzBFgVh+daEn1/8+fMREvL4fAwk6DJBjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmaCU+oHq2sRwTWmEiq5cMqZY4A4Q+/irlDxVc5iXlNaID1rSj/DLveHGEA2lvMCYB5rwEjTiox2m6DRa0R9ivCLZsIqVQPDn90xpcb0oBn40PHQCYeKKbaJNHR75jIxznJZ72qNXu5l13QgG5S6btMoZWiEbLftmSLC+sUqKQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QeiYWDDT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QeiYWDDT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721395353; x=1752931353;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9Nakq1tGJdPzBFgVh+daEn1/8+fMREvL4fAwk6DJBjc=;
  b=QeiYWDDTkS1aO4e0BYrQahvBXFWM5Yb9MfHyq86BfrLfLagvRduGSPnp
   tXPZMYpm+32bpQXhx5KgOZyR986uuq5/HQnFajv1hPBOhNtmP786ksF1u
   a3/FmJ9MIvjg2fcEdDt7aIBlRnfXrqCZzqMNuJVetI6dFbuqejg8SNwyd
   w/rVsjfs+/GYTZ76+xqot8axS8J/61BRb9Z0flSolFB0UpMK/XjPf6JD3
   crz8JZwfkTDQxpigmO2yuhEF3X4BM1+5ZJ2NgXsXIFpH5V+TcDpnldhNc
   pmLrikY5j/clQOH4k8UoD1CbPNOesnxKr5SrMl3i1007I7769ww9l7VPp
   Q==;
X-CSE-ConnectionGUID: +q4xSZtsSaOkscv8czaSEA==
X-CSE-MsgGUID: TXtsWSQLSNSI/Q+QAw2zHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="30158811"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="30158811"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 06:22:32 -0700
X-CSE-ConnectionGUID: MlDv4wKcRsOa0jfxUy3vSQ==
X-CSE-MsgGUID: 2IFtte+OReya7KNsFJSmwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="51171000"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.150.149])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 06:22:24 -0700
Message-ID: <e3a21f89-d857-4f67-8878-c3f2f4dcc205@intel.com>
Date: Fri, 19 Jul 2024 16:22:17 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] mmc: sdhci-of-dwcmshc: add common bulk optional
 clocks support
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
 <e6d09bb8f0b02843967cd5c6d378ce5adbbf661f.1721377374.git.unicorn_wang@outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <e6d09bb8f0b02843967cd5c6d378ce5adbbf661f.1721377374.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/07/24 11:45, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> In addition to the required core clock and optional
> bus clock, the soc will expand its own clocks, so
> the bulk clock mechanism is abstracted.
> 
> Note, I call the bulk clocks as "other clocks" due
> to the bus clock has been called as "optional".
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 91 ++++++++++++++++-------------
>  1 file changed, 49 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index e79aa4b3b6c3..fb4076c19ed5 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -108,7 +108,6 @@
>  #define DLL_LOCK_WO_TMOUT(x) \
>  	((((x) & DWCMSHC_EMMC_DLL_LOCKED) == DWCMSHC_EMMC_DLL_LOCKED) && \
>  	(((x) & DWCMSHC_EMMC_DLL_TIMEOUT) == 0))
> -#define RK35xx_MAX_CLKS 3
>  
>  /* PHY register area pointer */
>  #define DWC_MSHC_PTR_PHY_R	0x300
> @@ -199,23 +198,54 @@ enum dwcmshc_rk_type {
>  };
>  
>  struct rk35xx_priv {
> -	/* Rockchip specified optional clocks */
> -	struct clk_bulk_data rockchip_clks[RK35xx_MAX_CLKS];
>  	struct reset_control *reset;
>  	enum dwcmshc_rk_type devtype;
>  	u8 txclk_tapnum;
>  };
>  
> +#define DWCMSHC_MAX_OTHER_CLKS 3
> +
>  struct dwcmshc_priv {
>  	struct clk	*bus_clk;
>  	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA1 reg */
>  	int vendor_specific_area2; /* P_VENDOR_SPECIFIC_AREA2 reg */
>  
> +	int num_other_clks;
> +	struct clk_bulk_data other_clks[DWCMSHC_MAX_OTHER_CLKS];
> +
>  	void *priv; /* pointer to SoC private stuff */
>  	u16 delay_line;
>  	u16 flags;
>  };
>  
> +static int dwcmshc_get_enable_other_clks(struct device *dev,
> +					 struct dwcmshc_priv *priv,
> +					 int num_clks,
> +					 const char * const clk_ids[])
> +{
> +	int err;
> +
> +	if (num_clks > DWCMSHC_MAX_OTHER_CLKS)
> +		return -EINVAL;
> +
> +	for (int i = 0; i < num_clks; i++)
> +		priv->other_clks[i].id = clk_ids[i];
> +
> +	err = devm_clk_bulk_get_optional(dev, num_clks, priv->other_clks);
> +	if (err) {
> +		dev_err(dev, "failed to get clocks %d\n", err);
> +		return err;
> +	}
> +
> +	err = clk_bulk_prepare_enable(num_clks, priv->other_clks);
> +	if (err)
> +		dev_err(dev, "failed to enable clocks %d\n", err);
> +
> +	priv->num_other_clks = num_clks;
> +
> +	return err;
> +}
> +
>  /*
>   * If DMA addr spans 128MB boundary, we split the DMA transfer into two
>   * so that each DMA transfer doesn't exceed the boundary.
> @@ -1036,8 +1066,9 @@ static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *
>  
>  static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
>  {
> -	int err;
> +	static const char * const clk_ids[] = {"axi", "block", "timer"};
>  	struct rk35xx_priv *priv = dwc_priv->priv;
> +	int err;
>  
>  	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
>  	if (IS_ERR(priv->reset)) {
> @@ -1046,21 +1077,10 @@ static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
>  		return err;
>  	}
>  
> -	priv->rockchip_clks[0].id = "axi";
> -	priv->rockchip_clks[1].id = "block";
> -	priv->rockchip_clks[2].id = "timer";
> -	err = devm_clk_bulk_get_optional(mmc_dev(host->mmc), RK35xx_MAX_CLKS,
> -					 priv->rockchip_clks);
> -	if (err) {
> -		dev_err(mmc_dev(host->mmc), "failed to get clocks %d\n", err);
> -		return err;
> -	}
> -
> -	err = clk_bulk_prepare_enable(RK35xx_MAX_CLKS, priv->rockchip_clks);
> -	if (err) {
> -		dev_err(mmc_dev(host->mmc), "failed to enable clocks %d\n", err);
> +	err = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
> +					    ARRAY_SIZE(clk_ids), clk_ids);
> +	if (err)
>  		return err;
> -	}
>  
>  	if (of_property_read_u8(mmc_dev(host->mmc)->of_node, "rockchip,txclk-tapnum",
>  				&priv->txclk_tapnum))
> @@ -1280,9 +1300,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  err_clk:
>  	clk_disable_unprepare(pltfm_host->clk);
>  	clk_disable_unprepare(priv->bus_clk);
> -	if (rk_priv)
> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> -					   rk_priv->rockchip_clks);
> +	if (priv->num_other_clks)

'if (priv->num_other_clks)' is not necessary. clk_bulk_disable_unprepare()
does nothing if the number of clks is zero.

> +		clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
>  free_pltfm:
>  	sdhci_pltfm_free(pdev);
>  	return err;
> @@ -1304,7 +1323,6 @@ static void dwcmshc_remove(struct platform_device *pdev)
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	struct rk35xx_priv *rk_priv = priv->priv;
>  
>  	pm_runtime_get_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> @@ -1316,9 +1334,7 @@ static void dwcmshc_remove(struct platform_device *pdev)
>  
>  	clk_disable_unprepare(pltfm_host->clk);
>  	clk_disable_unprepare(priv->bus_clk);
> -	if (rk_priv)
> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> -					   rk_priv->rockchip_clks);
> +	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
>  	sdhci_pltfm_free(pdev);
>  }
>  
> @@ -1328,7 +1344,6 @@ static int dwcmshc_suspend(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	struct rk35xx_priv *rk_priv = priv->priv;
>  	int ret;
>  
>  	pm_runtime_resume(dev);
> @@ -1347,9 +1362,7 @@ static int dwcmshc_suspend(struct device *dev)
>  	if (!IS_ERR(priv->bus_clk))
>  		clk_disable_unprepare(priv->bus_clk);
>  
> -	if (rk_priv)
> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> -					   rk_priv->rockchip_clks);
> +	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
>  
>  	return ret;
>  }
> @@ -1359,7 +1372,6 @@ static int dwcmshc_resume(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	struct rk35xx_priv *rk_priv = priv->priv;
>  	int ret;
>  
>  	ret = clk_prepare_enable(pltfm_host->clk);
> @@ -1372,29 +1384,24 @@ static int dwcmshc_resume(struct device *dev)
>  			goto disable_clk;
>  	}
>  
> -	if (rk_priv) {
> -		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS,
> -					      rk_priv->rockchip_clks);
> -		if (ret)
> -			goto disable_bus_clk;
> -	}
> +	ret = clk_bulk_prepare_enable(priv->num_other_clks, priv->other_clks);
> +	if (ret)
> +		goto disable_bus_clk;
>  
>  	ret = sdhci_resume_host(host);
>  	if (ret)
> -		goto disable_rockchip_clks;
> +		goto disable_other_clks;
>  
>  	if (host->mmc->caps2 & MMC_CAP2_CQE) {
>  		ret = cqhci_resume(host->mmc);
>  		if (ret)
> -			goto disable_rockchip_clks;
> +			goto disable_other_clks;
>  	}
>  
>  	return 0;
>  
> -disable_rockchip_clks:
> -	if (rk_priv)
> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> -					   rk_priv->rockchip_clks);
> +disable_other_clks:
> +	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
>  disable_bus_clk:
>  	if (!IS_ERR(priv->bus_clk))
>  		clk_disable_unprepare(priv->bus_clk);

