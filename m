From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 06/16] mmc: meson-gx: rework set_ios function
Date: Mon, 21 Aug 2017 18:02:51 +0200
Message-ID: <20170821160301.21899-7-jbrunet@baylibre.com>
References: <20170821160301.21899-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170821160301.21899-1-jbrunet@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: linux-mmc@vger.kernel.org

Remove conditional write of cfg register. Warn if set_clk fails for some
reason. Consistently use host->dev instead of mixing with mmc_dev(mmc)

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 61668891b4fc..18fff28025d8 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -445,8 +445,8 @@ static void meson_mmc_set_tuning_params(struct mmc_host *mmc)
 static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct meson_host *host = mmc_priv(mmc);
-	u32 bus_width;
-	u32 val, orig;
+	u32 bus_width, val;
+	int err;
 
 	/*
 	 * GPIO regulator, only controls switching between 1v8 and
@@ -474,7 +474,7 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			int ret = regulator_enable(mmc->supply.vqmmc);
 
 			if (ret < 0)
-				dev_err(mmc_dev(mmc),
+				dev_err(host->dev,
 					"failed to enable vqmmc regulator\n");
 			else
 				host->vqmmc_enabled = true;
@@ -483,9 +483,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
-
-	meson_mmc_clk_set(host, ios->clock);
-
 	/* Bus width */
 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_1:
@@ -504,8 +501,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	}
 
 	val = readl(host->regs + SD_EMMC_CFG);
-	orig = val;
-
 	val &= ~CFG_BUS_WIDTH_MASK;
 	val |= FIELD_PREP(CFG_BUS_WIDTH_MASK, bus_width);
 
@@ -519,11 +514,12 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
