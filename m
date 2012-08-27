From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH] mmc: via-sdmmc: Use module_pci_driver
Date: Mon, 27 Aug 2012 12:12:11 +0530
Message-ID: <1346049731-21085-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37264 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386Ab2H0Gof (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Aug 2012 02:44:35 -0400
Received: by pbbrr13 with SMTP id rr13so6891499pbb.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Aug 2012 23:44:35 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, brucechang@via.com.tw, HaraldWelte@viatech.com, sachin.kamat@linaro.org, patches@linaro.org

module_pci_driver makes the code simpler by eliminating
module_init and module_exit calls.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/via-sdmmc.c |   16 +---------------
 1 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index 4b83c43..f18bece 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1337,21 +1337,7 @@ static struct pci_driver via_sd_driver = {
 	.resume = via_sd_resume,
 };
 
-static int __init via_sd_drv_init(void)
-{
-	pr_info(DRV_NAME ": VIA SD/MMC Card Reader driver "
-		"(C) 2008 VIA Technologies, Inc.\n");
-
-	return pci_register_driver(&via_sd_driver);
-}
-
-static void __exit via_sd_drv_exit(void)
-{
-	pci_unregister_driver(&via_sd_driver);
-}
-
-module_init(via_sd_drv_init);
-module_exit(via_sd_drv_exit);
+module_pci_driver(via_sd_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("VIA Technologies Inc.");
-- 
1.7.4.1

