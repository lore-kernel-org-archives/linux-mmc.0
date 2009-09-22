From: akpm@linux-foundation.org
Subject: [patch 093/232] mmc: make SDIO device/driver struct accessors public
Date: Tue, 22 Sep 2009 16:45:30 -0700
Message-ID: <200909222345.n8MNjUZt014478@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45806 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751556AbZIVXp7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 19:45:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, nico@fluxnic.net, linux-mmc@vger.kernel.org, nico@marvell.com

From: Nicolas Pitre <nico@fluxnic.net>

Especially with the PM framework, those are quite handy to have in driver
code too.

Signed-off-by: Nicolas Pitre <nico@marvell.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/core/sdio_bus.c   |    3 ---
 include/linux/mmc/sdio_func.h |    3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/mmc/core/sdio_bus.c~mmc-make-sdio-device-driver-struct-accessors-public drivers/mmc/core/sdio_bus.c
--- a/drivers/mmc/core/sdio_bus.c~mmc-make-sdio-device-driver-struct-accessors-public
+++ a/drivers/mmc/core/sdio_bus.c
@@ -20,9 +20,6 @@
 #include "sdio_cis.h"
 #include "sdio_bus.h"
 
-#define dev_to_sdio_func(d)	container_of(d, struct sdio_func, dev)
-#define to_sdio_driver(d)      container_of(d, struct sdio_driver, drv)
-
 /* show configuration fields */
 #define sdio_config_attr(field, format_string)				\
 static ssize_t								\
diff -puN include/linux/mmc/sdio_func.h~mmc-make-sdio-device-driver-struct-accessors-public include/linux/mmc/sdio_func.h
--- a/include/linux/mmc/sdio_func.h~mmc-make-sdio-device-driver-struct-accessors-public
+++ a/include/linux/mmc/sdio_func.h
@@ -67,6 +67,7 @@ struct sdio_func {
 
 #define sdio_get_drvdata(f)	dev_get_drvdata(&(f)->dev)
 #define sdio_set_drvdata(f,d)	dev_set_drvdata(&(f)->dev, d)
+#define dev_to_sdio_func(d)	container_of(d, struct sdio_func, dev)
 
 /*
  * SDIO function device driver
@@ -81,6 +82,8 @@ struct sdio_driver {
 	struct device_driver drv;
 };
 
+#define to_sdio_driver(d)	container_of(d, struct sdio_driver, drv)
+
 /**
  * SDIO_DEVICE - macro used to describe a specific SDIO device
  * @vend: the 16 bit manufacturer code
_
