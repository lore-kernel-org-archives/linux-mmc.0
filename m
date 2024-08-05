Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8B314B972;
	Mon,  5 Aug 2024 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849574; cv=none; b=a8gL58gULEqhDPdLY2sGLp/fuQnxGsAlmTJc0aJMUZFocY9B+/95b4PbTQk91T5n2HD9VRxageGC/rbU0bjP6voex+Jc6N1dwXlsFcO/6fxSoMGrIuTxrDD9FOO/35+J22q9A0dRuiQa6EWM8AHoEHf1VsIRQbHTr9l1kwZt220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849574; c=relaxed/simple;
	bh=XaZLr7IoQl3tCsBD0MzKm7r3OHhzhTX9bE9XWcen/QA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=chHBd7rCjTFvVRW0/fUXH6wyviOpIoCD29TkcKte7Ou8tDZ3+goYYrmZgJYiZ2lbzx+EeLKk/gZP6Pcvimw6zo/YxYP2Tu4DM1M5VXguARncKNBtZz0rsR6xyxxhQyjTfinFHgFw5QdDLCbyJPq/VZnkjzthiVdxG3536N1PLho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIuyg1yi; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIuyg1yi"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db19caec60so7285611b6e.1;
        Mon, 05 Aug 2024 02:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722849572; x=1723454372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lp03N9q94P+b0VTfwMKBdE9lEAm1JOVbrcRtoFwvCAM=;
        b=nIuyg1yipcpF6tuXvmwnIsuw15mgJPK1IEn52yh9XToqjuPUgypbn2AEEB3YuxR4bw
         c8cqYu7b/M/DEPqNnNRhVA12v9uxE6ptBi9+Msvrzlm3ZPS0DjWZ6eeM3Bonfnb3QVJD
         i0Pg3NlrU31l1bMcjVFd5xs5B8+k8xgaEMLs8m4HOFqC1MzWfgFzxS1aDKaEYTIIamKS
         bH5rIA5TP+gxpHgzcjvTPrrK6oBq8W7Ezl/leb55yqpePOkwEsEw8r6DRzbIm/oD2BJo
         JZoaT/y6rJNPjFcRUSQBndK3AjFA2IFno/Xmtny2Kj5UcyW4l8KAygTimRY3WdSVASBz
         6rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722849572; x=1723454372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lp03N9q94P+b0VTfwMKBdE9lEAm1JOVbrcRtoFwvCAM=;
        b=nyvKsn2WErd/+UeFNxyg/PscjHFrnUXaM2S7uqIiLTsKcOEvTpvGgzj5fROhcRmEZX
         lMbZQGCn7pvagvOB+d5MRE4dGV4+K6iZ8yS0nxqBAIebDha3thbx3oEp7H+ZwTXAxDcg
         9ChnnsmdhpUU+8AcmDO2SRd8JOpVtfxDsLc1hG4cu6DpRV7xOnB8swL8oxd5H+/1+VaM
         /dXekSNtuhsQ351J/MtoITXLW9TibY6yfa4e7S7zZojAjE6QzgvI2oN4ASMlh/TRtCVU
         UdvR99uAQolULvqcnP5mPsZnt6p0c3iuPXOT36Bwe0RAD+GH66FSPD4b4ZwBueUz+7Dx
         4xtA==
X-Forwarded-Encrypted: i=1; AJvYcCV8bEnwsr2UpyFyqg36D33OC61LhU7bptb/WJzEuCxOw9bnlv+JTsa8HFxzQ7nTB06+zyHR82VHQj2FEb9YVkpb6eXvNOd4XauaWNujALZGpFbPgdbkR86N4vnGbS28IUu6tjMJeZeZ3Ok1ygHyb8kqnV8+OjLMKcoFHtGBFDBUalszhg==
X-Gm-Message-State: AOJu0YwBMnq4fv7PfcvyxdsuFdafC/Dmkfk1Wayb98QBAVFCM3ctk5Ym
	31BNt5H+GqDHeLDnQBhYuWd4blp/zXC5ttzNvSTQHzKtXu8TvYyE
X-Google-Smtp-Source: AGHT+IEfmOLizMFk5P/SrlD7UaXTnriU6WQmVeoharKwUK7VAo90vO3Sw/aoWRuOCvcRBnL4je5sFw==
X-Received: by 2002:a05:6808:1444:b0:3db:25f6:a59c with SMTP id 5614622812f47-3db557fdf3amr15784856b6e.6.1722849572375;
        Mon, 05 Aug 2024 02:19:32 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db563c7381sm2561166b6e.56.2024.08.05.02.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 02:19:32 -0700 (PDT)
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
Subject: [PATCH v6 7/8] mmc: sdhci-of-dwcmshc: Add support for Sophgo SG2042
Date: Mon,  5 Aug 2024 17:19:24 +0800
Message-Id: <eb21847528a6487af54bb80f1ce94adff289cdb0.1722847198.git.unicorn_wang@outlook.com>
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

