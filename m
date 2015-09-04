From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [PATCH 1/5] mmc: sdhci-pxav3: Enable pxa1928 device support
Date: Fri,  4 Sep 2015 21:02:17 +0530
Message-ID: <1441380741-13115-2-git-send-email-vaibhav.hiremath@linaro.org>
References: <1441380741-13115-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441380741-13115-1-git-send-email-vaibhav.hiremath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kliu5@marvell.com, ulf.hansson@linaro.org, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
List-Id: linux-mmc@vger.kernel.org

SDHCI controller present in PXA1928 has few differences as far as
register map is concerned.
For example,

                         PXAxxx                    PXA1928
                         ======                    =======
 SDCLK_DELAY field       0x10A                     0x114
 SDCLK_DELAY mask        0x1F                      0x3FF
 SDCLK_DELAY shift        9                          8
 SDCLK_SEL shift          8                          2 (SEL1)

So in order to support multi-platform, use sdhci_pxa_regdata structure
as a variant data according to platform.

Note that, there are some more differences, which would be added
as and when respective feature gets added to the driver.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/mmc/host/sdhci-pxav3.c | 62 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 6d4bad4..aecae04 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -42,9 +42,6 @@
 #define PXAV3_RPM_DELAY_MS		50
 
 #define SD_CLOCK_BURST_SIZE_SETUP	0x10A
-#define SDCLK_SEL			0x100
-#define  SDCLK_DELAY_SHIFT		9
-#define  SDCLK_DELAY_MASK		0x1f
 
 #define SD_CFG_FIFO_PARAM		0x100
 #define  SDCFG_GEN_PAD_CLK_ON		BIT(6)
@@ -58,11 +55,25 @@
 #define  SDCE_MISC_INT			BIT(2)
 #define  SDCE_MISC_INT_EN		BIT(1)
 
+#define SD_RX_CFG_REG			0x114
+
 /* IO Power control */
 #define IO_PWR_AKEY_ASFAR		0xbaba
 #define IO_PWR_AKEY_ASSAR		0xeb10
 #define IO_PWR_MMC1_PAD_1V8		BIT(2)
 
+struct sdhci_pxa_data {
+	u32 sdclk_delay_reg;
+	u32 sdclk_delay_mask;
+	u8 sdclk_delay_shift;
+	u8 sdclk_sel_mask;
+	u8 sdclk_sel_shift;
+	/*
+	 * We have few more differences, add them along with their
+	 * respective feature support
+	 */
+};
+
 struct sdhci_pxa {
 	struct clk *clk_core;
 	struct clk *clk_io;
@@ -70,6 +81,24 @@ struct sdhci_pxa {
 	void __iomem *sdio3_conf_reg;
 	void __iomem *io_pwr_reg;
 	void __iomem *io_pwr_lock_reg;
+	struct sdhci_pxa_data *data;
+};
+
+static struct sdhci_pxa_data pxav3_data_v1 = {
+	.sdclk_delay_reg	= SD_CLOCK_BURST_SIZE_SETUP,
+	.sdclk_delay_mask	= 0x1F,
+	.sdclk_delay_shift	= 9,
+	.sdclk_sel_mask		= 0x1,
+	.sdclk_sel_shift	= 8,
+};
+
+static struct sdhci_pxa_data pxav3_data_v2 = {
+	.sdclk_delay_reg	= SD_RX_CFG_REG,
+	.sdclk_delay_mask	= 0x3FF,
+	.sdclk_delay_shift	= 8,
+	/* Only set SDCLK_SEL1, as driver uses default value of SDCLK_SEL0 */
+	.sdclk_sel_mask		= 0x3,
+	.sdclk_sel_shift	= 2,	/* SDCLK_SEL1 */
 };
 
 /*
@@ -183,6 +212,8 @@ static void pxav3_reset(struct sdhci_host *host, u8 mask)
 {
 	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
 	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_pxa *pxa = pltfm_host->priv;
 
 	sdhci_reset(host, mask);
 
@@ -193,12 +224,14 @@ static void pxav3_reset(struct sdhci_host *host, u8 mask)
 		 */
 		if (pdata && 0 != pdata->clk_delay_cycles) {
 			u16 tmp;
-
-			tmp = readw(host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
-			tmp |= (pdata->clk_delay_cycles & SDCLK_DELAY_MASK)
-				<< SDCLK_DELAY_SHIFT;
-			tmp |= SDCLK_SEL;
-			writew(tmp, host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
+			struct sdhci_pxa_data *data = pxa->data;
+
+			tmp = readw(host->ioaddr + data->sdclk_delay_reg);
+			tmp |= (pdata->clk_delay_cycles & data->sdclk_delay_mask)
+				<< data->sdclk_delay_shift;
+			tmp &= ~(data->sdclk_sel_mask << data->sdclk_sel_shift);
+			tmp |= 1 << data->sdclk_sel_shift;
+			writew(tmp, host->ioaddr + data->sdclk_delay_reg);
 		}
 	}
 }
@@ -363,10 +396,16 @@ static struct sdhci_pltfm_data sdhci_pxav3_pdata = {
 #ifdef CONFIG_OF
 static const struct of_device_id sdhci_pxav3_of_match[] = {
 	{
-		.compatible = "mrvl,pxav3-mmc",
+		.compatible	= "mrvl,pxav3-mmc",
+		.data		= (void *)&pxav3_data_v1,
+	},
+	{
+		.compatible	= "marvell,armada-380-sdhci",
+		.data		= (void *)&pxav3_data_v1,
 	},
 	{
-		.compatible = "marvell,armada-380-sdhci",
+		.compatible	= "marvell,pxav3-1928-sdhci",
+		.data		= (void *)&pxav3_data_v2,
 	},
 	{},
 };
@@ -470,6 +509,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 			goto err_of_parse;
 		sdhci_get_of_property(pdev);
 		pdata = pxav3_get_mmc_pdata(dev);
+		pxa->data = (struct sdhci_pxa_data *)match->data;
 		pdev->dev.platform_data = pdata;
 	} else if (pdata) {
 		/* on-chip device */
-- 
1.9.1
