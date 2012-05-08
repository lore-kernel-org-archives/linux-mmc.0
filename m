From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 3/3] mmc: omap: convert to module_platform_driver
Date: Tue, 8 May 2012 17:05:35 +0530
Message-ID: <1336476935-16564-4-git-send-email-svenkatr@ti.com>
References: <1336476935-16564-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44640 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753624Ab2EHLaH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 May 2012 07:30:07 -0400
In-Reply-To: <1336476935-16564-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Venkatraman S <svenkatr@ti.com>

Get rid of boilerplate code by using module_platform_driver macro,
no functional changes.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 0056bd8..552196c 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1614,19 +1614,7 @@ static struct platform_driver mmc_omap_driver = {
 	},
 };
 
-static int __init mmc_omap_init(void)
-{
-	return platform_driver_register(&mmc_omap_driver);
-}
-
-static void __exit mmc_omap_exit(void)
-{
-	platform_driver_unregister(&mmc_omap_driver);
-}
-
-module_init(mmc_omap_init);
-module_exit(mmc_omap_exit);
-
+module_platform_driver(mmc_omap_driver);
 MODULE_DESCRIPTION("OMAP Multimedia Card driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
1.7.5.4

