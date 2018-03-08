From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 4/8] mmc: sunxi: Move the power up action in a separate
 function
Date: Thu,  8 Mar 2018 15:52:50 +0100
Message-ID: <81323d51de103251658535c4c787d687316395c7.1520520655.git-series.maxime.ripard@bootlin.com>
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

We'll need to have the power up behaviour in order to implement runtime_pm.
Move it outside of the .set_ios callback for an easier access.

And it improves readibility as a bonus.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/mmc/host/sunxi-mmc.c | 60 ++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 4e81fe171532..e4b44c4adb8f 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -888,6 +888,37 @@ static void sunxi_mmc_power_on(struct mmc_host *mmc, struct mmc_ios *ios)
 	/* Android code had a usleep_range(50000, 55000); here */
 }
 
+static void sunxi_mmc_power_up(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sunxi_mmc_host *host = mmc_priv(mmc);
+
+	dev_dbg(mmc_dev(mmc), "Powering up\n");
+
+	if (!IS_ERR(mmc->supply.vmmc)) {
+		host->ferror = mmc_regulator_set_ocr(mmc,
+						     mmc->supply.vmmc,
+						     ios->vdd);
+		if (host->ferror)
+			return;
+	}
+
+	if (!IS_ERR(mmc->supply.vqmmc)) {
+		host->ferror = regulator_enable(mmc->supply.vqmmc);
+		if (host->ferror) {
+			dev_err(mmc_dev(mmc),
+				"failed to enable vqmmc\n");
+			return;
+		}
+		host->vqmmc_enabled = true;
+	}
+
+	host->ferror = sunxi_mmc_init_host(mmc);
+	if (host->ferror)
+		return;
+
+	sunxi_mmc_power_on(mmc, ios);
+}
+
 static void sunxi_mmc_power_off(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
@@ -906,45 +937,20 @@ static void sunxi_mmc_power_off(struct mmc_host *mmc, struct mmc_ios *ios)
 
 static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
-	struct sunxi_mmc_host *host = mmc_priv(mmc);
-
 	/* Set the power state */
 	switch (ios->power_mode) {
 	case MMC_POWER_ON:
+		sunxi_mmc_power_on(mmc, ios);
 		break;
 
 	case MMC_POWER_UP:
-		if (!IS_ERR(mmc->supply.vmmc)) {
-			host->ferror = mmc_regulator_set_ocr(mmc,
-							     mmc->supply.vmmc,
-							     ios->vdd);
-			if (host->ferror)
-				return;
-		}
-
-		if (!IS_ERR(mmc->supply.vqmmc)) {
-			host->ferror = regulator_enable(mmc->supply.vqmmc);
-			if (host->ferror) {
-				dev_err(mmc_dev(mmc),
-					"failed to enable vqmmc\n");
-				return;
-			}
-			host->vqmmc_enabled = true;
-		}
-
-		host->ferror = sunxi_mmc_init_host(mmc);
-		if (host->ferror)
-			return;
-
-		dev_dbg(mmc_dev(mmc), "power on!\n");
+		sunxi_mmc_power_up(mmc, ios);
 		break;
 
 	case MMC_POWER_OFF:
 		sunxi_mmc_power_off(mmc, ios);
 		break;
 	}
-
-	sunxi_mmc_power_on(mmc, ios);
 }
 
 static int sunxi_mmc_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
-- 
git-series 0.9.1
