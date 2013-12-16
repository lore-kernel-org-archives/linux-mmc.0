From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V2 1/2] mmc: core: Use MMC_UNSAFE_RESUME as default behavior
Date: Mon, 16 Dec 2013 13:31:47 +0100
Message-ID: <1387197108-24040-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:47354 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab3LPMbz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2013 07:31:55 -0500
Received: by mail-bk0-f48.google.com with SMTP id r7so2281925bkg.21
        for <linux-mmc@vger.kernel.org>; Mon, 16 Dec 2013 04:31:53 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Invoking system suspend or shutdown without using the Kconfig option
MMC_UNSAFE_RESUME, did trigger an ungraceful power cut of the card.

To improve the situation, change the behavior to always make use of the
available bus_ops callbacks that handles system suspend and shutdown
properly.

By changing the behavior MMC_UNSAFE_RESUME becomes redundant, so lets's
remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	Update commit message.
	Remove mmc_attach_bus_ops() and mmc_sd_attach_bus_ops().

---
 drivers/mmc/core/Kconfig |   15 ---------------
 drivers/mmc/core/core.c  |   17 -----------------
 drivers/mmc/core/mmc.c   |   23 +----------------------
 drivers/mmc/core/sd.c    |   23 +----------------------
 include/linux/mmc/host.h |    5 +----
 5 files changed, 3 insertions(+), 80 deletions(-)

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index 269d072..9ebee72 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -2,21 +2,6 @@
 # MMC core configuration
 #
 
-config MMC_UNSAFE_RESUME
-	bool "Assume MMC/SD cards are non-removable (DANGEROUS)"
-	help
-	  If you say Y here, the MMC layer will assume that all cards
-	  stayed in their respective slots during the suspend. The
-	  normal behaviour is to remove them at suspend and
-	  redetecting them at resume. Breaking this assumption will
-	  in most cases result in data corruption.
-
-	  This option is usually just for embedded systems which use
-	  a MMC/SD card for rootfs. Most people should say N here.
-
-	  This option sets a default which can be overridden by the
-	  module parameter "removable=0" or "removable=1".
-
 config MMC_CLKGATE
 	bool "MMC host clock gating"
 	help
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 098374b..10856ec 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -65,23 +65,6 @@ bool use_spi_crc = 1;
 module_param(use_spi_crc, bool, 0);
 
 /*
- * We normally treat cards as removed during suspend if they are not
- * known to be on a non-removable bus, to avoid the risk of writing
- * back data to a different card after resume.  Allow this to be
- * overridden if necessary.
- */
-#ifdef CONFIG_MMC_UNSAFE_RESUME
-bool mmc_assume_removable;
-#else
-bool mmc_assume_removable = 1;
-#endif
-EXPORT_SYMBOL(mmc_assume_removable);
-module_param_named(removable, mmc_assume_removable, bool, 0644);
-MODULE_PARM_DESC(
-	removable,
-	"MMC/SD cards are removable and may be removed during suspend");
-
-/*
  * Internal function. Schedule delayed work in the MMC work queue.
  */
 static int mmc_schedule_delayed_work(struct delayed_work *work,
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 98e9eb0..20f0468 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1636,16 +1636,6 @@ static int mmc_power_restore(struct mmc_host *host)
 static const struct mmc_bus_ops mmc_ops = {
 	.remove = mmc_remove,
 	.detect = mmc_detect,
-	.suspend = NULL,
-	.resume = NULL,
-	.power_restore = mmc_power_restore,
-	.alive = mmc_alive,
-	.shutdown = mmc_shutdown,
-};
-
-static const struct mmc_bus_ops mmc_ops_unsafe = {
-	.remove = mmc_remove,
-	.detect = mmc_detect,
 	.suspend = mmc_suspend,
 	.resume = mmc_resume,
 	.runtime_suspend = mmc_runtime_suspend,
@@ -1655,17 +1645,6 @@ static const struct mmc_bus_ops mmc_ops_unsafe = {
 	.shutdown = mmc_shutdown,
 };
 
-static void mmc_attach_bus_ops(struct mmc_host *host)
-{
-	const struct mmc_bus_ops *bus_ops;
-
-	if (!mmc_card_is_removable(host))
-		bus_ops = &mmc_ops_unsafe;
-	else
-		bus_ops = &mmc_ops;
-	mmc_attach_bus(host, bus_ops);
-}
-
 /*
  * Starting point for MMC card init.
  */
@@ -1685,7 +1664,7 @@ int mmc_attach_mmc(struct mmc_host *host)
 	if (err)
 		return err;
 
-	mmc_attach_bus_ops(host);
+	mmc_attach_bus(host, &mmc_ops);
 	if (host->ocr_avail_mmc)
 		host->ocr_avail = host->ocr_avail_mmc;
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 6f42050..485ffe5 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1202,16 +1202,6 @@ static int mmc_sd_power_restore(struct mmc_host *host)
 static const struct mmc_bus_ops mmc_sd_ops = {
 	.remove = mmc_sd_remove,
 	.detect = mmc_sd_detect,
-	.suspend = NULL,
-	.resume = NULL,
-	.power_restore = mmc_sd_power_restore,
-	.alive = mmc_sd_alive,
-	.shutdown = mmc_sd_suspend,
-};
-
-static const struct mmc_bus_ops mmc_sd_ops_unsafe = {
-	.remove = mmc_sd_remove,
-	.detect = mmc_sd_detect,
 	.runtime_suspend = mmc_sd_runtime_suspend,
 	.runtime_resume = mmc_sd_runtime_resume,
 	.suspend = mmc_sd_suspend,
@@ -1221,17 +1211,6 @@ static const struct mmc_bus_ops mmc_sd_ops_unsafe = {
 	.shutdown = mmc_sd_suspend,
 };
 
-static void mmc_sd_attach_bus_ops(struct mmc_host *host)
-{
-	const struct mmc_bus_ops *bus_ops;
-
-	if (!mmc_card_is_removable(host))
-		bus_ops = &mmc_sd_ops_unsafe;
-	else
-		bus_ops = &mmc_sd_ops;
-	mmc_attach_bus(host, bus_ops);
-}
-
 /*
  * Starting point for SD card init.
  */
@@ -1247,7 +1226,7 @@ int mmc_attach_sd(struct mmc_host *host)
 	if (err)
 		return err;
 
-	mmc_sd_attach_bus_ops(host);
+	mmc_attach_bus(host, &mmc_sd_ops);
 	if (host->ocr_avail_sd)
 		host->ocr_avail = host->ocr_avail_sd;
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 99f5709..2a139b2 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -424,12 +424,9 @@ static inline int mmc_regulator_get_supply(struct mmc_host *mmc)
 
 int mmc_pm_notify(struct notifier_block *notify_block, unsigned long, void *);
 
-/* Module parameter */
-extern bool mmc_assume_removable;
-
 static inline int mmc_card_is_removable(struct mmc_host *host)
 {
-	return !(host->caps & MMC_CAP_NONREMOVABLE) && mmc_assume_removable;
+	return !(host->caps & MMC_CAP_NONREMOVABLE);
 }
 
 static inline int mmc_card_keep_power(struct mmc_host *host)
-- 
1.7.9.5

