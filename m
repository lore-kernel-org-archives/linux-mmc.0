From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 1/3] mmc: omap_hsmmc: Fix the DT pbias workaround for MMC controllers 2 to 5
Date: Fri, 10 May 2013 17:42:33 +0530
Message-ID: <1368187955-13069-2-git-send-email-balajitk@ti.com>
References: <1368187955-13069-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1368187955-13069-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

Otherwise SDIO cards won't necessarily work when booted with
device tree as we will never power down the SDIO cards. This
means the SDIO card reset does not happen which at least some
WLAN controllers expect to happen with ifconfig wlan0 down.

The PBIAS voltage is only available for the first controller
instance, so let's limit the PBIAS workaround to the first
controller only.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Tested-by: Luciano Coelho <coelho@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 6e44025..29a63d2 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -161,6 +161,7 @@ struct omap_hsmmc_host {
 	 */
 	struct	regulator	*vcc;
 	struct	regulator	*vcc_aux;
+	int			pbias_disable;
 	void	__iomem		*base;
 	resource_size_t		mapbase;
 	spinlock_t		irq_lock; /* Prevent races with irq handler */
@@ -255,11 +256,11 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 	if (!host->vcc)
 		return 0;
 	/*
-	 * With DT, never turn OFF the regulator. This is because
+	 * With DT, never turn OFF the regulator for MMC1. This is because
 	 * the pbias cell programming support is still missing when
 	 * booting with Device tree
 	 */
-	if (dev->of_node && !vdd)
+	if (host->pbias_disable && !vdd)
 		return 0;
 
 	if (mmc_slot(host).before_set_reg)
@@ -1520,10 +1521,10 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			(ios->vdd == DUAL_VOLT_OCR_BIT) &&
 			/*
 			 * With pbias cell programming missing, this
-			 * can't be allowed when booting with device
+			 * can't be allowed on MMC1 when booting with device
 			 * tree.
 			 */
-			!host->dev->of_node) {
+			!host->pbias_disable) {
 				/*
 				 * The mmc_select_voltage fn of the core does
 				 * not seem to set the power_mode to
@@ -1871,6 +1872,10 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_context_save(host);
 
+	/* This can be removed once we support PBIAS with DT */
+	if (host->dev->of_node && host->mapbase == 0x4809c000)
+		host->pbias_disable = 1;
+
 	host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
 	/*
 	 * MMC can still work without debounce clock.
-- 
1.7.5.4

