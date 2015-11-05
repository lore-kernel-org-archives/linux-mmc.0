From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: Refactor code to register the MMC PM notifier
Date: Thu,  5 Nov 2015 16:11:12 +0100
Message-ID: <1446736272-16620-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:35298 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161903AbbKEPLS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2015 10:11:18 -0500
Received: by lbbes7 with SMTP id es7so37492792lbb.2
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2015 07:11:16 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Instead of checking for "#ifdef" directly in the code, let's invent a pair
of mmc core functions to deal with register/unregister the MMC PM notifier
block. Implement stubs for these functions when CONFIG_PM_SLEEP is unset,
as in that case the PM notifiers isn't used.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c  | 18 ++++++++++++++----
 drivers/mmc/core/core.h  |  8 ++++++++
 drivers/mmc/core/host.c  |  8 ++------
 include/linux/mmc/host.h |  4 ++--
 4 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5ae89e4..819d7a7 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2759,14 +2759,13 @@ int mmc_flush_cache(struct mmc_card *card)
 }
 EXPORT_SYMBOL(mmc_flush_cache);
 
-#ifdef CONFIG_PM
-
+#ifdef CONFIG_PM_SLEEP
 /* Do the card removal on suspend if card is assumed removeable
  * Do that in pm notifier while userspace isn't yet frozen, so we will be able
    to sync the card.
 */
-int mmc_pm_notify(struct notifier_block *notify_block,
-					unsigned long mode, void *unused)
+static int mmc_pm_notify(struct notifier_block *notify_block,
+			unsigned long mode, void *unused)
 {
 	struct mmc_host *host = container_of(
 		notify_block, struct mmc_host, pm_notify);
@@ -2813,6 +2812,17 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 
 	return 0;
 }
+
+void mmc_register_pm_notifier(struct mmc_host *host)
+{
+	host->pm_notify.notifier_call = mmc_pm_notify;
+	register_pm_notifier(&host->pm_notify);
+}
+
+void mmc_unregister_pm_notifier(struct mmc_host *host)
+{
+	unregister_pm_notifier(&host->pm_notify);
+}
 #endif
 
 /**
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 09241e5..bd00ac2 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -90,5 +90,13 @@ int mmc_execute_tuning(struct mmc_card *card);
 int mmc_hs200_to_hs400(struct mmc_card *card);
 int mmc_hs400_to_hs200(struct mmc_card *card);
 
+#ifdef CONFIG_PM_SLEEP
+void mmc_register_pm_notifier(struct mmc_host *host);
+void mmc_unregister_pm_notifier(struct mmc_host *host);
+#else
+static void mmc_register_pm_notifier(struct mmc_host *host) { }
+static void mmc_unregister_pm_notifier(struct mmc_host *host) { }
+#endif
+
 #endif
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index da950c4..86cf440 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -21,7 +21,6 @@
 #include <linux/export.h>
 #include <linux/leds.h>
 #include <linux/slab.h>
-#include <linux/suspend.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -348,9 +347,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	spin_lock_init(&host->lock);
 	init_waitqueue_head(&host->wq);
 	INIT_DELAYED_WORK(&host->detect, mmc_rescan);
-#ifdef CONFIG_PM
-	host->pm_notify.notifier_call = mmc_pm_notify;
-#endif
 	setup_timer(&host->retune_timer, mmc_retune_timer, (unsigned long)host);
 
 	/*
@@ -395,7 +391,7 @@ int mmc_add_host(struct mmc_host *host)
 #endif
 
 	mmc_start_host(host);
-	register_pm_notifier(&host->pm_notify);
+	mmc_register_pm_notifier(host);
 
 	return 0;
 }
@@ -412,7 +408,7 @@ EXPORT_SYMBOL(mmc_add_host);
  */
 void mmc_remove_host(struct mmc_host *host)
 {
-	unregister_pm_notifier(&host->pm_notify);
+	mmc_unregister_pm_notifier(host);
 	mmc_stop_host(host);
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 8673ffe..d57afc1 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -212,7 +212,9 @@ struct mmc_host {
 	u32			ocr_avail_sdio;	/* SDIO-specific OCR */
 	u32			ocr_avail_sd;	/* SD-specific OCR */
 	u32			ocr_avail_mmc;	/* MMC-specific OCR */
+#ifdef CONFIG_PM_SLEEP
 	struct notifier_block	pm_notify;
+#endif
 	u32			max_current_330;
 	u32			max_current_300;
 	u32			max_current_180;
@@ -434,8 +436,6 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
 
 int mmc_regulator_get_supply(struct mmc_host *mmc);
 
-int mmc_pm_notify(struct notifier_block *notify_block, unsigned long, void *);
-
 static inline int mmc_card_is_removable(struct mmc_host *host)
 {
 	return !(host->caps & MMC_CAP_NONREMOVABLE);
-- 
1.9.1

