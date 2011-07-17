From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH] mmc: fix runtime PM with -ENOSYS suspend case
Date: Sun, 17 Jul 2011 16:38:21 +0100 (BST)
Message-ID: <20110717153821.695FC9D401C@zog.reactivated.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:45847 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753796Ab1GQQSF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Jul 2011 12:18:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, ohad@wizery.com

From: Ohad Ben-Cohen <ohad@wizery.com>

In the case where a driver returns -ENOSYS from its suspend handler
to indicate that the device should be powered down over suspend, the
remove routine of the driver was not being called, leading to lots of
confusion during resume.

The problem is that runtime PM is disabled during this process,
and when we reach mmc_sdio_remove, calling the runtime PM functions here
(validly) return errors, and this was causing us to skip the remove
function.

Fix this by ignoring the error value of pm_runtime_get_sync(), which
can return valid errors. This also matches the behaviour of
pci_device_remove().

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/mmc/core/sdio_bus.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

For linux-3.1.

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index d2565df..e4e6822 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -167,11 +167,8 @@ static int sdio_bus_remove(struct device *dev)
 	int ret = 0;
 
 	/* Make sure card is powered before invoking ->remove() */
-	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD) {
-		ret = pm_runtime_get_sync(dev);
-		if (ret < 0)
-			goto out;
-	}
+	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
+		pm_runtime_get_sync(dev);
 
 	drv->remove(func);
 
@@ -191,7 +188,6 @@ static int sdio_bus_remove(struct device *dev)
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_sync(dev);
 
-out:
 	return ret;
 }
 
-- 
1.7.6

