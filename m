From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 1/6] mmc: core: remove check of host->removed for rescan routine
Date: Tue, 18 Jul 2017 16:59:31 +0800
Message-ID: <1500368376-160272-2-git-send-email-shawn.lin@rock-chips.com>
References: <1500368376-160272-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:56170 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751322AbdGRJAR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jul 2017 05:00:17 -0400
In-Reply-To: <1500368376-160272-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

The intention of this check was to prevent the conflict between
hotplug and removing driver for whatever reason. Currently it
doesn't improve anything and the following rescan process could
still saftly perform the scan flow. So these code seems pointless
now and let's remove them.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/core.c  | 13 -------------
 include/linux/mmc/host.h |  3 ---
 2 files changed, 16 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 2643126..b311ec9 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1769,13 +1769,6 @@ void mmc_detach_bus(struct mmc_host *host)
 static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
 				bool cd_irq)
 {
-#ifdef CONFIG_MMC_DEBUG
-	unsigned long flags;
-	spin_lock_irqsave(&host->lock, flags);
-	WARN_ON(host->removed);
-	spin_unlock_irqrestore(&host->lock, flags);
-#endif
-
 	/*
 	 * If the device is configured as wakeup, we prevent a new sleep for
 	 * 5 s to give provision for user space to consume the event.
@@ -2646,12 +2639,6 @@ void mmc_start_host(struct mmc_host *host)
 
 void mmc_stop_host(struct mmc_host *host)
 {
-#ifdef CONFIG_MMC_DEBUG
-	unsigned long flags;
-	spin_lock_irqsave(&host->lock, flags);
-	host->removed = 1;
-	spin_unlock_irqrestore(&host->lock, flags);
-#endif
 	if (host->slot.cd_irq >= 0) {
 		if (host->slot.cd_wake_enabled)
 			disable_irq_wake(host->slot.cd_irq);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ebd1ceb..4617c21 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -328,9 +328,6 @@ struct mmc_host {
 	unsigned int		use_spi_crc:1;
 	unsigned int		claimed:1;	/* host exclusively claimed */
 	unsigned int		bus_dead:1;	/* bus has been released */
-#ifdef CONFIG_MMC_DEBUG
-	unsigned int		removed:1;	/* host is being removed */
-#endif
 	unsigned int		can_retune:1;	/* re-tuning can be used */
 	unsigned int		doing_retune:1;	/* re-tuning in progress */
 	unsigned int		retune_now:1;	/* do re-tuning at next req */
-- 
1.9.1


