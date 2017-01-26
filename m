From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v4 3/13] mmc: sunxi: Always set signal delay to 0 for A64
Date: Thu, 26 Jan 2017 10:05:56 +0100
Message-ID: <6c9dae7e6c872420e5e565efb334be411269be21.1485421557.git-series.maxime.ripard@free-electrons.com>
References: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
References: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
List-Id: linux-mmc@vger.kernel.org

Experience have shown that the using the  autocalibration could severely
degrade the performances of the MMC bus.

Allwinner is using in its BSP a delay set to 0 for all the modes but HS400.
Remove the calibration code for now, and add comments to document our
findings.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/mmc/host/sunxi-mmc.c | 50 ++++++++++++-------------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 019f95e8e7c5..b9c8a62bc212 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -683,41 +683,19 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 
 static int sunxi_mmc_calibrate(struct sunxi_mmc_host *host, int reg_off)
 {
-	u32 reg = readl(host->reg_base + reg_off);
-	u32 delay;
-	unsigned long timeout;
-
 	if (!host->cfg->can_calibrate)
 		return 0;
 
-	reg &= ~(SDXC_CAL_DL_MASK << SDXC_CAL_DL_SW_SHIFT);
-	reg &= ~SDXC_CAL_DL_SW_EN;
-
-	writel(reg | SDXC_CAL_START, host->reg_base + reg_off);
-
-	dev_dbg(mmc_dev(host->mmc), "calibration started\n");
-
-	timeout = jiffies + HZ * SDXC_CAL_TIMEOUT;
-
-	while (!((reg = readl(host->reg_base + reg_off)) & SDXC_CAL_DONE)) {
-		if (time_before(jiffies, timeout))
-			cpu_relax();
-		else {
-			reg &= ~SDXC_CAL_START;
-			writel(reg, host->reg_base + reg_off);
-
-			return -ETIMEDOUT;
-		}
-	}
-
-	delay = (reg >> SDXC_CAL_DL_SHIFT) & SDXC_CAL_DL_MASK;
-
-	reg &= ~SDXC_CAL_START;
-	reg |= (delay << SDXC_CAL_DL_SW_SHIFT) | SDXC_CAL_DL_SW_EN;
-
-	writel(reg, host->reg_base + reg_off);
-
-	dev_dbg(mmc_dev(host->mmc), "calibration ended, reg is 0x%x\n", reg);
+	/*
+	 * FIXME:
+	 * This is not clear how the calibration is supposed to work
+	 * yet. The best rate have been obtained by simply setting the
+	 * delay to 0, as Allwinner does in its BSP.
+	 *
+	 * The only mode that doesn't have such a delay is HS400, that
+	 * is in itself a TODO.
+	 */
+	writel(SDXC_CAL_DL_SW_EN, host->reg_base + reg_off);
 
 	return 0;
 }
@@ -809,7 +787,13 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	if (ret)
 		return ret;
 
-	/* TODO: enable calibrate on sdc2 SDXC_REG_DS_DL_REG of A64 */
+	/*
+	 * FIXME:
+	 *
+	 * In HS400 we'll also need to calibrate the data strobe
+	 * signal. This should only happen on the MMC2 controller (at
+	 * least on the A64).
+	 */
 
 	return sunxi_mmc_oclk_onoff(host, 1);
 }
-- 
git-series 0.8.11
