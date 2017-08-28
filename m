From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v3 03/13] mmc: meson-gx: rework set_ios function
Date: Mon, 28 Aug 2017 16:29:05 +0200
Message-ID: <20170828142915.27020-4-jbrunet@baylibre.com>
References: <20170828142915.27020-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170828142915.27020-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Remove conditional write of cfg register. Warn if set_clk fails for some
reason. Consistently use host->dev instead of mixing with mmc_dev(mmc)

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 7d14d382cb1c..0d29f1f347eb 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -444,8 +444,8 @@ static void meson_mmc_set_tuning_params(struct mmc_host *mmc)
 static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct meson_host *host = mmc_priv(mmc);
-	u32 bus_width;
-	u32 val, orig;
+	u32 bus_width, val;
+	int err;
 
 	/*
 	 * GPIO regulator, only controls switching between 1v8 and
@@ -473,7 +473,7 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			int ret = regulator_enable(mmc->supply.vqmmc);
 
 			if (ret < 0)
-				dev_err(mmc_dev(mmc),
+				dev_err(host->dev,
 					"failed to enable vqmmc regulator\n");
 			else
 				host->vqmmc_enabled = true;
@@ -482,9 +482,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
-
-	meson_mmc_clk_set(host, ios->clock);
-
 	/* Bus width */
 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_1:
@@ -503,8 +500,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	}
 
 	val = readl(host->regs + SD_EMMC_CFG);
-	orig = val;
-
 	val &= ~CFG_BUS_WIDTH_MASK;
 	val |= FIELD_PREP(CFG_BUS_WIDTH_MASK, bus_width);
 
@@ -518,11 +513,12 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->timing == MMC_TIMING_MMC_HS400)
 		val |= CFG_CHK_DS;
 
-	if (val != orig) {
-		writel(val, host->regs + SD_EMMC_CFG);
-		dev_dbg(host->dev, "%s: SD_EMMC_CFG: 0x%08x -> 0x%08x\n",
-			__func__, orig, val);
-	}
+	err = meson_mmc_clk_set(host, ios->clock);
+	if (err)
+		dev_err(host->dev, "Failed to set clock: %d\n,", err);
+
+	writel(val, host->regs + SD_EMMC_CFG);
+	dev_dbg(host->dev, "SD_EMMC_CFG:  0x%08x\n", val);
 }
 
 static void meson_mmc_request_done(struct mmc_host *mmc,
-- 
2.9.5
