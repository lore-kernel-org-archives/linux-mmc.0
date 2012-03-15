From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH RESEND 7/8] mmc: host: omap_hsmmc: convert to module_platform_driver
Date: Thu, 15 Mar 2012 20:03:41 +0530
Message-ID: <1331822022-26714-8-git-send-email-svenkatr@ti.com>
References: <y>
 <1331822022-26714-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53693 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761337Ab2COOe4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 10:34:56 -0400
In-Reply-To: <1331822022-26714-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, balbi@ti.com

From: Felipe Balbi <balbi@ti.com>

this will delete some boilerplate code, no functional
changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 67cb63e..4476b26 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2200,21 +2200,7 @@ static struct platform_driver omap_hsmmc_driver = {
 	},
 };
 
-static int __init omap_hsmmc_init(void)
-{
-	/* Register the MMC driver */
-	return platform_driver_register(&omap_hsmmc_driver);
-}
-
-static void __exit omap_hsmmc_cleanup(void)
-{
-	/* Unregister MMC driver */
-	platform_driver_unregister(&omap_hsmmc_driver);
-}
-
-module_init(omap_hsmmc_init);
-module_exit(omap_hsmmc_cleanup);
-
+module_platform_driver(omap_hsmmc_driver);
 MODULE_DESCRIPTION("OMAP High Speed Multimedia Card driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
1.7.10.rc0.41.gfa678

