From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH] mmc: sdhci-pxav3: fix device wakeup initialization
Date: Tue, 2 Jun 2015 18:38:35 +0800
Message-ID: <1433241515-2093-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:44591 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751772AbbFBKjD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Jun 2015 06:39:03 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>

MMC_PM_KEEP_POWER doesn't imply MMC_PM_WAKE_SDIO_IRQ, we should only
enable device wake up when MMC_PM_WAKE_SDIO_IRQ is set. And "pm_flags"
is the requested pm features, we should not set it in the host driver.

At the same time, device wakeup is disabled by default, so there's no
need to disable device wakeup explicitly.

This patch fixes the warning as following:

[   64.616651] ------------[ cut here ]------------
[   64.616665] WARNING: CPU: 0 PID: 79 at linux/kernel/irq/manage.c:603 irq_set_irq_wake+0xf0/0x11c()
[   64.616667] Unbalanced IRQ 87 wake disable

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 01cb2d3..9cd5fc6 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -457,12 +457,8 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
-	if (host->mmc->pm_caps & MMC_PM_KEEP_POWER) {
+	if (host->mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ)
 		device_init_wakeup(&pdev->dev, 1);
-		host->mmc->pm_flags |= MMC_PM_WAKE_SDIO_IRQ;
-	} else {
-		device_init_wakeup(&pdev->dev, 0);
-	}
 
 	pm_runtime_put_autosuspend(&pdev->dev);
 
-- 
2.1.4

