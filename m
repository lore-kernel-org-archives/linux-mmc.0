From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 1/5] SDIO: introduce API for special power management features
Date: Tue, 09 Feb 2010 15:29:22 -0500
Message-ID: <1265747366-6676-2-git-send-email-nico@fluxnic.net>
References: <1265747366-6676-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:12186 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab0BIU3u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Feb 2010 15:29:50 -0500
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXL00I4TCXNVXE0@VL-MH-MR002.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 09 Feb 2010 15:29:48 -0500 (EST)
In-reply-to: <1265747366-6676-1-git-send-email-nico@fluxnic.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org

Some SDIO cards have the ability to keep on running autonomously when
the host system is suspended, and wake it up when needed.  This however
requires that the host controller preserve power to the card, and
configure itself appropriately for wake-up.

There is however 4 layers of abstractions involved: the host controller
driver, the MMC core code, the SDIO card management code, and the actual
SDIO function driver.  To make things simple and manageable, host drivers
must advertise their PM capabilities with a feature bitmask, then function
drivers can query and set those features from their suspend method.
Then each layer in the suspend call chain is expected to act upon those
bits accordingly.

Signed-off-by: Nicolas Pitre <nico@marvell.com>
---
 drivers/mmc/core/core.c       |   12 +++++++--
 drivers/mmc/core/sdio_io.c    |   49 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h      |    5 ++++
 include/linux/mmc/pm.h        |   30 +++++++++++++++++++++++++
 include/linux/mmc/sdio_func.h |    5 ++++
 5 files changed, 98 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/mmc/pm.h

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 30acd52..1dc34a4 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1259,6 +1259,9 @@ int mmc_suspend_host(struct mmc_host *host, pm_message_t state)
 	cancel_delayed_work(&host->detect);
 	mmc_flush_scheduled_work();
 
+	/* clear pm flags now and let card drivers set them as needed */
+	host->pm_flags = 0;
+
 	mmc_bus_get(host);
 	if (host->bus_ops && !host->bus_dead) {
 		if (host->bus_ops->suspend)
@@ -1273,12 +1276,13 @@ int mmc_suspend_host(struct mmc_host *host, pm_message_t state)
 			mmc_claim_host(host);
 			mmc_detach_bus(host);
 			mmc_release_host(host);
+			host->pm_flags = 0;
 			err = 0;
 		}
 	}
 	mmc_bus_put(host);
 
-	if (!err)
+	if (!err && !(host->pm_flags & MMC_PM_KEEP_POWER))
 		mmc_power_off(host);
 
 	return err;
