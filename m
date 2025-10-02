Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B323B278E67
	for <linux-mmc@vger.kernel.org>; Thu,  2 Oct 2025 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759439101; cv=none; b=YKy47aoxz3WsPSHRlKiO9QOJkRzeMZxM1N5rgjmW4x6EHSoNKj3zsLOJ5tLV68NRhUWhK51LYfURNrIaNUpblzNgYsjgni59CMj2yRxIco/4DijKq1AmcNzXpnlHQVTogMUy/1gv6MUuBs06VTK5Ws2PpiEjIADM/bq+srMRcuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759439101; c=relaxed/simple;
	bh=6TAVlTK+sXTzkna2XCGhzK3JAQmXwZYk58u9/NK5elY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Koz7D8W2OTdJeEJ82PJJqGG5rBtHNHEWKjRaM1IJUmfncTDqofarqSASoQoVX/CR+TL1MujfttJZp4aRI9qnclJ/3oap2ahyyotpcgRJGF1LyVub8jGjZyIxBC8eou/V9uFmr9nRfdgyEZdHoZKhStF9q1HZm1JAjD1d3ai1Ku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DqZIgWK2; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DqZIgWK2"
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-4de659d5a06so8636281cf.3
        for <linux-mmc@vger.kernel.org>; Thu, 02 Oct 2025 14:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759439099; x=1760043899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwbGC/K9B4U3uycXerXPSUMJfx+iuM+3b1WmPO2FpvA=;
        b=OqMEuvSYAa/Ylv72x0pDjMhYfwwy/IzAIvknZQg6+Hy1K12P2/UToPwxw0hePANnYE
         mNomuKCzV2dyKTrAwC1sM17cPuE/GiYNwtRZlZaJ9ouNCO1yPLphJPLOpB5LMQoma203
         ewnNWBqkukc0BULad9efVtGwiIK58Aqw+2BTKX+WkSRW97NLR9JZgI9+DCzJojtgQ4hm
         BAYKvA0NqmSzoAR55YM5j//hG4G44BXgXrxeHLpxe9unPaP7qaYfl5nrZxyHeEqFF83p
         6DYRhDkxEZMqY45FLFdkr9llc3aY1P6shtqnvbasCXTUnwFvWbCp75F62HE5pIdOrSXr
         W2Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVqyD8u1Hm2Dxq75kmLP0DNLqMmOrSCFF1r2pYXgwL/xs2AZsZXcKty1kj7ewYvlmdQ8dzT8Lt0cO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqQuybx5Gkao1m+CJDKSGQaoC844ssS/6dYEv20cSbQMgJqu4p
	huptN3HOXe2qglXdaia8tvSDangzS8q0RkasGSww2DhB9wyeofudVRaof+A+g79UHxiY0na+CC4
	xPgFzsilN2/MqHWZruylUztOgbHKEAiE6vRoAjc6RfZhfsQFxaqDjWGji2BddpIlprP+D9n9vuV
	p11pBbga+7Oll+iQ95jg8KJc1FCQVh3YWMb9/M42qIz2YaX11DzIXhiWqpsJneyDfjWwhSWmuvX
	rv9Tk6c0xz7
X-Gm-Gg: ASbGncvpn29yx1Mzznb5923Ixw4OIJ6dRnLQVTEuStCrMGfkESpNgj+BleEL8TOErtm
	0War73W0Ur/P5rdxWS9cT2wmUAbx48++Ag6HQqc0LwCXG1bt1gYaIyretQ/Cth6M946ZtQONQZT
	llSWWT63G2mWEvki36oOWuOFG+ctF2A+336Zuifng95b/COzDEcsfJaLJvfXOr74aAQ6iRyZP72
	fQnpUHbs0CQDI2bwdP+UoxXkLMglU1X9s1fZbQj98gMIrAYd3M+QJroqojKp+W6ZoiGOeBeXOEh
	Sfl+beoX3ANtSecboo0jf3EjBb/Rd8TIEfHCD0PN/YGpjp7nC8/IZCoxljXuU+oorNym2GM/mCg
	Hnxdab22/TNEARx9F8TDBNdQ0hqzd9D4fF8THRL6t1yxXv8xSon6XwQWKoKQY6EsVPb04BCuDYs
	LmXlyk
