From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] mmc: host: fix memory leak in mmc_add_host
Date: Mon, 11 Apr 2011 06:11:29 +0200
Message-ID: <1302495089-23699-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41407 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab1DKELc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 00:11:32 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, linus.walleij@linaro.org, Wolfram Sang <w.sang@pengutronix.de>

led_trigger_register_simple() allocates memory which must not be leaked
in the error-path of mmc_add_host. Move it past the only error-check in
the function.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---

I don't see any reason why it needs to be called before device_add.

 drivers/mmc/core/host.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 461e6a1..b29d3e8 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -325,12 +325,12 @@ int mmc_add_host(struct mmc_host *host)
 	WARN_ON((host->caps & MMC_CAP_SDIO_IRQ) &&
 		!host->ops->enable_sdio_irq);
 
-	led_trigger_register_simple(dev_name(&host->class_dev), &host->led);
-
 	err = device_add(&host->class_dev);
 	if (err)
 		return err;
 
+	led_trigger_register_simple(dev_name(&host->class_dev), &host->led);
+
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_host_debugfs(host);
 #endif
-- 
1.7.2.5

