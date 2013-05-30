From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 4/4] mmc: core: Initiate suspend|resume from mmc bus instead of mmc host
Date: Thu, 30 May 2013 14:53:11 +0200
Message-ID: <1369918391-15277-5-git-send-email-ulf.hansson@stericsson.com>
References: <1369918391-15277-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:52517 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752238Ab3E3MyN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 May 2013 08:54:13 -0400
In-Reply-To: <1369918391-15277-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

The host should be responsible to suspend|resume the host and not the
card. This patch changes this behaviour, by moving the responsiblity
to the mmc bus instead which already holds the card device.

The exported functions mmc_suspend|resume_host are now to be considered
as depcrecated. Once all host drivers moves away from using them, we
can remove them. As of now, a successful error code is always returned.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/bus.c  |   15 ++++++++++++++-
 drivers/mmc/core/core.c |   26 +++-----------------------
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index d9e8c2b..2842684 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -127,10 +127,16 @@ static int mmc_bus_suspend(struct device *dev)
 {
 	struct mmc_driver *drv = to_mmc_driver(dev->driver);
 	struct mmc_card *card = mmc_dev_to_card(dev);
+	struct mmc_host *host = card->host;
 	int ret = 0;
 
-	if (dev->driver && drv->suspend)
+	if (dev->driver && drv->suspend) {
 		ret = drv->suspend(card);
+		if (ret)
+			return ret;
+	}
+
+	ret = host->bus_ops->suspend(host);
 	return ret;
 }
 
@@ -138,10 +144,17 @@ static int mmc_bus_resume(struct device *dev)
 {
 	struct mmc_driver *drv = to_mmc_driver(dev->driver);
 	struct mmc_card *card = mmc_dev_to_card(dev);
+	struct mmc_host *host = card->host;
 	int ret = 0;
 
+	ret = host->bus_ops->resume(host);
+	if (ret)
+		pr_warn("%s: error %d during resume (card was removed?)\n",
+			mmc_hostname(host), ret);
+
 	if (dev->driver && drv->resume)
 		ret = drv->resume(card);
+
 	return ret;
 }
 #endif
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index da3b907..49a5bca 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2619,16 +2619,8 @@ EXPORT_SYMBOL(mmc_cache_ctrl);
  */
 int mmc_suspend_host(struct mmc_host *host)
 {
-	int err = 0;
-
-	mmc_bus_get(host);
-	if (host->bus_ops && !host->bus_dead) {
-		if (host->bus_ops->suspend)
-			err = host->bus_ops->suspend(host);
-	}
-	mmc_bus_put(host);
-
-	return err;
+	/* This function is deprecated */
+	return 0;
 }
 EXPORT_SYMBOL(mmc_suspend_host);
 
@@ -2638,19 +2630,7 @@ EXPORT_SYMBOL(mmc_suspend_host);
  */
 int mmc_resume_host(struct mmc_host *host)
 {
-	int err;
-
-	mmc_bus_get(host);
-	if (host->bus_ops && !host->bus_dead) {
-		BUG_ON(!host->bus_ops->resume);
-		err = host->bus_ops->resume(host);
-		if (err)
-			pr_warning("%s: error %d during resume "
-					    "(card was removed?)\n",
-					    mmc_hostname(host), err);
-	}
-	mmc_bus_put(host);
-
+	/* This function is deprecated */
 	return 0;
 }
 EXPORT_SYMBOL(mmc_resume_host);
-- 
1.7.10

