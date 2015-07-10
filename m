From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [PATCH] mmc: bus: check suspend/resume hooks for bus_ops before calling
Date: Fri, 10 Jul 2015 16:38:46 +0800
Message-ID: <1436517526-19392-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0120.outbound.protection.outlook.com ([65.55.169.120]:41113
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752487AbbGJInd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 10 Jul 2015 04:43:33 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

It needs to check suspend/resume hooks before calling them to avoid
call trace during hibernation.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/core/bus.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 972ff84..fc6b5e5 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -154,7 +154,8 @@ static int mmc_bus_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = host->bus_ops->suspend(host);
+	if (host->bus_ops->suspend)
+		ret = host->bus_ops->suspend(host);
 	return ret;
 }
 
@@ -164,10 +165,12 @@ static int mmc_bus_resume(struct device *dev)
 	struct mmc_host *host = card->host;
 	int ret;
 
-	ret = host->bus_ops->resume(host);
-	if (ret)
-		pr_warn("%s: error %d during resume (card was removed?)\n",
-			mmc_hostname(host), ret);
+	if (host->bus_ops->resume) {
+		ret = host->bus_ops->resume(host);
+		if (ret)
+			pr_warn("%s: error %d during resume (card was removed?)\n",
+				mmc_hostname(host), ret);
+	}
 
 	ret = pm_generic_resume(dev);
 	return ret;
-- 
2.1.0.27.g96db324

