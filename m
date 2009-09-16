From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 3/3] [MMC] make SDIO device/driver struct accessors public
Date: Tue, 15 Sep 2009 23:51:49 -0400
Message-ID: <1253073109-13849-4-git-send-email-nico@fluxnic.net>
References: <1253073109-13849-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:61396 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755269AbZIPDvu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2009 23:51:50 -0400
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KQ100870PEFU890@VL-MO-MR001.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 15 Sep 2009 23:51:53 -0400 (EDT)
In-reply-to: <1253073109-13849-1-git-send-email-nico@fluxnic.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-mmc@vger.kernel.org

Especially with the PM framework, those are quite handy to have in driver
code too.

Signed-off-by: Nicolas Pitre <nico@marvell.com>
---
 drivers/mmc/core/sdio_bus.c   |    3 ---
 include/linux/mmc/sdio_func.h |    3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 46284b5..d37464e 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -20,9 +20,6 @@
 #include "sdio_cis.h"
 #include "sdio_bus.h"
 
-#define dev_to_sdio_func(d)	container_of(d, struct sdio_func, dev)
-#define to_sdio_driver(d)      container_of(d, struct sdio_driver, drv)
-
 /* show configuration fields */
 #define sdio_config_attr(field, format_string)				\
 static ssize_t								\
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index 451bdfc..ac3ab68 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
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
-- 
1.6.5.rc0.164.g5f6b0

