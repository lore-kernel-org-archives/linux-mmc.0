From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 14/15] mmc: host: omap_hsmmc: use ios->vdd for setting vmmc voltage
Date: Thu, 27 Aug 2015 14:44:06 +0530
Message-ID: <1440666847-12594-15-git-send-email-kishon@ti.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440666847-12594-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

vdd voltage is set in mmc core to ios->vdd and vmmc should actually
be set to this voltage. Modify omap_hsmmc_enable_supply
to not take vdd as argument since now it's directly set to
the voltage in ios->vdd.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4cd7a58..58683b3 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -246,13 +246,14 @@ static int omap_hsmmc_get_cover_state(struct device *dev)
 
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
@@ -387,7 +388,7 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 	 * chips/cards need an interface voltage rail too.
 	 */
 	if (power_on) {
-		ret = omap_hsmmc_enable_supply(mmc, vdd);
+		ret = omap_hsmmc_enable_supply(mmc);
 		if (ret)
 			return ret;
 
-- 
1.7.9.5