Add support for the mmc controller of Sophgo SG2042.

SG2042 uses Synopsys PHY the same as TH1520 so we reuse the tuning
logic from TH1520. Besides this, this patch implement some SG2042
specific work, such as clocks and reset ops.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 125 ++++++++++++++++++++++++++--
 1 file changed, 118 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 16f420994519..ba8960d8b2d4 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -113,12 +113,15 @@
 #define DWC_MSHC_PTR_PHY_R	0x300
 
 /* PHY general configuration */
-#define PHY_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x00)
-#define PHY_CNFG_RSTN_DEASSERT	0x1  /* Deassert PHY reset */
-#define PHY_CNFG_PAD_SP_MASK	GENMASK(19, 16) /* bits [19:16] */
-#define PHY_CNFG_PAD_SP		0x0c /* PMOS TX drive strength */
-#define PHY_CNFG_PAD_SN_MASK	GENMASK(23, 20) /* bits [23:20] */
-#define PHY_CNFG_PAD_SN		0x0c /* NMOS TX drive strength */
+#define PHY_CNFG_R			(DWC_MSHC_PTR_PHY_R + 0x00)
+#define PHY_CNFG_RSTN_DEASSERT		0x1  /* Deassert PHY reset */
+#define PHY_CNFG_PHY_PWRGOOD_MASK	BIT_MASK(1) /* bit [1] */
+#define PHY_CNFG_PAD_SP_MASK		GENMASK(19, 16) /* bits [19:16] */
+#define PHY_CNFG_PAD_SP			0x0c /* PMOS TX drive strength */
+#define PHY_CNFG_PAD_SP_SG2042		0x09 /* PMOS TX drive strength for SG2042 */
+#define PHY_CNFG_PAD_SN_MASK		GENMASK(23, 20) /* bits [23:20] */
+#define PHY_CNFG_PAD_SN			0x0c /* NMOS TX drive strength */
+#define PHY_CNFG_PAD_SN_SG2042		0x08 /* NMOS TX drive strength for SG2042 */
 
 /* PHY command/response pad settings */
 #define PHY_CMDPAD_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x04)
@@ -147,10 +150,12 @@
 #define PHY_PAD_TXSLEW_CTRL_P		0x3 /* Slew control for P-Type pad TX */
 #define PHY_PAD_TXSLEW_CTRL_N_MASK	GENMASK(12, 9) /* bits [12:9] */
 #define PHY_PAD_TXSLEW_CTRL_N		0x3 /* Slew control for N-Type pad TX */
+#define PHY_PAD_TXSLEW_CTRL_N_SG2042	0x2 /* Slew control for N-Type pad TX for SG2042 */
 
 /* PHY CLK delay line settings */
 #define PHY_SDCLKDL_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x1d)
-#define PHY_SDCLKDL_CNFG_UPDATE	BIT(4) /* set before writing to SDCLKDL_DC */
+#define PHY_SDCLKDL_CNFG_EXTDLY_EN	BIT(0)
+#define PHY_SDCLKDL_CNFG_UPDATE		BIT(4) /* set before writing to SDCLKDL_DC */
 
 /* PHY CLK delay line delay code */
 #define PHY_SDCLKDL_DC_R		(DWC_MSHC_PTR_PHY_R + 0x1e)
@@ -158,10 +163,14 @@
 #define PHY_SDCLKDL_DC_DEFAULT		0x32 /* default delay code */
 #define PHY_SDCLKDL_DC_HS400		0x18 /* delay code for HS400 mode */
 
+#define PHY_SMPLDL_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x20)
+#define PHY_SMPLDL_CNFG_BYPASS_EN	BIT(1)
+
 /* PHY drift_cclk_rx delay line configuration setting */
 #define PHY_ATDL_CNFG_R			(DWC_MSHC_PTR_PHY_R + 0x21)
 #define PHY_ATDL_CNFG_INPSEL_MASK	GENMASK(3, 2) /* bits [3:2] */
 #define PHY_ATDL_CNFG_INPSEL		0x3 /* delay line input source */
+#define PHY_ATDL_CNFG_INPSEL_SG2042	0x2 /* delay line input source for SG2042 */
 
 /* PHY DLL control settings */
 #define PHY_DLL_CTRL_R			(DWC_MSHC_PTR_PHY_R + 0x24)
@@ -1013,6 +1022,85 @@ static int cv18xx_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 	return ret;
 }
 
