From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 1/2] MMC Agressive clocking framework v7
Date: Sun, 31 Oct 2010 17:06:09 +0100
Message-ID: <1288541169-16054-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:58926 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755861Ab0JaQGv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 31 Oct 2010 12:06:51 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, jh80.chung@samsung.com, Kyungmin Park <kmpark@infradead.org>, arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@stericsson.com>

This patch modifies the MMC core code to optionally call the
set_ios() operation on the driver with the clock frequency set
to 0 (gate) after a grace period of at least 8 MCLK cycles, then
restore it (ungate) before any new request. This gives
the driver the option to shut down the MCI clock to the MMC/SD
card when the clock frequency is 0, i.e. the core has stated
that the MCI clock does not need to be generated.

It is inspired by existing clock gating code found in the OMAP
and Atmel drivers and brings this up to the host abstraction.
Gating is performed before and after any MMC request.

It exemplifies by implementing this for the MMCI/PL180 MMC/SD
host controller, but it should be simple to switch OMAP and
Atmel over to using this instead.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
Changes v6->v7: found a bug when "gearing up" cards to higher
frequencies while the clock is gated. Regard this set_ios()
event as an "ungate".
---
 drivers/mmc/core/Kconfig   |   11 +++
 drivers/mmc/core/core.c    |   45 +++++++++++-
 drivers/mmc/core/core.h    |    2 +
 drivers/mmc/core/debugfs.c |    5 +
 drivers/mmc/core/host.c    |  182 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/core/host.h    |   21 +++++
 include/linux/mmc/host.h   |   10 +++
 7 files changed, 274 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index bb22ffd..1018ccc1 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -16,3 +16,14 @@ config MMC_UNSAFE_RESUME
 
 	  This option sets a default which can be overridden by the
 	  module parameter "removable=0" or "removable=1".
+
+config MMC_CLKGATE
+	bool "MMC host clock gating (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  This will attempt to agressively gate the clock to the MMC card.
+	  This is done to save power due to gating off the logic and bus
+	  noise when the MMC card is not in use. Your host driver has to
+	  support handling this in order for it to be of any use.
+
+	  If unsure, say N.
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8f86d70..1be5d65 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -130,6 +130,8 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 
 		if (mrq->done)
 			mrq->done(mrq);
+
+		mmc_host_clk_gate(host);
 	}
 }
 
@@ -190,6 +192,7 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 			mrq->stop->mrq = mrq;
 		}
 	}
+	mmc_host_clk_ungate(host);
 	host->ops->request(host, mrq);
 }
 
@@ -296,7 +299,7 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 
 		timeout_us = data->timeout_ns / 1000;
 		timeout_us += data->timeout_clks * 1000 /
-			(card->host->ios.clock / 1000);
+			(mmc_host_clk_rate(card->host) / 1000);
 
 		if (data->flags & MMC_DATA_WRITE)
 			/*
@@ -614,6 +617,12 @@ static inline void mmc_set_ios(struct mmc_host *host)
 		 ios->power_mode, ios->chip_select, ios->vdd,
 		 ios->bus_width, ios->timing);
 
+	/*
+	 * We get a new frequency while the clock is gated,
+	 * so make sure we regard this as ungating it.
+	 */
+	if (ios->clock > 0 && host->clk_gated)
+		host->clk_gated = false;
 	host->ops->set_ios(host, ios);
 }
 
@@ -641,6 +650,40 @@ void mmc_set_clock(struct mmc_host *host, unsigned int hz)
 	mmc_set_ios(host);
 }
 
+#ifdef CONFIG_MMC_CLKGATE
+/*
+ * This gates the clock by setting it to 0 Hz.
+ */
+void mmc_gate_clock(struct mmc_host *host)
+{
+	host->clk_old = host->ios.clock;
+	host->ios.clock = 0;
+	host->clk_gated = true;
+	mmc_set_ios(host);
+}
+
+/*
+ * This restores the clock from gating by using the cached
+ * clock value.
+ */
+void mmc_ungate_clock(struct mmc_host *host)
+{
+	/*
+	 * We should previously have gated the clock, so the clock
+	 * shall be 0 here!
+	 * The clock may however be 0 during intialization,
+	 * when some request operations are performed before setting
+	 * the frequency. When ungate is requested in that situation
+	 * we just ignore the call.
+	 */
+	if (host->clk_old) {
+		BUG_ON(host->ios.clock);
+		mmc_set_clock(host, host->clk_old);
+	}
+	host->clk_gated = false;
+}
+#endif
+
 /*
  * Change the bus mode (open drain/push-pull) of a host.
  */
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 77240cd..9972808 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -33,6 +33,8 @@ void mmc_init_erase(struct mmc_card *card);
 
 void mmc_set_chip_select(struct mmc_host *host, int mode);
 void mmc_set_clock(struct mmc_host *host, unsigned int hz);
