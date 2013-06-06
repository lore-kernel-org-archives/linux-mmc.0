From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 02/10] mmc: omap_hsmmc: make vcc and vcc_aux independent
Date: Fri, 7 Jun 2013 00:44:11 +0530
Message-ID: <1370546059-24181-3-git-send-email-balajitk@ti.com>
References: <20130523184045.GD13507@atomide.com>
 <1370546059-24181-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41237 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab3FFTOt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jun 2013 15:14:49 -0400
In-Reply-To: <1370546059-24181-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org
Cc: Balaji T K <balajitk@ti.com>

handle vcc and vcc_aux independently

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 1865321..bda1a42 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -253,7 +253,7 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 	 * If we don't see a Vcc regulator, assume it's a fixed
 	 * voltage always-on regulator.
 	 */
-	if (!host->vcc)
+	if (!host->vcc && !host->vcc_aux)
 		return 0;
 	/*
 	 * With DT, never turn OFF the regulator for MMC1. This is because
@@ -280,11 +280,12 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 	 * chips/cards need an interface voltage rail too.
 	 */
 	if (power_on) {
-		ret = mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
+		if (host->vcc)
+			ret = mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
 		/* Enable interface voltage rail, if needed */
 		if (ret == 0 && host->vcc_aux) {
 			ret = regulator_enable(host->vcc_aux);
-			if (ret < 0)
+			if (ret < 0 && host->vcc)
 				ret = mmc_regulator_set_ocr(host->mmc,
 							host->vcc, 0);
 		}
@@ -292,7 +293,7 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 		/* Shut down the rail */
 		if (host->vcc_aux)
 			ret = regulator_disable(host->vcc_aux);
-		if (!ret) {
+		if (host->vcc) {
 			/* Then proceed to shut down the local regulator */
 			ret = mmc_regulator_set_ocr(host->mmc,
 						host->vcc, 0);
-- 
1.7.5.4

