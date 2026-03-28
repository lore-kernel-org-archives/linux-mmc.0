Received: from mail-m15596.qiye.163.com (mail-m15596.qiye.163.com [101.71.155.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EF240DFD9
	for <linux-mmc@vger.kernel.org>; Sat, 28 Mar 2026 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774682358; cv=none; b=Hkr9ZFU5HqbdA6+23rHjfeorI6BM6f0/G1wEBeP48LeCv4c1Yxy4iYYCn3ObVjYFLQ5p0xrrFg+JqSaewIa5j2kl+RAzE8iYIpnZAaUfroyONAykZWep8JWz7iMoT25ofolBKYemqBiA3TF7jyYNOVoFtdb63c/hfPSSecmsdzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774682358; c=relaxed/simple;
	bh=wbR4dLYM5aS2tO0k7IDoyfoPMah1tsgG56VxkIQtmMg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=eYnkUgvzbaRGFNewPCR+Ps367LIYRRM3YfAB4WxyZITPNQ9TIurpzNeNpM4NLwpJWfvW71rNYFexW18N1b68tXtWehBJrk4N7r/uzy433uNl7Qqt5MAFDIe67qyORI4b1lURWKE++ZS8pyi9bN5q5I8yodLyBsOHLcrvpjLsdqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=awwpyaMD; arc=none smtp.client-ip=101.71.155.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="awwpyaMD"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 389ec6fc7;
	Sat, 28 Mar 2026 08:29:28 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3] mmc: sdhci-dwcmshc: Refactor Rockchip platform data for controller revisions
Date: Sat, 28 Mar 2026 08:29:22 +0800
Message-Id: <1774657762-152522-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9d31d88bfc09cckunmcfa577decdafce
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0kdTlYdHRpJTB5LQhhDHUhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=awwpyaMD8Wll4wgDpDOBiiV/uZ/1XpXeyusd/p/tqC4KP6Lh6FxYqZXKtmDzZzIzg1HEeMIkRPtw0xaS3OX3oMm26sifZoWouhwCAi9fuxkWzPMh3MfbHIuZQgszBeokXwxb93Y7xZNOw5ceRvS7/9H/jKR/wnjsZghw+MZ3i3I=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=KR+j9rTF2STA/yiWY1WnY1xK7H9cyKLdbiYd9SX2ZTg=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The driver previously used an enum (dwcmshc_rk_type) to distinguish
platforms like the RK3568 and RK3588 based on DT compatible names.
This approach is inflexible, scales poorly for future revisions or
mixed-revision platforms, and conflates SoC names with controller
revisions. One example is RK3576 which lists "rockchip,rk3588-dwcmshc"
as a secondary compatible string just in order to claim it uses the
same controller revision as RK3588. This is confusing and makes it
error-prone to add new SoC support.

Introduces a new struct rockchip_pltfm_data containing a dedicated
revision field. The old enum is removed, and all code paths are
updated to use the revision-based data.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Changes in v3:
- remove unnecesary parentheses
- add Adrian's tag

Changes in v2:
- update commit msg
- document the revision field
- re-order the Rockchip plftm data

 drivers/mmc/host/sdhci-of-dwcmshc.c | 92 +++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index a91b3e7..6139516 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -278,14 +278,8 @@
 #define PHY_DELAY_CODE_EMMC		0x17
 #define PHY_DELAY_CODE_SD		0x55
 
-enum dwcmshc_rk_type {
-	DWCMSHC_RK3568,
-	DWCMSHC_RK3588,
-};
-
 struct rk35xx_priv {
 	struct reset_control *reset;
-	enum dwcmshc_rk_type devtype;
 	u8 txclk_tapnum;
 };
 
@@ -330,6 +324,16 @@ struct k230_pltfm_data {
 	u32 write_prot_bit;
 };
 
+struct rockchip_pltfm_data {
+	struct dwcmshc_pltfm_data dwcmshc_pdata;
+	/*
+	 * The controller hardware has two known revisions documented internally:
+	 * - Revision 0: Exclusively used by RK3566 and RK3568 SoCs.
+	 * - Revision 1: Implemented in all other Rockchip SoCs, including RK3576, RK3588, etc.
+	 */
+	int revision;
+};
+
 static void dwcmshc_enable_card_clk(struct sdhci_host *host)
 {
 	u16 ctrl;
@@ -749,6 +753,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
 	struct rk35xx_priv *priv = dwc_priv->priv;
+	const struct rockchip_pltfm_data *rockchip_pdata = to_pltfm_data(dwc_priv, rockchip);
 	u8 txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
 	u32 extra, reg;
 	int err;
@@ -816,7 +821,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 	 * we must set it in higher speed mode.
 	 */
 	extra = DWCMSHC_EMMC_DLL_DLYENA;
-	if (priv->devtype == DWCMSHC_RK3568)
+	if (rockchip_pdata->revision == 0)
 		extra |= DLL_RXCLK_NO_INVERTER << DWCMSHC_EMMC_DLL_RXCLK_SRCSEL;
 	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_RXCLK);
 
@@ -842,7 +847,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
 	    host->mmc->ios.timing == MMC_TIMING_MMC_HS400)
 		txclk_tapnum = priv->txclk_tapnum;
 