+void mmc_gate_clock(struct mmc_host *host);
+void mmc_ungate_clock(struct mmc_host *host);
 void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
 void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
 void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index eed1405..998797e 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -183,6 +183,11 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 			&mmc_clock_fops))
 		goto err_node;
 
+#ifdef CONFIG_MMC_CLKGATE
+	if (!debugfs_create_u32("clk_delay", (S_IRUSR | S_IWUSR),
+				root, &host->clk_delay))
+		goto err_node;
+#endif
 	return;
 
 err_node:
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 10b8af2..f1834fb 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -3,6 +3,7 @@
  *
  *  Copyright (C) 2003 Russell King, All Rights Reserved.
  *  Copyright (C) 2007-2008 Pierre Ossman
+ *  Copyright (C) 2010 Linus Walleij
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -50,6 +51,182 @@ void mmc_unregister_host_class(void)
 static DEFINE_IDR(mmc_host_idr);
 static DEFINE_SPINLOCK(mmc_host_lock);
 
+#ifdef CONFIG_MMC_CLKGATE
+
+/*
+ * Enabling clock gating will make the core call out to the host
+ * once up and once down when it performs a request or card operation
+ * intermingled in any fashion. The driver will see this through
+ * set_ios() operations with ios.clock field set to 0 to gate
+ * (disable) the block clock, and to the old frequency to enable
+ * it again.
+ */
+static void mmc_host_clk_gate_delayed(struct mmc_host *host)
+{
+	unsigned long tick_ns;
+	unsigned long freq = host->ios.clock;
+	unsigned long flags;
+	int users;
+
+	if (!freq) {
+		pr_err("%s: frequency set to 0 in disable function, "
+		       "this means the clock is already disabled.\n",
+		       mmc_hostname(host));
+		return;
+	}
+	/*
+	 * New requests may have appeared while we were scheduling,
+	 * then there is no reason to delay the check before
+	 * clk_disable().
+	 */
+	spin_lock_irqsave(&host->clk_lock, flags);
+	users = host->clk_requests;
+	/*
+	 * Delay n bus cycles (at least 8 from MMC spec) before attempting
+	 * to disable the MCI block clock. The reference count
+	 * may have gone up again after this delay due to
+	 * rescheduling!
+	 */
+	if (!users) {
+		spin_unlock_irqrestore(&host->clk_lock, flags);
+		tick_ns = DIV_ROUND_UP(1000000000, freq);
+		ndelay(host->clk_delay * tick_ns);
+	} else {
+		/* New users appeared while waiting for this work */
+		host->clk_pending_gate = false;
+		spin_unlock_irqrestore(&host->clk_lock, flags);
+		return;
+	}
+	spin_lock_irqsave(&host->clk_lock, flags);
+	if (!host->clk_requests) {
+		spin_unlock_irqrestore(&host->clk_lock, flags);
+		/* this will set host->ios.clock to 0 */
+		mmc_gate_clock(host);
+		spin_lock_irqsave(&host->clk_lock, flags);
+		pr_debug("%s: gated MCI clock\n",
+			 mmc_hostname(host));
+	}
+	host->clk_pending_gate = false;
+	spin_unlock_irqrestore(&host->clk_lock, flags);
+}
+
+/*
+ * Internal work. Work to disable the clock at some later point.
+ */
+static void mmc_host_clk_gate_work(struct work_struct *work)
+{
+	struct mmc_host *host = container_of(work, struct mmc_host,
+					      clk_disable_work);
+
+	mmc_host_clk_gate_delayed(host);
+}
+
+/*
+ *	mmc_host_clk_ungate - make sure the host ios.clock is
+ *	restored to some non-zero value past this call.
+ *	@host: host to ungate.
+ *
+ *	Increase clock reference count and ungate clock if first user.
+ */
+void mmc_host_clk_ungate(struct mmc_host *host)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->clk_lock, flags);
+	if (host->clk_gated) {
+		spin_unlock_irqrestore(&host->clk_lock, flags);
+		mmc_ungate_clock(host);
+		spin_lock_irqsave(&host->clk_lock, flags);
+		pr_debug("%s: ungated MCI clock\n",
+			 mmc_hostname(host));
+	}
+	host->clk_requests++;
+	spin_unlock_irqrestore(&host->clk_lock, flags);
+}
+
+/*
+ *	mmc_host_clk_gate - call the host driver with ios.clock
+ *	set to zero as often as possible so as to make it
+ *	possible to gate off hardware MCI clocks.
+ *	@host: host to gate.
+ *
+ *	Decrease clock reference count and schedule disablement of clock.
+ */
+void mmc_host_clk_gate(struct mmc_host *host)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->clk_lock, flags);
+	host->clk_requests--;
+	if (!host->clk_requests) {
+		host->clk_pending_gate = true;
+		schedule_work(&host->clk_disable_work);
+	}
+	spin_unlock_irqrestore(&host->clk_lock, flags);
+}
+
+/*
+ *	mmc_host_clk_rate - get current clock frequency setting no matter
+ *	whether it's gated or not.
+ *	@host: host to get the clock frequency for.
+ */
+unsigned int mmc_host_clk_rate(struct mmc_host *host)
+{
+	unsigned long freq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->clk_lock, flags);
+	if (host->clk_gated)
+		freq = host->clk_old;
+	else
+		freq = host->ios.clock;
+	spin_unlock_irqrestore(&host->clk_lock, flags);
+	return freq;
+}
+
+/*
+ *	mmc_host_clk_init - set up clock gating code
+ *	@host: host with potential clock to control
+ */
+static inline void mmc_host_clk_init(struct mmc_host *host)
+{
+	host->clk_requests = 0;
+	host->clk_delay = 8; /* hold MCI clock in 8 cycles by default */
+	host->clk_gated = false;
+	host->clk_pending_gate = false;
+	INIT_WORK(&host->clk_disable_work, mmc_host_clk_gate_work);
+	spin_lock_init(&host->clk_lock);
+}
+
+/*
+ *	mmc_host_clk_exit - shut down clock gating code
+ *	@host: host with potential clock to control
+ */
+static inline void mmc_host_clk_exit(struct mmc_host *host)
+{
+	/*
+	 * Wait for any outstanding gate and then make sure we're
+	 * ungated before exiting.
+	 */
+	if (cancel_work_sync(&host->clk_disable_work))
+		mmc_host_clk_gate_delayed(host);
+	if (host->clk_gated)
+		mmc_host_clk_ungate(host);
+	BUG_ON(host->clk_requests > 0);
+}
+
+#else
+
+static inline void mmc_host_clk_init(struct mmc_host *host)
+{
+}
+
+static inline void mmc_host_clk_exit(struct mmc_host *host)
+{
+}
+
+#endif
+
 /**
  *	mmc_alloc_host - initialise the per-host structure.
  *	@extra: sizeof private data structure
@@ -82,6 +259,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->class_dev.class = &mmc_host_class;
 	device_initialize(&host->class_dev);
 
+	mmc_host_clk_init(host);
+
 	spin_lock_init(&host->lock);
 	init_waitqueue_head(&host->wq);
 	INIT_DELAYED_WORK(&host->detect, mmc_rescan);
@@ -163,6 +342,8 @@ void mmc_remove_host(struct mmc_host *host)
 	device_del(&host->class_dev);
 
 	led_trigger_unregister_simple(host->led);
+
+	mmc_host_clk_exit(host);
 }
 
 EXPORT_SYMBOL(mmc_remove_host);
@@ -183,4 +364,3 @@ void mmc_free_host(struct mmc_host *host)
 }
 
 EXPORT_SYMBOL(mmc_free_host);
-
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 8c87e11..de199f9 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -10,10 +10,31 @@
  */
 #ifndef _MMC_CORE_HOST_H
 #define _MMC_CORE_HOST_H
