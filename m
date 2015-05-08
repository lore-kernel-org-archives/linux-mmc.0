From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v3, 2/6] mmc: sdhci-pltfm: support both LE and BE mode for SDHCI platform
Date: Fri, 8 May 2015 14:50:18 +0800
Message-ID: <1431067818-41378-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0118.outbound.protection.outlook.com ([207.46.100.118]:26496
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751679AbbEHGx6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 May 2015 02:53:58 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

There has been only big-endian mode support for SDHCI platform before.
This patch makes the driver support both little-endian mode and
big-endian mode.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
Changes for v3:
	- Moved endian mode checking to generic mmc host driver
	- Modified the commit message
---
 drivers/mmc/host/sdhci-pltfm.c |  2 +-
 drivers/mmc/host/sdhci-pltfm.h | 63 ++++++++++++++++++++++++++++--------------
 2 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index a207f5a..8b6450e 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -224,7 +224,7 @@ int sdhci_pltfm_unregister(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
+	int dead = (sdhci_readl(host, SDHCI_INT_STATUS) == 0xffffffff);
 
 	sdhci_remove_host(host, dead);
 	clk_disable_unprepare(pltfm_host->clk);
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 04bc248..d377aeb 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -37,33 +37,54 @@ struct sdhci_pltfm_host {
  * These accessors are designed for big endian hosts doing I/O to
  * little endian controllers incorporating a 32-bit hardware byte swapper.
  */
-static inline u32 sdhci_be32bs_readl(struct sdhci_host *host, int reg)
+static inline void sdhci_clrsetbits(struct sdhci_host *host, u32 mask,
+				    u32 val, int reg)
 {
-	return in_be32(host->ioaddr + reg);
+	void __iomem *base = host->ioaddr + (reg & ~0x3);
+	u32 shift = (reg & 0x3) * 8;
+
+	if (host->mmc->big_endian_mode)
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
+	if (host->mmc->big_endian_mode)
+		return ioread32be(host->ioaddr + reg);
+	else
+		return ioread32(host->ioaddr + reg);
 }
 
-static inline u8 sdhci_be32bs_readb(struct sdhci_host *host, int reg)
+static inline u16 sdhci_32bs_readw(struct sdhci_host *host, int reg)
 {
-	return in_8(host->ioaddr + (reg ^ 0x3));
+	if (host->mmc->big_endian_mode)
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
+	if (host->mmc->big_endian_mode)
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
@@ -74,20 +95,20 @@ static inline void sdhci_be32bs_writew(struct sdhci_host *host,
 		pltfm_host->xfer_mode_shadow = val;
 		return;
 	case SDHCI_COMMAND:
-		sdhci_be32bs_writel(host,
-				    val << 16 | pltfm_host->xfer_mode_shadow,
-				    SDHCI_TRANSFER_MODE);
+		if (host->mmc->big_endian_mode)
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

