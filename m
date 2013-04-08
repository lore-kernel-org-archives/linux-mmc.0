From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH V2 1/2] mmc: core: Add bus_ops for runtime pm callbacks
Date: Mon, 8 Apr 2013 13:43:06 +0200
Message-ID: <1365421386-4623-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:43836 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934941Ab3DHLnU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Apr 2013 07:43:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

SDIO is the only protocol that uses runtime pm for the card device
right now. To provide the option for sd and mmc to use runtime pm as
well the bus_ops callback are extended with two new functions. One for
runtime_suspend and one for runtime_resume.

This patch will also implement the callbacks for SDIO to make sure
existing functionality is maintained.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Maya Erez <merez@codeaurora.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/core/bus.c  |   14 ++++++++++++--
 drivers/mmc/core/core.h |    2 ++
 drivers/mmc/core/sdio.c |   20 ++++++++++++++++++++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index e219c97..d9e8c2b 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -151,15 +151,25 @@ static int mmc_bus_resume(struct device *dev)
 static int mmc_runtime_suspend(struct device *dev)
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
+	struct mmc_host *host = card->host;
+	int ret = 0;
+
+	if (host->bus_ops->runtime_suspend)
+		ret = host->bus_ops->runtime_suspend(host);
 
-	return mmc_power_save_host(card->host);
+	return ret;
 }
 
 static int mmc_runtime_resume(struct device *dev)
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
+	struct mmc_host *host = card->host;
+	int ret = 0;
+
+	if (host->bus_ops->runtime_resume)
+		ret = host->bus_ops->runtime_resume(host);
 
-	return mmc_power_restore_host(card->host);
+	return ret;
 }
 
 static int mmc_runtime_idle(struct device *dev)
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index b9f18a2..9445519 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -22,6 +22,8 @@ struct mmc_bus_ops {
 	void (*detect)(struct mmc_host *);
 	int (*suspend)(struct mmc_host *);
 	int (*resume)(struct mmc_host *);
+	int (*runtime_suspend)(struct mmc_host *);
+	int (*runtime_resume)(struct mmc_host *);
 	int (*power_save)(struct mmc_host *);
 	int (*power_restore)(struct mmc_host *);
 	int (*alive)(struct mmc_host *);
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index aa0719a..0e6e8c1 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -988,6 +988,24 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	return err;
 }
 
+static int mmc_sdio_runtime_suspend(struct mmc_host *host)
+{
+	/*
+	 * Once sdio clients has entirely switched to runtime pm we wrap
+	 * the call to power_save here.
+	 */
+	return mmc_power_save_host(host);
+}
+
+static int mmc_sdio_runtime_resume(struct mmc_host *host)
+{
+	/*
+	 * Once sdio clients has entirely switched to runtime pm we wrap
+	 * the call to power_restore here.
+	 */
+	return mmc_power_restore_host(host);
+}
+
 static int mmc_sdio_power_restore(struct mmc_host *host)
 {
 	int ret;
@@ -1054,6 +1072,8 @@ static const struct mmc_bus_ops mmc_sdio_ops = {
 	.detect = mmc_sdio_detect,
 	.suspend = mmc_sdio_suspend,
 	.resume = mmc_sdio_resume,
+	.runtime_suspend = mmc_sdio_runtime_suspend,
+	.runtime_resume = mmc_sdio_runtime_resume,
 	.power_restore = mmc_sdio_power_restore,
 	.alive = mmc_sdio_alive,
 };
-- 
1.7.10

