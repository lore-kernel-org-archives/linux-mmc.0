From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [RFT PATCH 4/4] mmc: meson-gx: add signal resampling
Date: Thu,  6 Dec 2018 16:18:28 +0100
Message-ID: <20181206151828.24417-5-jbrunet@baylibre.com>
References: <20181206151828.24417-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206151828.24417-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

With some eMMC devices, there is still issues with the new phase
settings. Enabling signal resampling seems to solve the problem
for these.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 837bed0b8c01..c2690c1a50ff 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -66,6 +66,9 @@
 
 #define SD_EMMC_DELAY 0x4
 #define SD_EMMC_ADJUST 0x8
+#define   ADJUST_ADJ_DELAY_MASK GENMASK(21, 16)
+#define   ADJUST_DS_EN BIT(15)
+#define   ADJUST_ADJ_EN BIT(13)
 
 #define SD_EMMC_DELAY1 0x4
 #define SD_EMMC_DELAY2 0x8
@@ -143,6 +146,7 @@ struct meson_mmc_data {
 	unsigned int tx_delay_mask;
 	unsigned int rx_delay_mask;
 	unsigned int always_on;
+	unsigned int adjust;
 };
 
 struct sd_emmc_desc {
@@ -1162,7 +1166,7 @@ static int meson_mmc_get_cd(struct mmc_host *mmc)
 
 static void meson_mmc_cfg_init(struct meson_host *host)
 {
-	u32 cfg = 0;
+	u32 cfg = 0, adj = 0;
 
 	cfg |= FIELD_PREP(CFG_RESP_TIMEOUT_MASK,
 			  ilog2(SD_EMMC_CFG_RESP_TIMEOUT));
@@ -1173,6 +1177,10 @@ static void meson_mmc_cfg_init(struct meson_host *host)
 	cfg |= CFG_ERR_ABORT;
 
 	writel(cfg, host->regs + SD_EMMC_CFG);
+
+	/* enable signal resampling w/o delay */
+	adj = ADJUST_ADJ_EN;
+	writel(adj, host->regs + host->data->adjust);
 }
 
 static int meson_mmc_card_busy(struct mmc_host *mmc)
@@ -1396,12 +1404,14 @@ static const struct meson_mmc_data meson_gx_data = {
 	.tx_delay_mask	= CLK_V2_TX_DELAY_MASK,
 	.rx_delay_mask	= CLK_V2_RX_DELAY_MASK,
 	.always_on	= CLK_V2_ALWAYS_ON,
+	.adjust		= SD_EMMC_ADJUST,
 };
 
 static const struct meson_mmc_data meson_axg_data = {
 	.tx_delay_mask	= CLK_V3_TX_DELAY_MASK,
 	.rx_delay_mask	= CLK_V3_RX_DELAY_MASK,
 	.always_on	= CLK_V3_ALWAYS_ON,
+	.adjust		= SD_EMMC_V3_ADJUST,
 };
 
 static const struct of_device_id meson_mmc_of_match[] = {
-- 
2.19.2
