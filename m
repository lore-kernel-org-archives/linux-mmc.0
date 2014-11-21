From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v2 3/4] mmc: atmel-mci: stop using specific initcall
Date: Fri, 21 Nov 2014 16:33:37 +0100
Message-ID: <1416584018-8561-4-git-send-email-ludovic.desroches@atmel.com>
References: <1416584018-8561-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:49082 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758399AbaKUPeb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Nov 2014 10:34:31 -0500
In-Reply-To: <1416584018-8561-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org, chris@printf.net, nicolas.ferre@atmel.com, arnd@arndb.de, Ludovic Desroches <ludovic.desroches@atmel.com>

No more use late initcall to manage probing order. Use probe deferring
if needed.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 169b4eb..28546c3 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2510,25 +2510,14 @@ static int atmci_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver atmci_driver = {
+	.probe		= atmci_probe,
 	.remove		= atmci_remove,
 	.driver		= {
 		.name		= "atmel_mci",
 		.of_match_table	= of_match_ptr(atmci_dt_ids),
 	},
 };
-
-static int atmci_init(void)
-{
-	return platform_driver_probe(&atmci_driver, atmci_probe);
-}
-
-static void atmci_exit(void)
-{
-	platform_driver_unregister(&atmci_driver);
-}
-
-late_initcall(atmci_init); /* try to load after dma driver when built-in */
-module_exit(atmci_exit);
+module_platform_driver(atmci_driver);
 
 MODULE_DESCRIPTION("Atmel Multimedia Card Interface driver");
 MODULE_AUTHOR("Haavard Skinnemoen (Atmel)");
-- 
2.0.3

