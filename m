From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 1/8] wireless: wl1271: make wl12xx.h common to both spi and sdio
Date: Wed, 11 Aug 2010 21:21:46 +0300
Message-ID: <1281550913-17633-2-git-send-email-ohad@wizery.com>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1281550913-17633-1-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chikkature Rajashekar Madhusudhan <madhu.cr-l0cyMroinI0@public.gmane.org>, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Pandita Vikram <vikram.pandita-l0cyMroinI0@public.gmane.org>, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Move wl12xx.h outside of the spi-specific location,
so it can be shared with both spi and sdio solutions.

Signed-off-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
---
 drivers/net/wireless/wl12xx/wl1251_sdio.c |    2 +-
 drivers/net/wireless/wl12xx/wl1251_spi.c  |    2 +-
 drivers/net/wireless/wl12xx/wl1271_spi.c  |    2 +-
 include/linux/spi/wl12xx.h                |   34 -----------------------------
 include/linux/wl12xx.h                    |   34 +++++++++++++++++++++++++++++
 5 files changed, 37 insertions(+), 37 deletions(-)
 delete mode 100644 include/linux/spi/wl12xx.h
 create mode 100644 include/linux/wl12xx.h

diff --git a/drivers/net/wireless/wl12xx/wl1251_sdio.c b/drivers/net/wireless/wl12xx/wl1251_sdio.c
index b901b61..a319df1 100644
--- a/drivers/net/wireless/wl12xx/wl1251_sdio.c
+++ b/drivers/net/wireless/wl12xx/wl1251_sdio.c
@@ -24,7 +24,7 @@
 #include <linux/mmc/sdio_func.h>
 #include <linux/mmc/sdio_ids.h>
 #include <linux/platform_device.h>
-#include <linux/spi/wl12xx.h>
+#include <linux/wl12xx.h>
 #include <linux/irq.h>
 
 #include "wl1251.h"
diff --git a/drivers/net/wireless/wl12xx/wl1251_spi.c b/drivers/net/wireless/wl12xx/wl1251_spi.c
index 27fdfaa..a6faf3e 100644
--- a/drivers/net/wireless/wl12xx/wl1251_spi.c
+++ b/drivers/net/wireless/wl12xx/wl1251_spi.c
@@ -26,7 +26,7 @@
 #include <linux/slab.h>
 #include <linux/crc7.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/wl12xx.h>
+#include <linux/wl12xx.h>
 
 #include "wl1251.h"
 #include "wl1251_reg.h"
diff --git a/drivers/net/wireless/wl12xx/wl1271_spi.c b/drivers/net/wireless/wl12xx/wl1271_spi.c
index 4cb99c5..c3fdab7 100644
--- a/drivers/net/wireless/wl12xx/wl1271_spi.c
+++ b/drivers/net/wireless/wl12xx/wl1271_spi.c
@@ -25,7 +25,7 @@
 #include <linux/module.h>
 #include <linux/crc7.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/wl12xx.h>
+#include <linux/wl12xx.h>
 #include <linux/slab.h>
 
 #include "wl1271.h"
diff --git a/include/linux/spi/wl12xx.h b/include/linux/spi/wl12xx.h
deleted file mode 100644
index a223ecb..0000000
--- a/include/linux/spi/wl12xx.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * This file is part of wl12xx
- *
- * Copyright (C) 2009 Nokia Corporation
- *
- * Contact: Kalle Valo <kalle.valo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#ifndef _LINUX_SPI_WL12XX_H
-#define _LINUX_SPI_WL12XX_H
-
-struct wl12xx_platform_data {
-	void (*set_power)(bool enable);
-	/* SDIO only: IRQ number if WLAN_IRQ line is used, 0 for SDIO IRQs */
-	int irq;
-	bool use_eeprom;
-};
-
-#endif
diff --git a/include/linux/wl12xx.h b/include/linux/wl12xx.h
new file mode 100644
index 0000000..137ac89
--- /dev/null
+++ b/include/linux/wl12xx.h
@@ -0,0 +1,34 @@
+/*
+ * This file is part of wl12xx
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ *
+ * Contact: Kalle Valo <kalle.valo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef _LINUX_WL12XX_H
+#define _LINUX_WL12XX_H
+
+struct wl12xx_platform_data {
+	void (*set_power)(bool enable);
+	/* SDIO only: IRQ number if WLAN_IRQ line is used, 0 for SDIO IRQs */
+	int irq;
+	bool use_eeprom;
+};
+
+#endif
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