+#include <linux/mmc/host.h>
 
 int mmc_register_host_class(void);
 void mmc_unregister_host_class(void);
 
+#ifdef CONFIG_MMC_CLKGATE
+void mmc_host_clk_ungate(struct mmc_host *host);
+void mmc_host_clk_gate(struct mmc_host *host);
+unsigned int mmc_host_clk_rate(struct mmc_host *host);
+
+#else
+static inline void mmc_host_clk_ungate(struct mmc_host *host)
+{
+}
+
+static inline void mmc_host_clk_gate(struct mmc_host *host)
+{
+}
+
+static inline unsigned int mmc_host_clk_rate(struct mmc_host *host)
+{
+	return host->ios.clock;
+}
+#endif
+
 void mmc_host_deeper_disable(struct work_struct *work);
 
 #endif
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 6d87f68..c38c400 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -171,6 +171,16 @@ struct mmc_host {
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
+#ifdef CONFIG_MMC_CLKGATE
+	int			clk_requests;	/* internal reference counter */
+	unsigned int		clk_delay;	/* number of MCI clk hold cycles */
+	bool			clk_gated;	/* clock gated */
+	bool			clk_pending_gate; /* pending clock gating */
+	struct work_struct	clk_disable_work; /* delayed clock disablement */
+	unsigned int		clk_old;	/* old clock value cache */
+	spinlock_t		clk_lock;	/* lock for clk fields */
+#endif
+
 	/* host specific block data */
 	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
 	unsigned short		max_segs;	/* see blk_queue_max_segments */
-- 
1.7.2.3