X-Google-Smtp-Source: AGHT+IEsu1AW3A22wSpH7RO+ShAu0qlOicAA7meEU3TekUJi1ANGwFHUk5jnZcPNIDgFrucmk7k/jqBmXESU
X-Received: by 2002:a05:622a:a94a:10b0:4e4:f4cf:23d7 with SMTP id d75a77b69052e-4e576ada48amr9462051cf.39.1759439098524;
        Thu, 02 Oct 2025 14:04:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4e55cbd45aesm1940621cf.9.2025.10.02.14.04.57
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Oct 2025 14:04:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e2c11b94cso8158065e9.3
        for <linux-mmc@vger.kernel.org>; Thu, 02 Oct 2025 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759439097; x=1760043897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwbGC/K9B4U3uycXerXPSUMJfx+iuM+3b1WmPO2FpvA=;
        b=DqZIgWK2wqAkh5M+9VjQht8PYqTeeTbJsWST9og2lZrPPkRXD/XCJzn/aOC3R4jBl+
         S30CiG2tNH5CzhhUupIAwRuvrkE7CKl6SFP0wPqcJsi1oCQWFJ8iduirmGKVSMvy5RSK
         cZb1x3gMji6jvYlXOvAYBlRblmS8KcqWhw058=
X-Forwarded-Encrypted: i=1; AJvYcCWPDl56F09hEkA/Hoy/MOVxneGArdn6WOPD+u2ae4qsqkKv33wf59uHstb2z8tR0Mv230WDeYfSn14=@vger.kernel.org
X-Received: by 2002:a05:600c:8b22:b0:45b:4a98:91cf with SMTP id 5b1f17b1804b1-46e71102657mr4393365e9.15.1759439096538;
        Thu, 02 Oct 2025 14:04:56 -0700 (PDT)
X-Received: by 2002:a05:600c:8b22:b0:45b:4a98:91cf with SMTP id 5b1f17b1804b1-46e71102657mr4393165e9.15.1759439096023;
        Thu, 02 Oct 2025 14:04:56 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c4c0321sm61711295e9.8.2025.10.02.14.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:04:55 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: andersson@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH 3/3] mmc: brcmstb: save and restore registers during PM
Date: Thu,  2 Oct 2025 17:04:26 -0400
Message-Id: <20251002210426.2490368-4-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
References: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Added support to save and restore registers that are critical
during PM.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 124 +++++++++++++++++++++++++++++--
 1 file changed, 119 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 0905b316a24b..ffa602a99ab7 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -24,7 +24,9 @@
 #define BRCMSTB_MATCH_FLAGS_NO_64BIT		BIT(0)
 #define BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT	BIT(1)
 #define BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE	BIT(2)
-#define BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY	BIT(4)
+#define BRCMSTB_MATCH_FLAGS_HAS_CFG_V1		BIT(3)
+#define BRCMSTB_MATCH_FLAGS_HAS_CFG_V2		BIT(4)
+#define BRCMSTB_MATCH_FLAGS_USE_CARD_BUSY	BIT(5)
 
 #define BRCMSTB_PRIV_FLAGS_HAS_CQE		BIT(0)
 #define BRCMSTB_PRIV_FLAGS_GATE_CLOCK		BIT(1)
@@ -38,19 +40,39 @@
 #define SDIO_CFG_OP_DLY_DEFAULT			0x80000003
 #define SDIO_CFG_CQ_CAPABILITY			0x4c
 #define SDIO_CFG_CQ_CAPABILITY_FMUL		GENMASK(13, 12)
