From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: [PATCH] mmc: android-goldfish: Remove unnecessary NULL check on host
Date: Sat, 20 Sep 2014 15:06:08 +0530
Message-ID: <1411205768-3830-1-git-send-email-pramod.gurav@smartplayin.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp68.ord1c.emailsrvr.com ([108.166.43.68]:49064 "EHLO
	smtp68.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751032AbaITJgQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Sep 2014 05:36:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Pramod Gurav <pramod.gurav@smartplayin.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

This change removes unwanted NULL check around mmc private data
structure in remove function as the probe would not have succeeded
with this structure variable as NULL.

Cc: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
---
 drivers/mmc/host/android-goldfish.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
index 8b4e20a..76696e5 100644
--- a/drivers/mmc/host/android-goldfish.c
+++ b/drivers/mmc/host/android-goldfish.c
@@ -546,8 +546,6 @@ static int goldfish_mmc_remove(struct platform_device *pdev)
 {
 	struct goldfish_mmc_host *host = platform_get_drvdata(pdev);
 
-	BUG_ON(host == NULL);
-
 	mmc_remove_host(host->mmc);
 	free_irq(host->irq, host);
 	dma_free_coherent(&pdev->dev, BUFFER_SIZE, host->virt_base, host->phys_base);
-- 
1.8.3.2

