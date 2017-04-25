From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] mmc: cavium: Use module_pci_driver to simplify the code
Date: Tue, 25 Apr 2017 03:14:09 +0000
Message-ID: <20170425031409.9822-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34719 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S980207AbdDYDOO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Apr 2017 23:14:14 -0400
Received: by mail-pg0-f67.google.com with SMTP id t7so4431203pgt.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 Apr 2017 20:14:14 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>, David Daney <david.daney@cavium.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-mmc@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Use the module_pci_driver() macro to make the code simpler
by eliminating module_init and module_exit calls.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/mmc/host/cavium-thunderx.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
index 65244e8..fe3d772 100644
--- a/drivers/mmc/host/cavium-thunderx.c
+++ b/drivers/mmc/host/cavium-thunderx.c
@@ -179,18 +179,7 @@ static struct pci_driver thunder_mmc_driver = {
 	.remove = thunder_mmc_remove,
 };
 
-static int __init thunder_mmc_init_module(void)
-{
-	return pci_register_driver(&thunder_mmc_driver);
-}
-
-static void __exit thunder_mmc_exit_module(void)
-{
-	pci_unregister_driver(&thunder_mmc_driver);
-}
-
-module_init(thunder_mmc_init_module);
-module_exit(thunder_mmc_exit_module);
+module_pci_driver(thunder_mmc_driver);
 
 MODULE_AUTHOR("Cavium Inc.");
 MODULE_DESCRIPTION("Cavium ThunderX eMMC Driver");



