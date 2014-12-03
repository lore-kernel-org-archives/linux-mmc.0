From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH] mmc: atmel-mci: use SET_RUNTIME_PM_OPS() macro
Date: Wed, 3 Dec 2014 14:43:14 +0100
Message-ID: <1417614194-28409-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:6197 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbaLCNnQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Dec 2014 08:43:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>

Use SET_RUNTIME_PM_OPS() since SET_PM_RUNTIME_PM_OPS() has been dropped.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---

Hi Ulf,

Can you take this patch which fixes a compilation error that has appeared only
on next-20141203.

Thanks

Regards

 drivers/mmc/host/atmel-mci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 62aba9a..03d7c75 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2561,7 +2561,7 @@ static int atmci_runtime_resume(struct device *dev)
 static const struct dev_pm_ops atmci_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
 				pm_runtime_force_resume)
-	SET_PM_RUNTIME_PM_OPS(atmci_runtime_suspend, atmci_runtime_resume, NULL)
+	SET_RUNTIME_PM_OPS(atmci_runtime_suspend, atmci_runtime_resume, NULL)
 };
 
 static struct platform_driver atmci_driver = {
-- 
2.0.3

