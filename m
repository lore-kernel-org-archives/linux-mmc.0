From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V3 4/30] mmc: add ability to save power by powering off cards
Date: Wed, 09 Sep 2009 14:57:04 +0300
Message-ID: <20090909115704.12833.32488.sendpatchset@ahunter-laptop>
References: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42717 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbZIIL5B (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2009 07:57:01 -0400
In-Reply-To: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>, Matt Fleming <matt@console-pimps.org>

>From ead8ace5804bd9fa2093a5e2e0e80e1ab14d20b0 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Mon, 11 May 2009 12:20:57 +0300
Subject: [PATCH] mmc: add ability to save power by powering off cards

Power can be saved by powering off cards that are not
in use.  This is similar to suspend / resume except
it is under the control of the driver, and does not
require any power management support.  It can only
be used when the driver can monitor whether the card
is removed, otherwise it is unsafe.  This is possible
because, unlike suspend, the driver still receives
card detect and / or cover switch interrupts.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/core/core.c  |   34 ++++++++++++++++++++++++++++++++++
 drivers/mmc/core/core.h  |    2 ++
 drivers/mmc/core/mmc.c   |   11 +++++++++++
 drivers/mmc/core/sd.c    |   11 +++++++++++
 include/linux/mmc/host.h |    3 +++
 5 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index bab5015..39f7bd1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1145,6 +1145,40 @@ void mmc_stop_host(struct mmc_host *host)
 	mmc_power_off(host);
 }
 
+void mmc_power_save_host(struct mmc_host *host)
+{
+	mmc_bus_get(host);
+
+	if (!host->bus_ops || host->bus_dead || !host->bus_ops->power_restore) {
+		mmc_bus_put(host);
+		return;
+	}
+
+	if (host->bus_ops->power_save)
+		host->bus_ops->power_save(host);
+
+	mmc_bus_put(host);
+
+	mmc_power_off(host);
+}
+EXPORT_SYMBOL(mmc_power_save_host);
+
+void mmc_power_restore_host(struct mmc_host *host)
+{
+	mmc_bus_get(host);
+
+	if (!host->bus_ops || host->bus_dead || !host->bus_ops->power_restore) {
+		mmc_bus_put(host);
+		return;
+	}
+
+	mmc_power_up(host);
+	host->bus_ops->power_restore(host);
+
+	mmc_bus_put(host);
+}
+EXPORT_SYMBOL(mmc_power_restore_host);
+
 #ifdef CONFIG_PM
 
 /**
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index c819eff..f7eb4c4 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -20,6 +20,8 @@ struct mmc_bus_ops {
 	void (*detect)(struct mmc_host *);
 	void (*suspend)(struct mmc_host *);
 	void (*resume)(struct mmc_host *);
+	void (*power_save)(struct mmc_host *);
+	void (*power_restore)(struct mmc_host *);
 };
 
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3e35075..01f7226 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -549,6 +549,14 @@ static void mmc_resume(struct mmc_host *host)
 
 }
 
+static void mmc_power_restore(struct mmc_host *host)
+{
+	host->card->state &= ~MMC_STATE_HIGHSPEED;
+	mmc_claim_host(host);
+	mmc_init_card(host, host->ocr, host->card);
+	mmc_release_host(host);
+}
+
 #ifdef CONFIG_MMC_UNSAFE_RESUME
 
 static const struct mmc_bus_ops mmc_ops = {
@@ -556,6 +564,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.detect = mmc_detect,
 	.suspend = mmc_suspend,
 	.resume = mmc_resume,
+	.power_restore = mmc_power_restore,
 };
 
 static void mmc_attach_bus_ops(struct mmc_host *host)
@@ -570,6 +579,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.detect = mmc_detect,
 	.suspend = NULL,
 	.resume = NULL,
+	.power_restore = mmc_power_restore,
 };
 
 static const struct mmc_bus_ops mmc_ops_unsafe = {
@@ -577,6 +587,7 @@ static const struct mmc_bus_ops mmc_ops_unsafe = {
 	.detect = mmc_detect,
 	.suspend = mmc_suspend,
 	.resume = mmc_resume,
+	.power_restore = mmc_power_restore,
 };
 
 static void mmc_attach_bus_ops(struct mmc_host *host)
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 80cccd2..debe26e 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -603,6 +603,14 @@ static void mmc_sd_resume(struct mmc_host *host)
 
 }
 
+static void mmc_sd_power_restore(struct mmc_host *host)
+{
+	host->card->state &= ~MMC_STATE_HIGHSPEED;
+	mmc_claim_host(host);
+	mmc_sd_init_card(host, host->ocr, host->card);
+	mmc_release_host(host);
+}
+
 #ifdef CONFIG_MMC_UNSAFE_RESUME
 
 static const struct mmc_bus_ops mmc_sd_ops = {
@@ -610,6 +618,7 @@ static const struct mmc_bus_ops mmc_sd_ops = {
 	.detect = mmc_sd_detect,
 	.suspend = mmc_sd_suspend,
 	.resume = mmc_sd_resume,
+	.power_restore = mmc_sd_power_restore,
 };
 
 static void mmc_sd_attach_bus_ops(struct mmc_host *host)
@@ -624,6 +633,7 @@ static const struct mmc_bus_ops mmc_sd_ops = {
 	.detect = mmc_sd_detect,
 	.suspend = NULL,
 	.resume = NULL,
+	.power_restore = mmc_sd_power_restore,
 };
 
 static const struct mmc_bus_ops mmc_sd_ops_unsafe = {
@@ -631,6 +641,7 @@ static const struct mmc_bus_ops mmc_sd_ops_unsafe = {
 	.detect = mmc_sd_detect,
 	.suspend = mmc_sd_suspend,
 	.resume = mmc_sd_resume,
+	.power_restore = mmc_sd_power_restore,
 };
 
 static void mmc_sd_attach_bus_ops(struct mmc_host *host)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index bb867d2..c1cbe59 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -223,6 +223,9 @@ static inline void *mmc_priv(struct mmc_host *host)
 extern int mmc_suspend_host(struct mmc_host *, pm_message_t);
 extern int mmc_resume_host(struct mmc_host *);
 
+extern void mmc_power_save_host(struct mmc_host *host);
+extern void mmc_power_restore_host(struct mmc_host *host);
+
 extern void mmc_detect_change(struct mmc_host *, unsigned long delay);
 extern void mmc_request_done(struct mmc_host *, struct mmc_request *);
 
-- 
1.5.6.3

