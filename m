From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/7] mmc: sh_mmcif: Move away from using deprecated APIs
Date: Wed,  2 Oct 2013 10:30:45 +0200
Message-ID: <1380702651-13389-2-git-send-email-ulf.hansson@linaro.org>
References: <1380702651-13389-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:56833 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365Ab3JBIa7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Oct 2013 04:30:59 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so456902lbh.14
        for <linux-mmc@vger.kernel.org>; Wed, 02 Oct 2013 01:30:58 -0700 (PDT)
In-Reply-To: <1380702651-13389-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

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

