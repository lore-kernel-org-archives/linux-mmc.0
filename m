From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 09/16] mmc: meson-gx: fix dual data rate mode frequencies
Date: Mon, 21 Aug 2017 18:02:54 +0200
Message-ID: <20170821160301.21899-10-jbrunet@baylibre.com>
References: <20170821160301.21899-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821160301.21899-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

In DDR modes, meson mmc controller requires an input rate twice as fast
as the output rate

Fixes: 51c5d8447bd7 ("MMC: meson: initial support for GX platforms")
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 2f45daa5d510..0d3416dae8cf 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -262,14 +262,29 @@ static void meson_mmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 			     mmc_get_dma_dir(data));
 }
 
-static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
+static bool meson_mmc_timing_is_ddr(struct mmc_ios *ios)
+{
+	if (ios->timing == MMC_TIMING_MMC_DDR52 ||
+	    ios->timing == MMC_TIMING_UHS_DDR50 ||
+	    ios->timing == MMC_TIMING_MMC_HS400)
+		return true;
+
+	return false;
+}
+
+static int meson_mmc_clk_set(struct meson_host *host, struct mmc_ios *ios)
 {
 	struct mmc_host *mmc = host->mmc;
+	unsigned long rate = ios->clock;
 	int ret;
 	u32 cfg;
 
+	/* DDR modes require higher module clock */
+	if (meson_mmc_timing_is_ddr(ios))
+		rate <<= 1;
+
 	/* Same request - bail-out */
-	if (host->req_rate == clk_rate)
+	if (host->req_rate == rate)
 		return 0;
 
 	/* stop clock */
@@ -278,25 +293,29 @@ static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
 	writel(cfg, host->regs + SD_EMMC_CFG);
 	host->req_rate = 0;
 
-	if (!clk_rate) {
+	if (!rate) {
 		mmc->actual_clock = 0;
 		/* return with clock being stopped */
 		return 0;
 	}
 
-	ret = clk_set_rate(host->mmc_clk, clk_rate);
+	ret = clk_set_rate(host->mmc_clk, rate);
 	if (ret) {
 		dev_err(host->dev, "Unable to set cfg_div_clk to %lu. ret=%d\n",
-			clk_rate, ret);
+			rate, ret);
 		return ret;
 	}
 
-	host->req_rate = clk_rate;
+	host->req_rate = rate;
 	mmc->actual_clock = clk_get_rate(host->mmc_clk);
 
+	/* We should report the real output frequency of the controller */
+	if (meson_mmc_timing_is_ddr(ios))
+		mmc->actual_clock >>= 1;
+
 	dev_dbg(host->dev, "clk rate: %u Hz\n", mmc->actual_clock);
-	if (clk_rate != mmc->actual_clock)
-		dev_dbg(host->dev, "requested rate was %lu\n", clk_rate);
+	if (ios->clock != mmc->actual_clock)
+		dev_dbg(host->dev, "requested rate was %u\n", ios->clock);
 
 	/* (re)start clock */
 	cfg = readl(host->regs + SD_EMMC_CFG);
@@ -490,16 +509,14 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	val |= FIELD_PREP(CFG_BUS_WIDTH_MASK, bus_width);
 
 	val &= ~CFG_DDR;
-	if (ios->timing == MMC_TIMING_UHS_DDR50 ||
-	    ios->timing == MMC_TIMING_MMC_DDR52 ||
-	    ios->timing == MMC_TIMING_MMC_HS400)
+	if (meson_mmc_timing_is_ddr(ios))
 		val |= CFG_DDR;
 
 	val &= ~CFG_CHK_DS;
 	if (ios->timing == MMC_TIMING_MMC_HS400)
 		val |= CFG_CHK_DS;
 
-	err = meson_mmc_clk_set(host, ios->clock);
+	err = meson_mmc_clk_set(host, ios);
 	if (err)
 		dev_err(host->dev, "Failed to set clock: %d\n,", err);
 
-- 
2.9.5
