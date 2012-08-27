From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH] mmc: dw_mmc-pci: Use module_pci_driver
Date: Mon, 27 Aug 2012 11:59:17 +0530
Message-ID: <1346048957-18493-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55281 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab2H0Gbi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Aug 2012 02:31:38 -0400
Received: by pbbrr13 with SMTP id rr13so6874892pbb.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Aug 2012 23:31:38 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, sachin.kamat@linaro.org, patches@linaro.org, shashidharh@vayavyalabs.com

module_pci_driver makes the code simpler by eliminating module_init
and module_exit calls.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/dw_mmc-pci.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index dc0d25a..f5ab03d 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -140,18 +140,7 @@ static struct pci_driver dw_mci_pci_driver = {
 	},
 };
 
-static int __init dw_mci_init(void)
-{
-	return pci_register_driver(&dw_mci_pci_driver);
-}
-
-static void __exit dw_mci_exit(void)
-{
-	pci_unregister_driver(&dw_mci_pci_driver);
-}
-
-module_init(dw_mci_init);
-module_exit(dw_mci_exit);
+module_pci_driver(dw_mci_pci_driver);
 
 MODULE_DESCRIPTION("DW Multimedia Card PCI Interface driver");
 MODULE_AUTHOR("Shashidhar Hiremath <shashidharh@vayavyalabs.com>");
-- 
1.7.4.1

