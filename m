Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646D3EEC8;
	Thu, 13 Jun 2024 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718242957; cv=none; b=n1+pGY09VXoFklg60pJ0vSS+qlD6LjDWAB8440s+1vOFAkshqtreeIaqP2dN4EFikJ8JoQt+FQHmP7yXMRTrwlsL7lsD2OItZ+UM7b2vYG9u/s7A57/atM4/CRaUDIJKTd+R5j1m7M/COkqU2aRdWd/gr4jmb1dLjWjANmUzfkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718242957; c=relaxed/simple;
	bh=dwSiyZbjAYi8O0aXBmltdVy7jFDRI0ZIY1O/BdFRe2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B7MNgIDBjXqofitpPvDgsg5IATswbUrGbavQqlXEeUyqUPhWdGIOyGQcXOLtElV14ZcNhYkTbIj21U+BrOHirH39+79Q6uJhdXpAFtrnP5i7RX7Bhi84mFoVqVmtlAd/Xv44ahJOkdVfYvMb5R146D7MnKJfBFA5fCD/nc808lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtOSPglU; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtOSPglU"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d2299e6650so231311b6e.2;
        Wed, 12 Jun 2024 18:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718242954; x=1718847754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlV+jmlvyicWU6t9hgzw9ghUfe9KqjZKCqvHTzsCeeQ=;
        b=CtOSPglUEPGvoX2gKnpnSce/PWTTZE7G/egnTu6VNtKViEtdxg2J1qWp/MdsMIpvmJ
         dS6tTuno4ApDft7XCwm7idMT3NfBonhOm/cO3pQoEsLQf+uNOrPp1VJ4YJWX8r6VItR3
         QDhedcAZT3s4M5nbsoDXVtYF3OsreWIQ7B84qVSNlcVa0+aJEh2C9l5SRPTwQpStbYz0
         L2c5jpZf6IWsn8yqz7qWzWfsOzRwAH+jyWIpWt3l5DDxydJdbwcJzO84b8ukP3J5LtJ7
         wZSxaoX39oUqNSL8MCqVjJUnDRvbmosrkia2smYiuVxi5FjGle8xgs5dCIUDTKzmfUjk
         wEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718242954; x=1718847754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlV+jmlvyicWU6t9hgzw9ghUfe9KqjZKCqvHTzsCeeQ=;
        b=l5QYhPNzlap4XtVyyEM6oAXGKPWgkMJ0CaereG0XUQ3zUYeTTYZAR2J5rQ/UcWk3jx
         fUse5rg044zXGaTIZxy+QUYXXNmWvjcb1xOpa5A8JeuDlDe9RmujI2I0NTbp7Hr23YAb
         Hqv7kMJwaeWZ/8fUF1TqQgdVIH6F9HgxSByDY6I19X16BCeWk4poxvQOmobgMPlCavk/
         kV1s+K2AqRG4TJcu92KyJg3hZ6jIcXcv1oFanBfWB6FjWrnn1EM6AJI49rLB6T4yO/yh
         tWA8XN6SccjB2uuh8yO/2kaMVN/SxMYDhCx26U6XL0AmOejRqBLyDATc5jOdmTFanRrh
         ZJEA==
X-Forwarded-Encrypted: i=1; AJvYcCUFRVB4vcdNZFDpVtj0yKyJL7uQ/o0TTW7YtkTW9fk/bnLj9c5FEWz8TrBTHiikZLuNXkgz51goiHkkqoq2lgzHx+WYiTNSRB3fZ5tJsbOX5GihU19Xrlt+8ZhS/UYbV6CxqkhBmGDUN84u4Jd+i/Psz48W5ysi+KdKwJj7UXZQMZpwfw==
X-Gm-Message-State: AOJu0YxXTbJK0+QfaI0RO9gmSA2vWzH+AX7s7gax8nqVoyM+cfd4Fg5O
	Zmw2mw9v/2Yq4xwaL6UKWxkIqD2YNCHG6gKpA6oIZ3C2g5Yij365aiJuRyno
