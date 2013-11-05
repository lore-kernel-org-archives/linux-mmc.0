From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/3] mmc: sh_mobile_sdhi: Use modern PM macros to define pm callbacks
Date: Tue,  5 Nov 2013 13:10:01 +0100
Message-ID: <1383653403-10049-2-git-send-email-ulf.hansson@linaro.org>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:42237 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728Ab3KEMKM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Nov 2013 07:10:12 -0500
Received: by mail-we0-f172.google.com with SMTP id q58so3387760wes.31
        for <linux-mmc@vger.kernel.org>; Tue, 05 Nov 2013 04:10:10 -0800 (PST)
In-Reply-To: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
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

