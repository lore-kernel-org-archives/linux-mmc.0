Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5086217741;
	Thu, 13 Jun 2024 01:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243025; cv=none; b=ffRI8p5aoZq+mUXqL0IeEqSHNm9WhyDrLS8WXeWAXScwS72DtWSIm/LyQeqigzW9cbCP8RvNc43rRHQie3UHDNcoXkGTjwblTXWIGdVhTe0f6q2v5Ae4pucSx9sCmWoJQ3mVqwVcTQkeINCkAM97q45R0S6Tl5c42mep956fapA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243025; c=relaxed/simple;
	bh=RvJV1kfgS5VsvQe2v3nI15O55PRjbk5jKsiC3YqjJ20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YkypvcUJ2SFlY8ZHhLbPkR/o4fiFEhGvS2xaDrGS1Plom3PJFQTcHQj3uwJr3gTcAegP1jz3Za7U8apRDL9jFzz3aiJoJds4pH6zmrj+MmCGZD3mVinJy+K/o1WIKgbcy5bG6ZBtfBNPVwnbLZJmRmsaYzfgePl7OYJu8RBWcsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCXnYEPh; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCXnYEPh"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ba70a0ed75so298920eaf.1;
        Wed, 12 Jun 2024 18:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718243022; x=1718847822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pa5paPyLFaIvlDKRYO3r2AiKWf66KpIRKCv3yER7jFo=;
        b=PCXnYEPhRyc9u3LuLG+dpmXop+TAV4sn0UshY83Ze/6jFMlOntb2yddvAjTq+aYa3g
         bBXHU/NdjtyEggtM1N0SztFkNn3GDoaI6U0Su1bx3eq3pX3G9DLGwYWTg48Q/YTx333L
         EkgLgV1JB4keoVukSbcAEcTw+KAyeafNJBHwjAwjW7EfCPEFyywFGzZlWC1yijRPzvpR
         UpGVw7OY1upFy1cDYbLNvYjI8QmnUYrNbsqXnO6SIOYnO3XQPE/G9i8cERnT84BHfiz6
         W8XzWZgGq0huNzXq/4eShm/LsVsh1qwodNzSaALxexKpzqTVM9C8HhyOE2SQgeFgWX73
         XvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718243022; x=1718847822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pa5paPyLFaIvlDKRYO3r2AiKWf66KpIRKCv3yER7jFo=;
        b=tBU5KknQzC6CC9rlyCFQlLBeC1+bkKY/pAYMA85E5UrFG/z2Ek4sksQBxzG53Im1Xg
         EsP0ppd9z3dvikUGTI+1Q6kWQRhIubk1U4zSo0XM/vnvP1iOzb4cOiD3A3zozi5uNm/H
         ivwQglaKaxrHYar5yvI8ZL1XsgbgLLZBqhLOx133Itwh4ca7jgINo7CJWhaja2IHtLwA
         laLPV/+WDY+6V5jEpemYwAgjmXMo2T+XUgv6TZ+kWiBhr1/rRcTZq8I9LxbstaAafkap
         0usDQ9kaiZf+5pcmRyrYkCLjHTpIHOeryLeNyLQvGst+0uC2g93HAtZRfCr9m8Kyu3CO
         +7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWYzWqlfJ6XzZ3siWdWmcjQPM0/o5z70cZ8ZQL6CFFsXTHuWUaOs3qu1Pc6TMcmLsPDMyHqlkYhsjU2E3G8CyQ6hC/cxCYow4eV/K6BnjTAS3QhAklBo8mlDAKIzwEbnET6qibrked+0ozMzt2zGq1bZkU/8nOO8GfcBO9WrmnqmsCB+g==
X-Gm-Message-State: AOJu0YzEZuRhYzuH0+anfJOoo5VadZ/XHUZ0k5X0HB3jA/qGdd2+HV/i
	QB0EcVOJPev7Z0ioW6AV5CpSpw98qbwxcgdixQKEl2elxARvtxak
X-Google-Smtp-Source: AGHT+IFHY32p6WRy8aXgAhgI2jg/QRmSqj0czMoSEtq5wJ8S15vpDIei+2sdjk80QfaRRPhpbCPk4w==
X-Received: by 2002:a4a:cb13:0:b0:5bd:15fc:8fe5 with SMTP id 006d021491bc7-5bd15fc96fbmr799925eaf.7.1718243021947;
        Wed, 12 Jun 2024 18:43:41 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd62926ef8sm46561eaf.39.2024.06.12.18.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 18:43:41 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: adrian.hunter@intel.com,
	aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	ulf.hansson@linaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v3 4/4] mmc: sdhci-of-dwcmshc: add callback functions for dwcmshc
Date: Thu, 13 Jun 2024 09:43:34 +0800
Message-Id: <2182f65bad83e394a7ffb9259b2c1aa130912961.1718241495.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718241495.git.unicorn_wang@outlook.com>
References: <cover.1718241495.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

