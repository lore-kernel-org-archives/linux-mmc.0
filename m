From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH] mmc: sdhci-pci: Use module_pci_driver
Date: Mon, 27 Aug 2012 11:57:02 +0530
Message-ID: <1346048822-18048-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50596 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab2H0G32 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Aug 2012 02:29:28 -0400
Received: by pbbrr13 with SMTP id rr13so6872044pbb.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Aug 2012 23:29:28 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, sachin.kamat@linaro.org, patches@linaro.org

module_pci_driver makes the code simpler by eliminating
module_init and module_exit calls.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/sdhci-pci.c |   19 +------------------
 1 files changed, 1 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 504da71..3f0794e 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1476,24 +1476,7 @@ static struct pci_driver sdhci_driver = {
 	},
 };
 
-/*****************************************************************************\
- *                                                                           *
- * Driver init/exit                                                          *
- *                                                                           *
-\*****************************************************************************/
-
-static int __init sdhci_drv_init(void)
-{
-	return pci_register_driver(&sdhci_driver);
-}
-
-static void __exit sdhci_drv_exit(void)
-{
-	pci_unregister_driver(&sdhci_driver);
-}
-
-module_init(sdhci_drv_init);
-module_exit(sdhci_drv_exit);
+module_pci_driver(sdhci_driver);
 
 MODULE_AUTHOR("Pierre Ossman <pierre@ossman.eu>");
 MODULE_DESCRIPTION("Secure Digital Host Controller Interface PCI driver");
-- 
1.7.4.1

