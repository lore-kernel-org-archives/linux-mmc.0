Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64158C09;
	Thu, 13 Jun 2024 01:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243001; cv=none; b=oc2L1CI6pY6IG91u5JDcjDJ87h5iV23vDGlu+/koXPbZ9D/aAZtonu2ui7cyXCpDs4ikzdxyTk8IyHtSEKgLvLAHlz6b6iOV+9nI8oDIUR8T7QgjFRV7bMwjZ7RfM1mQrUeVdzHqV5en1k41I8TxQZUbaIiXh6yVXDZ6i4nR3cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243001; c=relaxed/simple;
	bh=18h/ZmPomL46p/IdVTL3lUMVHnK21Ly+03PCZGlxfsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cuVScfACL0F6pIophYUNAgdHhfbunGuLD+QHQh0lmZDZIpkF2Uat6BWsA+uuZpQ+zcHb6Wl33yY/xBb85v11fxVBC64RQFpSn9GHy5AxNysLg5eRcEVV+btbZFkWPC1FlWFRV7xTGKgF0iF6NjkD5Dm4xY2bJXMgTbTnoFlXa58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvdG+Sux; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvdG+Sux"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d24724514eso101555b6e.0;
        Wed, 12 Jun 2024 18:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718242999; x=1718847799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbD6SremdmxVZ0GUzq/7rE++FPn/ciMc7/PALB4g6fM=;
        b=OvdG+SuxNT0UV62/bTFiTOpaQc6G6YT6yumn6cQ84mzr2iNGWfVd0M7s3nBwWomMaW
         LO18vLrVoO18Rn0SYfxz39cyFwNSo0WzUkEk2CywSgPlGDR8IOfJ24e9aeY/pY5rPLP4
         VRSprzBzltWHY5GU94JJxuoBw8yoIVr0QRi7N05mKHWEez9KOlDXo9mP8mM7yCQoJ3oo
         6wDLI5UoDA6aYVnIYtm6eYvBF3QKHQj/IsTY0veXVzfrJ2tNSvEYVlS0fpFj7IwKtspS
         FPIZpnc4WP/x6Nh0kydQGVTtPnYxnrQKm2S74p2MbrvCOizYZYp48ZYOEjg7D+gpI1U5
         5+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718242999; x=1718847799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbD6SremdmxVZ0GUzq/7rE++FPn/ciMc7/PALB4g6fM=;
        b=PLivZhWEBlrpLFVzRWJZgeumQr5qIYQWk68CRYQEyHOfauMOAcR/PuEOGnk5E7Kjx5
         er3n04JC/pnXH88oNy33vrRV6ugWsa9TK/r7OeKNkMGXXM57I4Wf8ti3eaFIuTujR/zC
         YznaUEb8N72+xWYHKaeTPoRFI1o8ueTwYcyGuzIRqvf5yGp/yHLhzXOeHQlr/OeurWqw
         Uk4uY6zhIPu0DXhSDYb427sbMX2kC7cL33LQOi/DqEt8SsHJSG2gBobuxuk7E3AD+OFh
         PJvBKTnlYrTUAUs3QlAhVnu6MqnJFF/WPZgrzfF4ybtS1hGgknCc6N4X246fIlHhw3Dk
         vTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNr4I77cfwKy9IOssgHFdLLX/RwsqBzbOEa+2IokaS90gPMSWueultJWQMk8rlpBoP8FQG2b5vxEgsg0BlnZaHZBLq7BDLkjZIx+vW74N7Jw05dIxMCQUCz5JRVOxhBqAJk6KGGg2raxcrnImZyTMF3ORV2sWrgRk5lR1zm4G55ma9kg==
X-Gm-Message-State: AOJu0Yyjd4gmN6g7cqT81RchXtn6QV+jjXGwWX8MchwSGTL9lmfxkLzc
	FyaamG5i3ZQc7SEB4IjwN8NZyw1e1k7WqHkoR+mrdHtnmJ0tpUzC
X-Google-Smtp-Source: AGHT+IFmIDk/X/zy9LRcduSnBl9YyJYHeNIg54XFnzU/VeRzTcaAbcqqt1huRWTU4iTw8UjZVGCjUg==
X-Received: by 2002:a05:6808:2191:b0:3d2:308b:9bb4 with SMTP id 5614622812f47-3d23e0cfbb9mr3918608b6e.43.1718242998751;
        Wed, 12 Jun 2024 18:43:18 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d24762ee1esm49355b6e.29.2024.06.12.18.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 18:43:18 -0700 (PDT)
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
Subject: [PATCH v3 3/4] mmc: sdhci-of-dwcmshc: extract init function for rk35xx/th1520
Date: Thu, 13 Jun 2024 09:43:11 +0800
Message-Id: <459e341a32128ffbae5acdc77a1c835cbee582e6.1718241495.git.unicorn_wang@outlook.com>
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

