From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 07/14] mmc: meson-gx: rework clk_set function
Date: Fri,  4 Aug 2017 19:43:46 +0200
Message-ID: <20170804174353.16486-8-jbrunet@baylibre.com>
References: <20170804174353.16486-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170804174353.16486-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Clean-up clk_set function to prepare the next changes (DDR and clk-stop)

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 18fff28025d8..8f9ba5190c18 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -139,7 +139,7 @@ struct meson_host {
 	struct clk *core_clk;
 	struct clk_mux mux;
 	struct clk *mux_clk;
-	unsigned long current_clock;
+	unsigned long req_rate;
 
 	struct clk_divider cfg_div;
 	struct clk *cfg_div_clk;
@@ -275,29 +275,18 @@ static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
 	int ret;
 	u32 cfg;
 
-	if (clk_rate) {
-		if (WARN_ON(clk_rate > mmc->f_max))
-			clk_rate = mmc->f_max;
-		else if (WARN_ON(clk_rate < mmc->f_min))
-			clk_rate = mmc->f_min;
-	}
-
-	if (clk_rate == host->current_clock)
+	/* Same request - bail-out */
+	if (host->req_rate == clk_rate)
 		return 0;
 
 	/* stop clock */
 	cfg = readl(host->regs + SD_EMMC_CFG);
-	if (!(cfg & CFG_STOP_CLOCK)) {
-		cfg |= CFG_STOP_CLOCK;
-		writel(cfg, host->regs + SD_EMMC_CFG);
-	}
-
-	dev_dbg(host->dev, "change clock rate %u -> %lu\n",
-		mmc->actual_clock, clk_rate);
+	cfg |= CFG_STOP_CLOCK;
+	writel(cfg, host->regs + SD_EMMC_CFG);
+	host->req_rate = 0;
 
 	if (!clk_rate) {
 		mmc->actual_clock = 0;
-		host->current_clock = 0;
 		/* return with clock being stopped */
 		return 0;
 	}
@@ -309,13 +298,12 @@ static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
 		return ret;
 	}
 
+	host->req_rate = clk_rate;
 	mmc->actual_clock = clk_get_rate(host->cfg_div_clk);
-	host->current_clock = clk_rate;
 
+	dev_dbg(host->dev, "clk rate: %u Hz\n", mmc->actual_clock);
 	if (clk_rate != mmc->actual_clock)
-		dev_dbg(host->dev,
-			"divider requested rate %lu != actual rate %u\n",
-			clk_rate, mmc->actual_clock);
+		dev_dbg(host->dev, "requested rate was %lu\n", clk_rate);
 
 	/* (re)start clock */
 	cfg = readl(host->regs + SD_EMMC_CFG);
-- 
2.9.4
