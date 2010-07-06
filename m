From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 09/15] wireless: wl12xx: support pdata SDIO handlers
Date: Tue,  6 Jul 2010 03:37:40 +0300
Message-ID: <1278376666-3509-10-git-send-email-ohad@wizery.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1278376666-3509-1-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Chikkature Rajashekar Madhusudhan <madhu.cr-l0cyMroinI0@public.gmane.org>, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Ohad Ben-Cohen <ohadb-l0cyMroinI0@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Ohad Ben-Cohen <ohadb-l0cyMroinI0@public.gmane.org>

Make it possible for board code to send SDIO handlers to
the wl12xx driver.

These SDIO handlers are needed to allow software to trigger
card detect events for hard-wired SDIO devices such as the
wl1271 device.

Signed-off-by: Ohad Ben-Cohen <ohadb-l0cyMroinI0@public.gmane.org>
---
 drivers/net/wireless/wl12xx/wl1271.h |    4 ++++
 include/linux/wl12xx.h               |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/net/wireless/wl12xx/wl1271.h b/drivers/net/wireless/wl12xx/wl1271.h
index 6f1b6b5..fc4d122 100644
--- a/drivers/net/wireless/wl12xx/wl1271.h
+++ b/drivers/net/wireless/wl12xx/wl1271.h
@@ -356,6 +356,10 @@ struct wl1271 {
 	struct wl1271_if_operations *if_ops;
 
 	void (*set_power)(bool enable);
+	/* SDIO card detect emulation */
+	void (*set_carddetect)(bool card_present);
+	void (*set_embedded_data)(void *priv);
+
 	int irq;
 
 	spinlock_t wl_lock;
diff --git a/include/linux/wl12xx.h b/include/linux/wl12xx.h
index 137ac89..4106184 100644
--- a/include/linux/wl12xx.h
+++ b/include/linux/wl12xx.h
@@ -26,6 +26,8 @@
 
 struct wl12xx_platform_data {
 	void (*set_power)(bool enable);
+	void (*set_carddetect)(bool card_present);
+	void (*set_embedded_data)(void *priv);
 	/* SDIO only: IRQ number if WLAN_IRQ line is used, 0 for SDIO IRQs */
 	int irq;
 	bool use_eeprom;
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
