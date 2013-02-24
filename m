From: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH] mmc: omap_hsmmc: Remove redundant check
Date: Mon, 25 Feb 2013 04:22:19 +0530
Message-ID: <1361746339-28836-1-git-send-email-s.syam@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36408 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756368Ab3BXWwc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Feb 2013 17:52:32 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: syamsidhardh@gmail.com, balajitk@ti.com, cjb@laptop.org

Remove redundant check for (host == NULL)

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 drivers/mmc/host/omap_hsmmc.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index bc58078..5d690e6 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2100,10 +2100,7 @@ static int omap_hsmmc_suspend(struct device *dev)
 	int ret = 0;
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
 
-	if (!host)
-		return 0;
-
-	if (host && host->suspended)
+	if (!host || host->suspended)
 		return 0;
 
 	pm_runtime_get_sync(host->dev);
@@ -2134,10 +2131,7 @@ static int omap_hsmmc_resume(struct device *dev)
 	int ret = 0;
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
 
-	if (!host)
-		return 0;
-
-	if (host && !host->suspended)
+	if (!(host && host->suspended))
 		return 0;
 
 	pm_runtime_get_sync(host->dev);
-- 
1.7.9.5

