From: Balaji T K <balajitk@ti.com>
Subject: [PATCH RESEND v11 7/7] mmc: omap_hsmmc: remove pbias workaround
Date: Wed, 19 Feb 2014 20:26:41 +0530
Message-ID: <1392821801-29673-8-git-send-email-balajitk@ti.com>
References: <1389627375-9107-1-git-send-email-balajitk@ti.com>
 <1392821801-29673-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56914 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753734AbaBSO5X (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Feb 2014 09:57:23 -0500
In-Reply-To: <1392821801-29673-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, chris@printf.net, tony@atomide.com
Cc: broonie@kernel.org, Balaji T K <balajitk@ti.com>

remove pbias workaround

Signed-off-by: Balaji T K <balajitk@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |   20 +-------------------
 1 files changed, 1 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2287bda..014bfe5 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -170,7 +170,6 @@ struct omap_hsmmc_host {
 	struct	regulator	*vcc_aux;
 	struct	regulator	*pbias;
 	bool			pbias_enabled;
-	int			pbias_disable;
 	void	__iomem		*base;
 	resource_size_t		mapbase;
 	spinlock_t		irq_lock; /* Prevent races with irq handler */
@@ -267,13 +266,6 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 	 */
 	if (!host->vcc)
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
@@ -1539,13 +1531,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
@@ -1878,10 +1864,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_context_save(host);
 
-	/* This can be removed once we support PBIAS with DT */
-	if (host->dev->of_node && res->start == 0x4809c000)
-		host->pbias_disable = 1;
-
 	host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
 	/*
 	 * MMC can still work without debounce clock.
-- 
1.7.5.4

