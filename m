From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 1/3] mmc: host: omap_hsmmc: Do not initialize MMC regulators
 to NULL on error
Date: Wed, 7 Jun 2017 14:06:10 +0530
Message-ID: <20170607083612.14224-2-kishon@ti.com>
References: <20170607083612.14224-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170607083612.14224-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, nsekhar@ti.com
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Do not initialize MMC regulators to NULL on error in omap_hsmmc driver
similar to what is done in mmc_regulator_get_supply(). This is in
preparation for using mmc_regulator_get_supply() to get MMC
regulators.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 8c39dccacf39..de82ac0a87e2 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -250,14 +250,14 @@ static int omap_hsmmc_enable_supply(struct mmc_host *mmc)
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 	struct mmc_ios *ios = &mmc->ios;
 
-	if (mmc->supply.vmmc) {
+	if (!IS_ERR(mmc->supply.vmmc)) {
 		ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
 		if (ret)
 			return ret;
 	}
 
 	/* Enable interface voltage rail, if needed */
-	if (mmc->supply.vqmmc && !host->vqmmc_enabled) {
+	if (!IS_ERR(mmc->supply.vqmmc) && !host->vqmmc_enabled) {
 		ret = regulator_enable(mmc->supply.vqmmc);
 		if (ret) {
 			dev_err(mmc_dev(mmc), "vmmc_aux reg enable failed\n");
@@ -269,7 +269,7 @@ static int omap_hsmmc_enable_supply(struct mmc_host *mmc)
 	return 0;
 
 err_vqmmc:
-	if (mmc->supply.vmmc)
+	if (!IS_ERR(mmc->supply.vmmc))
 		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
 
 	return ret;
@@ -281,7 +281,7 @@ static int omap_hsmmc_disable_supply(struct mmc_host *mmc)
 	int status;
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 
-	if (mmc->supply.vqmmc && host->vqmmc_enabled) {
+	if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled) {
 		ret = regulator_disable(mmc->supply.vqmmc);
 		if (ret) {
 			dev_err(mmc_dev(mmc), "vmmc_aux reg disable failed\n");
@@ -290,7 +290,7 @@ static int omap_hsmmc_disable_supply(struct mmc_host *mmc)
 		host->vqmmc_enabled = 0;
 	}
 
-	if (mmc->supply.vmmc) {
+	if (!IS_ERR(mmc->supply.vmmc)) {
 		ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
 		if (ret)
 			goto err_set_ocr;
@@ -299,7 +299,7 @@ static int omap_hsmmc_disable_supply(struct mmc_host *mmc)
 	return 0;
 
 err_set_ocr:
-	if (mmc->supply.vqmmc) {
+	if (!IS_ERR(mmc->supply.vqmmc)) {
 		status = regulator_enable(mmc->supply.vqmmc);
 		if (status)
 			dev_err(mmc_dev(mmc), "vmmc_aux re-enable failed\n");
@@ -313,7 +313,7 @@ static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on,
 {
 	int ret;
 
-	if (!host->pbias)
+	if (IS_ERR(host->pbias))
 		return 0;
 
 	if (power_on) {
@@ -363,7 +363,7 @@ static int omap_hsmmc_set_power(struct omap_hsmmc_host *host, int power_on,
 	 * If we don't see a Vcc regulator, assume it's a fixed
 	 * voltage always-on regulator.
 	 */
-	if (!mmc->supply.vmmc)
+	if (IS_ERR(mmc->supply.vmmc))
 		return 0;
 
 	if (mmc_pdata(host)->before_set_reg)
@@ -415,7 +415,7 @@ static int omap_hsmmc_disable_boot_regulator(struct regulator *reg)
 {
 	int ret;
 
-	if (!reg)
+	if (IS_ERR(reg))
 		return 0;
 
 	if (regulator_is_enabled(reg)) {
@@ -480,7 +480,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 			return ret;
 		dev_dbg(host->dev, "unable to get vmmc regulator %ld\n",
 			PTR_ERR(mmc->supply.vmmc));
-		mmc->supply.vmmc = NULL;
 	} else {
 		ocr_value = mmc_regulator_get_ocrmask(mmc->supply.vmmc);
 		if (ocr_value > 0)
@@ -495,7 +494,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 			return ret;
 		dev_dbg(host->dev, "unable to get vmmc_aux regulator %ld\n",
 			PTR_ERR(mmc->supply.vqmmc));
-		mmc->supply.vqmmc = NULL;
 	}
 
 	host->pbias = devm_regulator_get_optional(host->dev, "pbias");
@@ -508,7 +506,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 		}
 		dev_dbg(host->dev, "unable to get pbias regulator %ld\n",
 			PTR_ERR(host->pbias));
-		host->pbias = NULL;
 	}
 
 	/* For eMMC do not power off when not in sleep state */
-- 
2.11.0