X-Google-Smtp-Source: AGHT+IFSzepBg6/pUgNYtDyc6E3JgstuaT5hHnEQHOPNsry8OPTFbsNNvb+6S4DGGB6zA+Xi4sIVmw==
X-Received: by 2002:a05:6808:1994:b0:3d2:1c4d:f0b9 with SMTP id 5614622812f47-3d23e11d1camr3409819b6e.53.1718242954055;
        Wed, 12 Jun 2024 18:42:34 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476bb5aesm48112b6e.38.2024.06.12.18.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 18:42:33 -0700 (PDT)
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
Subject: [PATCH v3 1/4] mmc: sdhci-of-dwcmshc: adjust positions of helper routines
Date: Thu, 13 Jun 2024 09:42:25 +0800
Message-Id: <dec4798dc2728428e7468515cbf0bc87c6eff4a9.1718241495.git.unicorn_wang@outlook.com>
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

This patch does not change the logic of the code, but only adjusts
the positions of some helper functions in the file according to
categories to facilitate future function search and maintenance.

Category: helper functions (except for driver callback functions
such as probe/remove/suspend/resume) are divided into two categories:

- dwcmshc level helpers
- soc level helpers

After the adjustment, these functions will be put together according
to category.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 392 +++++++++++++++-------------
 1 file changed, 204 insertions(+), 188 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index e79aa4b3b6c3..a68818f53786 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -216,6 +216,12 @@ struct dwcmshc_priv {
 	u16 flags;
 };
 
+/*******************************************************************************
+ *
+ * dwcmshc level helper routines begin
+ *
+ ******************************************************************************/
+
 /*
  * If DMA addr spans 128MB boundary, we split the DMA transfer into two
  * so that each DMA transfer doesn't exceed the boundary.
@@ -249,13 +255,6 @@ static unsigned int dwcmshc_get_max_clock(struct sdhci_host *host)
 		return pltfm_host->clock;
 }
 
-static unsigned int rk35xx_get_max_clock(struct sdhci_host *host)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-
-	return clk_round_rate(pltfm_host->clk, ULONG_MAX);
-}
-
 static void dwcmshc_check_auto_cmd23(struct mmc_host *mmc,
 				     struct mmc_request *mrq)
 {
@@ -377,29 +376,6 @@ static void dwcmshc_phy_3_3v_init(struct sdhci_host *host)
 	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
 }
 
-static void th1520_sdhci_set_phy(struct sdhci_host *host)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
-	u16 emmc_ctrl;
-
-	/* Before power on, set PHY configs */
-	if (priv->flags & FLAG_IO_FIXED_1V8)
-		dwcmshc_phy_1_8v_init(host);
-	else
-		dwcmshc_phy_3_3v_init(host);
-
-	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
-		emmc_ctrl = sdhci_readw(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
-		emmc_ctrl |= DWCMSHC_CARD_IS_EMMC;
-		sdhci_writew(host, emmc_ctrl, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
-	}
-
-	sdhci_writeb(host, FIELD_PREP(PHY_DLL_CNFG1_SLVDLY_MASK, PHY_DLL_CNFG1_SLVDLY) |
-		     PHY_DLL_CNFG1_WAITCYCLE, PHY_DLL_CNFG1_R);
-}
-
 static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
 				      unsigned int timing)
 {
@@ -437,20 +413,6 @@ static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 }
 
-static void th1520_set_uhs_signaling(struct sdhci_host *host,
-				     unsigned int timing)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-
-	dwcmshc_set_uhs_signaling(host, timing);
-	if (timing == MMC_TIMING_MMC_HS400)
-		priv->delay_line = PHY_SDCLKDL_DC_HS400;
-	else
-		sdhci_writeb(host, 0, PHY_DLLDL_CNFG_R);
-	th1520_sdhci_set_phy(host);
-}
-
 static void dwcmshc_hs400_enhanced_strobe(struct mmc_host *mmc,
 					  struct mmc_ios *ios)
 {
@@ -553,6 +515,112 @@ static void dwcmshc_cqhci_dumpregs(struct mmc_host *mmc)
 	sdhci_dumpregs(mmc_priv(mmc));
 }
 
