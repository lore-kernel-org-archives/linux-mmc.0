From: Piotr Sroka <piotrs@cadence.com>
Subject: [v2] mmc: sdhci-cadence: add HS400 enhanced strobe support
Date: Fri, 3 Mar 2017 08:31:33 +0000
Message-ID: <1488529893-6690-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Piotr Sroka <piotrs@cadence.com>
List-Id: linux-mmc@vger.kernel.org

Add support for HS400ES mode to Cadence SDHCI driver.

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
---
Changes in v2:
- Modify enhanced strobe function to handle disabling 
  enhanced strobe inside the function. 
  Do no relay on that mmc_set_ios() is called 
  immediately after host->ops->hs400_enhanced_strobe(host, &host->ios).
---
 drivers/mmc/host/sdhci-cadence.c | 57 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 316cfec..6198ae2 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -40,6 +40,7 @@
 #define   SDHCI_CDNS_HRS06_MODE_MMC_DDR		0x3
 #define   SDHCI_CDNS_HRS06_MODE_MMC_HS200	0x4
 #define   SDHCI_CDNS_HRS06_MODE_MMC_HS400	0x5
+#define   SDHCI_CDNS_HRS06_MODE_MMC_HS400ES	0x6
 
 /* SRS - Slot Register Set (SDHCI-compatible) */
 #define SDHCI_CDNS_SRS_BASE		0x200
@@ -64,6 +65,7 @@
 
 struct sdhci_cdns_priv {
 	void __iomem *hrs_addr;
+	bool enhanced_strobe;
 };
 
 static void sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
@@ -108,11 +110,28 @@ static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
 	return host->max_clk / 1000;
 }
 
+static void sdhci_cdns_set_emmc_mode(struct sdhci_cdns_priv *priv, u32 mode)
+{
+	u32 tmp;
+
+	/* The speed mode for eMMC is selected by HRS06 register */
+	tmp = readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
+	tmp &= ~SDHCI_CDNS_HRS06_MODE_MASK;
+	tmp |= mode;
+	writel(tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
+}
+
+static void sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv, u32 *mode)
+{
+	*mode = readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
+	*mode = *mode & SDHCI_CDNS_HRS06_MODE_MASK;
+}
+
 static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
 					 unsigned int timing)
 {
 	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
-	u32 mode, tmp;
+	u32 mode;
 
 	switch (timing) {
 	case MMC_TIMING_MMC_HS:
@@ -125,18 +144,17 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
 		mode = SDHCI_CDNS_HRS06_MODE_MMC_HS200;
 		break;
 	case MMC_TIMING_MMC_HS400:
-		mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400;
+		if (priv->enhanced_strobe)
+			mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400ES;
+		else
+			mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400;
 		break;
 	default:
 		mode = SDHCI_CDNS_HRS06_MODE_SD;
 		break;
 	}
 
-	/* The speed mode for eMMC is selected by HRS06 register */
-	tmp = readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
-	tmp &= ~SDHCI_CDNS_HRS06_MODE_MASK;
-	tmp |= mode;
-	writel(tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
+	sdhci_cdns_set_emmc_mode(priv, mode);
 
 	/* For SD, fall back to the default handler */
 	if (mode == SDHCI_CDNS_HRS06_MODE_SD)
@@ -213,6 +231,28 @@ static int sdhci_cdns_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	return sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
 }
 
+static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
+					     struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	u32 timingMode;
+
+	priv->enhanced_strobe = ios->enhanced_strobe;
+
+	sdhci_cdns_get_emmc_mode(priv, &timingMode);
+
+	if (timingMode == SDHCI_CDNS_HRS06_MODE_MMC_HS400 &&
+	    ios->enhanced_strobe)
+		sdhci_cdns_set_emmc_mode(priv,
+					 SDHCI_CDNS_HRS06_MODE_MMC_HS400ES);
+
+	if (timingMode == SDHCI_CDNS_HRS06_MODE_MMC_HS400ES &&
+	    !ios->enhanced_strobe)
+		sdhci_cdns_set_emmc_mode(priv,
+					 SDHCI_CDNS_HRS06_MODE_MMC_HS400);
+}
+
 static int sdhci_cdns_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
@@ -240,8 +280,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 
 	priv = sdhci_cdns_priv(host);
 	priv->hrs_addr = host->ioaddr;
+	priv->enhanced_strobe = false;
 	host->ioaddr += SDHCI_CDNS_SRS_BASE;
 	host->mmc_host_ops.execute_tuning = sdhci_cdns_execute_tuning;
+	host->mmc_host_ops.hs400_enhanced_strobe =
+		sdhci_cdns_hs400_enhanced_strobe;
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
-- 
2.2.2
