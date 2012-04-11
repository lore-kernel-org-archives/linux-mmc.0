From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] mmc: omap_hsmmc: Get rid of of_have_populated_dt() usage
Date: Wed, 11 Apr 2012 15:33:13 +0530
Message-ID: <1334138593-9692-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57018 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754868Ab2DKKEB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Apr 2012 06:04:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>, Balaji TK <balajitk@ti.com>, Rob Herring <rob.herring@calxeda.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

of_have_populated_dt() is not expected to be used in drivers but
instead only in early platform init code.
Drivers on the other hand should rely on dev->of_node or of_match_device().
Besides usage of of_have_populated_dt() also throws up build error as below
which was reported by Balaji TK, when omap_hsmmc is built as a module.

ERROR: "allnodes" [drivers/mmc/host/omap_hsmmc.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

So get rid of all of_have_populated_dt() usage in omap_hsmmc driver and
instead use dev->of_node to make the same dicisions as earlier.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Reported-by: Benoit Cousson <b-cousson@ti.com>
Cc: Balaji TK <balajitk@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index ecc9521..4254b6f 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -252,7 +252,7 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 	 * the pbias cell programming support is still missing when
 	 * booting with Device tree
 	 */
-	if (of_have_populated_dt() && !vdd)
+	if (dev->of_node && !vdd)
 		return 0;
 
 	if (mmc_slot(host).before_set_reg)
@@ -1564,7 +1564,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			 * can't be allowed when booting with device
 			 * tree.
 			 */
-			(!of_have_populated_dt())) {
+			!host->dev->of_node) {
 				/*
 				 * The mmc_select_voltage fn of the core does
 				 * not seem to set the power_mode to
-- 
1.7.1