+#define SDIO_CFG_SD_PIN_SEL			0x44
+#define SDIO_CFG_V1_SD_PIN_SEL			0x54
+#define SDIO_CFG_PHY_SW_MODE_0_RX_CTRL		0x7C
 #define SDIO_CFG_MAX_50MHZ_MODE			0x1ac
 #define SDIO_CFG_MAX_50MHZ_MODE_STRAP_OVERRIDE	BIT(31)
 #define SDIO_CFG_MAX_50MHZ_MODE_ENABLE		BIT(0)
 
+#define SDIO_BOOT_MAIN_CTL			0x0
+
 #define MMC_CAP_HSE_MASK	(MMC_CAP2_HSX00_1_2V | MMC_CAP2_HSX00_1_8V)
 /* Select all SD UHS type I SDR speed above 50MB/s */
 #define MMC_CAP_UHS_I_SDR_MASK	(MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104)
 
+enum cfg_core_ver {
+	SDIO_CFG_CORE_V1 = 1,
+	SDIO_CFG_CORE_V2,
+};
+
+struct sdhci_brcmstb_saved_regs {
+	u32 sd_pin_sel;
+	u32 phy_sw_mode0_rxctrl;
+	u32 max_50mhz_mode;
+	u32 boot_main_ctl;
+};
+
 struct sdhci_brcmstb_priv {
 	void __iomem *cfg_regs;
+	void __iomem *boot_regs;
+	struct sdhci_brcmstb_saved_regs saved_regs;
 	unsigned int flags;
 	struct clk *base_clk;
 	u32 base_freq_hz;
+	void (*save_restore_regs)(struct mmc_host *mmc, int save);
 };
 
 struct brcmstb_match_priv {
@@ -60,6 +82,69 @@ struct brcmstb_match_priv {
 	const unsigned int flags;
 };
 
+static void sdhci_brcmstb_save_regs(struct mmc_host *mmc, enum cfg_core_ver ver)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct sdhci_brcmstb_saved_regs *sr = &priv->saved_regs;
+	void __iomem *cr = priv->cfg_regs;
+	bool is_emmc = mmc->caps & MMC_CAP_NONREMOVABLE;
+
+	/* save  */
+	if (is_emmc && priv->boot_regs)
+		sr->boot_main_ctl = readl(priv->boot_regs + SDIO_BOOT_MAIN_CTL);
+
+	if (ver == SDIO_CFG_CORE_V1) {
+		sr->sd_pin_sel = readl(cr + SDIO_CFG_V1_SD_PIN_SEL);
+		return;
+	}
+
+	sr->sd_pin_sel = readl(cr + SDIO_CFG_SD_PIN_SEL);
+	sr->phy_sw_mode0_rxctrl = readl(cr + SDIO_CFG_PHY_SW_MODE_0_RX_CTRL);
+	sr->max_50mhz_mode = readl(cr + SDIO_CFG_MAX_50MHZ_MODE);
+}
+
+static void sdhci_brcmstb_restore_regs(struct mmc_host *mmc,
+						enum cfg_core_ver ver)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	struct sdhci_brcmstb_saved_regs *sr = &priv->saved_regs;
+	void __iomem *cr = priv->cfg_regs;
+	bool is_emmc = mmc->caps & MMC_CAP_NONREMOVABLE;
+
+	/* restore */
+	if (is_emmc && priv->boot_regs)
+		writel(sr->boot_main_ctl, priv->boot_regs + SDIO_BOOT_MAIN_CTL);
+
+	if (ver == SDIO_CFG_CORE_V1) {
+		writel(sr->sd_pin_sel, cr + SDIO_CFG_SD_PIN_SEL);
+		return;
+	}
+
+	writel(sr->sd_pin_sel, cr + SDIO_CFG_SD_PIN_SEL);
+	writel(sr->phy_sw_mode0_rxctrl, cr + SDIO_CFG_PHY_SW_MODE_0_RX_CTRL);
+	writel(sr->max_50mhz_mode, cr + SDIO_CFG_MAX_50MHZ_MODE);
+}
+
+static void sdhci_brcmstb_save_restore_regs_v1(struct mmc_host *mmc, int save)
+{
+	if (save)
+		sdhci_brcmstb_save_regs(mmc, SDIO_CFG_CORE_V1);
+	else
+		sdhci_brcmstb_restore_regs(mmc, SDIO_CFG_CORE_V1);
+}
+
+static void sdhci_brcmstb_save_restore_regs_v2(struct mmc_host *mmc, int save)
+{
+	if (save)
+		sdhci_brcmstb_save_regs(mmc, SDIO_CFG_CORE_V2);
+	else
+		sdhci_brcmstb_restore_regs(mmc, SDIO_CFG_CORE_V2);
+}
+
 static inline void enable_clock_gating(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -300,24 +385,33 @@ static struct brcmstb_match_priv match_priv_7425 = {
 	.ops = &sdhci_brcmstb_ops,
 };
 
-static struct brcmstb_match_priv match_priv_7445 = {
+static struct brcmstb_match_priv match_priv_74371 = {
 	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
 	.ops = &sdhci_brcmstb_ops,
 };
 
+static struct brcmstb_match_priv match_priv_7445 = {
+	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT |
+			BRCMSTB_MATCH_FLAGS_HAS_CFG_V1,
+	.ops = &sdhci_brcmstb_ops,
+};
+
 static struct brcmstb_match_priv match_priv_72116 = {
-	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
+	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT |
+			BRCMSTB_MATCH_FLAGS_HAS_CFG_V1,
 	.ops = &sdhci_brcmstb_ops_72116,
 };
 
 static const struct brcmstb_match_priv match_priv_7216 = {
-	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
+	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE |
+			BRCMSTB_MATCH_FLAGS_HAS_CFG_V2,
 	.hs400es = sdhci_brcmstb_hs400es,
 	.ops = &sdhci_brcmstb_ops_7216,
 };
 
 static struct brcmstb_match_priv match_priv_74165b0 = {
-	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
+	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE |
+			BRCMSTB_MATCH_FLAGS_HAS_CFG_V2,
 	.hs400es = sdhci_brcmstb_hs400es,
 	.ops = &sdhci_brcmstb_ops_74165b0,
 };
@@ -325,6 +419,7 @@ static struct brcmstb_match_priv match_priv_74165b0 = {
 static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
 	{ .compatible = "brcm,bcm2712-sdhci", .data = &match_priv_2712 },
 	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
+	{ .compatible = "brcm,bcm74371-sdhci", .data = &match_priv_74371 },
 	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
 	{ .compatible = "brcm,bcm72116-sdhci", .data = &match_priv_72116 },
 	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
@@ -441,6 +536,19 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	if (res)
 		goto err;
 
+	/* map non-standard BOOT registers if present */
+	if (host->mmc->caps & MMC_CAP_NONREMOVABLE) {
+		priv->boot_regs = devm_platform_get_and_ioremap_resource(pdev, 2, NULL);
+		if (IS_ERR(priv->boot_regs))
+			priv->boot_regs = NULL;
+	}
+
+	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_HAS_CFG_V1)
+		priv->save_restore_regs = sdhci_brcmstb_save_restore_regs_v1;
+
+	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_HAS_CFG_V2)
+		priv->save_restore_regs = sdhci_brcmstb_save_restore_regs_v2;
+
 	/*
 	 * Automatic clock gating does not work for SD cards that may
 	 * voltage switch so only enable it for non-removable devices.
@@ -533,6 +641,9 @@ static int sdhci_brcmstb_suspend(struct device *dev)
 	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
+	if (priv->save_restore_regs)
+		priv->save_restore_regs(host->mmc, 1);
+
 	clk_disable_unprepare(priv->base_clk);
 	if (host->mmc->caps2 & MMC_CAP2_CQE) {
 		ret = cqhci_suspend(host->mmc);
@@ -564,6 +675,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
 			ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
 	}
 
+	if (priv->save_restore_regs)
+		priv->save_restore_regs(host->mmc, 0);
+
 	if (host->mmc->caps2 & MMC_CAP2_CQE)
 		ret = cqhci_resume(host->mmc);
 
-- 
2.34.1

