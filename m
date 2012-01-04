From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 06/11] mfd: tmio: remove now unneeded tmio_mmc_cd_wakeup()
Date: Wed,  4 Jan 2012 15:17:11 +0100
Message-ID: <1325686636-23905-7-git-send-email-g.liakhovetski@gmx.de>
References: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

Now, that all users of tmio_mmc_cd_wakeup() have been converted over to
drivers/mmc/core/cd-gpio.c, that function can be removed.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/mfd/tmio.h |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 4ef9307..08fb7d2 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -4,7 +4,6 @@
 #include <linux/device.h>
 #include <linux/fb.h>
 #include <linux/io.h>
-#include <linux/jiffies.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
@@ -110,16 +109,6 @@ struct tmio_mmc_data {
 };
 
 /*
- * This function is deprecated and will be removed soon. Please, convert your
- * platform to use drivers/mmc/core/cd-gpio.c
- */
-static inline void tmio_mmc_cd_wakeup(struct tmio_mmc_data *pdata)
-{
-	if (pdata)
-		mmc_detect_change(dev_get_drvdata(dev), msecs_to_jiffies(100));
-}
-
-/*
  * data for the NAND controller
  */
 struct tmio_nand_data {
-- 
1.7.2.5

