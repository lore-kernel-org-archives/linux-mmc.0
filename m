Received: from mail-m17238.xmail.ntesmail.com (mail-m17238.xmail.ntesmail.com [45.195.17.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D412FC23
	for <linux-mmc@vger.kernel.org>; Fri, 22 Nov 2024 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292068; cv=none; b=RuS7QLbdarNuQ8D6EjAHVXmynAomhhPeKHUbSv5Zk4T/wsMq+8m19D/jphwUmfSJgFOG9aZGTcriqp9VF+VyuKDzQINLbJzhopYYdHwTXV6Whts+lKDlO14hdqfguJFON6vdH3/dXQkjzjer42K000h+kWtiOppcMD933KnHaSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292068; c=relaxed/simple;
	bh=fqChlzKktpG9hnoM7niFonsAWa05TR6YH43ITDbsX5I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=b8yolN1ukn5+PJ2DfSasSW4w7PMtwRSZ/vsk/CosZpt3a+STRKktY6J/TwxkE3muW+zAXGYi+83f5bnHdTDGDS2INSVYILifRpwzCYULFAO+E1yWPsMDNdz885aZ6DJdM150Pi5LyimLPfakakGYIWR3v7ljKYdGkFvHc2HHQDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=bASxYq9W; arc=none smtp.client-ip=45.195.17.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="bASxYq9W"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 38959665;
	Fri, 22 Nov 2024 17:24:35 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	YiFeng Zhao <zyf@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: sdhci-of-dwcmshc: Restore missing regs for RK3576 platform
Date: Fri, 22 Nov 2024 17:24:08 +0800
Message-Id: <1732267448-72548-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUlIHlZNSEkdSE5CT0tNSklWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a935330032409cckunm38959665
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P006Kxw6PjIYGT4JDAE0GEtW
	Mk4KC0pVSlVKTEhJSU1MT0xNQ0pIVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhLTkM3Bg++
DKIM-Signature:a=rsa-sha256;
	b=bASxYq9W35aKDVpuxQJMSLflCRPg84ZdQsJ+Wzd5Zvksz3OVW2tnipj6qztENdyu2BJ7U/B1Z60DQ9dJyq5WJv5N5VMaiXvzDVJb8oK/tr3+09uMxWEyCuzvmaJ15aofGCRKpm1XobFXVMpDr8ndZFhTWWLAIvgGccjTb7OxQ70=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=ULdm66vH3eysA/Cw8Jg21nq4yfZIlWCcghnT2DeAKqs=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

DECMSHC_EMMC_MISC_CON is introduced from RK3576 which need to be
saved and restore after .reset() with SDHCI_RESET_ALL is called,
because we assert the reset line. Otherwise the entire controller
is broken anyway.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-of-dwcmshc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 8999b97..aa46655 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -81,6 +81,8 @@
 #define DWCMSHC_EMMC_DLL_TXCLK		0x808
 #define DWCMSHC_EMMC_DLL_STRBIN		0x80c
 #define DECMSHC_EMMC_DLL_CMDOUT		0x810
+#define MISC_INTCLK_EN			BIT(1)
+#define DECMSHC_EMMC_MISC_CON		0x81c
 #define DWCMSHC_EMMC_DLL_STATUS0	0x840
 #define DWCMSHC_EMMC_DLL_START		BIT(0)
 #define DWCMSHC_EMMC_DLL_LOCKED		BIT(8)
@@ -213,6 +215,7 @@ enum dwcmshc_rk_type {
 struct rk35xx_priv {
 	struct reset_control *reset;
 	enum dwcmshc_rk_type devtype;
+	bool has_misc_con;
 	u8 txclk_tapnum;
 };
 
@@ -720,6 +723,7 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
 	struct rk35xx_priv *priv = dwc_priv->priv;
+	int misc_con;
 
 	if (mask & SDHCI_RESET_ALL && priv->reset) {
 		reset_control_assert(priv->reset);
@@ -728,6 +732,12 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 	}
 
 	sdhci_reset(host, mask);
+
+	/* Restore DECMSHC_EMMC_MISC_CON */
+	if (priv->has_misc_con) {
+		misc_con = sdhci_readl(host, DECMSHC_EMMC_MISC_CON);
+		sdhci_writel(host, misc_con | MISC_INTCLK_EN, DECMSHC_EMMC_MISC_CON);
+	}
 }
 
 static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
@@ -735,7 +745,7 @@ static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
 {
 	static const char * const clk_ids[] = {"axi", "block", "timer"};
 	struct rk35xx_priv *priv;
-	int err;
+	int err, misc_con;
 
 	priv = devm_kzalloc(dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
 	if (!priv)
@@ -746,6 +756,9 @@ static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
 	else
 		priv->devtype = DWCMSHC_RK3568;
 
+	if (of_device_is_compatible(dev->of_node, "rockchip,rk3576-dwcmshc"))
+		priv->has_misc_con = true;
+
 	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
 	if (IS_ERR(priv->reset)) {
 		err = PTR_ERR(priv->reset);
@@ -767,6 +780,10 @@ static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
 	/* Reset previous settings */
 	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
 	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
+	if (priv->has_misc_con) {
+		misc_con = sdhci_readl(host, DECMSHC_EMMC_MISC_CON);
+		sdhci_writel(host, misc_con | MISC_INTCLK_EN, DECMSHC_EMMC_MISC_CON);
+	}
 
 	dwc_priv->priv = priv;
 
-- 
2.7.4

