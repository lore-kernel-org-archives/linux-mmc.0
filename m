From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 2/3] mmc: atmel-mci: stop using specific initcall
Date: Thu, 20 Nov 2014 11:07:54 +0100
Message-ID: <1416478075-17059-2-git-send-email-ludovic.desroches@atmel.com>
References: <1416478075-17059-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:45017 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756170AbaKTKIW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Nov 2014 05:08:22 -0500
In-Reply-To: <1416478075-17059-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>

No more use late initcall to manage probing order. Use probe deferring
if needed. Then use module_platform_driver and clean init/exit
attributes.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index b9226b3..9b85c4e 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2137,7 +2137,7 @@ static irqreturn_t atmci_detect_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init atmci_init_slot(struct atmel_mci *host,
+static int atmci_init_slot(struct atmel_mci *host,
 		struct mci_slot_pdata *slot_data, unsigned int id,
 		u32 sdc_reg, u32 sdio_irq)
 {
@@ -2344,7 +2344,7 @@ static void __init atmci_get_cap(struct atmel_mci *host)
 	}
 }
 
-static int __init atmci_probe(struct platform_device *pdev)
+static int atmci_probe(struct platform_device *pdev)
 {
 	struct mci_platform_data	*pdata;
 	struct atmel_mci		*host;
@@ -2480,7 +2480,7 @@ err_init_slot:
 	return ret;
 }
 
-static int __exit atmci_remove(struct platform_device *pdev)
+static int atmci_remove(struct platform_device *pdev)
 {
 	struct atmel_mci	*host = platform_get_drvdata(pdev);
 	unsigned int		i;
@@ -2510,25 +2510,14 @@ static int __exit atmci_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver atmci_driver = {
-	.remove		= __exit_p(atmci_remove),
+	.probe		= atmci_probe,
+	.remove		= atmci_remove,
 	.driver		= {
 		.name		= "atmel_mci",
 		.of_match_table	= of_match_ptr(atmci_dt_ids),
 	},
 };
-
-static int __init atmci_init(void)
-{
-	return platform_driver_probe(&atmci_driver, atmci_probe);
-}
-
-static void __exit atmci_exit(void)
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

