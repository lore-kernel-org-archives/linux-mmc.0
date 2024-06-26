Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FDD14EC65;
	Wed, 26 Jun 2024 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719429229; cv=none; b=UXdAx2QsXKz7FU4efKLsTq4FzQSersrBsHvDfcu9MBNf2qJGUXjD5bfwAjwH+jWaH0HY8Y0W/CiaI3bOCOG5sMrPxcqudi/J65zyO3fhB/yKA+S69kaXyUm9fEnoAQCYN38HNTZW19JwgmeYLlKSwB4W5A3zblgxM5lDIqIB+sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719429229; c=relaxed/simple;
	bh=7j3jtoPvuA2KY8If0hqAkipRsCFqhbDCwfM482dZkLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9iGtIKblt5cT03LV12QzLg6EW2hFyTmUTjUF/fkQuv5NvRC6eKX0azTfRrYqAaVvCJnvk22cgurAws+BfdNOxEsowTSCfKiFBhus9HJXQCTKkLff7xr4bZWtIJmHV1CeMjqYQ9u9/nLuxXocX3lER8PvTWYPKQ+D0tStmTEelQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eO4CUeyE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eO4CUeyE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719429227; x=1750965227;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7j3jtoPvuA2KY8If0hqAkipRsCFqhbDCwfM482dZkLs=;
  b=eO4CUeyERijG7HJdZI7n73IyTHqdH+abziR67h8f5YSJjVVeoBIVOO6m
   8bfoEiAMUCJM0a2RkEz8Z2Av6OhkGnl/MmB0JhWedRcSRZzoQxffmxU4Z
   z4FNSX7FfUGh+UXMfUTKpzoQu7V94JLnza+oEQURW2s3Ds9CbkC1vmx2u
   /fJ/UiGElPLvC6DBANUUbGmis4fY6pvwMSJ1ERFxo1W9S+utduqeIgcv6
   sg0ryvr9XY85VvaoYZj7v9eLKyOL6mLXTx7mmTBeEmbFe73ic3usj0PF+
   xM6UNXM3DvrXopVNvXaHBJ8Z7DZ4b1/BG+1dn2sX23roGiR8Keh/7yZB0
   g==;
X-CSE-ConnectionGUID: 0T43w2dRSruCwVV8El9jfA==
X-CSE-MsgGUID: /U1HneDQRz64QYuJFUPbEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="20346138"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="20346138"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 12:13:45 -0700
X-CSE-ConnectionGUID: nFcpEuqHQJaaIPTvcMHMQg==
X-CSE-MsgGUID: U45ZLO7hRoupdx86U1t6hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="74865433"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 12:13:40 -0700
Message-ID: <6f4acb70-b4a1-4583-b1fe-20f979ef16c6@intel.com>
Date: Wed, 26 Jun 2024 22:13:33 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] mmc: sdhci-of-dwcmshc: add callback functions for
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
References: <cover.1718697954.git.unicorn_wang@outlook.com>
 <8d13fcec6059b640dc126def05515ca582542c11.1718697954.git.unicorn_wang@outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <8d13fcec6059b640dc126def05515ca582542c11.1718697954.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/24 11:38, Chen Wang wrote:
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

This could be 5 patches:
	1. Common bulk optional clocks support (as suggested below)
	2. Move functions dwcmshc_rk35xx_init() and dwcmshc_rk35xx_postinit()
	3. Factor out code for th1520_init()
	4. Factor out code into dwcmshc_rk35xx_init
	5. Add dwcmshc_pltfm_data etc

> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 327 ++++++++++++++++------------
>  1 file changed, 184 insertions(+), 143 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index e79aa4b3b6c3..f6d6903a0e36 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -206,6 +206,7 @@ struct rk35xx_priv {
>  	u8 txclk_tapnum;
>  };
>  
> +struct dwcmshc_pltfm_data;

A blank line here would make it be more readable