+static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
+	.enable		= dwcmshc_sdhci_cqe_enable,
+	.disable	= sdhci_cqe_disable,
+	.dumpregs	= dwcmshc_cqhci_dumpregs,
+	.set_tran_desc	= dwcmshc_set_tran_desc,
+};
+
+static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *pdev)
+{
+	struct cqhci_host *cq_host;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	bool dma64 = false;
+	u16 clk;
+	int err;
+
+	host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
+	cq_host = devm_kzalloc(&pdev->dev, sizeof(*cq_host), GFP_KERNEL);
+	if (!cq_host) {
+		dev_err(mmc_dev(host->mmc), "Unable to setup CQE: not enough memory\n");
+		goto dsbl_cqe_caps;
+	}
+
+	/*
+	 * For dwcmshc host controller we have to enable internal clock
+	 * before access to some registers from Vendor Specific Area 2.
+	 */
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk |= SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	if (!(clk & SDHCI_CLOCK_INT_EN)) {
+		dev_err(mmc_dev(host->mmc), "Unable to setup CQE: internal clock enable error\n");
+		goto free_cq_host;
+	}
+
+	cq_host->mmio = host->ioaddr + priv->vendor_specific_area2;
+	cq_host->ops = &dwcmshc_cqhci_ops;
+
+	/* Enable using of 128-bit task descriptors */
+	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
+	if (dma64) {
+		dev_dbg(mmc_dev(host->mmc), "128-bit task descriptors\n");
+		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
+	}
+	err = cqhci_init(cq_host, host->mmc, dma64);
+	if (err) {
+		dev_err(mmc_dev(host->mmc), "Unable to setup CQE: error %d\n", err);
+		goto int_clock_disable;
+	}
+
+	dev_dbg(mmc_dev(host->mmc), "CQE init done\n");
+
+	return;
+
+int_clock_disable:
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk &= ~SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+free_cq_host:
+	devm_kfree(&pdev->dev, cq_host);
+
+dsbl_cqe_caps:
+	host->mmc->caps2 &= ~(MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD);
+}
+
+static void dwcmshc_disable_card_clk(struct sdhci_host *host)
+{
+	u16 ctrl;
+
+	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	if (ctrl & SDHCI_CLOCK_CARD_EN) {
+		ctrl &= ~SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
+	}
+}
+
+#ifdef CONFIG_PM
+
+static void dwcmshc_enable_card_clk(struct sdhci_host *host)
+{
+	u16 ctrl;
+
+	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	if ((ctrl & SDHCI_CLOCK_INT_EN) && !(ctrl & SDHCI_CLOCK_CARD_EN)) {
+		ctrl |= SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
+	}
+}
+
+#endif
+
+/*******************************************************************************
+ *
+ * SoC level helper routines begin
+ *
+ ******************************************************************************/
+
+static unsigned int rk35xx_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return clk_round_rate(pltfm_host->clk, ULONG_MAX);
+}
+
 static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -681,6 +749,98 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 	sdhci_reset(host, mask);
 }
 
