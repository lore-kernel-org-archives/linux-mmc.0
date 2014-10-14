From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5/7] mmc: msm_sdcc: Use platform_set|get_drvdata
Date: Tue, 14 Oct 2014 13:45:18 +0200
Message-ID: <1413287120-10914-6-git-send-email-ulf.hansson@linaro.org>
References: <1413287120-10914-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:47164 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061AbaJNLpk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Oct 2014 07:45:40 -0400
Received: by mail-lb0-f176.google.com with SMTP id p9so8183187lbv.35
        for <linux-mmc@vger.kernel.org>; Tue, 14 Oct 2014 04:45:38 -0700 (PDT)
In-Reply-To: <1413287120-10914-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

The msm_sdcc host shall not use mmc core specific macros to handle its
driver data. Instead, convert to use the platform device driver macros.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/msm_sdcc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 9405ecd..90c60fd 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -1360,7 +1360,7 @@ msmsdcc_probe(struct platform_device *pdev)
 	if (ret)
 		goto cmd_irq_free;
 
-	mmc_set_drvdata(pdev, mmc);
+	platform_set_drvdata(pdev, mmc);
 	mmc_add_host(mmc);
 
 	pr_info("%s: Qualcomm MSM SDCC at 0x%016llx irq %d,%d dma %d\n",
@@ -1419,7 +1419,7 @@ ioremap_free:
 static int
 msmsdcc_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct mmc_host *mmc = mmc_get_drvdata(dev);
+	struct mmc_host *mmc = platform_get_drvdata(dev);
 
 	if (mmc) {
 		struct msmsdcc_host *host = mmc_priv(mmc);
@@ -1437,7 +1437,7 @@ msmsdcc_suspend(struct platform_device *dev, pm_message_t state)
 static int
 msmsdcc_resume(struct platform_device *dev)
 {
-	struct mmc_host *mmc = mmc_get_drvdata(dev);
+	struct mmc_host *mmc = platform_get_drvdata(dev);
 
 	if (mmc) {
 		struct msmsdcc_host *host = mmc_priv(mmc);
-- 
1.9.1

