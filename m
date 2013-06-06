From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 07/10] mmc: omap_hsmmc: remove dt pbias workaround
Date: Fri, 7 Jun 2013 00:44:16 +0530
Message-ID: <1370546059-24181-8-git-send-email-balajitk@ti.com>
References: <20130523184045.GD13507@atomide.com>
 <1370546059-24181-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43632 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752756Ab3FFTOx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 6 Jun 2013 15:14:53 -0400
In-Reply-To: <1370546059-24181-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org
Cc: Balaji T K <balajitk@ti.com>

With pbias support in place remove dt workaround for pbias

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   20 +-------------------
 1 files changed, 1 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 8dd1cd3..f2e3d1a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -161,7 +161,6 @@ struct omap_hsmmc_host {
 	 */
 	struct	regulator	*vcc;
 	struct	regulator	*vcc_aux;
-	int			pbias_disable;
 	void	__iomem		*base;
 	resource_size_t		mapbase;
 	spinlock_t		irq_lock; /* Prevent races with irq handler */
@@ -259,13 +258,6 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 	 */
 	if (!host->vcc && !host->vcc_aux)
 		return 0;
-	/*
-	 * With DT, never turn OFF the regulator for MMC1. This is because
-	 * the pbias cell programming support is still missing when
-	 * booting with Device tree
-	 */
-	if (host->pbias_disable && !vdd)
-		return 0;
 
 	if (mmc_slot(host).before_set_reg)
 		mmc_slot(host).before_set_reg(dev, slot, power_on, vdd);
@@ -1552,13 +1544,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		 * of external transceiver; but they all handle 1.8V.
 		 */
 		if ((OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET) &&
-			(ios->vdd == DUAL_VOLT_OCR_BIT) &&
-			/*
-			 * With pbias cell programming missing, this
-			 * can't be allowed on MMC1 when booting with device
-			 * tree.
-			 */
-			!host->pbias_disable) {
+			(ios->vdd == DUAL_VOLT_OCR_BIT)) {
 				/*
 				 * The mmc_select_voltage fn of the core does
 				 * not seem to set the power_mode to
@@ -1956,10 +1942,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_context_save(host);
 
-	/* This can be removed once we support PBIAS with DT */
-	if (host->dev->of_node && host->mapbase == 0x4809c000)
-		host->pbias_disable = 1;
-
 	host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
 	/*
 	 * MMC can still work without debounce clock.
-- 
1.7.5.4