+static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+{
+	int err;
+	struct rk35xx_priv *priv = dwc_priv->priv;
+
+	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
+	if (IS_ERR(priv->reset)) {
+		err = PTR_ERR(priv->reset);
+		dev_err(mmc_dev(host->mmc), "failed to get reset control %d\n", err);
+		return err;
+	}
+
+	priv->rockchip_clks[0].id = "axi";
+	priv->rockchip_clks[1].id = "block";
+	priv->rockchip_clks[2].id = "timer";
+	err = devm_clk_bulk_get_optional(mmc_dev(host->mmc), RK35xx_MAX_CLKS,
+					 priv->rockchip_clks);
+	if (err) {
+		dev_err(mmc_dev(host->mmc), "failed to get clocks %d\n", err);
+		return err;
+	}
+
+	err = clk_bulk_prepare_enable(RK35xx_MAX_CLKS, priv->rockchip_clks);
+	if (err) {
+		dev_err(mmc_dev(host->mmc), "failed to enable clocks %d\n", err);
+		return err;
+	}
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
+static void th1520_sdhci_set_phy(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
+	u16 emmc_ctrl;
+
+	/* Before power on, set PHY configs */
+	if (priv->flags & FLAG_IO_FIXED_1V8)
+		dwcmshc_phy_1_8v_init(host);
+	else
+		dwcmshc_phy_3_3v_init(host);
+
+	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
+		emmc_ctrl = sdhci_readw(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
+		emmc_ctrl |= DWCMSHC_CARD_IS_EMMC;
+		sdhci_writew(host, emmc_ctrl, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
+	}
+
+	sdhci_writeb(host, FIELD_PREP(PHY_DLL_CNFG1_SLVDLY_MASK, PHY_DLL_CNFG1_SLVDLY) |
+		     PHY_DLL_CNFG1_WAITCYCLE, PHY_DLL_CNFG1_R);
+}
+
+static void th1520_set_uhs_signaling(struct sdhci_host *host,
+				     unsigned int timing)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+
+	dwcmshc_set_uhs_signaling(host, timing);
+	if (timing == MMC_TIMING_MMC_HS400)
+		priv->delay_line = PHY_SDCLKDL_DC_HS400;
+	else
+		sdhci_writeb(host, 0, PHY_DLLDL_CNFG_R);
+	th1520_sdhci_set_phy(host);
+}
+
 static int th1520_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -967,128 +1127,6 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_cv18xx_pdata = {
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
-static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
-	.enable		= dwcmshc_sdhci_cqe_enable,
-	.disable	= sdhci_cqe_disable,
-	.dumpregs	= dwcmshc_cqhci_dumpregs,
-	.set_tran_desc	= dwcmshc_set_tran_desc,
-};
-
-static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *pdev)
-{
-	struct cqhci_host *cq_host;
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	bool dma64 = false;
-	u16 clk;
-	int err;
-
-	host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
-	cq_host = devm_kzalloc(&pdev->dev, sizeof(*cq_host), GFP_KERNEL);
-	if (!cq_host) {
-		dev_err(mmc_dev(host->mmc), "Unable to setup CQE: not enough memory\n");
-		goto dsbl_cqe_caps;
-	}
-
-	/*
-	 * For dwcmshc host controller we have to enable internal clock
-	 * before access to some registers from Vendor Specific Area 2.
-	 */
-	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	clk |= SDHCI_CLOCK_INT_EN;
-	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	if (!(clk & SDHCI_CLOCK_INT_EN)) {
-		dev_err(mmc_dev(host->mmc), "Unable to setup CQE: internal clock enable error\n");
-		goto free_cq_host;
-	}
-
-	cq_host->mmio = host->ioaddr + priv->vendor_specific_area2;
-	cq_host->ops = &dwcmshc_cqhci_ops;
-
-	/* Enable using of 128-bit task descriptors */
-	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
-	if (dma64) {
-		dev_dbg(mmc_dev(host->mmc), "128-bit task descriptors\n");
-		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
-	}
-	err = cqhci_init(cq_host, host->mmc, dma64);
-	if (err) {
-		dev_err(mmc_dev(host->mmc), "Unable to setup CQE: error %d\n", err);
-		goto int_clock_disable;
-	}
-
-	dev_dbg(mmc_dev(host->mmc), "CQE init done\n");
-
-	return;
-
-int_clock_disable:
-	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	clk &= ~SDHCI_CLOCK_INT_EN;
-	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-
-free_cq_host:
-	devm_kfree(&pdev->dev, cq_host);
-
-dsbl_cqe_caps:
-	host->mmc->caps2 &= ~(MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD);
-}
-
-static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
-{
-	int err;
-	struct rk35xx_priv *priv = dwc_priv->priv;
-
-	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
-	if (IS_ERR(priv->reset)) {
-		err = PTR_ERR(priv->reset);
-		dev_err(mmc_dev(host->mmc), "failed to get reset control %d\n", err);
-		return err;
-	}
-
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
-		return err;
-	}
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
@@ -1288,17 +1326,6 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	return err;
 }
 
-static void dwcmshc_disable_card_clk(struct sdhci_host *host)
-{
-	u16 ctrl;
-
-	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	if (ctrl & SDHCI_CLOCK_CARD_EN) {
-		ctrl &= ~SDHCI_CLOCK_CARD_EN;
-		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
-	}
-}
-
 static void dwcmshc_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
@@ -1406,17 +1433,6 @@ static int dwcmshc_resume(struct device *dev)
 
 #ifdef CONFIG_PM
 
-static void dwcmshc_enable_card_clk(struct sdhci_host *host)
-{
-	u16 ctrl;
-
-	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	if ((ctrl & SDHCI_CLOCK_INT_EN) && !(ctrl & SDHCI_CLOCK_CARD_EN)) {
-		ctrl |= SDHCI_CLOCK_CARD_EN;
-		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
-	}
-}
-
 static int dwcmshc_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
-- 
2.25.1

