From: Stefan Roese <sr@denx.de>
Subject: [PATCH] mmc: omap_hsmmc: Add small delay after enabling power
Date: Thu, 11 Sep 2014 16:11:05 +0200
Message-ID: <1410444665-24492-1-git-send-email-sr@denx.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Thorsten Einsbein <thorsten.eisbein@head-acoustics.de>, Ulf Hansson <ulf.hansson@linaro.org>, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Thorsten Einsbein <thorsten.eisbein@head-acoustics.de>

On the TAO3530 (OMAP3530 based) we noticed that some SD cards are not
detected reliably upon bootup (timeout). Especially the SanDisk Ultra
8GiB seems to be problematic here. The SanDisk Extreme also has this
problem on this platform, but not that often. A Samsung 8 GiB type 6
doesn't show this problem at all.

This patch now adds a short delay after enabling the power on the slot.
With this delay all cards are detected reliably.

Signed-off-by: Thorsten Einsbein <thorsten.eisbein@head-acoustics.de>
Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9656726..62ff0a7 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -335,6 +335,10 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 				ret = mmc_regulator_set_ocr(host->mmc,
 							host->vcc, 0);
 		}
+
+		dev_dbg(host->dev, "omap_hsmmc_set_power: wait a little (slot %d)\n",
+			slot);
+		msleep(5);
 	} else {
 		/* Shut down the rail */
 		if (host->vcc_aux)
-- 
2.1.0

