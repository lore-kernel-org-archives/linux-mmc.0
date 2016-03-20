From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH] mmc: omap_hsmmc: pass omap_hsmmc_host pointer directly
Date: Mon, 21 Mar 2016 00:58:08 +0100
Message-ID: <1458518288-22774-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34007 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbcCTX6Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Mar 2016 19:58:16 -0400
Received: by mail-wm0-f52.google.com with SMTP id p65so133233776wmp.1
        for <linux-mmc@vger.kernel.org>; Sun, 20 Mar 2016 16:58:15 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andreas Fenkart <afenkart@gmail.com>

unnecessary indirection via 'struct device' back to omap_hsmmc_host

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d2b2525..898878d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -357,15 +357,14 @@ static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on,
 	return 0;
 }
 
-static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
+static int omap_hsmmc_set_power(struct omap_hsmmc_host *host, int power_on,
+				int vdd)
 {
-	struct omap_hsmmc_host *host =
-		platform_get_drvdata(to_platform_device(dev));
 	struct mmc_host *mmc = host->mmc;
 	int ret = 0;
 
 	if (mmc_pdata(host)->set_power)
-		return mmc_pdata(host)->set_power(dev, power_on, vdd);
+		return mmc_pdata(host)->set_power(host->dev, power_on, vdd);
 
 	/*
 	 * If we don't see a Vcc regulator, assume it's a fixed
@@ -375,7 +374,7 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 		return 0;
 
 	if (mmc_pdata(host)->before_set_reg)
-		mmc_pdata(host)->before_set_reg(dev, power_on, vdd);
+		mmc_pdata(host)->before_set_reg(host->dev, power_on, vdd);
 
 	ret = omap_hsmmc_set_pbias(host, false, 0);
 	if (ret)
@@ -409,7 +408,7 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 	}
 
 	if (mmc_pdata(host)->after_set_reg)
-		mmc_pdata(host)->after_set_reg(dev, power_on, vdd);
+		mmc_pdata(host)->after_set_reg(host->dev, power_on, vdd);
 
 	return 0;
 
@@ -1278,11 +1277,11 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 		clk_disable_unprepare(host->dbclk);
 
 	/* Turn the power off */
-	ret = omap_hsmmc_set_power(host->dev, 0, 0);
+	ret = omap_hsmmc_set_power(host, 0, 0);
 
 	/* Turn the power ON with given VDD 1.8 or 3.0v */
 	if (!ret)
-		ret = omap_hsmmc_set_power(host->dev, 1, vdd);
+		ret = omap_hsmmc_set_power(host, 1, vdd);
 	pm_runtime_get_sync(host->dev);
 	if (host->dbclk)
 		clk_prepare_enable(host->dbclk);
@@ -1722,10 +1721,10 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->power_mode != host->power_mode) {
 		switch (ios->power_mode) {
 		case MMC_POWER_OFF:
-			omap_hsmmc_set_power(host->dev, 0, 0);
+			omap_hsmmc_set_power(host, 0, 0);
 			break;
 		case MMC_POWER_UP:
-			omap_hsmmc_set_power(host->dev, 1, ios->vdd);
+			omap_hsmmc_set_power(host, 1, ios->vdd);
 			break;
 		case MMC_POWER_ON:
 			do_send_init_stream = 1;
-- 
2.7.0

