From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v2, 1/4] mmc: sdhci-pltfm: add little-endian mode support for SDHCI platform
Date: Tue, 14 Apr 2015 18:04:43 +0800
Message-ID: <1429005883-21089-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0140.outbound.protection.outlook.com ([157.56.111.140]:46737
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752965AbbDNKID (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Apr 2015 06:08:03 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

This patch adds little-endian mode support for little-endian host
controller. To indicate the little-endian mode, we could add
'little-endian' property in device tree node.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 12 ++++++-
 drivers/mmc/host/sdhci-pltfm.h | 74 ++++++++++++++++++++++++++++++------------
 2 files changed, 64 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index a207f5a..7ef1dcb 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -121,6 +121,8 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 				    size_t priv_size)
 {
 	struct sdhci_host *host;
+	struct device_node *np = pdev->dev.of_node;
+	struct sdhci_pltfm_host *pltfm_host;
 	struct resource *iomem;
 	int ret;
 
@@ -141,6 +143,14 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		goto err;
 	}
 
+	pltfm_host = sdhci_priv(host);
+	pltfm_host->endian_mode = BIG_ENDIAN_MODE;
+
+#ifdef CONFIG_OF
+	if (of_get_property(np, "little-endian", NULL))
+		pltfm_host->endian_mode = LITTLE_ENDIAN_MODE;
+#endif /* CONFIG_OF */
+
 	host->hw_name = dev_name(&pdev->dev);
 	if (pdata && pdata->ops)
 		host->ops = pdata->ops;
@@ -224,7 +234,7 @@ int sdhci_pltfm_unregister(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
+	int dead = (sdhci_readl(host, SDHCI_INT_STATUS) == 0xffffffff);
 
 	sdhci_remove_host(host, dead);
 	clk_disable_unprepare(pltfm_host->clk);
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 04bc248..a8cf954 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -28,6 +28,10 @@ struct sdhci_pltfm_host {
 	/* migrate from sdhci_of_host */
 	unsigned int clock;
 	u16 xfer_mode_shadow;
+	enum endian_mode {
+		LITTLE_ENDIAN_MODE,
+		BIG_ENDIAN_MODE,
+	} endian_mode;
 
 	unsigned long private[0] ____cacheline_aligned;
 };
@@ -37,33 +41,61 @@ struct sdhci_pltfm_host {
  * These accessors are designed for big endian hosts doing I/O to
  * little endian controllers incorporating a 32-bit hardware byte swapper.
  */
-static inline u32 sdhci_be32bs_readl(struct sdhci_host *host, int reg)
+static inline void sdhci_clrsetbits(struct sdhci_host *host, u32 mask,
+				    u32 val, int reg)
 {
-	return in_be32(host->ioaddr + reg);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	void __iomem *base = host->ioaddr + (reg & ~0x3);
+	u32 shift = (reg & 0x3) * 8;
+
+	if (pltfm_host->endian_mode == BIG_ENDIAN_MODE)
+		iowrite32be(((ioread32be(base) & ~(mask << shift)) |
+			    (val << shift)), base);
+	else
+		iowrite32(((ioread32(base) & ~(mask << shift)) |
+			  (val << shift)), base);
 }
 
-static inline u16 sdhci_be32bs_readw(struct sdhci_host *host, int reg)
+static inline u32 sdhci_32bs_readl(struct sdhci_host *host, int reg)
 {
-	return in_be16(host->ioaddr + (reg ^ 0x2));
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	if (pltfm_host->endian_mode == BIG_ENDIAN_MODE)
+		return ioread32be(host->ioaddr + reg);
+	else
+		return ioread32(host->ioaddr + reg);
 }
 
-static inline u8 sdhci_be32bs_readb(struct sdhci_host *host, int reg)
+static inline u16 sdhci_32bs_readw(struct sdhci_host *host, int reg)
 {
-	return in_8(host->ioaddr + (reg ^ 0x3));
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	if (pltfm_host->endian_mode == BIG_ENDIAN_MODE)
+		return ioread16be(host->ioaddr + (reg ^ 0x2));
+	else
+		return ioread16(host->ioaddr + (reg ^ 0x2));
 }
 
-static inline void sdhci_be32bs_writel(struct sdhci_host *host,
-				       u32 val, int reg)
+static inline u8 sdhci_32bs_readb(struct sdhci_host *host, int reg)
 {
-	out_be32(host->ioaddr + reg, val);
+	return ioread8(host->ioaddr + (reg ^ 0x3));
 }
 
-static inline void sdhci_be32bs_writew(struct sdhci_host *host,
+static inline void sdhci_32bs_writel(struct sdhci_host *host,
+		u32 val, int reg)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	if (pltfm_host->endian_mode == BIG_ENDIAN_MODE)
+		iowrite32be(val, host->ioaddr + reg);
+	else
+		iowrite32(val, host->ioaddr + reg);
+}
+
+static inline void sdhci_32bs_writew(struct sdhci_host *host,
 				       u16 val, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	int base = reg & ~0x3;
-	int shift = (reg & 0x2) * 8;
 
 	switch (reg) {
 	case SDHCI_TRANSFER_MODE:
@@ -74,20 +106,20 @@ static inline void sdhci_be32bs_writew(struct sdhci_host *host,
 		pltfm_host->xfer_mode_shadow = val;
 		return;
 	case SDHCI_COMMAND:
-		sdhci_be32bs_writel(host,
-				    val << 16 | pltfm_host->xfer_mode_shadow,
-				    SDHCI_TRANSFER_MODE);
+		if (pltfm_host->endian_mode == BIG_ENDIAN_MODE)
+			iowrite32be(val << 16 | pltfm_host->xfer_mode_shadow,
+				    host->ioaddr + SDHCI_TRANSFER_MODE);
+		else
+			iowrite32(val << 16 | pltfm_host->xfer_mode_shadow,
+				  host->ioaddr + SDHCI_TRANSFER_MODE);
 		return;
 	}
-	clrsetbits_be32(host->ioaddr + base, 0xffff << shift, val << shift);
+	sdhci_clrsetbits(host, 0xffff, val, reg);
 }
 
-static inline void sdhci_be32bs_writeb(struct sdhci_host *host, u8 val, int reg)
+static inline void sdhci_32bs_writeb(struct sdhci_host *host, u8 val, int reg)
 {
-	int base = reg & ~0x3;
-	int shift = (reg & 0x3) * 8;
-
-	clrsetbits_be32(host->ioaddr + base , 0xff << shift, val << shift);
+	sdhci_clrsetbits(host, 0xff, val, reg);
 }
 #endif /* CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER */
 
-- 
2.1.0.27.g96db324

