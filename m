From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v3 3/5] mmc: mxcmmc: use slot-gpio API for write-protect detection
Date: Mon,  8 Apr 2013 23:28:07 +0200
Message-ID: <1365456489-13152-4-git-send-email-agust@denx.de>
References: <1365456489-13152-1-git-send-email-agust@denx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:54145 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965124Ab3DHV2l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Apr 2013 17:28:41 -0400
In-Reply-To: <1365456489-13152-1-git-send-email-agust@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: devicetree-discuss@lists.ozlabs.org, Sascha Hauer <s.hauer@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, Anatolij Gustschin <agust@denx.de>

slot-gpio API suppors read-only detection when "wp-gpios"
property is present in the device tree mmc node. Use this
API for write-protect detection.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
v3:
 - add Acked-by line

v2:
 - no changes

 drivers/mmc/host/mxcmmc.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 9845b2d..eb45bf0 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -38,6 +38,7 @@
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/of_gpio.h>
+#include <linux/mmc/slot-gpio.h>
 
 #include <asm/dma.h>
 #include <asm/irq.h>
@@ -917,10 +918,11 @@ static int mxcmci_get_ro(struct mmc_host *mmc)
 	if (host->pdata && host->pdata->get_ro)
 		return !!host->pdata->get_ro(mmc_dev(mmc));
 	/*
-	 * Board doesn't support read only detection; let the mmc core
-	 * decide what to do.
+	 * If board doesn't support read only detection (no mmc_gpio
+	 * context or gpio is invalid), then let the mmc core decide
+	 * what to do.
 	 */
-	return -ENOSYS;
+	return mmc_gpio_get_ro(mmc);
 }
 
 static void mxcmci_enable_sdio_irq(struct mmc_host *mmc, int enable)
-- 
1.7.5.4

