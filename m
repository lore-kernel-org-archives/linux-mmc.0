From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] mmc: agressive clocking framework v9
Date: Thu,  4 Nov 2010 12:16:30 +0100
Message-ID: <1288869390-20465-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:37851 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755079Ab0KDLRd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 4 Nov 2010 07:17:33 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, David Vrabel <david.vrabel@csr.com>, Kyungmin Park <kmpark@infradead.org>, jh80.chung@samsung.com, Linus Walleij <linus.walleij@stericsson.com>

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

It is injected into the runtime PM support that is already
available for the host controller, so the runtime suspend/resume
flow will now be like this:

1. gate the clock with set_ios()
2. call the host core .disable() function
3. suspend complete
4. call the host core .enable() function
5. ungate the clock with set_ios()

Both gating and enable/disable are made optional.

The gate/disable delay is now one and the same. However
if clock gating is enabled, the delay is assured to be
at least 8 MCI bus cycles, as per the MMC spec. Biggest
delay takes precedence.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
Changes v7->v9:

Switch to grouping this with the runtime PM stuff as Alan
suggested. Is this looking better?

Disadvantage of this: platforms that don't want runtime PM can't
use this.

Code is untested: compiling in runtime PM hangs my platform,
can the Texas guys try this maybe?
---
 drivers/mmc/core/Kconfig |   11 ++++
 drivers/mmc/core/bus.c   |    7 ++-
 drivers/mmc/core/core.c  |  114 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/core/core.h  |   23 +++++++++
 include/linux/mmc/host.h |    5 ++
 5 files changed, 156 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index bb22ffd..8915c03 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -16,3 +16,14 @@ config MMC_UNSAFE_RESUME
 
 	  This option sets a default which can be overridden by the
 	  module parameter "removable=0" or "removable=1".
+
+config MMC_CLKGATE
+	bool "MMC host clock gating (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && PM_RUNTIME
+	help
+	  This will attempt to agressively gate the clock to the MMC card.
+	  This is done to save power due to gating off the logic and bus
+	  noise when the MMC card is not in use. Your host driver has to
+	  support handling this in order for it to be of any use.
+
+	  If unsure, say N.
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index af8dc6a..9064def 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -148,14 +148,19 @@ static int mmc_runtime_suspend(struct device *dev)
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
 
+	mmc_gate_clock(card->host);
 	return mmc_power_save_host(card->host);
 }
 
 static int mmc_runtime_resume(struct device *dev)
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
+	int ret;
 
-	return mmc_power_restore_host(card->host);
+	ret = mmc_power_restore_host(card->host);
+	if (!ret)
+		mmc_ungate_clock(card->host);
+	return ret;
 }
 
 static int mmc_runtime_idle(struct device *dev)
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8f86d70..b997d6c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -296,7 +296,7 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
 
 		timeout_us = data->timeout_ns / 1000;
 		timeout_us += data->timeout_clks * 1000 /
-			(card->host->ios.clock / 1000);
+			(mmc_host_clk_rate(card->host) / 1000);
 
 		if (data->flags & MMC_DATA_WRITE)
 			/*
@@ -561,6 +561,8 @@ void mmc_host_deeper_disable(struct work_struct *work)
  */
 int mmc_host_lazy_disable(struct mmc_host *host)
 {
+	unsigned int disable_delay = mmc_host_disable_delay(host);
+
 	if (!(host->caps & MMC_CAP_DISABLE))
 		return 0;
 
@@ -573,9 +575,9 @@ int mmc_host_lazy_disable(struct mmc_host *host)
 	if (!host->enabled)
 		return 0;
 
-	if (host->disable_delay) {
+	if (disable_delay) {
 		mmc_schedule_delayed_work(&host->disable,
-				msecs_to_jiffies(host->disable_delay));
+				msecs_to_jiffies(disable_delay));
 		return 0;
 	} else
 		return mmc_host_do_disable(host, 1);
@@ -614,6 +616,12 @@ static inline void mmc_set_ios(struct mmc_host *host)
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
 
@@ -641,6 +649,106 @@ void mmc_set_clock(struct mmc_host *host, unsigned int hz)
 	mmc_set_ios(host);
 }
 
