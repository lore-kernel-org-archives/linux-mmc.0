From: Piotr Sroka <piotrs@cadence.com>
Subject: [PATCH] Add HS400 enhanced strobe support
Date: Wed, 15 Feb 2017 13:50:14 +0000
Message-ID: <1487166614-12808-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, Piotr Sroka <piotrs@cadence.com>
List-Id: linux-mmc@vger.kernel.org

Add support for HS400ES mode to Cadence SDHCI driver.

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
---
 drivers/mmc/host/sdhci-cadence.c | 41 +++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 4b0ecb9..5296c7c 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -39,6 +39,7 @@
 #define   SDHCI_CDNS_HRS06_MODE_MMC_DDR		0x3
 #define   SDHCI_CDNS_HRS06_MODE_MMC_HS200	0x4
 #define   SDHCI_CDNS_HRS06_MODE_MMC_HS400	0x5
+#define   SDHCI_CDNS_HRS06_MODE_MMC_HS400ES	0x6
 
 /* SRS - Slot Register Set (SDHCI-compatible) */
 #define SDHCI_CDNS_SRS_BASE		0x200
@@ -63,6 +64,7 @@
 
 struct sdhci_cdns_priv {
 	void __iomem *hrs_addr;
+	bool enhanced_strobe;
 };
 
 static void sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
@@ -107,11 +109,22 @@ static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
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
 static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
 					 unsigned int timing)
 {
 	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
-	u32 mode, tmp;
+	u32 mode;
 
 	switch (timing) {
 	case MMC_TIMING_MMC_HS:
@@ -124,24 +137,35 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
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
 		sdhci_set_uhs_signaling(host, timing);
 }
 
+static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
+					     struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+
+	priv->enhanced_strobe = ios->enhanced_strobe;
+	if (ios->enhanced_strobe)
+		sdhci_cdns_set_emmc_mode(priv,
+					 SDHCI_CDNS_HRS06_MODE_MMC_HS400ES);
+}
+
 static const struct sdhci_ops sdhci_cdns_ops = {
 	.set_clock = sdhci_set_clock,
 	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
@@ -239,8 +263,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 
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
