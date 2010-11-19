From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH] sdio: fix runtime PM anomalies by introducing MMC_CAP_POWER_OFF_CARD
Date: Fri, 19 Nov 2010 09:29:09 +0200
Message-ID: <1290151749-21308-1-git-send-email-ohad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44758 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab0KSH22 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Nov 2010 02:28:28 -0500
Received: by fxm13 with SMTP id 13so416486fxm.19
        for <linux-mmc@vger.kernel.org>; Thu, 18 Nov 2010 23:28:27 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Daniel Drake <dsd@laptop.org>, Arnd Hannemann <arnd@arndnet.de>, Ohad Ben-Cohen <ohad@wizery.com>

Some board/card/host configurations are not capable of powering off the
card after boot.

To support such configurations, and to allow smoother transition to
runtime PM behavior, MMC_CAP_POWER_OFF_CARD is added, so hosts need to
explicitly indicate whether it's OK to power off their cards after boot.

SDIO core will enable runtime PM for a card only if that cap is set.
As a result, the card will be powered down after boot, and will only
be powered up again when a driver is loaded (and then it's up to the
driver to decide whether power will be kept or not).

This will prevent sdio_bus_probe() failures with setups that do not
support powering off the card.

Reported-and-tested-by: Daniel Drake <dsd@laptop.org>
Reported-and-tested-by: Arnd Hannemann <arnd@arndnet.de>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
This is a second fix intended to 2.6.37 (first one is at https://patchwork.kernel.org/patch/323182/). It depends on the first one and cannot be applied independently.

 drivers/mmc/core/sdio.c     |   37 +++++++++++++++++++++++--------------
 drivers/mmc/core/sdio_bus.c |   33 ++++++++++++++++++++++-----------
 include/linux/mmc/host.h    |    1 +
 3 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 42a949b..efef5f9 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -547,9 +547,11 @@ static void mmc_sdio_detect(struct mmc_host *host)
 	BUG_ON(!host->card);
 
 	/* Make sure card is powered before detecting it */
-	err = pm_runtime_get_sync(&host->card->dev);
-	if (err < 0)
-		goto out;
+	if (host->caps & MMC_CAP_POWER_OFF_CARD) {
+		err = pm_runtime_get_sync(&host->card->dev);
+		if (err < 0)
+			goto out;
+	}
 
 	mmc_claim_host(host);
 
@@ -571,7 +573,8 @@ static void mmc_sdio_detect(struct mmc_host *host)
 	 * is about to show up at this point, the _sync variant is
 	 * desirable anyway.
 	 */
-	pm_runtime_put_sync(&host->card->dev);
+	if (host->caps & MMC_CAP_POWER_OFF_CARD)
+		pm_runtime_put_sync(&host->card->dev);
 
 out:
 	if (err) {
@@ -728,16 +731,21 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
 	card = host->card;
 
 	/*
-	 * Let runtime PM core know our card is active
+	 * Enable runtime PM only if supported by host+card+board
 	 */
-	err = pm_runtime_set_active(&card->dev);
-	if (err)
-		goto remove;
+	if (host->caps & MMC_CAP_POWER_OFF_CARD) {
+		/*
+		 * Let runtime PM core know our card is active
+		 */
+		err = pm_runtime_set_active(&card->dev);
+		if (err)
+			goto remove;
 
-	/*
-	 * Enable runtime PM for this card
-	 */
-	pm_runtime_enable(&card->dev);
+		/*
+		 * Enable runtime PM for this card
+		 */
+		pm_runtime_enable(&card->dev);
+	}
 
 	/*
 	 * The number of functions on the card is encoded inside
@@ -755,9 +763,10 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
 			goto remove;
 
 		/*
-		 * Enable Runtime PM for this func
+		 * Enable Runtime PM for this func (if supported)
 		 */
-		pm_runtime_enable(&card->sdio_func[i]->dev);
+		if (host->caps & MMC_CAP_POWER_OFF_CARD)
+			pm_runtime_enable(&card->sdio_func[i]->dev);
 	}
 
 	mmc_release_host(host);
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 2716c7a..203da44 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -17,6 +17,7 @@
 #include <linux/pm_runtime.h>
 
 #include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
 #include <linux/mmc/sdio_func.h>
 
 #include "sdio_cis.h"
@@ -132,9 +133,11 @@ static int sdio_bus_probe(struct device *dev)
 	 * it should call pm_runtime_put_noidle() in its probe routine and
 	 * pm_runtime_get_noresume() in its remove routine.
 	 */
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
-		goto out;
+	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD) {
+		ret = pm_runtime_get_sync(dev);
+		if (ret < 0)
+			goto out;
+	}
 
 	/* Set the default block size so the driver is sure it's something
 	 * sensible. */
@@ -151,7 +154,8 @@ static int sdio_bus_probe(struct device *dev)
 	return 0;
 
 disable_runtimepm:
-	pm_runtime_put_noidle(dev);
+	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
+		pm_runtime_put_noidle(dev);
 out:
 	return ret;
 }
@@ -160,12 +164,14 @@ static int sdio_bus_remove(struct device *dev)
 {
 	struct sdio_driver *drv = to_sdio_driver(dev->driver);
 	struct sdio_func *func = dev_to_sdio_func(dev);
-	int ret;
+	int ret = 0;
 
 	/* Make sure card is powered before invoking ->remove() */
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
-		goto out;
+	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD) {
+		ret = pm_runtime_get_sync(dev);
+		if (ret < 0)
+			goto out;
+	}
 
 	drv->remove(func);
 
@@ -178,10 +184,12 @@ static int sdio_bus_remove(struct device *dev)
 	}
 
 	/* First, undo the increment made directly above */
-	pm_runtime_put_noidle(dev);
+	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
+		pm_runtime_put_noidle(dev);
 
 	/* Then undo the runtime PM settings in sdio_bus_probe() */
-	pm_runtime_put_noidle(dev);
+	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
+		pm_runtime_put_noidle(dev);
 
 out:
 	return ret;
@@ -191,6 +199,8 @@ out:
 
 static int sdio_bus_pm_prepare(struct device *dev)
 {
+	struct sdio_func *func = dev_to_sdio_func(dev);
+
 	/*
 	 * Resume an SDIO device which was suspended at run time at this
 	 * point, in order to allow standard SDIO suspend/resume paths
@@ -212,7 +222,8 @@ static int sdio_bus_pm_prepare(struct device *dev)
 	 * since there is little point in failing system suspend if a
 	 * device can't be resumed.
 	 */
-	pm_runtime_resume(dev);
+	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
+		pm_runtime_resume(dev);
 
 	return 0;
 }
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 53496bb..381c77f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -168,6 +168,7 @@ struct mmc_host {
 						/* DDR mode at 1.8V */
 #define MMC_CAP_1_2V_DDR	(1 << 12)	/* can support */
 						/* DDR mode at 1.2V */
+#define MMC_CAP_POWER_OFF_CARD	(1 << 13)	/* Can power off after boot */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
1.7.0.4