-	if ((priv->devtype == DWCMSHC_RK3588) && host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
+	if (rockchip_pdata->revision == 1 && host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
 		txclk_tapnum = DLL_TXCLK_TAPNUM_90_DEGREES;
 
 		extra = DLL_CMDOUT_SRC_CLK_NEG |
@@ -898,11 +903,6 @@ static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
 	if (!priv)
 		return -ENOMEM;
 
-	if (of_device_is_compatible(dev->of_node, "rockchip,rk3588-dwcmshc"))
-		priv->devtype = DWCMSHC_RK3588;
-	else
-		priv->devtype = DWCMSHC_RK3568;
-
 	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
 	if (IS_ERR(priv->reset)) {
 		err = PTR_ERR(priv->reset);
@@ -2115,30 +2115,52 @@ static const struct cqhci_host_ops rk35xx_cqhci_ops = {
 	.set_tran_desc	= dwcmshc_set_tran_desc,
 };
 
-static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
-	.pdata = {
-		.ops = &sdhci_dwcmshc_rk35xx_ops,
-		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
-			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
-		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+static const struct rockchip_pltfm_data sdhci_dwcmshc_rk3568_pdata = {
+	.dwcmshc_pdata = {
+		.pdata = {
+			.ops = &sdhci_dwcmshc_rk35xx_ops,
+			.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+				  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
+			.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+				   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+		},
+		.cqhci_host_ops = &rk35xx_cqhci_ops,
+		.init = dwcmshc_rk35xx_init,
+		.postinit = dwcmshc_rk35xx_postinit,
 	},
-	.cqhci_host_ops = &rk35xx_cqhci_ops,
-	.init = dwcmshc_rk35xx_init,
-	.postinit = dwcmshc_rk35xx_postinit,
+	.revision = 0,
 };
 
-static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
-	.pdata = {
-		.ops = &sdhci_dwcmshc_rk35xx_ops,
-		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
-			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
-		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+static const struct rockchip_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
+	.dwcmshc_pdata = {
+		.pdata = {
+			.ops = &sdhci_dwcmshc_rk35xx_ops,
+			.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+				  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
+			.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+				   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+		},
+		.cqhci_host_ops = &rk35xx_cqhci_ops,
+		.init = dwcmshc_rk35xx_init,
+		.postinit = dwcmshc_rk3576_postinit,
+	},
+	.revision = 1,
+};
+
+static const struct rockchip_pltfm_data sdhci_dwcmshc_rk3588_pdata = {
+	.dwcmshc_pdata = {
+		.pdata = {
+			.ops = &sdhci_dwcmshc_rk35xx_ops,
+			.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+				  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
+			.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+				   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+		},
+		.cqhci_host_ops = &rk35xx_cqhci_ops,
+		.init = dwcmshc_rk35xx_init,
+		.postinit = dwcmshc_rk35xx_postinit,
 	},
-	.cqhci_host_ops = &rk35xx_cqhci_ops,
-	.init = dwcmshc_rk35xx_init,
-	.postinit = dwcmshc_rk3576_postinit,
+	.revision = 1,
 };
 
 static const struct dwcmshc_pltfm_data sdhci_dwcmshc_th1520_pdata = {
@@ -2309,7 +2331,7 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
 	},
 	{
 		.compatible = "rockchip,rk3588-dwcmshc",
-		.data = &sdhci_dwcmshc_rk35xx_pdata,
+		.data = &sdhci_dwcmshc_rk3588_pdata,
 	},
 	{
 		.compatible = "rockchip,rk3576-dwcmshc",
@@ -2317,7 +2339,7 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
 	},
 	{
 		.compatible = "rockchip,rk3568-dwcmshc",
-		.data = &sdhci_dwcmshc_rk35xx_pdata,
+		.data = &sdhci_dwcmshc_rk3568_pdata,
 	},
 	{
 		.compatible = "snps,dwcmshc-sdhci",
-- 
2.7.4

