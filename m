From: Yixun Lan <yixun.lan@amlogic.com>
Subject: [PATCH 2/3] mmc: meson-axg: add support for the Meson-AXG platform
Date: Tue, 3 Apr 2018 18:06:50 +0800
Message-ID: <20180403100652.41056-3-yixun.lan@amlogic.com>
References: <20180403100652.41056-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180403100652.41056-1-yixun.lan@amlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nan Li <nan.li@amlogic.com>, Yixun Lan <yixun.lan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, Jerome Brunet <jbrunet@baylibre.com>, Heiner Kallweit <hkallweit1@gmail.com>, Rob Herring <robh@kernel.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Nan Li <nan.li@amlogic.com>

Introduce the compatible data to cover the register offset & mask
change of the eMMC controller in Amlogic's Meson-AXG SoC.

Signed-off-by: Nan Li <nan.li@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 61 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 4f972b879fe6..56c90542ac29 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -47,15 +47,29 @@
 #define   CLK_CORE_PHASE_MASK GENMASK(9, 8)
 #define   CLK_TX_PHASE_MASK GENMASK(11, 10)
 #define   CLK_RX_PHASE_MASK GENMASK(13, 12)
-#define   CLK_TX_DELAY_MASK GENMASK(19, 16)
-#define   CLK_RX_DELAY_MASK GENMASK(23, 20)
+#define   CLK_V2_TX_DELAY_MASK GENMASK(19, 16)
+#define   CLK_V2_RX_DELAY_MASK GENMASK(23, 20)
+#define   CLK_V2_ALWAYS_ON BIT(24)
+
+#define   CLK_V3_TX_DELAY_MASK GENMASK(21, 16)
+#define   CLK_V3_RX_DELAY_MASK GENMASK(27, 22)
+#define   CLK_V3_ALWAYS_ON BIT(28)
+
 #define   CLK_DELAY_STEP_PS 200
 #define   CLK_PHASE_STEP 30
 #define   CLK_PHASE_POINT_NUM (360 / CLK_PHASE_STEP)
-#define   CLK_ALWAYS_ON BIT(24)
+
+#define   CLK_TX_DELAY_MASK(h)		(h->data->tx_delay_mask)
+#define   CLK_RX_DELAY_MASK(h)		(h->data->rx_delay_mask)
+#define   CLK_ALWAYS_ON(h)		(h->data->always_on)
 
 #define SD_EMMC_DELAY 0x4
 #define SD_EMMC_ADJUST 0x8
+
+#define SD_EMMC_DELAY1 0x4
+#define SD_EMMC_DELAY2 0x8
+#define SD_EMMC_V3_ADJUST 0xc
+
 #define SD_EMMC_CALOUT 0x10
 #define SD_EMMC_START 0x40
 #define   START_DESC_INIT BIT(0)
@@ -122,6 +136,12 @@
 
 #define MUX_CLK_NUM_PARENTS 2
 
+struct meson_mmc_data {
+	unsigned int tx_delay_mask;
+	unsigned int rx_delay_mask;
+	unsigned int always_on;
+};
+
 struct sd_emmc_desc {
 	u32 cmd_cfg;
 	u32 cmd_arg;
@@ -131,6 +151,7 @@ struct sd_emmc_desc {
 
 struct meson_host {
 	struct	device		*dev;
+	struct	meson_mmc_data *data;
 	struct	mmc_host	*mmc;
 	struct	mmc_command	*cmd;
 
@@ -474,7 +495,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
 
 	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
 	clk_reg = 0;
-	clk_reg |= CLK_ALWAYS_ON;
+	clk_reg |= CLK_ALWAYS_ON(host);
 	clk_reg |= CLK_DIV_MASK;
 	writel(clk_reg, host->regs + SD_EMMC_CLOCK);
 
@@ -574,7 +595,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
 
 	tx->reg = host->regs + SD_EMMC_CLOCK;
 	tx->phase_mask = CLK_TX_PHASE_MASK;
-	tx->delay_mask = CLK_TX_DELAY_MASK;
+	tx->delay_mask = CLK_TX_DELAY_MASK(host);
 	tx->delay_step_ps = CLK_DELAY_STEP_PS;
 	tx->hw.init = &init;
 
@@ -597,7 +618,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
 
 	rx->reg = host->regs + SD_EMMC_CLOCK;
 	rx->phase_mask = CLK_RX_PHASE_MASK;
-	rx->delay_mask = CLK_RX_DELAY_MASK;
+	rx->delay_mask = CLK_RX_DELAY_MASK(host);
 	rx->delay_step_ps = CLK_DELAY_STEP_PS;
 	rx->hw.init = &init;
 
@@ -1184,6 +1205,13 @@ static int meson_mmc_probe(struct platform_device *pdev)
 		goto free_host;
 	}
 
+	host->data = (struct meson_mmc_data *)
+		of_device_get_match_data(&pdev->dev);
+	if (!host->data) {
+		ret = -EINVAL;
+		goto free_host;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(host->regs)) {
@@ -1315,11 +1343,24 @@ static int meson_mmc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct meson_mmc_data meson_gx_data = {
+	.tx_delay_mask	= CLK_V2_TX_DELAY_MASK,
+	.rx_delay_mask	= CLK_V2_RX_DELAY_MASK,
+	.always_on	= CLK_V2_ALWAYS_ON,
+};
+
+static const struct meson_mmc_data meson_axg_data = {
+	.tx_delay_mask	= CLK_V3_TX_DELAY_MASK,
+	.rx_delay_mask	= CLK_V3_RX_DELAY_MASK,
+	.always_on	= CLK_V3_ALWAYS_ON,
+};
+
 static const struct of_device_id meson_mmc_of_match[] = {
-	{ .compatible = "amlogic,meson-gx-mmc", },
-	{ .compatible = "amlogic,meson-gxbb-mmc", },
-	{ .compatible = "amlogic,meson-gxl-mmc", },
-	{ .compatible = "amlogic,meson-gxm-mmc", },
+	{ .compatible = "amlogic,meson-gx-mmc",		.data = &meson_gx_data },
+	{ .compatible = "amlogic,meson-gxbb-mmc", 	.data = &meson_gx_data },
+	{ .compatible = "amlogic,meson-gxl-mmc",	.data = &meson_gx_data },
+	{ .compatible = "amlogic,meson-gxm-mmc",	.data = &meson_gx_data },
+	{ .compatible = "amlogic,meson-axg-mmc",	.data = &meson_axg_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, meson_mmc_of_match);
-- 
2.16.2