Extract init function for rk35xx/th1520, which is an intermediate
process before further optimization.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 83 ++++++++++++++++-------------
 1 file changed, 46 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 346d2d323a05..38ab755aa044 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -749,10 +749,19 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 	sdhci_reset(host, mask);
 }
 
-static int rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+static int rk35xx_init(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
 {
 	int err;
-	struct rk35xx_priv *priv = dwc_priv->priv;
+	struct rk35xx_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	if (of_device_is_compatible(dev->of_node, "rockchip,rk3588-dwcmshc"))
+		priv->devtype = DWCMSHC_RK3588;
+	else
+		priv->devtype = DWCMSHC_RK3568;
 
 	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
 	if (IS_ERR(priv->reset)) {
@@ -787,6 +796,8 @@ static int rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
 	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
 	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
 
+	dwc_priv->priv = priv;
+
 	return 0;
 }
 
@@ -915,6 +926,35 @@ static void th1520_sdhci_reset(struct sdhci_host *host, u8 mask)
 	}
 }
 
+static int th1520_init(struct device *dev,
+		       struct sdhci_host *host,
+		       struct dwcmshc_priv *dwc_priv)
+{
+	dwc_priv->delay_line = PHY_SDCLKDL_DC_DEFAULT;
+
+	if (device_property_read_bool(dev, "mmc-ddr-1_8v") ||
+	    device_property_read_bool(dev, "mmc-hs200-1_8v") ||
+	    device_property_read_bool(dev, "mmc-hs400-1_8v"))
+		dwc_priv->flags |= FLAG_IO_FIXED_1V8;
+	else
+		dwc_priv->flags &= ~FLAG_IO_FIXED_1V8;
+
+	/*
+	 * start_signal_voltage_switch() will try 3.3V first
+	 * then 1.8V. Use SDHCI_SIGNALING_180 rather than
+	 * SDHCI_SIGNALING_330 to avoid setting voltage to 3.3V
+	 * in sdhci_start_signal_voltage_switch().
+	 */
+	if (dwc_priv->flags & FLAG_IO_FIXED_1V8) {
+		host->flags &= ~SDHCI_SIGNALING_330;
+		host->flags |=  SDHCI_SIGNALING_180;
+	}
+
+	sdhci_enable_v4_mode(host);
+
+	return 0;
+}
+
 static void cv18xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1230,46 +1270,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	host->mmc_host_ops.execute_tuning = dwcmshc_execute_tuning;
 
 	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
-		rk_priv = devm_kzalloc(&pdev->dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
-		if (!rk_priv) {
-			err = -ENOMEM;
-			goto err_clk;
-		}
-
-		if (of_device_is_compatible(pdev->dev.of_node, "rockchip,rk3588-dwcmshc"))
-			rk_priv->devtype = DWCMSHC_RK3588;
-		else
-			rk_priv->devtype = DWCMSHC_RK3568;
-
-		priv->priv = rk_priv;
-
-		err = rk35xx_init(host, priv);
+		err = rk35xx_init(&pdev->dev, host, priv);
 		if (err)
 			goto err_clk;
 	}
 
 	if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
-		priv->delay_line = PHY_SDCLKDL_DC_DEFAULT;
-
-		if (device_property_read_bool(dev, "mmc-ddr-1_8v") ||
-		    device_property_read_bool(dev, "mmc-hs200-1_8v") ||
-		    device_property_read_bool(dev, "mmc-hs400-1_8v"))
-			priv->flags |= FLAG_IO_FIXED_1V8;
-		else
-			priv->flags &= ~FLAG_IO_FIXED_1V8;
-
-		/*
-		 * start_signal_voltage_switch() will try 3.3V first
-		 * then 1.8V. Use SDHCI_SIGNALING_180 rather than
-		 * SDHCI_SIGNALING_330 to avoid setting voltage to 3.3V
-		 * in sdhci_start_signal_voltage_switch().
-		 */
-		if (priv->flags & FLAG_IO_FIXED_1V8) {
-			host->flags &= ~SDHCI_SIGNALING_330;
-			host->flags |=  SDHCI_SIGNALING_180;
-		}
-
-		sdhci_enable_v4_mode(host);
+		err = th1520_init(&pdev->dev, host, priv);
+		if (err)
+			goto err_clk;
 	}
 
 #ifdef CONFIG_ACPI
-- 
2.25.1

