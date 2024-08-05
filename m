Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E173BB48;
	Mon,  5 Aug 2024 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849451; cv=none; b=QtJe7DEXBqGrcI9S+nKxW6j6Khc97gVwYly4UQZxKvA9WGJeHmIwVLogTR6GqeBQbajPsQce7HvswBUlglV2YOrVzS27t1E028J9o7zPApKBDUs1tSfLgmmouiQZ3oRL//8dHadu8MQGq/LfFz/MtMoTHviF2npnGY/cXtueGiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849451; c=relaxed/simple;
	bh=gRISN6VGNF9/g5MWQMWyS15u9A1X4YCJbdBU/quLlAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F3GQJaQpSnD7+RHw6qIsOCvMDbdKBf8UFQjiC8ltfhd8t775+7bLIBvQ4WsotHPoDD7GZzh4Z/C/KNDC9+YixWqgrzlrV4KDZ9JLS3PDqpJM8LD6inxjamISYW22T19cOgnLd9TOnRxHuqN/M7oFDrjGs0wTERhwYiHPmgLB//c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmAje5uj; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmAje5uj"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c667b28c82so2731078eaf.1;
        Mon, 05 Aug 2024 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722849449; x=1723454249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQqYFrR1LoRoAq9WMHUyKnpA+f/vebxojh36F6qI1pQ=;
        b=UmAje5ujoNdCyFsdFycxztSQJ4FqNIu+FjEWu+dPzz87yGC2rdgtuAYuIg/8hlvwIw
         86Go2pDFurHraGbMsWtDizjVE4sL3qM59q582Xf/J+tIXleL6/oeVKEE9Wz8EMdbal87
         cBgNanHq/bijE+ihOU8LCQILh2YCrEa5uyxm0ilaGSpAVMT420gwgcuEpOVzw1M5Zahd
         v3+E/ZIYmDlvgCmW7w0TaaVfBkdirUend0GfXq4LrWb07ZeKzvIh6o4YwflXJbr9wB8l
         WGzCKIrD5+8+V5iGaK0eAGLjG2UoJxuMOFrNtyjiCHCBAukmUarvt5MyN7K89spUrJqm
         9Kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722849449; x=1723454249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQqYFrR1LoRoAq9WMHUyKnpA+f/vebxojh36F6qI1pQ=;
        b=rZ1bmNjwOGhKSXaohspam95YeiztdPnhe7mt2Ah6DcGNV3H9Tl56lqPaNLoWyhH8MA
         hrbAj8pjS23caRsCIPogIA8tOnvwpvMYszujaA9KS5m41XQDyfVfZjCcwiuuIiJ1qd+f
         Awcb4ZBDNjxsYfA4BTA5/Ey6KZgl/hTZB7NkyATapqIrljT3nkWh7E6S3XouhzwhKssA
         vVvWx7uzVaVV4y+9dWFO6Q5m4hJpTVY0zVRrm3mYTNXd03uadxQytlh86iM3TJr/zgA0
         t7xmGaElkO2fZygmRthjAeVkpBaWDlld05hyWW2BftWInJr3/omOUHKZpl+/yPtCzsZS
         JySg==
X-Forwarded-Encrypted: i=1; AJvYcCXLA3F1fU578II5gCKiZDWn5peZOwccYPYE0jcqm/3+w7+8MAmUxbmCmYtRmsKz49yksa96ebLBMgE/xB/M/LgzUxGN75Vava5zU/4RFp4RG84mCQUmtycESSVdmLetVXeUcIhElB1RmwrQGtsFo29Ixqm5gzWM/o3HLOTixbj00B8p4g==
X-Gm-Message-State: AOJu0YxiA/YNOMnhPP7YJahgHQrY6Ffx6xQTtF4qRW1WAbtqmiqqxS5y
	EhngrORJCfyTlMniJDpiR6heJ2H9q/mCZKlIeiQK4k8kPjnYtKTy
X-Google-Smtp-Source: AGHT+IGCy+jdlK/J3lqkGlGo1ErX2mOA09jw089OryMpR/Vo8xZDbSFHm7BN15u6pLFZnwVwM21NYQ==
X-Received: by 2002:a4a:e609:0:b0:5d8:a13:f99d with SMTP id 006d021491bc7-5d80a1411c3mr2590865eaf.1.1722849449035;
        Mon, 05 Aug 2024 02:17:29 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70a31ec3713sm2973075a34.44.2024.08.05.02.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 02:17:28 -0700 (PDT)
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
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Drew Fustini <drew@pdp7.com>
Subject: [PATCH v6 1/8] mmc: sdhci-of-dwcmshc: add common bulk optional clocks support
Date: Mon,  5 Aug 2024 17:17:21 +0800
Message-Id: <e57e8c51da81f176b49608269a884f840903e78e.1722847198.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722847198.git.unicorn_wang@outlook.com>
References: <cover.1722847198.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

In addition to the required core clock and optional
bus clock, the soc will expand its own clocks, so
the bulk clock mechanism is abstracted.

Note, I call the bulk clocks as "other clocks" due
to the bus clock has been called as "optional".

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Tested-by: Drew Fustini <drew@pdp7.com> # TH1520
Tested-by: Inochi Amaoto <inochiama@outlook.com> # Duo and Huashan Pi
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 90 +++++++++++++++--------------
 1 file changed, 48 insertions(+), 42 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index e79aa4b3b6c3..35401616fb2e 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -108,7 +108,6 @@
 #define DLL_LOCK_WO_TMOUT(x) \
 	((((x) & DWCMSHC_EMMC_DLL_LOCKED) == DWCMSHC_EMMC_DLL_LOCKED) && \
 	(((x) & DWCMSHC_EMMC_DLL_TIMEOUT) == 0))
