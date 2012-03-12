From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 2/4] mmc: omap_hsmmc: Avoid a regulator voltage change with dt
Date: Mon, 12 Mar 2012 20:32:38 +0530
Message-ID: <1331564560-23276-3-git-send-email-rnayak@ti.com>
References: <1331564560-23276-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46948 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755716Ab2CLPDY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 Mar 2012 11:03:24 -0400
In-Reply-To: <1331564560-23276-1-git-send-email-rnayak@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robherring2@gmail.com, grant.likely@secretlab.ca, cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, svenkatr@ti.com, linaro-dev@lists.linaro.org, Rajendra Nayak <rnayak@ti.com>

When booting with Device tree, the omap_hsmmc driver does not
program the pbias cell (inside OMAP control module) during
a regulator voltage change.
In case of non-dt boot, this is handled using callbacks
from within platform_data and implemented in machine code.
To be able to do this with device tree, without invoking
any machine code, a OMAP control module driver is needed
which is yet missing.

The pbias cell is used to provide a 1.8v or 3.0v reference
to the mmc/sd/sdio1 interface supporting both 1.8v and 3.0v
voltages.

Until a OMAP control module driver is available to handle this,
when booting with a device tree blob, never change the regulator
voltage which might then require a pbias cell re-program.
There are 2 instances where in the mmc regulator voltage can be
changed.
-1- when the regulator is turned OFF.
-2- when attempting a switch to 1.8v from 3.0v for dual volt cards

This patch avoids a voltage change in both cases when booting from
device tree, and hence compromises on power savings.
Once the OMAP control module driver is available and hsmmc driver
is modified to then do pbias programming even when booting
with device tree, these limitaions can be removed to achieve better
power savings.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 38ae8c0..f29e1a2 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -244,6 +244,13 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 	 */
 	if (!host->vcc)
 		return 0;
+	/*
+	 * With DT, never turn OFF the regulator. This is because
+	 * the pbias cell programming support is still missing when
+	 * booting with Device tree
+	 */
+	if (of_have_populated_dt() && !vdd)
+		return 0;
 
 	if (mmc_slot(host).before_set_reg)
 		mmc_slot(host).before_set_reg(dev, slot, power_on, vdd);
@@ -1516,7 +1523,13 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		 * of external transceiver; but they all handle 1.8V.
 		 */
 		if ((OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET) &&
-			(ios->vdd == DUAL_VOLT_OCR_BIT)) {
+			(ios->vdd == DUAL_VOLT_OCR_BIT) &&
+			/*
+			 * With pbias cell programming missing, this
+			 * can't be allowed when booting with device
+			 * tree.
+			 */
+			(!of_have_populated_dt())) {
 				/*
 				 * The mmc_select_voltage fn of the core does
 				 * not seem to set the power_mode to
-- 
1.7.1

