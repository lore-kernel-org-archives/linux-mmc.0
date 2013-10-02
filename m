From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/7] mmc: sh_mmcif: Convert to PM macros when defining dev_pm_ops
Date: Wed,  2 Oct 2013 10:30:46 +0200
Message-ID: <1380702651-13389-3-git-send-email-ulf.hansson@linaro.org>
References: <1380702651-13389-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:45967 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab3JBIbD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Oct 2013 04:31:03 -0400
Received: by mail-lb0-f173.google.com with SMTP id o14so455935lbi.32
        for <linux-mmc@vger.kernel.org>; Wed, 02 Oct 2013 01:31:01 -0700 (PDT)
In-Reply-To: <1380702651-13389-1-git-send-email-ulf.hansson@linaro.org>
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

