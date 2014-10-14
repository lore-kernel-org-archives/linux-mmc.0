From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/7] mmc: core: Remove superfluous ifdefs for SDIO bus' PM callbacks
Date: Tue, 14 Oct 2014 13:45:14 +0200
Message-ID: <1413287120-10914-2-git-send-email-ulf.hansson@linaro.org>
References: <1413287120-10914-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:36207 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061AbaJNLpd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Oct 2014 07:45:33 -0400
Received: by mail-la0-f44.google.com with SMTP id hs14so8371293lab.3
        for <linux-mmc@vger.kernel.org>; Tue, 14 Oct 2014 04:45:31 -0700 (PDT)
In-Reply-To: <1413287120-10914-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_bus.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index e4eb456..5c02367 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -195,8 +195,6 @@ static int sdio_bus_remove(struct device *dev)
 	return ret;
 }
 
-#ifdef CONFIG_PM
-
 static const struct dev_pm_ops sdio_bus_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_generic_suspend, pm_generic_resume)
 	SET_RUNTIME_PM_OPS(
@@ -206,14 +204,6 @@ static const struct dev_pm_ops sdio_bus_pm_ops = {
 	)
 };
 
-#define SDIO_PM_OPS_PTR	(&sdio_bus_pm_ops)
-
-#else /* !CONFIG_PM */
-
-#define SDIO_PM_OPS_PTR	NULL
-
-#endif /* !CONFIG_PM */
-
 static struct bus_type sdio_bus_type = {
 	.name		= "sdio",
 	.dev_groups	= sdio_dev_groups,
@@ -221,7 +211,7 @@ static struct bus_type sdio_bus_type = {
 	.uevent		= sdio_bus_uevent,
 	.probe		= sdio_bus_probe,
 	.remove		= sdio_bus_remove,
-	.pm		= SDIO_PM_OPS_PTR,
+	.pm		= &sdio_bus_pm_ops,
 };
 
 int sdio_register_bus(void)
-- 
1.9.1

