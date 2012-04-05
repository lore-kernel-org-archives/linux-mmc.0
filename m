From: Jan Luebbe <jlu@pengutronix.de>
Subject: [PATCH] davinci_mmc: set MODULE_ALIAS to allow autoloading
Date: Thu,  5 Apr 2012 10:05:08 +0200
Message-ID: <1333613108-28607-1-git-send-email-jlu@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47180 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254Ab2DEIHM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Apr 2012 04:07:12 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: davinci-linux-open-source@linux.davincidsp.com, Jan Luebbe <jlu@pengutronix.de>

Davinci MMC platform devices (as in mach-davinci/devices-da8xx.c) use
"davinci_mmc" as their name. To allow autoloading of the relevant
driver, the module needs to set the MODULE_ALIAS.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 drivers/mmc/host/davinci_mmc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index c1f3673..7cf6c62 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1533,4 +1533,5 @@ module_exit(davinci_mmcsd_exit);
 MODULE_AUTHOR("Texas Instruments India");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("MMC/SD driver for Davinci MMC controller");
+MODULE_ALIAS("platform:davinci_mmc");
 
