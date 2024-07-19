Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFD28002A;
	Fri, 19 Jul 2024 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378716; cv=none; b=f9F4hKk6gVABMwAOA+jrwr1MxpVB/kSODeCdeNHiTlw9G/kmmC+rVcRzNGYNet3tdkD4LpMckat5jh4PY1B3BUhsVKFi6Gz3xuZl/dYCnLZAs/F034JZGZjD5kr5ABaH/GuNhP3KuX7TUIKsqMJMeDqaLlKcDIY5W6pWBJ+H1R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378716; c=relaxed/simple;
	bh=ckOGdbz8CF8OKFi17EcSClrEZ5EoMu1Hq0cV2/kx5+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRaMxTX/HGTl6GsKRhHIoKEtrisDd+2MKlcfQYuBhqk9JjKQbMM9PUOuJ2pqrq1yIx+/CGc2yyOr7JHfCyxkHt/49jJZOAigYG8b+RP1ZxnY3RN43VFiTF9zNB2Qug6xcBvHCmt7VucFVywmr7+uQZ1iTeEm1rTIo26J0VR9G+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfdTX2FW; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfdTX2FW"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5c6924f2383so800397eaf.2;
        Fri, 19 Jul 2024 01:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721378714; x=1721983514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sELq+pnUeocm+uKlZ5dgRG6XUZ8Z2pYFiswc3B/vsIc=;
        b=ZfdTX2FW3e8y3FaI63W6q3xnu5lOaswi0r3WRahEEjMjyCAxMxU8XI7pB/EGlbngPs
         w3X17wn9bbuGMAnCdd76OrS4V4PH+kZlwNlwPp2KSQMw0LKLKYRXjKmrQ3mD+BnlIA6K
         LyFAVZCnDIOGJwi5EnNrBNnoxvoORykiPOg+Sk0qfeB5DQkhMpzxQITmuRSi8phvzKT7
         /kX9yuSlYtj3DZYr/IqYdxydjyv5MhEqLwnJkARYJTUICmOxnRo9/wh6OWxv5dprt/yv
         qMqv0ssU31shgfwzlpy7ll0/fLBziuzNytLNOd69efGMQXG4fAWnQHxDC3rf8tfhBUgi
         cUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721378714; x=1721983514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sELq+pnUeocm+uKlZ5dgRG6XUZ8Z2pYFiswc3B/vsIc=;
        b=bNcfvnYKel1TbewGOHFOjCVtqMMfmfzMytYYFHli5MYDF9wm0m2sHPMNfFoAlFzzOV
         6xvFvHhw6Oz37VOyJqJ535lbH0B8CVYjAKdMw/ksg+W1/2NEg5TpcOD9rU5oonjylyZO
         697Bh+g2BbstvDDmIMlg6LJLHlhQEfjboMQMuXoQiIEOrxu9alew/aBmj+rmR2yT5xc4
         5mWr0Vny/Xvoq7RE2jrCGyus6MCQMwo4hdo6DmXhSvOj6ESVjsttfZIpC9szni3rLonm
         9mSs6g7usIAibZYsRzyVWTID+CIrx7m1zu5X8UyPnIkzBJFnoztt9aGj79IwO3ZkEJvJ
         gMrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJoKxkkpoLA/OzHdPRqIWYwILtYMDd5/yGFmAjxVGRTVNwNsRXDgxFX4HLMQxs2//+X0EEj1XY5P+08Ot8bpXBAQMqG1tIzv2AP1oSOUH5fpCOAjGpb8Ir6y5a1MTCNakQ7cbXpTWwNVUEOc8QlxRN90qG1KWBz03hesvaYioA/daUbA==
X-Gm-Message-State: AOJu0YxMazmSo8k/34ZKcoMLYrahEDdX5qst8EmiD/JdZjB3ISIRGmwk
	GrQvBbHYLaVSMEAosrzSvlcKAl8lTpFVumNt5quqoe3A8e4CUZEz
X-Google-Smtp-Source: AGHT+IGOQXJd+89L2geGpYfPlq1f04pQ5M8BxLCVshzWe/3mlon4W0Wf3vA0TEKVNMoepz+AwfvC7w==
X-Received: by 2002:a05:6820:1e81:b0:5c6:9293:ed8a with SMTP id 006d021491bc7-5d41c219082mr9049921eaf.6.1721378714072;
        Fri, 19 Jul 2024 01:45:14 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d55a855091sm171342eaf.20.2024.07.19.01.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 01:45:13 -0700 (PDT)
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
Subject: [PATCH v5 1/8] mmc: sdhci-of-dwcmshc: add common bulk optional clocks support
Date: Fri, 19 Jul 2024 16:45:06 +0800
Message-Id: <e6d09bb8f0b02843967cd5c6d378ce5adbbf661f.1721377374.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721377374.git.unicorn_wang@outlook.com>
References: <cover.1721377374.git.unicorn_wang@outlook.com>
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
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 91 ++++++++++++++++-------------
 1 file changed, 49 insertions(+), 42 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index e79aa4b3b6c3..fb4076c19ed5 100644
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
@@ -1280,9 +1300,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
 err_clk:
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+	if (priv->num_other_clks)
+		clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
 free_pltfm:
 	sdhci_pltfm_free(pdev);
 	return err;
@@ -1304,7 +1323,6 @@ static void dwcmshc_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	struct rk35xx_priv *rk_priv = priv->priv;
 
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -1316,9 +1334,7 @@ static void dwcmshc_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
 	sdhci_pltfm_free(pdev);
 }
 
@@ -1328,7 +1344,6 @@ static int dwcmshc_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	struct rk35xx_priv *rk_priv = priv->priv;
 	int ret;
 
 	pm_runtime_resume(dev);
@@ -1347,9 +1362,7 @@ static int dwcmshc_suspend(struct device *dev)
 	if (!IS_ERR(priv->bus_clk))
 		clk_disable_unprepare(priv->bus_clk);
 
-	if (rk_priv)
-		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
-					   rk_priv->rockchip_clks);
+	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
 
 	return ret;
 }
@@ -1359,7 +1372,6 @@ static int dwcmshc_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	struct rk35xx_priv *rk_priv = priv->priv;
 	int ret;
 
 	ret = clk_prepare_enable(pltfm_host->clk);
@@ -1372,29 +1384,24 @@ static int dwcmshc_resume(struct device *dev)
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

