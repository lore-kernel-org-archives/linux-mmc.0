From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [PATCH 2/5] mmc: sdhci-pxav3: Add platform specific set_clock ops
Date: Fri,  4 Sep 2015 21:02:18 +0530
Message-ID: <1441380741-13115-3-git-send-email-vaibhav.hiremath@linaro.org>
References: <1441380741-13115-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441380741-13115-1-git-send-email-vaibhav.hiremath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kliu5@marvell.com, ulf.hansson@linaro.org, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
List-Id: linux-mmc@vger.kernel.org

In case of PXA1928 & family of devices, the TX BUS and internal clock
need to be set as part of ->set_clock() ops, so this patch adds
platform specific ->set_clock() operation.

Note that, in order to not break other platforms, this patch
introduced the flag, which controls whether controller/platform
specific clock configuration needs to be executed.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/mmc/host/sdhci-pxav3.c | 46 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index aecae04..c2b2b78 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -48,6 +48,10 @@
 #define  SDCFG_GEN_PAD_CLK_CNT_MASK	0xFF
 #define  SDCFG_GEN_PAD_CLK_CNT_SHIFT	24
 
+#define SD_FIFO_PARAM			0x104
+#define  INTERNAL_CLK_GATE_CTRL		BIT(8)
+#define  INTERNAL_CLK_GATE_ON		BIT(9)
+
 #define SD_SPI_MODE			0x108
 #define SD_CE_ATA_1			0x10C
 
@@ -57,6 +61,9 @@
 
 #define SD_RX_CFG_REG			0x114
 
+#define TX_CFG_REG			0x118
+#define  TX_INTERNAL_SEL_BUS_CLK	BIT(30)
+
 /* IO Power control */
 #define IO_PWR_AKEY_ASFAR		0xbaba
 #define IO_PWR_AKEY_ASSAR		0xeb10
@@ -68,6 +75,9 @@ struct sdhci_pxa_data {
 	u8 sdclk_delay_shift;
 	u8 sdclk_sel_mask;
 	u8 sdclk_sel_shift;
+
+	/* set this if platform needs separate clock configuration */
+	bool set_pltfrm_clk;
 	/*
 	 * We have few more differences, add them along with their
 	 * respective feature support
@@ -90,6 +100,7 @@ static struct sdhci_pxa_data pxav3_data_v1 = {
 	.sdclk_delay_shift	= 9,
 	.sdclk_sel_mask		= 0x1,
 	.sdclk_sel_shift	= 8,
+	.set_pltfrm_clk		= false,
 };
 
 static struct sdhci_pxa_data pxav3_data_v2 = {
@@ -99,6 +110,7 @@ static struct sdhci_pxa_data pxav3_data_v2 = {
 	/* Only set SDCLK_SEL1, as driver uses default value of SDCLK_SEL0 */
 	.sdclk_sel_mask		= 0x3,
 	.sdclk_sel_shift	= 2,	/* SDCLK_SEL1 */
+	.set_pltfrm_clk		= true,
 };
 
 /*
@@ -375,8 +387,40 @@ static void pxav3_voltage_switch(struct sdhci_host *host,
 	writel(val, pxa->io_pwr_reg);
 }
 
+static void pxav3_set_tx_clock(struct sdhci_host *host)
+{
+	u32 val;
+
+	val = sdhci_readl(host, TX_CFG_REG);
+	val |= TX_INTERNAL_SEL_BUS_CLK;
+	sdhci_writel(host, val, TX_CFG_REG);
+}
+
+static void pxav3_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_pxa *pxa = pltfm_host->priv;
+
+	/* We still use common sdhci_set_clock() */
+	sdhci_set_clock(host, clock);
+
+	/* platform/controller specific clock configuration */
+	if (pxa->data->set_pltfrm_clk && clock != 0) {
+		u32 val;
+
+		val = sdhci_readw(host, SD_FIFO_PARAM);
+		/* Internal clock gate ON and CTRL = 0b11 */
+		val |= INTERNAL_CLK_GATE_CTRL | INTERNAL_CLK_GATE_ON;
+		sdhci_writew(host, val, SD_FIFO_PARAM);
+
+		/* TX internal clock selection */
+		pxav3_set_tx_clock(host);
+	}
+
+}
+
 static const struct sdhci_ops pxav3_sdhci_ops = {
-	.set_clock			= sdhci_set_clock,
+	.set_clock			= pxav3_set_clock,
 	.platform_send_init_74_clocks	= pxav3_gen_init_74_clocks,
 	.get_max_clock			= sdhci_pltfm_clk_get_max_clock,
 	.set_bus_width			= sdhci_set_bus_width,
-- 
1.9.1