-#define RK35xx_MAX_CLKS 3
 
 /* PHY register area pointer */
 #define DWC_MSHC_PTR_PHY_R	0x300
@@ -199,23 +198,54 @@ enum dwcmshc_rk_type {
 };
 
 struct rk35xx_priv {
-	/* Rockchip specified optional clocks */
-	struct clk_bulk_data rockchip_clks[RK35xx_MAX_CLKS];
 	struct reset_control *reset;
 	enum dwcmshc_rk_type devtype;
 	u8 txclk_tapnum;
 };
 
+#define DWCMSHC_MAX_OTHER_CLKS 3
+
 struct dwcmshc_priv {
 	struct clk	*bus_clk;
 	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA1 reg */
 	int vendor_specific_area2; /* P_VENDOR_SPECIFIC_AREA2 reg */
 
+	int num_other_clks;
+	struct clk_bulk_data other_clks[DWCMSHC_MAX_OTHER_CLKS];
+
 	void *priv; /* pointer to SoC private stuff */
 	u16 delay_line;
 	u16 flags;
 };
 
+static int dwcmshc_get_enable_other_clks(struct device *dev,
+					 struct dwcmshc_priv *priv,
+					 int num_clks,
+					 const char * const clk_ids[])
+{
+	int err;
+
+	if (num_clks > DWCMSHC_MAX_OTHER_CLKS)
+		return -EINVAL;
+
+	for (int i = 0; i < num_clks; i++)
+		priv->other_clks[i].id = clk_ids[i];
+
+	err = devm_clk_bulk_get_optional(dev, num_clks, priv->other_clks);
+	if (err) {
+		dev_err(dev, "failed to get clocks %d\n", err);
+		return err;
+	}
+
+	err = clk_bulk_prepare_enable(num_clks, priv->other_clks);
+	if (err)
+		dev_err(dev, "failed to enable clocks %d\n", err);
+
+	priv->num_other_clks = num_clks;
+
+	return err;
+}
+
 /*
  * If DMA addr spans 128MB boundary, we split the DMA transfer into two
  * so that each DMA transfer doesn't exceed the boundary.
@@ -1036,8 +1066,9 @@ static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *
 
 static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
 {
-	int err;
+	static const char * const clk_ids[] = {"axi", "block", "timer"};
 	struct rk35xx_priv *priv = dwc_priv->priv;
+	int err;
 
 	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
 	if (IS_ERR(priv->reset)) {
@@ -1046,21 +1077,10 @@ static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
 		return err;
 	}
 
-	priv->rockchip_clks[0].id = "axi";
-	priv->rockchip_clks[1].id = "block";
-	priv->rockchip_clks[2].id = "timer";
-	err = devm_clk_bulk_get_optional(mmc_dev(host->mmc), RK35xx_MAX_CLKS,
-					 priv->rockchip_clks);
-	if (err) {
-		dev_err(mmc_dev(host->mmc), "failed to get clocks %d\n", err);
-		return err;
-	}
-
-	err = clk_bulk_prepare_enable(RK35xx_MAX_CLKS, priv->rockchip_clks);
-	if (err) {
-		dev_err(mmc_dev(host->mmc), "failed to enable clocks %d\n", err);
+	err = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
+					    ARRAY_SIZE(clk_ids), clk_ids);
+	if (err)
 		return err;
-	}
 
 	if (of_property_read_u8(mmc_dev(host->mmc)->of_node, "rockchip,txclk-tapnum",
 				&priv->txclk_tapnum))
@@ -1280,9 +1300,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 err_clk:
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
 free_pltfm:
 	sdhci_pltfm_free(pdev);
 	return err;
@@ -1304,7 +1322,6 @@ static void dwcmshc_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	struct rk35xx_priv *rk_priv = priv->priv;
 
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -1316,9 +1333,7 @@ static void dwcmshc_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
 	sdhci_pltfm_free(pdev);
 }
 
@@ -1328,7 +1343,6 @@ static int dwcmshc_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	struct rk35xx_priv *rk_priv = priv->priv;
 	int ret;
 
 	pm_runtime_resume(dev);
@@ -1347,9 +1361,7 @@ static int dwcmshc_suspend(struct device *dev)
 	if (!IS_ERR(priv->bus_clk))
 		clk_disable_unprepare(priv->bus_clk);
 
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
 
 	return ret;
 }
@@ -1359,7 +1371,6 @@ static int dwcmshc_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	struct rk35xx_priv *rk_priv = priv->priv;
 	int ret;
 
 	ret = clk_prepare_enable(pltfm_host->clk);
@@ -1372,29 +1383,24 @@ static int dwcmshc_resume(struct device *dev)
 			goto disable_clk;
 	}
 
-	if (rk_priv) {
-		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS,
-					      rk_priv->rockchip_clks);
-		if (ret)
-			goto disable_bus_clk;
-	}
+	ret = clk_bulk_prepare_enable(priv->num_other_clks, priv->other_clks);
+	if (ret)
+		goto disable_bus_clk;
 
 	ret = sdhci_resume_host(host);
 	if (ret)
-		goto disable_rockchip_clks;
+		goto disable_other_clks;
 
 	if (host->mmc->caps2 & MMC_CAP2_CQE) {
 		ret = cqhci_resume(host->mmc);
 		if (ret)
-			goto disable_rockchip_clks;
+			goto disable_other_clks;
 	}
 
 	return 0;
 
-disable_rockchip_clks:
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+disable_other_clks:
+	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
 disable_bus_clk:
 	if (!IS_ERR(priv->bus_clk))
 		clk_disable_unprepare(priv->bus_clk);
-- 
2.34.1

