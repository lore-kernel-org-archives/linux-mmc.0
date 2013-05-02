From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH V4 2/4] mmc: core: Add bus_ops for runtime pm callbacks
Date: Thu, 2 May 2013 14:02:37 +0200
Message-ID: <1367496159-7090-3-git-send-email-ulf.hansson@stericsson.com>
References: <1367496159-7090-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:34093 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753159Ab3EBMDa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 May 2013 08:03:30 -0400
In-Reply-To: <1367496159-7090-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maya Erez <merez@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Liu <kliu5@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>, Daniel Drake <dsd@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

From: Ulf Hansson <ulf.hansson@linaro.org>

SDIO is the only protocol that uses runtime pm for the card device
right now. To provide the option for sd and mmc to use runtime pm as
well the bus_ops callback are extended with two new functions. One for
runtime_suspend and one for runtime_resume.

This patch will also implement the callbacks for SDIO to make sure
existing functionality is maintained. It also prepares to move
away from using the mmc_power_restore_host API, since it is not
needed when using runtime PM.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Maya Erez <merez@codeaurora.org>
Cc: Subhash Jadavani <subhashj@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Liu <kliu5@marvell.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Drake <dsd@laptop.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/core/bus.c  |   14 ++++++++++++--
 drivers/mmc/core/core.c |    2 +-
 drivers/mmc/core/core.h |    3 +++
 drivers/mmc/core/sdio.c |   16 ++++++++++++++++
 4 files changed, 32 insertions(+), 3 deletions(-)

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
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 808db8b..a6c4dbf 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1459,7 +1459,7 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
  * If a host does all the power sequencing itself, ignore the
  * initial MMC_POWER_UP stage.
  */
-static void mmc_power_up(struct mmc_host *host)
+void mmc_power_up(struct mmc_host *host)
 {
 	int bit;
 
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index b9f18a2..6242ffb 100644
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
@@ -44,6 +46,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
 int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
 void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
+void mmc_power_up(struct mmc_host *host);
 void mmc_power_off(struct mmc_host *host);
 void mmc_power_cycle(struct mmc_host *host);
 
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 6889a82..6603f20 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1051,11 +1051,27 @@ out:
 	return ret;
 }
 
+static int mmc_sdio_runtime_suspend(struct mmc_host *host)
+{
+	/* No references to the card, cut the power to it. */
+	mmc_power_off(host);
+	return 0;
+}
+
+static int mmc_sdio_runtime_resume(struct mmc_host *host)
+{
+	/* Restore power and re-initialize. */
+	mmc_power_up(host);
+	return mmc_sdio_power_restore(host);
+}
+
 static const struct mmc_bus_ops mmc_sdio_ops = {
 	.remove = mmc_sdio_remove,
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

