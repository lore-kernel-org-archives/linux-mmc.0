From: weiyj_lk@163.com
Subject: [PATCH -next] mmc: toshsd: use module_pci_driver to simplify the code
Date: Tue,  9 Dec 2014 09:08:05 +0800
Message-ID: <1418087285-14334-1-git-send-email-weiyj_lk@163.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from m12-17.163.com ([220.181.12.17]:50106 "EHLO m12-17.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261AbaLIBI1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 8 Dec 2014 20:08:27 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, Ondrej Zary <linux@rainbow-software.org>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-mmc@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Use the module_pci_driver() macro to make the code simpler
by eliminating module_init and module_exit calls.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/mmc/host/toshsd.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/mmc/host/toshsd.c b/drivers/mmc/host/toshsd.c
index 4666262..e5d8dec 100644
--- a/drivers/mmc/host/toshsd.c
+++ b/drivers/mmc/host/toshsd.c
@@ -699,18 +699,7 @@ static struct pci_driver toshsd_driver = {
 	.driver.pm = &toshsd_pm_ops,
 };
 
-static int __init toshsd_drv_init(void)
-{
-	return pci_register_driver(&toshsd_driver);
-}
-
-static void __exit toshsd_drv_exit(void)
-{
-	pci_unregister_driver(&toshsd_driver);
-}
-
-module_init(toshsd_drv_init);
-module_exit(toshsd_drv_exit);
+module_pci_driver(toshsd_driver);
 
 MODULE_AUTHOR("Ondrej Zary, Richard Betts");
 MODULE_DESCRIPTION("Toshiba PCI Secure Digital Host Controller Interface driver");

