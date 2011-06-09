From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] mmc: sdio: fix runtime PM path during driver removal
Date: Fri, 10 Jun 2011 02:40:27 +0300
Message-ID: <1307662827-16618-1-git-send-email-ohad@wizery.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

After commit e1866b3 "PM / Runtime: Rework runtime PM handling
during driver removal" was introduced, the driver core stopped
incrementing the runtime PM usage counter of the device during
the invocation of the ->remove() callback.

This indirectly broke SDIO's runtime PM path during driver removal,
because no one calls _put_sync() anymore after ->remove() completes.

This means that the power of runtime-PM-managed SDIO cards is kept
high after their driver is removed (even if it was powered down
beforehand).

Fix that by directly calling _put_sync() when the last usage
counter is downref'ed by the SDIO bus.

Reported-and-tested-by: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Signed-off-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/core/sdio_bus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index d29b9c3..d2565df 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -189,7 +189,7 @@ static int sdio_bus_remove(struct device *dev)
 
 	/* Then undo the runtime PM settings in sdio_bus_probe() */
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
-		pm_runtime_put_noidle(dev);
+		pm_runtime_put_sync(dev);
 
 out:
 	return ret;
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
