From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 07/13] mmc: omap_hsmmc: remove dt pbias workaround
Date: Tue, 30 Apr 2013 19:33:47 +0530
Message-ID: <1367330633-5941-8-git-send-email-balajitk@ti.com>
References: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, b-cousson@ti.com
Cc: Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

With pbias control support in place remove dt workaround for pbias

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   15 +--------------
 1 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 217c063..c84d2ad 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -256,13 +256,6 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 	 */
 	if (!host->vcc && !host->vcc_aux)
 		return 0;
-	/*
-	 * With DT, never turn OFF the regulator. This is because
-	 * the pbias cell programming support is still missing when
-	 * booting with Device tree
-	 */
-	if (dev->of_node && !vdd)
-		return 0;
 
 	if (mmc_slot(host).before_set_reg)
 		mmc_slot(host).before_set_reg(dev, slot, power_on, vdd);
@@ -1528,13 +1521,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		 * of external transceiver; but they all handle 1.8V.
 		 */
 		if ((OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET) &&
-			(ios->vdd == DUAL_VOLT_OCR_BIT) &&
-			/*
-			 * With pbias cell programming missing, this
-			 * can't be allowed when booting with device
-			 * tree.
-			 */
-			!host->dev->of_node) {
+			(ios->vdd == DUAL_VOLT_OCR_BIT)) {
 				/*
 				 * The mmc_select_voltage fn of the core does
 				 * not seem to set the power_mode to
-- 
1.7.5.4

