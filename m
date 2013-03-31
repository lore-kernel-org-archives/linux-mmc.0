From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 2/5] mmc: mxcmmc: use slot-gpio API for write-protect detection
Date: Mon,  1 Apr 2013 00:23:02 +0200
Message-ID: <1364768585-5177-3-git-send-email-agust@denx.de>
References: <1364768585-5177-1-git-send-email-agust@denx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:43888 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755741Ab3CaWXU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 31 Mar 2013 18:23:20 -0400
In-Reply-To: <1364768585-5177-1-git-send-email-agust@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>

slot-gpio API suppors read-only detection when "wp-gpios"
property is present in the device tree mmc node. Use this
API for write-protect detection.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
v2:
 - no changes

 drivers/mmc/host/mxcmmc.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 07a37d8..7fe93dd 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -38,6 +38,7 @@
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/of_gpio.h>
+#include <linux/mmc/slot-gpio.h>
 
 #include <asm/dma.h>
 #include <asm/irq.h>
@@ -901,10 +902,11 @@ static int mxcmci_get_ro(struct mmc_host *mmc)
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