+static inline void sg2042_sdhci_phy_init(struct sdhci_host *host)
+{
+	u32 val;
+
+	/* Asset phy reset & set tx drive strength */
+	val = sdhci_readl(host, PHY_CNFG_R);
+	val &= ~PHY_CNFG_RSTN_DEASSERT;
+	val |= FIELD_PREP(PHY_CNFG_PHY_PWRGOOD_MASK, 1);
+	val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP_SG2042);
+	val |= FIELD_PREP(PHY_CNFG_PAD_SN_MASK, PHY_CNFG_PAD_SN_SG2042);
+	sdhci_writel(host, val, PHY_CNFG_R);
+
+	/* Configure phy pads */
+	val = PHY_PAD_RXSEL_3V3;
+	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
+	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
+	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
+	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
+
+	val = PHY_PAD_RXSEL_3V3;
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
+	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
+
+	val = PHY_PAD_RXSEL_3V3;
+	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
+	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
+
+	/* Configure delay line */
+	/* Enable fixed delay */
+	sdhci_writeb(host, PHY_SDCLKDL_CNFG_EXTDLY_EN, PHY_SDCLKDL_CNFG_R);
+	/*
+	 * Set delay line.
+	 * Its recommended that bit UPDATE_DC[4] is 1 when SDCLKDL_DC is being written.
+	 * Ensure UPDATE_DC[4] is '0' when not updating code.
+	 */
+	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
+	val |= PHY_SDCLKDL_CNFG_UPDATE;
+	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
+	/* Add 10 * 70ps = 0.7ns for output delay */
+	sdhci_writeb(host, 10, PHY_SDCLKDL_DC_R);
+	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
+	val &= ~(PHY_SDCLKDL_CNFG_UPDATE);
+	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
+
+	/* Set SMPLDL_CNFG, Bypass */
+	sdhci_writeb(host, PHY_SMPLDL_CNFG_BYPASS_EN, PHY_SMPLDL_CNFG_R);
+
+	/* Set ATDL_CNFG, tuning clk not use for init */
+	val = FIELD_PREP(PHY_ATDL_CNFG_INPSEL_MASK, PHY_ATDL_CNFG_INPSEL_SG2042);
+	sdhci_writeb(host, val, PHY_ATDL_CNFG_R);
+
+	/* Deasset phy reset */
+	val = sdhci_readl(host, PHY_CNFG_R);
+	val |= PHY_CNFG_RSTN_DEASSERT;
+	sdhci_writel(host, val, PHY_CNFG_R);
+}
+
+static void sg2042_sdhci_reset(struct sdhci_host *host, u8 mask)
+{
+	sdhci_reset(host, mask);
+
+	if (mask & SDHCI_RESET_ALL)
+		sg2042_sdhci_phy_init(host);
+}
+
+static int sg2042_init(struct device *dev, struct sdhci_host *host,
+		       struct dwcmshc_priv *dwc_priv)
+{
+	static const char * const clk_ids[] = {"timer"};
+
+	return dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
+					     ARRAY_SIZE(clk_ids), clk_ids);
+}
+
 static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.set_clock		= sdhci_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
@@ -1054,6 +1142,16 @@ static const struct sdhci_ops sdhci_dwcmshc_cv18xx_ops = {
 	.platform_execute_tuning = cv18xx_sdhci_execute_tuning,
 };
 
+static const struct sdhci_ops sdhci_dwcmshc_sg2042_ops = {
+	.set_clock		= sdhci_set_clock,
+	.set_bus_width		= sdhci_set_bus_width,
+	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
+	.get_max_clock		= dwcmshc_get_max_clock,
+	.reset			= sg2042_sdhci_reset,
+	.adma_write_desc	= dwcmshc_adma_write_desc,
+	.platform_execute_tuning = th1520_execute_tuning,
+};
+
 static const struct dwcmshc_pltfm_data sdhci_dwcmshc_pdata = {
 	.pdata = {
 		.ops = &sdhci_dwcmshc_ops,
@@ -1102,6 +1200,15 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_cv18xx_pdata = {
 	},
 };
 
+static const struct dwcmshc_pltfm_data sdhci_dwcmshc_sg2042_pdata = {
+	.pdata = {
+		.ops = &sdhci_dwcmshc_sg2042_ops,
+		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	},
+	.init = sg2042_init,
+};
+
 static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
 	.enable		= dwcmshc_sdhci_cqe_enable,
 	.disable	= sdhci_cqe_disable,
@@ -1194,6 +1301,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
 		.compatible = "thead,th1520-dwcmshc",
 		.data = &sdhci_dwcmshc_th1520_pdata,
 	},
+	{
+		.compatible = "sophgo,sg2042-dwcmshc",
+		.data = &sdhci_dwcmshc_sg2042_pdata,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
-- 
2.34.1

