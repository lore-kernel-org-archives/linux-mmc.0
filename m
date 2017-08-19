From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] mmc: cavium-octeon: Convert to use module_platform_driver
Date: Sat, 19 Aug 2017 21:06:11 +0800
Message-ID: <20170819130611.3335-1-axel.lin@ingics.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36980 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdHSNGp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Aug 2017 09:06:45 -0400
Received: by mail-pg0-f67.google.com with SMTP id 83so18359919pgb.4
        for <linux-mmc@vger.kernel.org>; Sat, 19 Aug 2017 06:06:45 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jan Glauber <jglauber@cavium.com>, David Daney <david.daney@cavium.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, linux-mmc@vger.kernel.org, Axel Lin <axel.lin@ingics.com>

Get rid of boilerplate code by using module_platform_driver macro.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mmc/host/cavium-octeon.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
index 951d2cd..22aded1 100644
--- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -342,18 +342,7 @@ static struct platform_driver octeon_mmc_driver = {
 	},
 };
 
-static int __init octeon_mmc_init(void)
-{
-	return platform_driver_register(&octeon_mmc_driver);
-}
-
-static void __exit octeon_mmc_cleanup(void)
-{
-	platform_driver_unregister(&octeon_mmc_driver);
-}
-
-module_init(octeon_mmc_init);
-module_exit(octeon_mmc_cleanup);
+module_platform_driver(octeon_mmc_driver);
 
 MODULE_AUTHOR("Cavium Inc. <support@cavium.com>");
 MODULE_DESCRIPTION("Low-level driver for Cavium OCTEON MMC/SSD card");
-- 
2.9.3

