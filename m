From: NeilBrown <neil@brown.name>
Subject: [PATCH 2/4] mmc/core: add pm_runtime tracking to mmc_host devices.
Date: Wed, 25 Mar 2015 07:56:10 +1100
Message-ID: <20150324205610.20572.73676.stgit@notabene.brown>
References: <20150324205316.20572.30538.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55426 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897AbbCXVIf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 24 Mar 2015 17:08:35 -0400
In-Reply-To: <20150324205316.20572.30538.stgit@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Enable runtime pm for mmc_host devices, and take a
reference while the host is claimed.

Use an autosuspend timeout so that the device isn't
put to sleep until we have been idle for a while.

Set the parent to ignore children, so the PM status of
the host does not affect the controller at all.

This functionality will be used in a future patch to allow
commands to be sent to the device when the host is idle.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/mmc/core/core.c |    5 +++++
 drivers/mmc/core/host.c |   23 +++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 23f10f72e5f3..ca475a5c8d94 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -900,6 +900,7 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
 
 	might_sleep();
 
+	pm_runtime_get_sync(&host->class_dev);
 	add_wait_queue(&host->wq, &wait);
 	spin_lock_irqsave(&host->lock, flags);
 	while (1) {
@@ -922,6 +923,8 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
 	remove_wait_queue(&host->wq, &wait);
 	if (host->ops->enable && !stop && host->claim_cnt == 1)
 		host->ops->enable(host);
+	if (stop)
+		pm_runtime_put(&host->class_dev);
 	return stop;
 }
 
@@ -953,6 +956,8 @@ void mmc_release_host(struct mmc_host *host)
 		spin_unlock_irqrestore(&host->lock, flags);
 		wake_up(&host->wq);
 	}
+	pm_runtime_mark_last_busy(&host->class_dev);
+	pm_runtime_put_autosuspend(&host->class_dev);
 }
 EXPORT_SYMBOL(mmc_release_host);
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 8be0df758e68..c205c4531b44 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -22,6 +22,7 @@
 #include <linux/leds.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -490,6 +491,11 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->class_dev.parent = dev;
 	host->class_dev.class = &mmc_host_class;
 	device_initialize(&host->class_dev);
+	if (dev)
+		/*
+		 * The device can sleep even when host is claimed.
+		 */
+		pm_suspend_ignore_children(dev, true);
 
 	if (mmc_gpio_alloc(host)) {
 		put_device(&host->class_dev);
@@ -532,15 +538,25 @@ EXPORT_SYMBOL(mmc_alloc_host);
 int mmc_add_host(struct mmc_host *host)
 {
 	int err;
+	struct device *dev = &host->class_dev;
 
 	WARN_ON((host->caps & MMC_CAP_SDIO_IRQ) &&
 		!host->ops->enable_sdio_irq);
 
-	err = device_add(&host->class_dev);
+	err = device_add(dev);
 	if (err)
 		return err;
+	pm_runtime_enable(dev);
+	/*
+	 * The host should be able to suspend while the attached card
+	 * stays awake.
+	 */
+	pm_suspend_ignore_children(dev, true);
+	pm_runtime_get_sync(dev);
+	pm_runtime_set_autosuspend_delay(dev, 100);
+	pm_runtime_use_autosuspend(dev);
 
-	led_trigger_register_simple(dev_name(&host->class_dev), &host->led);
+	led_trigger_register_simple(dev_name(dev), &host->led);
 
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_host_debugfs(host);
@@ -550,6 +566,9 @@ int mmc_add_host(struct mmc_host *host)
 	mmc_start_host(host);
 	register_pm_notifier(&host->pm_notify);
 
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	return 0;
 }
 


