From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] mmc: sdhci-esdhc-imx: Fixup runtime PM conditions during ->probe()
Date: Fri, 19 Dec 2014 10:47:03 +0100
Message-ID: <1418982423-8069-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:38186 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbaLSJrI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Dec 2014 04:47:08 -0500
Received: by mail-la0-f45.google.com with SMTP id gq15so513564lab.32
        for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2014 01:47:07 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Dong Aisheng <b29396@freescale.com>, Shawn Guo <shawn.guo@linaro.org>

By configure runtime PM prior we enable the use of it, we close the gap
for strange and unhandled conditions. Moreover it makes us rely on the
driver core, after finalized ->probe(), to request an inactive device
to become runtime PM idle/suspended, which earlier potentially could
happen already at pm_runtime_set_autosuspend_delay().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 043866c..10ef824 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1080,10 +1080,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		goto disable_clk;
 
 	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_suspend_ignore_children(&pdev->dev, 1);
+	pm_runtime_enable(&pdev->dev);
 
 	return 0;
 
-- 
1.9.1

