From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 7/7] mmc: meson-gx: add signal resampling tuning
Date: Wed, 17 Apr 2019 22:43:55 +0200
Message-ID: <20190417204355.469-8-jbrunet@baylibre.com>
References: <20190417204355.469-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417204355.469-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Use signal resampling tuning for the UHS and HS200 modes.
Instead of trying to get the *best* resampling setting with complex
window calculation, we just stop on the first working setting.

If the tuning setting later proves unstable, we will just continue the
tuning where we left it.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 73 +++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 50b03c167435..207c65b3ddf1 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -488,6 +488,61 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	return clk_prepare_enable(host->mmc_clk);
 }
 
+static void meson_mmc_disable_resampling(struct meson_host *host)
+{
+	unsigned int val = readl(host->regs + host->data->adjust);
+
+	val &= ~ADJUST_ADJ_EN;
+	writel(val, host->regs + host->data->adjust);
+}
+
+static void meson_mmc_reset_resampling(struct meson_host *host)
+{
+	unsigned int val;
+
+	meson_mmc_disable_resampling(host);
+
+	val = readl(host->regs + host->data->adjust);
+	val &= ~ADJUST_ADJ_DELAY_MASK;
+	writel(val, host->regs + host->data->adjust);
+}
+
+static int meson_mmc_resampling_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct meson_host *host = mmc_priv(mmc);
+	unsigned int val, dly, max_dly, i;
+	int ret;
+
+	/* Resampling is done using the source clock */
+	max_dly = DIV_ROUND_UP(clk_get_rate(host->mux_clk),
+			       clk_get_rate(host->mmc_clk));
+
+	val = readl(host->regs + host->data->adjust);
+	val |= ADJUST_ADJ_EN;
+	writel(val, host->regs + host->data->adjust);
+
+	if (mmc->doing_retune)
+		dly = FIELD_GET(ADJUST_ADJ_DELAY_MASK, val) + 1;
+	else
+		dly = 0;
+
+	for (i = 0; i < max_dly; i++) {
+		val &= ~ADJUST_ADJ_DELAY_MASK;
+		val |= FIELD_PREP(ADJUST_ADJ_DELAY_MASK, (dly + i) % max_dly);
+		writel(val, host->regs + host->data->adjust);
+
+		ret = mmc_send_tuning(mmc, opcode, NULL);
+		if (!ret) {
+			dev_dbg(mmc_dev(mmc), "resampling delay: %u\n",
+				(dly + i) % max_dly);
+			return 0;
+		}
+	}
+
+	meson_mmc_reset_resampling(host);
+	return -EIO;
+}
+
 static int meson_mmc_prepare_ios_clock(struct meson_host *host,
 				       struct mmc_ios *ios)
 {
@@ -507,6 +562,19 @@ static int meson_mmc_prepare_ios_clock(struct meson_host *host,
 	return meson_mmc_clk_set(host, ios->clock, ddr);
 }
 
+static void meson_mmc_check_resampling(struct meson_host *host,
+				       struct mmc_ios *ios)
+{
+	switch (ios->timing) {
+	case MMC_TIMING_LEGACY:
+	case MMC_TIMING_MMC_HS:
+	case MMC_TIMING_SD_HS:
+	case MMC_TIMING_MMC_DDR52:
+		meson_mmc_disable_resampling(host);
+		break;
+	}
+}
+
 static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct meson_host *host = mmc_priv(mmc);
@@ -533,9 +601,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
 
-		/* disable signal resampling */
-		writel(0, host->regs + host->data->adjust);
-
 		break;
 
 	case MMC_POWER_ON:
@@ -573,6 +638,7 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	val &= ~CFG_BUS_WIDTH_MASK;
 	val |= FIELD_PREP(CFG_BUS_WIDTH_MASK, bus_width);
 
+	meson_mmc_check_resampling(host, ios);
 	err = meson_mmc_prepare_ios_clock(host, ios);
 	if (err)
 		dev_err(host->dev, "Failed to set clock: %d\n,", err);
@@ -962,6 +1028,7 @@ static const struct mmc_host_ops meson_mmc_ops = {
 	.get_cd         = meson_mmc_get_cd,
 	.pre_req	= meson_mmc_pre_req,
 	.post_req	= meson_mmc_post_req,
+	.execute_tuning = meson_mmc_resampling_tuning,
 	.card_busy	= meson_mmc_card_busy,
 	.start_signal_voltage_switch = meson_mmc_voltage_switch,
 };
-- 
2.20.1