>  struct dwcmshc_priv {
>  	struct clk	*bus_clk;
>  	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA1 reg */
> @@ -214,6 +215,16 @@ struct dwcmshc_priv {
>  	void *priv; /* pointer to SoC private stuff */
>  	u16 delay_line;
>  	u16 flags;
> +
> +	const struct dwcmshc_pltfm_data *pltfm_data;
> +};
> +
> +struct dwcmshc_pltfm_data {
> +	const struct sdhci_pltfm_data pdata;
> +	int (*init)(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
> +	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
> +	int  (*clks_enable)(struct dwcmshc_priv *dwc_priv);
> +	void (*clks_disable)(struct dwcmshc_priv *dwc_priv);

In patch 3 you also add bulk clocks, so might as well share
that functionality instead of ->clks_enable() etc. e.g. (untested)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index e79aa4b3b6c3..ad93be9b6ae9 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -108,7 +108,6 @@
 #define DLL_LOCK_WO_TMOUT(x) \
 	((((x) & DWCMSHC_EMMC_DLL_LOCKED) == DWCMSHC_EMMC_DLL_LOCKED) && \
 	(((x) & DWCMSHC_EMMC_DLL_TIMEOUT) == 0))
-#define RK35xx_MAX_CLKS 3
 
 /* PHY register area pointer */
 #define DWC_MSHC_PTR_PHY_R	0x300
@@ -199,23 +198,52 @@ enum dwcmshc_rk_type {
 };
 
 struct rk35xx_priv {
-	/* Rockchip specified optional clocks */
-	struct clk_bulk_data rockchip_clks[RK35xx_MAX_CLKS];
 	struct reset_control *reset;
 	enum dwcmshc_rk_type devtype;
 	u8 txclk_tapnum;
 };
 
+#define DWCMSHC_MAX_CLKS 3
+
 struct dwcmshc_priv {
 	struct clk	*bus_clk;
 	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA1 reg */
 	int vendor_specific_area2; /* P_VENDOR_SPECIFIC_AREA2 reg */
 
+	int num_clks;
+	struct clk_bulk_data clks[DWCMSHC_MAX_CLKS];
+
 	void *priv; /* pointer to SoC private stuff */
 	u16 delay_line;
 	u16 flags;
 };
 
+static int dwcmshc_get_enable_clks(struct device *dev, struct dwcmshc_priv *priv,
+				   int num_clks, const char *clk_ids[])
+{
+	int err;
+
+	if (num_clks > DWCMSHC_MAX_CLKS)
+		return -EINVAL;
+
+	priv->num_clks = num_clks;
+
+	for (int i = 0; i < num_clks; i++)
+		priv->clks[i].id = clk_ids[i];
+
+	err = devm_clk_bulk_get_optional(dev, priv->num_clks, priv->clks);
+	if (err) {
+		dev_err(dev, "failed to get clocks %d\n", err);
+		return err;
+	}
+
+	err = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
+	if (err)
+		dev_err(dev, "failed to enable clocks %d\n", err);
+
+	return err;
+}
+
 /*
  * If DMA addr spans 128MB boundary, we split the DMA transfer into two
  * so that each DMA transfer doesn't exceed the boundary.
@@ -1036,8 +1064,9 @@ static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *
 
 static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
 {
-	int err;
+	static const char *clk_ids[] = {"axi", "block", "timer"};
 	struct rk35xx_priv *priv = dwc_priv->priv;
+	int err;
 
 	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
 	if (IS_ERR(priv->reset)) {
@@ -1046,21 +1075,9 @@ static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
 		return err;
 	}
 
-	priv->rockchip_clks[0].id = "axi";
-	priv->rockchip_clks[1].id = "block";
-	priv->rockchip_clks[2].id = "timer";
-	err = devm_clk_bulk_get_optional(mmc_dev(host->mmc), RK35xx_MAX_CLKS,
-					 priv->rockchip_clks);
-	if (err) {
-		dev_err(mmc_dev(host->mmc), "failed to get clocks %d\n", err);
+	err = dwcmshc_get_enable_clks(mmc_dev(host->mmc), dwc_priv, ARRAY_SIZE(clk_ids), clk_ids);
+	if (err)
 		return err;
-	}
-
-	err = clk_bulk_prepare_enable(RK35xx_MAX_CLKS, priv->rockchip_clks);
-	if (err) {
-		dev_err(mmc_dev(host->mmc), "failed to enable clocks %d\n", err);
-		return err;
-	}
 
 	if (of_property_read_u8(mmc_dev(host->mmc)->of_node, "rockchip,txclk-tapnum",
 				&priv->txclk_tapnum))
@@ -1280,9 +1297,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 err_clk:
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
 free_pltfm:
 	sdhci_pltfm_free(pdev);
 	return err;
@@ -1304,7 +1319,6 @@ static void dwcmshc_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	struct rk35xx_priv *rk_priv = priv->priv;
 
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -1316,9 +1330,7 @@ static void dwcmshc_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
 	sdhci_pltfm_free(pdev);
 }
 
@@ -1328,7 +1340,6 @@ static int dwcmshc_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	struct rk35xx_priv *rk_priv = priv->priv;
 	int ret;
 
 	pm_runtime_resume(dev);
@@ -1347,9 +1358,7 @@ static int dwcmshc_suspend(struct device *dev)
 	if (!IS_ERR(priv->bus_clk))
 		clk_disable_unprepare(priv->bus_clk);
 
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
 
 	return ret;
 }
@@ -1359,7 +1368,6 @@ static int dwcmshc_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	struct rk35xx_priv *rk_priv = priv->priv;
 	int ret;
 
 	ret = clk_prepare_enable(pltfm_host->clk);
@@ -1372,29 +1380,24 @@ static int dwcmshc_resume(struct device *dev)
 			goto disable_clk;
 	}
 
-	if (rk_priv) {
-		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS,
-					      rk_priv->rockchip_clks);
-		if (ret)
-			goto disable_bus_clk;
-	}
+	ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
+	if (ret)
+		goto disable_bus_clk;
 
 	ret = sdhci_resume_host(host);
 	if (ret)
-		goto disable_rockchip_clks;
+		goto disable_optional_clks;
 
 	if (host->mmc->caps2 & MMC_CAP2_CQE) {
 		ret = cqhci_resume(host->mmc);
 		if (ret)
-			goto disable_rockchip_clks;
+			goto disable_optional_clks;
 	}
 
 	return 0;
 
-disable_rockchip_clks:
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+disable_optional_clks:
+	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
 disable_bus_clk:
 	if (!IS_ERR(priv->bus_clk))
 		clk_disable_unprepare(priv->bus_clk);


>  };
>  
>  /*
> @@ -681,6 +692,92 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>  	sdhci_reset(host, mask);
>  }
>  
> +static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
> +			       struct dwcmshc_priv *dwc_priv)
> +{
> +	int err;
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
> +
> +	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
> +	if (IS_ERR(priv->reset)) {
> +		err = PTR_ERR(priv->reset);
> +		dev_err(mmc_dev(host->mmc), "failed to get reset control %d\n", err);
> +		return err;
> +	}
> +
> +	priv->rockchip_clks[0].id = "axi";
> +	priv->rockchip_clks[1].id = "block";
> +	priv->rockchip_clks[2].id = "timer";
> +	err = devm_clk_bulk_get_optional(mmc_dev(host->mmc), RK35xx_MAX_CLKS,
> +					 priv->rockchip_clks);
> +	if (err) {
> +		dev_err(mmc_dev(host->mmc), "failed to get clocks %d\n", err);
> +		return err;
> +	}
> +
> +	err = clk_bulk_prepare_enable(RK35xx_MAX_CLKS, priv->rockchip_clks);
> +	if (err) {
> +		dev_err(mmc_dev(host->mmc), "failed to enable clocks %d\n", err);
> +		return err;
> +	}
> +
> +	if (of_property_read_u8(mmc_dev(host->mmc)->of_node, "rockchip,txclk-tapnum",
> +				&priv->txclk_tapnum))
> +		priv->txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
> +
> +	/* Disable cmd conflict check */
> +	sdhci_writel(host, 0x0, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
> +	/* Reset previous settings */
> +	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
> +	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
> +
> +	dwc_priv->priv = priv;
> +
> +	return 0;
> +}
> +
> +static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> +{
> +	/*
> +	 * Don't support highspeed bus mode with low clk speed as we
> +	 * cannot use DLL for this condition.
> +	 */
> +	if (host->mmc->f_max <= 52000000) {
> +		dev_info(mmc_dev(host->mmc), "Disabling HS200/HS400, frequency too low (%d)\n",
> +			 host->mmc->f_max);
> +		host->mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);
> +		host->mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR);
> +	}
> +}
> +
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
>  static int th1520_execute_tuning(struct sdhci_host *host, u32 opcode)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -755,6 +852,35 @@ static void th1520_sdhci_reset(struct sdhci_host *host, u8 mask)
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
> @@ -932,39 +1058,54 @@ static const struct sdhci_ops sdhci_dwcmshc_cv18xx_ops = {
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
> +	.clks_enable = rk35xx_clks_enable,
> +	.clks_disable = rk35xx_clks_disable,
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
> @@ -1034,61 +1175,6 @@ static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *
>  	host->mmc->caps2 &= ~(MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD);
>  }
>  
> -static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> -{
> -	int err;
> -	struct rk35xx_priv *priv = dwc_priv->priv;
> -
> -	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
> -	if (IS_ERR(priv->reset)) {
> -		err = PTR_ERR(priv->reset);
> -		dev_err(mmc_dev(host->mmc), "failed to get reset control %d\n", err);
> -		return err;
> -	}
> -
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
> -		return err;
> -	}
> -
> -	if (of_property_read_u8(mmc_dev(host->mmc)->of_node, "rockchip,txclk-tapnum",
> -				&priv->txclk_tapnum))
> -		priv->txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
> -
> -	/* Disable cmd conflict check */
> -	sdhci_writel(host, 0x0, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
> -	/* Reset previous settings */
> -	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
> -	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
> -
> -	return 0;
> -}
> -
> -static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> -{
> -	/*
> -	 * Don't support highspeed bus mode with low clk speed as we
> -	 * cannot use DLL for this condition.
> -	 */
> -	if (host->mmc->f_max <= 52000000) {
> -		dev_info(mmc_dev(host->mmc), "Disabling HS200/HS400, frequency too low (%d)\n",
> -			 host->mmc->f_max);
> -		host->mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);
> -		host->mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR);
> -	}
> -}
> -
>  static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>  	{
>  		.compatible = "rockchip,rk3588-dwcmshc",
> @@ -1135,8 +1221,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_host *host;
>  	struct dwcmshc_priv *priv;
> -	struct rk35xx_priv *rk_priv = NULL;
> -	const struct sdhci_pltfm_data *pltfm_data;
> +	const struct dwcmshc_pltfm_data *pltfm_data;
>  	int err;
>  	u32 extra, caps;
>  
> @@ -1146,7 +1231,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	host = sdhci_pltfm_init(pdev, pltfm_data,
> +	host = sdhci_pltfm_init(pdev, &pltfm_data->pdata,
>  				sizeof(struct dwcmshc_priv));
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
> @@ -1161,6 +1246,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  
>  	pltfm_host = sdhci_priv(host);
>  	priv = sdhci_pltfm_priv(pltfm_host);
> +	priv->pltfm_data = pltfm_data;
>  
>  	if (dev->of_node) {
>  		pltfm_host->clk = devm_clk_get(dev, "core");
> @@ -1191,49 +1277,12 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.hs400_enhanced_strobe = dwcmshc_hs400_enhanced_strobe;
>  	host->mmc_host_ops.execute_tuning = dwcmshc_execute_tuning;
>  
> -	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
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
> +	if (pltfm_data->init) {
> +		err = pltfm_data->init(&pdev->dev, host, priv);
>  		if (err)
>  			goto err_clk;
>  	}
>  
> -	if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
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
> -	}
> -
>  #ifdef CONFIG_ACPI
>  	if (pltfm_data == &sdhci_dwcmshc_bf3_pdata)
>  		sdhci_enable_v4_mode(host);
> @@ -1261,8 +1310,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  		dwcmshc_cqhci_init(host, pdev);
>  	}
>  
> -	if (rk_priv)
> -		dwcmshc_rk35xx_postinit(host, priv);
> +	if (pltfm_data->postinit)
> +		pltfm_data->postinit(host, priv);
>  
>  	err = __sdhci_add_host(host);
>  	if (err)
> @@ -1280,9 +1329,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  err_clk:
>  	clk_disable_unprepare(pltfm_host->clk);
>  	clk_disable_unprepare(priv->bus_clk);
> -	if (rk_priv)
> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> -					   rk_priv->rockchip_clks);
> +	if (pltfm_data->clks_disable)
> +		pltfm_data->clks_disable(priv);
>  free_pltfm:
>  	sdhci_pltfm_free(pdev);
>  	return err;
> @@ -1304,7 +1352,6 @@ static void dwcmshc_remove(struct platform_device *pdev)
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	struct rk35xx_priv *rk_priv = priv->priv;
>  
>  	pm_runtime_get_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> @@ -1316,9 +1363,8 @@ static void dwcmshc_remove(struct platform_device *pdev)
>  
>  	clk_disable_unprepare(pltfm_host->clk);
>  	clk_disable_unprepare(priv->bus_clk);
> -	if (rk_priv)
> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> -					   rk_priv->rockchip_clks);
> +	if (priv->pltfm_data->clks_disable)
> +		priv->pltfm_data->clks_disable(priv);
>  	sdhci_pltfm_free(pdev);
>  }
>  
> @@ -1328,7 +1374,6 @@ static int dwcmshc_suspend(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	struct rk35xx_priv *rk_priv = priv->priv;
>  	int ret;
>  
>  	pm_runtime_resume(dev);
> @@ -1347,9 +1392,8 @@ static int dwcmshc_suspend(struct device *dev)
>  	if (!IS_ERR(priv->bus_clk))
>  		clk_disable_unprepare(priv->bus_clk);
>  
> -	if (rk_priv)
> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> -					   rk_priv->rockchip_clks);
> +	if (priv->pltfm_data->clks_disable)
> +		priv->pltfm_data->clks_disable(priv);
>  
>  	return ret;
>  }
> @@ -1359,7 +1403,6 @@ static int dwcmshc_resume(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	struct rk35xx_priv *rk_priv = priv->priv;
>  	int ret;
>  
>  	ret = clk_prepare_enable(pltfm_host->clk);
> @@ -1372,29 +1415,27 @@ static int dwcmshc_resume(struct device *dev)
>  			goto disable_clk;
>  	}
>  
> -	if (rk_priv) {
> -		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS,
> -					      rk_priv->rockchip_clks);
> +	if (priv->pltfm_data->clks_enable) {
> +		ret = priv->pltfm_data->clks_enable(priv);
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
> +	if (priv->pltfm_data->clks_disable)
> +		priv->pltfm_data->clks_disable(priv);
>  disable_bus_clk:
>  	if (!IS_ERR(priv->bus_clk))
>  		clk_disable_unprepare(priv->bus_clk);

