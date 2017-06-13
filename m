From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 1/2] mmc: slot-gpio: Add support to enable irq wake on cd_irq
Date: Tue, 13 Jun 2017 15:07:51 +0300
Message-ID: <1497355672-12980-2-git-send-email-adrian.hunter@intel.com>
References: <1497355672-12980-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32287 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751965AbdFMMNy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 13 Jun 2017 08:13:54 -0400
In-Reply-To: <1497355672-12980-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Add host capability MMC_CAP_CD_WAKE to enable irq wake on the card detect
irq.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c      | 5 ++++-
 drivers/mmc/core/slot-gpio.c | 2 ++
 include/linux/mmc/host.h     | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0056547f4301..5a9d837599a1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2798,8 +2798,11 @@ void mmc_stop_host(struct mmc_host *host)
 	host->removed = 1;
 	spin_unlock_irqrestore(&host->lock, flags);
 #endif
-	if (host->slot.cd_irq >= 0)
+	if (host->slot.cd_irq >= 0) {
+		if (host->slot.cd_wake_enabled)
+			disable_irq_wake(host->slot.cd_irq);
 		disable_irq(host->slot.cd_irq);
+	}
 
 	host->rescan_disable = 1;
 	cancel_delayed_work_sync(&host->detect);
diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index a8450a8701e4..863f1dbbfc1b 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -151,6 +151,8 @@ void mmc_gpiod_request_cd_irq(struct mmc_host *host)
 
 	if (irq < 0)
 		host->caps |= MMC_CAP_NEEDS_POLL;
+	else if ((host->caps & MMC_CAP_CD_WAKE) && !enable_irq_wake(irq))
+		host->slot.cd_wake_enabled = true;
 }
 EXPORT_SYMBOL(mmc_gpiod_request_cd_irq);
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ac9e29ac93d6..3be13de0c062 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -198,6 +198,7 @@ struct mmc_async_req {
  */
 struct mmc_slot {
 	int cd_irq;
+	bool cd_wake_enabled;
 	void *handler_priv;
 };
 
@@ -288,6 +289,7 @@ struct mmc_host {
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
+#define MMC_CAP_CD_WAKE		(1 << 28)	/* Enable card detect wake */
 #define MMC_CAP_CMD_DURING_TFR	(1 << 29)	/* Commands during data transfer */
 #define MMC_CAP_CMD23		(1 << 30)	/* CMD23 supported. */
 #define MMC_CAP_HW_RESET	(1 << 31)	/* Hardware reset */
-- 
1.9.1

