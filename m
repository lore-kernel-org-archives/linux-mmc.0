From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 23/27] mmc: sh_mmcif: Move away from using deprecated APIs
Date: Thu, 26 Sep 2013 16:54:48 +0200
Message-ID: <1380207292-16968-24-git-send-email-ulf.hansson@linaro.org>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

Suspend and resume of cards are being handled from the protocol layer
and consequently the mmc_suspend|resume_host APIs are deprecated.

This means we can simplify the suspend|resume callbacks by removing the
use of the deprecated APIs.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 36629a0..6bffebe 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1542,19 +1542,15 @@ static int sh_mmcif_remove(struct platform_device *pdev)
 static int sh_mmcif_suspend(struct device *dev)
 {
 	struct sh_mmcif_host *host = dev_get_drvdata(dev);
-	int ret = mmc_suspend_host(host->mmc);
 
-	if (!ret)
-		sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
+	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
 
-	return ret;
+	return 0;
 }
 
 static int sh_mmcif_resume(struct device *dev)
 {
-	struct sh_mmcif_host *host = dev_get_drvdata(dev);
-
-	return mmc_resume_host(host->mmc);
+	return 0;
 }
 #else
 #define sh_mmcif_suspend	NULL
-- 
1.7.9.5
