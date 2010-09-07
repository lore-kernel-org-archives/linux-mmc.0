From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v1 8/8] wireless: wl1271_sdio: enable Runtime PM
Date: Tue,  7 Sep 2010 14:29:09 +0300
Message-ID: <1283858949-11073-9-git-send-email-ohad@wizery.com>
References: <1283858949-11073-1-git-send-email-ohad@wizery.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1283858949-11073-1-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Gao Yunpeng <yunpeng.gao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Enable runtime pm for the wl1271 SDIO device.

We request power whenever the WLAN interface is brought up,
and release it after the WLAN interface is taken down.

As a result, power is released immediately after probe returns,
since at that point power has not been explicitly requested yet
(i.e. the WLAN interface is still down).

Signed-off-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
---
 drivers/net/wireless/wl12xx/wl1271_sdio.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/net/wireless/wl12xx/wl1271_sdio.c b/drivers/net/wireless/wl12xx/wl1271_sdio.c
index 824b9e8..235191e 100644
--- a/drivers/net/wireless/wl12xx/wl1271_sdio.c
+++ b/drivers/net/wireless/wl12xx/wl1271_sdio.c
@@ -30,6 +30,7 @@
 #include <linux/mmc/card.h>
 #include <linux/gpio.h>
 #include <linux/wl12xx.h>
+#include <linux/pm_runtime.h>
 
 #include "wl1271.h"
 #include "wl12xx_80211.h"
@@ -153,20 +154,27 @@ static void wl1271_sdio_raw_write(struct wl1271 *wl, int addr, void *buf,
 static int wl1271_sdio_set_power(struct wl1271 *wl, bool enable)
 {
 	struct sdio_func *func = wl_to_func(wl);
+	int err;
 
 	/* Let the SDIO stack handle wlan_enable control, so we
 	 * keep host claimed while wlan is in use to keep wl1271
 	 * alive.
 	 */
 	if (enable) {
+		err = pm_runtime_get_sync(&func->dev);
+		if (err)
+			goto out;
+
 		sdio_claim_host(func);
 		sdio_enable_func(func);
 	} else {
 		sdio_disable_func(func);
 		sdio_release_host(func);
+		err = pm_runtime_put_sync(&func->dev);
 	}
 
-	return 0;
+out:
+	return err;
 }
 
 static struct wl1271_if_operations sdio_ops = {
@@ -233,6 +241,8 @@ static int __devinit wl1271_probe(struct sdio_func *func,
 
 	sdio_set_drvdata(func, wl);
 
+	pm_runtime_put_noidle(&func->dev);
+
 	wl1271_notice("initialized");
 
 	return 0;
@@ -255,6 +265,8 @@ static void __devexit wl1271_remove(struct sdio_func *func)
 
 	wl1271_unregister_hw(wl);
 	wl1271_free_hw(wl);
+
+	pm_runtime_get_noresume(&func->dev);
 }
 
 static struct sdio_driver wl1271_sdio_driver = {
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
