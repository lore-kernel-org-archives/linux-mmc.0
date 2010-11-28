From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 3/3] mmc: sdio: don't power up cards on system suspend
Date: Sun, 28 Nov 2010 07:21:30 +0200
Message-ID: <1290921690-6133-4-git-send-email-ohad@wizery.com>
References: <1290921690-6133-1-git-send-email-ohad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57371 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab0K1FTs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Nov 2010 00:19:48 -0500
Received: by mail-fx0-f46.google.com with SMTP id 15so1617040fxm.19
        for <linux-mmc@vger.kernel.org>; Sat, 27 Nov 2010 21:19:47 -0800 (PST)
In-Reply-To: <1290921690-6133-1-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

Initial SDIO runtime PM implementation took a conservative approach
of powering up cards (and fully reinitializing them) on system suspend,
just before the suspend handlers of the relevant drivers were executed.

To avoid redundant power and reinitialization cycles, this patch removes
this behavior: if a card is already powered off when system suspend kicks
in, it is left at that state.

If a card is active when a system sleep starts, everything is
straightforward and works exactly like before. But if the card was
already suspended before the sleep began, then when MMC core power it up
back on resume, its run-time PM status has to be updated to reflect the
actual post-system sleep status.

The technique to do that is borrowed from the I2C runtime PM
implementation (for more info also see Documentation/power/runtime_pm.txt).

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/core/core.c     |   13 +++++++++++++
 drivers/mmc/core/sdio_bus.c |   32 --------------------------------
 2 files changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index e8332d7..2e29faf 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -22,6 +22,7 @@
 #include <linux/scatterlist.h>
 #include <linux/log2.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -1785,6 +1786,18 @@ int mmc_resume_host(struct mmc_host *host)
 		if (!(host->pm_flags & MMC_PM_KEEP_POWER)) {
 			mmc_power_up(host);
 			mmc_select_voltage(host, host->ocr);
+			/*
+			 * Tell runtime PM core we just powered up the card,
+			 * since it still believes the card is powered off.
+			 * Note that currently runtime PM is only enabled
+			 * for SDIO cards that are MMC_CAP_POWER_OFF_CARD
+			 */
+			if (mmc_card_sdio(host->card) &&
+				(host->caps & MMC_CAP_POWER_OFF_CARD)) {
+				pm_runtime_disable(&host->card->dev);
+				pm_runtime_set_active(&host->card->dev);
+				pm_runtime_enable(&host->card->dev);
+			}
 		}
 		BUG_ON(!host->bus_ops->resume);
 		err = host->bus_ops->resume(host);
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 203da44..d29b9c3 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -197,44 +197,12 @@ out:
 
 #ifdef CONFIG_PM_RUNTIME
 
-static int sdio_bus_pm_prepare(struct device *dev)
-{
-	struct sdio_func *func = dev_to_sdio_func(dev);
-
-	/*
-	 * Resume an SDIO device which was suspended at run time at this
-	 * point, in order to allow standard SDIO suspend/resume paths
-	 * to keep working as usual.
-	 *
-	 * Ultimately, the SDIO driver itself will decide (in its
-	 * suspend handler, or lack thereof) whether the card should be
-	 * removed or kept, and if kept, at what power state.
-	 *
-	 * At this point, PM core have increased our use count, so it's
-	 * safe to directly resume the device. After system is resumed
-	 * again, PM core will drop back its runtime PM use count, and if
-	 * needed device will be suspended again.
-	 *
-	 * The end result is guaranteed to be a power state that is
-	 * coherent with the device's runtime PM use count.
-	 *
-	 * The return value of pm_runtime_resume is deliberately unchecked
-	 * since there is little point in failing system suspend if a
-	 * device can't be resumed.
-	 */
-	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
-		pm_runtime_resume(dev);
-
-	return 0;
-}
-
 static const struct dev_pm_ops sdio_bus_pm_ops = {
 	SET_RUNTIME_PM_OPS(
 		pm_generic_runtime_suspend,
 		pm_generic_runtime_resume,
 		pm_generic_runtime_idle
 	)
-	.prepare = sdio_bus_pm_prepare,
 };
 
 #define SDIO_PM_OPS_PTR	(&sdio_bus_pm_ops)
-- 
1.7.0.4

