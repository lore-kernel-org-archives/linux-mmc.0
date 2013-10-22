From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 2/7] mmc: sh_mmcif: Convert to PM macros when defining dev_pm_ops
Date: Tue, 22 Oct 2013 16:07:21 +0200
Message-ID: <1382450846-17144-3-git-send-email-ulf.hansson@linaro.org>
References: <1382450846-17144-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:65417 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab3JVOHl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Oct 2013 10:07:41 -0400
Received: by mail-lb0-f182.google.com with SMTP id p9so7043012lbv.13
        for <linux-mmc@vger.kernel.org>; Tue, 22 Oct 2013 07:07:38 -0700 (PDT)
In-Reply-To: <1382450846-17144-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Use SET_SYSTEM_SLEEP_PM_OPS to simplify code.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 6bffebe..32bc412 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1538,7 +1538,7 @@ static int sh_mmcif_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int sh_mmcif_suspend(struct device *dev)
 {
 	struct sh_mmcif_host *host = dev_get_drvdata(dev);
@@ -1552,10 +1552,7 @@ static int sh_mmcif_resume(struct device *dev)
 {
 	return 0;
 }
-#else
-#define sh_mmcif_suspend	NULL
-#define sh_mmcif_resume		NULL
-#endif	/* CONFIG_PM */
+#endif
 
 static const struct of_device_id mmcif_of_match[] = {
 	{ .compatible = "renesas,sh-mmcif" },
@@ -1564,8 +1561,7 @@ static const struct of_device_id mmcif_of_match[] = {
 MODULE_DEVICE_TABLE(of, mmcif_of_match);
 
 static const struct dev_pm_ops sh_mmcif_dev_pm_ops = {
-	.suspend = sh_mmcif_suspend,
-	.resume = sh_mmcif_resume,
+	SET_SYSTEM_SLEEP_PM_OPS(sh_mmcif_suspend, sh_mmcif_resume)
 };
 
 static struct platform_driver sh_mmcif_driver = {
-- 
1.7.9.5