+#ifdef CONFIG_MMC_CLKGATE
+/**
+ * mmc_host_may_gate_card - check if this card may be gated
+ * @card: card to check.
+ */
+static bool mmc_may_gate_card(struct mmc_card *card)
+{
+	/* If there is no card we may gate it */
+	if (!card)
+		return true;
+	/*
+	 * Don't gate SDIO cards! These need to be clocked at all times
+	 * since they may be independent systems generating interrupts
+	 * and other events. The clock requests counter from the core will
+	 * go down to zero since the core does not need it, but we will not
+	 * gate the clock, because there is somebody out there that may still
+	 * be using it.
+	 */
+	if (mmc_card_sdio(card))
+		return false;
+
+	return true;
+}
+
+/**
+ * mmc_host_clk_rate - get current clock frequency setting no matter
+ * whether it's gated or not.
+ * @host: host to get the clock frequency for.
+ */
+unsigned int mmc_host_clk_rate(struct mmc_host *host)
+{
+	unsigned long freq;
+
+	if (host->clk_gated)
+		freq = host->clk_old;
+	else
+		freq = host->ios.clock;
+	return freq;
+}
+
+/**
+ * mmc_gate_clock - gates the clock by setting it to 0 Hz.
+ * @host: the host to gate
+ */
+void mmc_gate_clock(struct mmc_host *host)
+{
+	if (!mmc_may_gate_card(host->card))
+		return;
+	host->clk_old = host->ios.clock;
+	host->ios.clock = 0;
+	host->clk_gated = true;
+	mmc_set_ios(host);
+}
+
+/**
+ * mmc_ungate_clock - restores the clock from gating by using the cached
+ * clock value
+ * @host: the host to ungate
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
+
+/**
+ * mmc_host_disable_delay - adjust delay so it covers atleast 8 MCLK cycles
+ * @host_delay: delay suggested by the host controller
+ * All measures in milliseconds. This makes the runtime PM gate the
+ * clock and also call the host disable function (if any) after at
+ * least 8 MCI clock cycles.
+ */
+unsigned int mmc_host_disable_delay(struct mmc_host *host)
+{
+	unsigned long freq = host->ios.clock;
+	unsigned long tick_ms;
+	unsigned long host_delay = host->disable_delay;
+
+	if (!freq)
+		return host_delay;
+	/*
+	 * Delay n bus cycles (at least 8 from MMC spec) before attempting
+	 * to disable the MCI clock.
+	 */
+	tick_ms = 8 * DIV_ROUND_UP(1000000, freq);
+	return (tick_ms > host_delay) ? tick_ms : host_delay;
+}
+#endif
+
 /*
  * Change the bus mode (open drain/push-pull) of a host.
  */
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 77240cd..0eb3f3f 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -68,5 +68,28 @@ void mmc_remove_host_debugfs(struct mmc_host *host);
 void mmc_add_card_debugfs(struct mmc_card *card);
 void mmc_remove_card_debugfs(struct mmc_card *card);
 
+/* Clock gating functions */
+#ifdef CONFIG_MMC_CLKGATE
+unsigned int mmc_host_clk_rate(struct mmc_host *host);
+void mmc_gate_clock(struct mmc_host *host);
+void mmc_ungate_clock(struct mmc_host *host);
+unsigned int mmc_host_disable_delay(struct mmc_host *host);
+#else
+static inline unsigned int mmc_host_clk_rate(struct mmc_host *host)
+{
+	return host->ios.clock;
+}
+static inline void mmc_gate_clock(struct mmc_host *host)
+{
+}
+static inline void mmc_ungate_clock(struct mmc_host *host)
+{
+}
+static inline unsigned int mmc_host_disable_delay(struct mmc_host *host)
+{
+	return host->disable_delay;
+}
+#endif
+
 #endif
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 6d87f68..6f83d71 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -171,6 +171,11 @@ struct mmc_host {
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
+#ifdef CONFIG_MMC_CLKGATE
+	bool			clk_gated;	/* clock gated */
+	unsigned int		clk_old;	/* old clock value cache */
+#endif
+
 	/* host specific block data */
 	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
 	unsigned short		max_segs;	/* see blk_queue_max_segments */
-- 
1.7.2.3

