Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBC414B972;
	Mon,  5 Aug 2024 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849471; cv=none; b=rV/IU9+AqrOiYL/mTd6VNouP1JC/2Uh5nvSIRv4ScwPCHst67Kahccr5PT5Z5GoTpBblRDg4ahK77gNZFV6OyHGrRzSkaOEDPMar40rU4d1ZkgJfi2nKtnJ4ro0YbbaCwG35cpmgP4eCmuzC8lnqJISaIAnzxEgypFdJnst6ZAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849471; c=relaxed/simple;
	bh=1p/349K3IO1rk9ZoWOQeR3BQuqWpRESY7cifdcnU0ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LWU8wgz6LCpr2vAvgxs8xX5VOuEcbHupzWQSeN458z+4/ykWNkd/LWnRQd70zIsgSsj+jqJkqr4NgG1B7kkHH/TyR7Kjvs3YSPF4b2zJ1KMW4nNNSPrBiWzoMtf7DBkOoEYZN7P1b3njZGI6RJUgJTTvfycMs6+z14hnOJRqSIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuSeVEC2; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuSeVEC2"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d829d41a89so165603eaf.3;
        Mon, 05 Aug 2024 02:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722849469; x=1723454269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8k5uVQtfV8NUTOLFTh7RVXzJOtMU6EKEmam/qAPo2E=;
        b=UuSeVEC26hbdCI3YaMr/pcpc/Moej/FJCn++z7uSbVrmHvYld4agFksM0hyDctM1qz
         KQklwyCEhOAN9bvjtcCh32uItdiz9S9K7vrORj5Ggle57z+hz/4VWTgBusVBkknPOVwR
         wvXO8W8tukuZqK7j1QRTZMCz2GcQp/nIdS0YGDu1nrLOWfBcgld4ERb/Fu7/yC3aSXuu
         fjZJhEOIwj/wBbCFi1h8VDnXpr+hZUWR7QS/Wrsl4YSBbviKo1xJDl2hCP3KlbtKvuqe
         EmokYpAyiJsmSzJxsJgHzcbimT84NPQidDp0UbrX3M6cD4x8gDWWFT32sy31o5PJvgjb
         ugew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722849469; x=1723454269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8k5uVQtfV8NUTOLFTh7RVXzJOtMU6EKEmam/qAPo2E=;
        b=ZooGM20e10wujF0wJfdcWBmQeiTPgrTOD0yXFIN+zhj0mBaYfYlEazGygw069K/EFM
         HUA87X3e+VWX9TGw/hZJwUtMB0JfSztLCSGbl/9aL7tWCDibL6tSDfZvaxEi/kHh338L
         uw3IwrXgd3giIocXR0kEgQDNpOp6RcD5u4ScSmJqn1eCGZcQg2Atfb84E9lY8DJkFThP
         CnI3VE4k6XlqAx2N4KUsmqh5XUaUJC2fszhcbnm1gFKzzGTPghlHPUghlbKpNzKf94bs
         CAadP4TK0cZrwA4p/9YQN5Mua8TVVHRC7XB21jz5L36uPSnGnIyfvzpuVRhSYxmmvblN
         oi8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtISmdLyEvG/TJXlBqBEat+TjolUXNq+/nLbO/Qgm/ahNbzZEZjK6h3xV7JSmwwSqbqZN5sbaXjAW61hP9khQkjbaoEtqkZNGU3wiXWInCb1HdLZ3xBeF/2DN5hUZPFZMoKAqehykojFoMpJRW4YUuNRSQDpQbeV1vkfwo2TUWMiPgRw==
X-Gm-Message-State: AOJu0YyzA9u5malv2q2zUrFDDpnv6N6fs8Cb0913+3QG6VnQwqZJ+1hq
	NWzMDc/GnA2vEWLwnNVYrAJws59HhWJ4wMYtMpj39gWSdg/hyGAF