@@ -1296,8 +1300,10 @@ int mmc_resume_host(struct mmc_host *host)
 
 	mmc_bus_get(host);
 	if (host->bus_ops && !host->bus_dead) {
-		mmc_power_up(host);
-		mmc_select_voltage(host, host->ocr);
+		if (!(host->pm_flags & MMC_PM_KEEP_POWER)) {
+			mmc_power_up(host);
+			mmc_select_voltage(host, host->ocr);
+		}
 		BUG_ON(!host->bus_ops->resume);
 		err = host->bus_ops->resume(host);
 		if (err) {
diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index f9aa8a7..ee25ffa 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -635,3 +635,52 @@ void sdio_f0_writeb(struct sdio_func *func, unsigned char b, unsigned int addr,
 		*err_ret = ret;
 }
 EXPORT_SYMBOL_GPL(sdio_f0_writeb);
+
+/**
+ *	sdio_get_host_pm_caps - get host power management capabilities
+ *	@func: SDIO function attached to host
+ *
+ *	REturns a capability bitmask corresponding to power management
+ *	features supported by the host controller that the card function
+ *	might rely upon during a system suspend.  The host doesn't need
+ *	to be claimed, nor the function active, for this information to be
+ *	obtained.
+ */
+mmc_pm_flag_t sdio_get_host_pm_caps(struct sdio_func *func)
+{
+	BUG_ON(!func);
+	BUG_ON(!func->card);
+
+	return func->card->host->pm_caps;
+}
+EXPORT_SYMBOL_GPL(sdio_get_host_pm_caps);
+
+/**
+ *	sdio_set_host_pm_flags - set wanted host power management capabilities
+ *	@func: SDIO function attached to host
+ *
+ *	Set a capability bitmask corresponding to wanted host controller
+ *	power management features for the upcoming suspend state.
+ *	This must be called, if needed, each time the suspend method of
+ *	the function driver is called, and must contain only bits that
+ *	were returned by sdio_get_host_pm_caps().
+ *	The host doesn't need to be claimed, nor the function active,
+ *	for this information to be set.
+ */
+int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags)
+{
+	struct mmc_host *host;
+
+	BUG_ON(!func);
+	BUG_ON(!func->card);
+
+	host = func->card->host;
+
+	if (flags & ~host->pm_caps)
+		return -EINVAL;
+
+	/* function suspend methods are serialized, hence no lock needed */
+	host->pm_flags |= flags;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sdio_set_host_pm_flags);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index eaf3636..43eaf5c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 
 #include <linux/mmc/core.h>
+#include <linux/mmc/pm.h>
 
 struct mmc_ios {
 	unsigned int	clock;			/* clock rate */
@@ -152,6 +153,8 @@ struct mmc_host {
 #define MMC_CAP_NONREMOVABLE	(1 << 8)	/* Nonremovable e.g. eMMC */
 #define MMC_CAP_WAIT_WHILE_BUSY	(1 << 9)	/* Waits while card is busy */
 
+	mmc_pm_flag_t		pm_caps;	/* supported pm features */
+
 	/* host specific block data */
 	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
 	unsigned short		max_hw_segs;	/* see blk_queue_max_hw_segments */
@@ -197,6 +200,8 @@ struct mmc_host {
 	struct task_struct	*sdio_irq_thread;
 	atomic_t		sdio_irq_thread_abort;
 
+	mmc_pm_flag_t		pm_flags;	/* requested pm features */
+
 #ifdef CONFIG_LEDS_TRIGGERS
 	struct led_trigger	*led;		/* activity led */
 #endif
diff --git a/include/linux/mmc/pm.h b/include/linux/mmc/pm.h
new file mode 100644
index 0000000..d37aac4
--- /dev/null
+++ b/include/linux/mmc/pm.h
@@ -0,0 +1,30 @@
+/*
+ * linux/include/linux/mmc/pm.h
+ *
+ * Author:	Nicolas Pitre
+ * Copyright:	(C) 2009 Marvell Technology Group Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef LINUX_MMC_PM_H
+#define LINUX_MMC_PM_H
+
+/*
+ * These flags are used to describe power management features that
+ * some cards (typically SDIO cards) might wish to benefit from when
+ * the host system is being suspended.  There are several layers of
+ * abstractions involved, from the host controller driver, to the MMC core
+ * code, to the SDIO core code, to finally get to the actual SDIO function
+ * driver.  This file is therefore used for common definitions shared across
+ * all those layers.
+ */
+
+typedef unsigned int mmc_pm_flag_t;
+
+#define MMC_PM_KEEP_POWER	(1 << 0)	/* preserve card power during suspend */
+#define MMC_PM_WAKE_SDIO_IRQ	(1 << 1)	/* wake up host system on SDIO IRQ assertion */
+
+#endif
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index ac3ab68..c6c0cce 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -15,6 +15,8 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 
+#include <linux/mmc/pm.h>
+
 struct mmc_card;
 struct sdio_func;
 
@@ -153,5 +155,8 @@ extern unsigned char sdio_f0_readb(struct sdio_func *func,
 extern void sdio_f0_writeb(struct sdio_func *func, unsigned char b,
 	unsigned int addr, int *err_ret);
 
+extern mmc_pm_flag_t sdio_get_host_pm_caps(struct sdio_func *func);
+extern int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags);
+
 #endif
 
-- 
1.7.0.rc2.1.g694b5

