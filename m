From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v3 4/7] mmc: sunxi: Move clock configuration to a function
Date: Mon, 16 Apr 2018 16:23:02 +0200
Message-ID: <ed072568a5b39d1dbcb6c35469aa3ab04f450eda.1523888566.git-series.maxime.ripard@bootlin.com>
References: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
References: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
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

In order to improve readibility and reusability, let's move the clock setup
to a small function called by our .set_ios hook.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/mmc/host/sunxi-mmc.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index c0bb75e17a44..3c1ab46cc60a 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -871,6 +871,23 @@ static void sunxi_mmc_set_bus_width(struct sunxi_mmc_host *host,
 	}
 }
 
+static void sunxi_mmc_set_clk(struct sunxi_mmc_host *host, struct mmc_ios *ios)
+{
+	u32 rval;
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
 static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
@@ -920,21 +937,7 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	}
 
 	sunxi_mmc_set_bus_width(host, ios->bus_width);
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
+	sunxi_mmc_set_clk(host, ios);
 }
 
 static int sunxi_mmc_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
-- 
git-series 0.9.1
