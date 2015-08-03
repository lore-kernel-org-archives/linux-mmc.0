From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 14/16] mmc: host: omap_hsmmc: use ios->vdd for setting vmmc voltage
Date: Mon, 3 Aug 2015 17:56:39 +0530
Message-ID: <1438604801-11823-15-git-send-email-kishon@ti.com>
References: <1438604801-11823-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438604801-11823-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

vdd voltage is set in mmc core to ios->vdd and vmmc should actually
be set to this voltage. Modify omap_hsmmc_enable_supply
to not take vdd as argument since now it's directly set to
the voltage in ios->vdd.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e04060b..9a28719 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -247,13 +247,14 @@ static int omap_hsmmc_get_cover_state(struct device *dev)
 
 #ifdef CONFIG_REGULATOR
 
-static int omap_hsmmc_enable_supply(struct mmc_host *mmc, int vdd)
+static int omap_hsmmc_enable_supply(struct mmc_host *mmc)
 {
 	int ret;
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
+	struct mmc_ios *ios = &mmc->ios;
 
 	if (mmc->supply.vmmc) {
-		ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+		ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
 		if (ret)
 			return ret;
 	}
@@ -385,7 +386,7 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 	 * chips/cards need an interface voltage rail too.
 	 */
 	if (power_on) {
-		ret = omap_hsmmc_enable_supply(mmc, vdd);
+		ret = omap_hsmmc_enable_supply(mmc);
 		if (ret)
 			return ret;
 
-- 
1.7.9.5
