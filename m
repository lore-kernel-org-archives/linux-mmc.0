From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/2] mmc: atmel-mci: add CONFIG_PM_SLEEP to suspend/resume
 functions
Date: Fri, 29 Mar 2013 16:05:40 +0900
Message-ID: <003301ce2c4b$d2864fb0$7792ef10$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:45278 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754615Ab3C2HFm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Mar 2013 03:05:42 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MKE000JMUD0D3O0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Mar 2013 16:05:41 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Ludovic Desroches' <ludovic.desroches@atmel.com>, 'Jingoo Han' <jg1.han@samsung.com>

Add CONFIG_PM_SLEEP to suspend/resume functions to fix the following
build warning when CONFIG_PM_SLEEP is not selected. This is because
sleep PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
the CONFIG_PM_SLEEP is enabled.

drivers/mmc/host/atmel-mci.c:2526:12: warning: 'atmci_suspend' defined but not used [-Wunused-function]
drivers/mmc/host/atmel-mci.c:2556:12: warning: 'atmci_resume' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/atmel-mci.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 10f8b73..172f874 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2499,7 +2499,7 @@ static int __exit atmci_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int atmci_suspend(struct device *dev)
 {
 	struct atmel_mci *host = dev_get_drvdata(dev);
@@ -2554,17 +2554,15 @@ static int atmci_resume(struct device *dev)
 
 	return ret;
 }
-static SIMPLE_DEV_PM_OPS(atmci_pm, atmci_suspend, atmci_resume);
-#define ATMCI_PM_OPS	(&atmci_pm)
-#else
-#define ATMCI_PM_OPS	NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(atmci_pm, atmci_suspend, atmci_resume);
+
 static struct platform_driver atmci_driver = {
 	.remove		= __exit_p(atmci_remove),
 	.driver		= {
 		.name		= "atmel_mci",
-		.pm		= ATMCI_PM_OPS,
+		.pm		= &atmci_pm,
 		.of_match_table	= of_match_ptr(atmci_dt_ids),
 	},
 };
-- 
1.7.2.5


