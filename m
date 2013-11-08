From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/8] mmc: sh_mobile_sdhi: Use modern PM macros to define pm callbacks
Date: Fri,  8 Nov 2013 07:06:09 +0100
Message-ID: <1383890776-6912-2-git-send-email-ulf.hansson@linaro.org>
References: <1383890776-6912-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:47950 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab3KHGGZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Nov 2013 01:06:25 -0500
Received: by mail-lb0-f173.google.com with SMTP id w7so1130505lbi.32
        for <linux-mmc@vger.kernel.org>; Thu, 07 Nov 2013 22:06:23 -0800 (PST)
In-Reply-To: <1383890776-6912-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 87ed3fb..2227a9f 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -297,10 +297,10 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops tmio_mmc_dev_pm_ops = {
-	.suspend = tmio_mmc_host_suspend,
-	.resume = tmio_mmc_host_resume,
-	.runtime_suspend = tmio_mmc_host_runtime_suspend,
-	.runtime_resume = tmio_mmc_host_runtime_resume,
+	SET_SYSTEM_SLEEP_PM_OPS(tmio_mmc_host_suspend, tmio_mmc_host_resume)
+	SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
+			tmio_mmc_host_runtime_resume,
+			NULL)
 };
 
 static struct platform_driver sh_mobile_sdhi_driver = {
-- 
1.7.9.5

