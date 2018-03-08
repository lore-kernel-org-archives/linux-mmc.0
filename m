From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 3/8] mmc: sunxi: Move the power on action in a separate
 function
Date: Thu,  8 Mar 2018 15:52:49 +0100
Message-ID: <cff8ee6d63b8e48881fc2c9d81a1a2d383fbbc5f.1520520655.git-series.maxime.ripard@bootlin.com>
References: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
References: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, ulf.hansson@linaro.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-mmc@vger.kernel.org, Quentin Schulz <quentin.schulz@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

We'll need to have the power on behaviour in order to implement runtime_pm.
Move it outside of the .set_ios callback for an easier access.

And it improves readibility as a bonus.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/mmc/host/sunxi-mmc.c | 62 ++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index a53e39d8b07e..4e81fe171532 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -855,6 +855,39 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	return 0;
 }
 
+static void sunxi_mmc_power_on(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sunxi_mmc_host *host = mmc_priv(mmc);
+	u32 rval;
+
+	dev_dbg(mmc_dev(mmc), "Powering on\n");
+
+	/* set bus width */
+	switch (ios->bus_width) {
+	case MMC_BUS_WIDTH_1:
+		mmc_writel(host, REG_WIDTH, SDXC_WIDTH1);
+		break;
+	case MMC_BUS_WIDTH_4:
+		mmc_writel(host, REG_WIDTH, SDXC_WIDTH4);
+		break;
+	case MMC_BUS_WIDTH_8:
+		mmc_writel(host, REG_WIDTH, SDXC_WIDTH8);
+		break;
+	}
+
+	/* set ddr mode */
+	rval = mmc_readl(host, REG_GCTRL);
+	if (ios->timing == MMC_TIMING_UHS_DDR50 ||
+	    ios->timing == MMC_TIMING_MMC_DDR52)
+		rval |= SDXC_DDR_MODE;
+	else
+		rval &= ~SDXC_DDR_MODE;
+	mmc_writel(host, REG_GCTRL, rval);
+
+	host->ferror = sunxi_mmc_clk_set_rate(host, ios);
+	/* Android code had a usleep_range(50000, 55000); here */
+}
+
 static void sunxi_mmc_power_off(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
@@ -874,7 +907,6 @@ static void sunxi_mmc_power_off(struct mmc_host *mmc, struct mmc_ios *ios)
 static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
-	u32 rval;
 
 	/* Set the power state */
 	switch (ios->power_mode) {
@@ -912,33 +944,7 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
-	/* set bus width */
-	switch (ios->bus_width) {
-	case MMC_BUS_WIDTH_1:
-		mmc_writel(host, REG_WIDTH, SDXC_WIDTH1);
-		break;
-	case MMC_BUS_WIDTH_4:
-		mmc_writel(host, REG_WIDTH, SDXC_WIDTH4);
-		break;
-	case MMC_BUS_WIDTH_8:
-		mmc_writel(host, REG_WIDTH, SDXC_WIDTH8);
-		break;
-	}
-
-	/* set ddr mode */
-	rval = mmc_readl(host, REG_GCTRL);
-	if (ios->timing == MMC_TIMING_UHS_DDR50 ||
-	    ios->timing == MMC_TIMING_MMC_DDR52)
-		rval |= SDXC_DDR_MODE;
-	else
-		rval &= ~SDXC_DDR_MODE;
-	mmc_writel(host, REG_GCTRL, rval);
-
-	/* set up clock */
-	if (ios->power_mode) {
-		host->ferror = sunxi_mmc_clk_set_rate(host, ios);
-		/* Android code had a usleep_range(50000, 55000); here */
-	}
+	sunxi_mmc_power_on(mmc, ios);
 }
 
 static int sunxi_mmc_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
-- 
git-series 0.9.1