X-Google-Smtp-Source: AGHT+IEIp8y7lLQIWcjPh7pCGQ/cek2Jyros8ijAp0OQXpassUcZ+4MW/h9yG7N6uQtXrGDYyEcl1w==
X-Received: by 2002:a05:6820:4b0a:b0:5d8:ebe:23fb with SMTP id 006d021491bc7-5d80ebe26ffmr5871359eaf.7.1722849468666;
        Mon, 05 Aug 2024 02:17:48 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d7478b084csm1882630eaf.0.2024.08.05.02.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 02:17:48 -0700 (PDT)
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
Subject: [PATCH v6 2/8] mmc: sdhci-of-dwcmshc: move two rk35xx functions
Date: Mon,  5 Aug 2024 17:17:40 +0800
Message-Id: <54204702d5febd3e867eb3544c36919fe4140a88.1722847198.git.unicorn_wang@outlook.com>
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

This patch just move dwcmshc_rk35xx_init() and
dwcmshc_rk35xx_postinit() to put the functions
of rk35xx together as much as possible.

This change is an intermediate process before
further modification.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Tested-by: Drew Fustini <drew@pdp7.com> # TH1520
Tested-by: Inochi Amaoto <inochiama@outlook.com> # Duo and Huashan Pi
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 90 ++++++++++++++---------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 35401616fb2e..a002636d51fd 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -711,6 +711,51 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 	sdhci_reset(host, mask);
 }
 
+static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+{
+	static const char * const clk_ids[] = {"axi", "block", "timer"};
+	struct rk35xx_priv *priv = dwc_priv->priv;
+	int err;
+
+	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
+	if (IS_ERR(priv->reset)) {
+		err = PTR_ERR(priv->reset);
+		dev_err(mmc_dev(host->mmc), "failed to get reset control %d\n", err);
+		return err;
+	}
+
+	err = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
+					    ARRAY_SIZE(clk_ids), clk_ids);
+	if (err)
+		return err;
+
+	if (of_property_read_u8(mmc_dev(host->mmc)->of_node, "rockchip,txclk-tapnum",
+				&priv->txclk_tapnum))
+		priv->txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
+
+	/* Disable cmd conflict check */
+	sdhci_writel(host, 0x0, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
+	/* Reset previous settings */
+	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
+	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
+
+	return 0;
+}
+
+static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+{
+	/*
+	 * Don't support highspeed bus mode with low clk speed as we
+	 * cannot use DLL for this condition.
+	 */
+	if (host->mmc->f_max <= 52000000) {
+		dev_info(mmc_dev(host->mmc), "Disabling HS200/HS400, frequency too low (%d)\n",
+			 host->mmc->f_max);
+		host->mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);
+		host->mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR);
+	}
+}
+
 static int th1520_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1064,51 +1109,6 @@ static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *
 	host->mmc->caps2 &= ~(MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD);
 }
 
-static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
-{
-	static const char * const clk_ids[] = {"axi", "block", "timer"};
-	struct rk35xx_priv *priv = dwc_priv->priv;
-	int err;
-
-	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
-	if (IS_ERR(priv->reset)) {
-		err = PTR_ERR(priv->reset);
-		dev_err(mmc_dev(host->mmc), "failed to get reset control %d\n", err);
-		return err;
-	}
-
-	err = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
-					    ARRAY_SIZE(clk_ids), clk_ids);
-	if (err)
-		return err;
-
-	if (of_property_read_u8(mmc_dev(host->mmc)->of_node, "rockchip,txclk-tapnum",
-				&priv->txclk_tapnum))
-		priv->txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
-
-	/* Disable cmd conflict check */
-	sdhci_writel(host, 0x0, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
-	/* Reset previous settings */
-	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
-	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
-
-	return 0;
-}
-
-static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
-{
-	/*
-	 * Don't support highspeed bus mode with low clk speed as we
-	 * cannot use DLL for this condition.
-	 */
-	if (host->mmc->f_max <= 52000000) {
-		dev_info(mmc_dev(host->mmc), "Disabling HS200/HS400, frequency too low (%d)\n",
-			 host->mmc->f_max);
-		host->mmc->caps2 &= ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);
-		host->mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR);
-	}
-}
-
 static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
 	{
 		.compatible = "rockchip,rk3588-dwcmshc",
-- 
2.34.1

