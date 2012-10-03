From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/2] mmc: dw_mmc: use helper macro module_platform_driver()
Date: Wed,  3 Oct 2012 16:26:37 +0300
Message-ID: <1349270797-19189-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1349270797-19189-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:42591 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755132Ab2JCN0o (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 3 Oct 2012 09:26:44 -0400
In-Reply-To: <1349270797-19189-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Since v3.2 we have nice macro to define the platform driver's init and exit
calls. This patch simplifies the dw_mmc platform driver by using that macro.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/dw_mmc-pltfm.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 777c585..779335b 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -119,6 +119,7 @@ static const struct of_device_id dw_mci_pltfm_match[] = {
 MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
 
 static struct platform_driver dw_mci_pltfm_driver = {
+	.probe		= dw_mci_pltfm_probe,
 	.remove		= __devexit_p(dw_mci_pltfm_remove),
 	.driver		= {
 		.name		= "dw_mmc",
@@ -127,18 +128,7 @@ static struct platform_driver dw_mci_pltfm_driver = {
 	},
 };
 
-static int __init dw_mci_init(void)
-{
-	return platform_driver_probe(&dw_mci_pltfm_driver, dw_mci_pltfm_probe);
-}
-
-static void __exit dw_mci_exit(void)
-{
-	platform_driver_unregister(&dw_mci_pltfm_driver);
-}
-
-module_init(dw_mci_init);
-module_exit(dw_mci_exit);
+module_platform_driver(dw_mci_pltfm_driver);
 
 MODULE_DESCRIPTION("DW Multimedia Card Interface driver");
 MODULE_AUTHOR("NXP Semiconductor VietNam");
-- 
1.7.10.4