The current framework is not easily extended to support new SOCs.
For example, in the current code we see that the SOC-level
structure `rk35xx_priv` and related logic are distributed in
functions such as dwcmshc_probe/dwcmshc_remove/dwcmshc_suspend/......,
which is inappropriate.

The solution is to abstract some possible common operations of soc
as dwcmshc platform data. Each soc implements the corresponding callback
function according to its own needs.
dwcmshc framework is responsible for calling these callback functions
in those dwcmshc_xxx functions at proper positions.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 143 +++++++++++++++++++---------
 1 file changed, 99 insertions(+), 44 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 38ab755aa044..ebae461019f9 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -206,6 +206,7 @@ struct rk35xx_priv {
 	u8 txclk_tapnum;
 };
 
+struct dwcmshc_ops;
 struct dwcmshc_priv {
 	struct clk	*bus_clk;
 	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA1 reg */
@@ -214,6 +215,20 @@ struct dwcmshc_priv {
 	void *priv; /* pointer to SoC private stuff */
 	u16 delay_line;
 	u16 flags;
+
+	const struct dwcmshc_ops *ops;
+};
+
+struct dwcmshc_ops {
+	int (*init)(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
+	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
+	int  (*clks_enable)(struct dwcmshc_priv *dwc_priv);
+	void (*clks_disable)(struct dwcmshc_priv *dwc_priv);
+};
+
+struct dwcmshc_data {
+	const struct sdhci_pltfm_data *pdata;
+	const struct dwcmshc_ops *ops;
 };
 
 /*******************************************************************************
@@ -815,6 +830,25 @@ static void rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_pr
 	}
 }
 
+static int rk35xx_clks_enable(struct dwcmshc_priv *dwc_priv)
+{
+	struct rk35xx_priv *priv = dwc_priv->priv;
+	int ret = 0;
+
+	if (priv)
+		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS, priv->rockchip_clks);
+	return ret;
+}
+
+static void rk35xx_clks_disable(struct dwcmshc_priv *dwc_priv)
+{
+	struct rk35xx_priv *priv = dwc_priv->priv;
+
+	if (priv)
+		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
+					   priv->rockchip_clks);
+}
+
 static void th1520_sdhci_set_phy(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1167,30 +1201,65 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_cv18xx_pdata = {
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
+static const struct dwcmshc_ops dwcmshc_rk35xx_ops = {
+	.init = rk35xx_init,
+	.postinit = rk35xx_postinit,
+	.clks_enable = rk35xx_clks_enable,
+	.clks_disable = rk35xx_clks_disable,
+};
+
+static const struct dwcmshc_ops dwcmshc_th1520_ops = {
+	.init = th1520_init,
+};
+
+static const struct dwcmshc_data dwcmshc_cv18xx_data = {
+	.pdata = &sdhci_dwcmshc_cv18xx_pdata,
+};
+
+static const struct dwcmshc_data dwcmshc_generic_data = {
+	.pdata = &sdhci_dwcmshc_pdata,
+};
+
+static const struct dwcmshc_data dwcmshc_rk35xx_data = {
+	.pdata = &sdhci_dwcmshc_rk35xx_pdata,
+	.ops = &dwcmshc_rk35xx_ops,
+};
+
+static const struct dwcmshc_data dwcmshc_th1520_data = {
+	.pdata = &sdhci_dwcmshc_th1520_pdata,
+	.ops = &dwcmshc_th1520_ops,
+};
+
+#ifdef CONFIG_ACPI
+static const struct dwcmshc_data dwcmshc_bf3_data = {
+	.pdata = &sdhci_dwcmshc_bf3_pdata,
+};
+#endif
+
 static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
 	{
 		.compatible = "rockchip,rk3588-dwcmshc",
-		.data = &sdhci_dwcmshc_rk35xx_pdata,
+		.data = &dwcmshc_rk35xx_data,
 	},
 	{
 		.compatible = "rockchip,rk3568-dwcmshc",
-		.data = &sdhci_dwcmshc_rk35xx_pdata,
+		.data = &dwcmshc_rk35xx_data,
 	},
 	{
 		.compatible = "snps,dwcmshc-sdhci",
-		.data = &sdhci_dwcmshc_pdata,
+		.data = &dwcmshc_generic_data,
 	},
 	{
 		.compatible = "sophgo,cv1800b-dwcmshc",
-		.data = &sdhci_dwcmshc_cv18xx_pdata,
+		.data = &dwcmshc_cv18xx_data,
 	},
 	{
 		.compatible = "sophgo,sg2002-dwcmshc",
-		.data = &sdhci_dwcmshc_cv18xx_pdata,
+		.data = &dwcmshc_cv18xx_data,
 	},
 	{
 		.compatible = "thead,th1520-dwcmshc",
-		.data = &sdhci_dwcmshc_th1520_pdata,
+		.data = &dwcmshc_th1520_data,
 	},
 	{},
 };
@@ -1200,7 +1269,7 @@ MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
 static const struct acpi_device_id sdhci_dwcmshc_acpi_ids[] = {
 	{
 		.id = "MLNXBF30",
-		.driver_data = (kernel_ulong_t)&sdhci_dwcmshc_bf3_pdata,
+		.driver_data = (kernel_ulong_t)&dwcmshc_bf3_data,
 	},
 	{}
 };
@@ -1213,18 +1282,17 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
 	struct dwcmshc_priv *priv;
-	struct rk35xx_priv *rk_priv = NULL;
-	const struct sdhci_pltfm_data *pltfm_data;
+	const struct dwcmshc_data *data;
 	int err;
 	u32 extra, caps;
 
-	pltfm_data = device_get_match_data(&pdev->dev);
-	if (!pltfm_data) {
+	data = device_get_match_data(&pdev->dev);
+	if (!data) {
 		dev_err(&pdev->dev, "Error: No device match data found\n");
 		return -ENODEV;
 	}
 
-	host = sdhci_pltfm_init(pdev, pltfm_data,
+	host = sdhci_pltfm_init(pdev, data->pdata,
 				sizeof(struct dwcmshc_priv));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
@@ -1239,6 +1307,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 
 	pltfm_host = sdhci_priv(host);
 	priv = sdhci_pltfm_priv(pltfm_host);
+	priv->ops = data->ops;
 
 	if (dev->of_node) {
 		pltfm_host->clk = devm_clk_get(dev, "core");
@@ -1269,20 +1338,14 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	host->mmc_host_ops.hs400_enhanced_strobe = dwcmshc_hs400_enhanced_strobe;
 	host->mmc_host_ops.execute_tuning = dwcmshc_execute_tuning;
 
-	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
-		err = rk35xx_init(&pdev->dev, host, priv);
-		if (err)
-			goto err_clk;
-	}
-
-	if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
-		err = th1520_init(&pdev->dev, host, priv);
+	if (data->ops && data->ops->init) {
+		err = data->ops->init(&pdev->dev, host, priv);
 		if (err)
 			goto err_clk;
 	}
 
 #ifdef CONFIG_ACPI
-	if (pltfm_data == &sdhci_dwcmshc_bf3_pdata)
+	if (data == &dwcmshc_bf3_data)
 		sdhci_enable_v4_mode(host);
 #endif
 
@@ -1308,8 +1371,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
 		dwcmshc_cqhci_init(host, pdev);
 	}
 
-	if (rk_priv)
-		rk35xx_postinit(host, priv);
+	if (data->ops && data->ops->postinit)
+		data->ops->postinit(host, priv);
 
 	err = __sdhci_add_host(host);
 	if (err)
@@ -1327,9 +1390,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
 err_clk:
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+	if (data->ops && data->ops->clks_disable)
+		data->ops->clks_disable(priv);
 free_pltfm:
 	sdhci_pltfm_free(pdev);
 	return err;
@@ -1340,7 +1402,6 @@ static void dwcmshc_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	struct rk35xx_priv *rk_priv = priv->priv;
 
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -1352,9 +1413,8 @@ static void dwcmshc_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+	if (priv->ops && priv->ops->clks_disable)
+		priv->ops->clks_disable(priv);
 	sdhci_pltfm_free(pdev);
 }
 
@@ -1364,7 +1424,6 @@ static int dwcmshc_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	struct rk35xx_priv *rk_priv = priv->priv;
 	int ret;
 
 	pm_runtime_resume(dev);
@@ -1383,9 +1442,8 @@ static int dwcmshc_suspend(struct device *dev)
 	if (!IS_ERR(priv->bus_clk))
 		clk_disable_unprepare(priv->bus_clk);
 
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+	if (priv->ops && priv->ops->clks_disable)
+		priv->ops->clks_disable(priv);
 
 	return ret;
 }
@@ -1395,7 +1453,6 @@ static int dwcmshc_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	struct rk35xx_priv *rk_priv = priv->priv;
 	int ret;
 
 	ret = clk_prepare_enable(pltfm_host->clk);
@@ -1408,29 +1465,27 @@ static int dwcmshc_resume(struct device *dev)
 			goto disable_clk;
 	}
 
-	if (rk_priv) {
-		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS,
-					      rk_priv->rockchip_clks);
+	if (priv->ops && priv->ops->clks_enable) {
+		ret = priv->ops->clks_enable(priv);
 		if (ret)
 			goto disable_bus_clk;
 	}
 
 	ret = sdhci_resume_host(host);
 	if (ret)
-		goto disable_rockchip_clks;
+		goto disable_soc_clks;
 
 	if (host->mmc->caps2 & MMC_CAP2_CQE) {
 		ret = cqhci_resume(host->mmc);
 		if (ret)
-			goto disable_rockchip_clks;
+			goto disable_soc_clks;
 	}
 
 	return 0;
 
-disable_rockchip_clks:
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+disable_soc_clks:
+	if (priv->ops && priv->ops->clks_disable)
+		priv->ops->clks_disable(priv);
 disable_bus_clk:
 	if (!IS_ERR(priv->bus_clk))
 		clk_disable_unprepare(priv->bus_clk);
-- 
2.25.1

