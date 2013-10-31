From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2] mmc: core: Remove MMC_CLKGATE
Date: Thu, 31 Oct 2013 01:01:40 +0100
Message-ID: <1383177700-30064-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:56381 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab3JaABp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 20:01:45 -0400
Received: by mail-oa0-f49.google.com with SMTP id j10so2273847oah.8
        for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2013 17:01:45 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

No platforms is using MMC_CLKGATE anymore. Moreover the same clock
gating operations are easier to implement using runtime PM, which
several host drivers already had converted to.

By removing all related code for MMC_CLKGATE, a significant less amount
of code needs to be maintained. The corresponding code for the
MMC_QUIRK_BROKEN_CLK_GATING is also removed in this patch.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Rebased patches towards latest mmc-next.
	- Removed code for corresponding MMC_QUIRK_BROKEN_CLK_GATING as well.

---
 Documentation/mmc/mmc-dev-attrs.txt |   10 --
 drivers/mmc/core/Kconfig            |   10 --
 drivers/mmc/core/core.c             |  114 +---------------
 drivers/mmc/core/core.h             |    3 -
 drivers/mmc/core/debugfs.c          |    5 -
 drivers/mmc/core/host.c             |  245 -----------------------------------
 drivers/mmc/core/mmc.c              |    6 +-
 drivers/mmc/core/quirks.c           |   18 ---
 drivers/mmc/core/sd.c               |   12 +-
 drivers/mmc/core/sdio.c             |    5 +-
 drivers/mmc/core/sdio_irq.c         |   10 +-
 include/linux/mmc/card.h            |    1 -
 include/linux/mmc/host.h            |   27 ----
 13 files changed, 12 insertions(+), 454 deletions(-)

diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/mmc-dev-attrs.txt
index 189bab0..caa5557 100644
--- a/Documentation/mmc/mmc-dev-attrs.txt
+++ b/Documentation/mmc/mmc-dev-attrs.txt
@@ -72,13 +72,3 @@ Note on raw_rpmb_size_mult:
 	"raw_rpmb_size_mult" is a mutliple of 128kB block.
 	RPMB size in byte is calculated by using the following equation:
 	RPMB partition size = 128kB x raw_rpmb_size_mult
-
-SD/MMC/SDIO Clock Gating Attribute
-==================================
-
-Read and write access is provided to following attribute.
-This attribute appears only if CONFIG_MMC_CLKGATE is enabled.
-
-	clkgate_delay	Tune the clock gating delay with desired value in milliseconds.
-
-echo <desired delay> > /sys/class/mmc_host/mmcX/clkgate_delay
diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index 269d072..bb22ffd 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -16,13 +16,3 @@ config MMC_UNSAFE_RESUME
 
 	  This option sets a default which can be overridden by the
 	  module parameter "removable=0" or "removable=1".
-
-config MMC_CLKGATE
-	bool "MMC host clock gating"
-	help
-	  This will attempt to aggressively gate the clock to the MMC card.
-	  This is done to save power due to gating off the logic and bus
-	  noise when the MMC card is not in use. Your host driver has to
-	  support handling this in order for it to be of any use.
-
-	  If unsure, say N.
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 57a2b40..2b0a122 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -186,8 +186,6 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 
 		if (mrq->done)
 			mrq->done(mrq);
-
-		mmc_host_clk_release(host);
 	}
 }
 
@@ -252,7 +250,6 @@ mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 			mrq->stop->mrq = mrq;
 		}
 	}
-	mmc_host_clk_hold(host);
 	led_trigger_event(host->led, LED_FULL);
 	host->ops->request(host, mrq);
 }
@@ -483,11 +480,8 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
 static void mmc_pre_req(struct mmc_host *host, struct mmc_request *mrq,
 		 bool is_first_req)
 {
-	if (host->ops->pre_req) {
-		mmc_host_clk_hold(host);
+	if (host->ops->pre_req)
 		host->ops->pre_req(host, mrq, is_first_req);
-		mmc_host_clk_release(host);
-	}
 }
 
 /**
@@ -502,11 +496,8 @@ static void mmc_pre_req(struct mmc_host *host, struct mmc_request *mrq,
 static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
 			 int err)
 {
-	if (host->ops->post_req) {
-		mmc_host_clk_hold(host);
+	if (host->ops->post_req)
 		host->ops->post_req(host, mrq, err);
-		mmc_host_clk_release(host);
-	}
 }
 
 /**
@@ -984,8 +975,6 @@ static inline void mmc_set_ios(struct mmc_host *host)
 		 ios->power_mode, ios->chip_select, ios->vdd,
 		 ios->bus_width, ios->timing);
 
-	if (ios->clock > 0)
-		mmc_set_ungated(host);
 	host->ops->set_ios(host, ios);
 }
 
@@ -994,17 +983,15 @@ static inline void mmc_set_ios(struct mmc_host *host)
  */
 void mmc_set_chip_select(struct mmc_host *host, int mode)
 {
-	mmc_host_clk_hold(host);
 	host->ios.chip_select = mode;
 	mmc_set_ios(host);
-	mmc_host_clk_release(host);
 }
 
 /*
  * Sets the host clock to the highest possible frequency that
  * is below "hz".
  */
-static void __mmc_set_clock(struct mmc_host *host, unsigned int hz)
+void mmc_set_clock(struct mmc_host *host, unsigned int hz)
 {
 	WARN_ON(hz < host->f_min);
 
@@ -1015,77 +1002,13 @@ static void __mmc_set_clock(struct mmc_host *host, unsigned int hz)
 	mmc_set_ios(host);
 }
 
-void mmc_set_clock(struct mmc_host *host, unsigned int hz)
-{
-	mmc_host_clk_hold(host);
-	__mmc_set_clock(host, hz);
-	mmc_host_clk_release(host);
-}
-
-#ifdef CONFIG_MMC_CLKGATE
-/*
- * This gates the clock by setting it to 0 Hz.
- */
-void mmc_gate_clock(struct mmc_host *host)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&host->clk_lock, flags);
-	host->clk_old = host->ios.clock;
-	host->ios.clock = 0;
-	host->clk_gated = true;
-	spin_unlock_irqrestore(&host->clk_lock, flags);
-	mmc_set_ios(host);
-}
-
-/*
- * This restores the clock from gating by using the cached
- * clock value.
- */
-void mmc_ungate_clock(struct mmc_host *host)
-{
-	/*
-	 * We should previously have gated the clock, so the clock shall
-	 * be 0 here! The clock may however be 0 during initialization,
-	 * when some request operations are performed before setting
-	 * the frequency. When ungate is requested in that situation
-	 * we just ignore the call.
-	 */
-	if (host->clk_old) {
-		BUG_ON(host->ios.clock);
-		/* This call will also set host->clk_gated to false */
-		__mmc_set_clock(host, host->clk_old);
-	}
-}
-
-void mmc_set_ungated(struct mmc_host *host)
-{
-	unsigned long flags;
-
-	/*
-	 * We've been given a new frequency while the clock is gated,
-	 * so make sure we regard this as ungating it.
-	 */
-	spin_lock_irqsave(&host->clk_lock, flags);
-	host->clk_gated = false;
-	spin_unlock_irqrestore(&host->clk_lock, flags);
-}
-
-#else
-void mmc_set_ungated(struct mmc_host *host)
-{
-}
-#endif
-
 /*
  * Change the bus mode (open drain/push-pull) of a host.
  */
 void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode)
 {
-	mmc_host_clk_hold(host);
 	host->ios.bus_mode = mode;
 	mmc_set_ios(host);
-	mmc_host_clk_release(host);
 }
 
 /*
@@ -1093,10 +1016,8 @@ void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode)
  */
 void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
 {
-	mmc_host_clk_hold(host);
 	host->ios.bus_width = width;
 	mmc_set_ios(host);
-	mmc_host_clk_release(host);
 }
 
 /**
@@ -1394,11 +1315,8 @@ int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
 	int old_signal_voltage = host->ios.signal_voltage;
 
 	host->ios.signal_voltage = signal_voltage;
-	if (host->ops->start_signal_voltage_switch) {
-		mmc_host_clk_hold(host);
+	if (host->ops->start_signal_voltage_switch)
 		err = host->ops->start_signal_voltage_switch(host, &host->ios);
-		mmc_host_clk_release(host);
-	}
 
 	if (err)
 		host->ios.signal_voltage = old_signal_voltage;
@@ -1443,7 +1361,6 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, u32 ocr)
 	if (!mmc_host_is_spi(host) && (cmd.resp[0] & R1_ERROR))
 		return -EIO;
 
-	mmc_host_clk_hold(host);
 	/*
 	 * The card should drive cmd and dat[0:3] low immediately
 	 * after the response of cmd11, but wait 1 ms to be sure
@@ -1492,8 +1409,6 @@ power_cycle:
 		mmc_power_cycle(host, ocr);
 	}
 
-	mmc_host_clk_release(host);
-
 	return err;
 }
 
@@ -1502,10 +1417,8 @@ power_cycle:
  */
 void mmc_set_timing(struct mmc_host *host, unsigned int timing)
 {
-	mmc_host_clk_hold(host);
 	host->ios.timing = timing;
 	mmc_set_ios(host);
-	mmc_host_clk_release(host);
 }
 
 /*
@@ -1513,10 +1426,8 @@ void mmc_set_timing(struct mmc_host *host, unsigned int timing)
  */
 void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
 {
-	mmc_host_clk_hold(host);
 	host->ios.drv_type = drv_type;
 	mmc_set_ios(host);
-	mmc_host_clk_release(host);
 }
 
 /*
@@ -1535,8 +1446,6 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 	if (host->ios.power_mode == MMC_POWER_ON)
 		return;
 
-	mmc_host_clk_hold(host);
-
 	host->ios.vdd = fls(ocr) - 1;
 	if (mmc_host_is_spi(host))
 		host->ios.chip_select = MMC_CS_HIGH;
@@ -1567,8 +1476,6 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 	 * time required to reach a stable voltage.
 	 */
 	mmc_delay(10);
-
-	mmc_host_clk_release(host);
 }
 
 void mmc_power_off(struct mmc_host *host)
@@ -1576,8 +1483,6 @@ void mmc_power_off(struct mmc_host *host)
 	if (host->ios.power_mode == MMC_POWER_OFF)
 		return;
 
-	mmc_host_clk_hold(host);
-
 	host->ios.clock = 0;
 	host->ios.vdd = 0;
 
@@ -1596,8 +1501,6 @@ void mmc_power_off(struct mmc_host *host)
 	 * can be successfully turned on again.
 	 */
 	mmc_delay(1);
-
-	mmc_host_clk_release(host);
 }
 
 void mmc_power_cycle(struct mmc_host *host, u32 ocr)
@@ -2226,9 +2129,7 @@ static void mmc_hw_reset_for_init(struct mmc_host *host)
 {
 	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
 		return;
-	mmc_host_clk_hold(host);
 	host->ops->hw_reset(host);
-	mmc_host_clk_release(host);
 }
 
 int mmc_can_reset(struct mmc_card *card)
@@ -2260,7 +2161,6 @@ static int mmc_do_hw_reset(struct mmc_host *host, int check)
 	if (!mmc_can_reset(card))
 		return -EOPNOTSUPP;
 
-	mmc_host_clk_hold(host);
 	mmc_set_clock(host, host->f_init);
 
 	host->ops->hw_reset(host);
@@ -2275,10 +2175,8 @@ static int mmc_do_hw_reset(struct mmc_host *host, int check)
 			cmd.arg = card->rca << 16;
 		cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
 		err = mmc_wait_for_cmd(card->host, &cmd, 0);
-		if (!err) {
-			mmc_host_clk_release(host);
+		if (!err)
 			return -ENOSYS;
-		}
 	}
 
 	host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_DDR);
@@ -2293,8 +2191,6 @@ static int mmc_do_hw_reset(struct mmc_host *host, int check)
 	host->ios.timing = MMC_TIMING_LEGACY;
 	mmc_set_ios(host);
 
-	mmc_host_clk_release(host);
-
 	return host->bus_ops->power_restore(host);
 }
 
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 443a584..2eb1ade 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -36,9 +36,6 @@ void mmc_init_erase(struct mmc_card *card);
 
 void mmc_set_chip_select(struct mmc_host *host, int mode);
 void mmc_set_clock(struct mmc_host *host, unsigned int hz);
-void mmc_gate_clock(struct mmc_host *host);
-void mmc_ungate_clock(struct mmc_host *host);
-void mmc_set_ungated(struct mmc_host *host);
 void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
 void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
 u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 54829c0..5509fef 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -224,11 +224,6 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 			&mmc_clock_fops))
 		goto err_node;
 
-#ifdef CONFIG_MMC_CLKGATE
-	if (!debugfs_create_u32("clk_delay", (S_IRUSR | S_IWUSR),
-				root, &host->clk_delay))
-		goto err_node;
-#endif
 #ifdef CONFIG_FAIL_MMC_REQUEST
 	if (fail_request)
 		setup_fault_attr(&fail_default_attr, fail_request);
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 49bc403..fa6a903 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -57,246 +57,6 @@ void mmc_unregister_host_class(void)
 static DEFINE_IDR(mmc_host_idr);
 static DEFINE_SPINLOCK(mmc_host_lock);
 
-#ifdef CONFIG_MMC_CLKGATE
-static ssize_t clkgate_delay_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct mmc_host *host = cls_dev_to_mmc_host(dev);
-	return snprintf(buf, PAGE_SIZE, "%lu\n", host->clkgate_delay);
-}
-
-static ssize_t clkgate_delay_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct mmc_host *host = cls_dev_to_mmc_host(dev);
-	unsigned long flags, value;
-
-	if (kstrtoul(buf, 0, &value))
-		return -EINVAL;
-
-	spin_lock_irqsave(&host->clk_lock, flags);
-	host->clkgate_delay = value;
-	spin_unlock_irqrestore(&host->clk_lock, flags);
-	return count;
-}
-
-/*
- * Enabling clock gating will make the core call out to the host
- * once up and once down when it performs a request or card operation
- * intermingled in any fashion. The driver will see this through
- * set_ios() operations with ios.clock field set to 0 to gate (disable)
- * the block clock, and to the old frequency to enable it again.
- */
-static void mmc_host_clk_gate_delayed(struct mmc_host *host)
-{
-	unsigned long tick_ns;
-	unsigned long freq = host->ios.clock;
-	unsigned long flags;
-
-	if (!freq) {
-		pr_debug("%s: frequency set to 0 in disable function, "
-			 "this means the clock is already disabled.\n",
-			 mmc_hostname(host));
-		return;
-	}
-	/*
-	 * New requests may have appeared while we were scheduling,
-	 * then there is no reason to delay the check before
-	 * clk_disable().
-	 */
-	spin_lock_irqsave(&host->clk_lock, flags);
-
-	/*
-	 * Delay n bus cycles (at least 8 from MMC spec) before attempting
-	 * to disable the MCI block clock. The reference count may have
-	 * gone up again after this delay due to rescheduling!
-	 */
-	if (!host->clk_requests) {
-		spin_unlock_irqrestore(&host->clk_lock, flags);
-		tick_ns = DIV_ROUND_UP(1000000000, freq);
-		ndelay(host->clk_delay * tick_ns);
-	} else {
-		/* New users appeared while waiting for this work */
-		spin_unlock_irqrestore(&host->clk_lock, flags);
-		return;
-	}
-	mutex_lock(&host->clk_gate_mutex);
-	spin_lock_irqsave(&host->clk_lock, flags);
-	if (!host->clk_requests) {
-		spin_unlock_irqrestore(&host->clk_lock, flags);
-		/* This will set host->ios.clock to 0 */
-		mmc_gate_clock(host);
-		spin_lock_irqsave(&host->clk_lock, flags);
-		pr_debug("%s: gated MCI clock\n", mmc_hostname(host));
-	}
-	spin_unlock_irqrestore(&host->clk_lock, flags);
-	mutex_unlock(&host->clk_gate_mutex);
-}
-
-/*
- * Internal work. Work to disable the clock at some later point.
- */
-static void mmc_host_clk_gate_work(struct work_struct *work)
-{
-	struct mmc_host *host = container_of(work, struct mmc_host,
-					      clk_gate_work.work);
-
-	mmc_host_clk_gate_delayed(host);
-}
-
-/**
- *	mmc_host_clk_hold - ungate hardware MCI clocks
- *	@host: host to ungate.
- *
- *	Makes sure the host ios.clock is restored to a non-zero value
- *	past this call.	Increase clock reference count and ungate clock
- *	if we're the first user.
- */
-void mmc_host_clk_hold(struct mmc_host *host)
-{
-	unsigned long flags;
-
-	/* cancel any clock gating work scheduled by mmc_host_clk_release() */
-	cancel_delayed_work_sync(&host->clk_gate_work);
-	mutex_lock(&host->clk_gate_mutex);
-	spin_lock_irqsave(&host->clk_lock, flags);
-	if (host->clk_gated) {
-		spin_unlock_irqrestore(&host->clk_lock, flags);
-		mmc_ungate_clock(host);
-		spin_lock_irqsave(&host->clk_lock, flags);
-		pr_debug("%s: ungated MCI clock\n", mmc_hostname(host));
-	}
-	host->clk_requests++;
-	spin_unlock_irqrestore(&host->clk_lock, flags);
-	mutex_unlock(&host->clk_gate_mutex);
-}
-
-/**
- *	mmc_host_may_gate_card - check if this card may be gated
- *	@card: card to check.
- */
-static bool mmc_host_may_gate_card(struct mmc_card *card)
-{
-	/* If there is no card we may gate it */
-	if (!card)
-		return true;
-	/*
-	 * Don't gate SDIO cards! These need to be clocked at all times
-	 * since they may be independent systems generating interrupts
-	 * and other events. The clock requests counter from the core will
-	 * go down to zero since the core does not need it, but we will not
-	 * gate the clock, because there is somebody out there that may still
-	 * be using it.
-	 */
-	return !(card->quirks & MMC_QUIRK_BROKEN_CLK_GATING);
-}
-
-/**
- *	mmc_host_clk_release - gate off hardware MCI clocks
- *	@host: host to gate.
- *
- *	Calls the host driver with ios.clock set to zero as often as possible
- *	in order to gate off hardware MCI clocks. Decrease clock reference
- *	count and schedule disabling of clock.
- */
-void mmc_host_clk_release(struct mmc_host *host)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&host->clk_lock, flags);
-	host->clk_requests--;
-	if (mmc_host_may_gate_card(host->card) &&
-	    !host->clk_requests)
-		schedule_delayed_work(&host->clk_gate_work,
-				      msecs_to_jiffies(host->clkgate_delay));
-	spin_unlock_irqrestore(&host->clk_lock, flags);
-}
-
-/**
- *	mmc_host_clk_rate - get current clock frequency setting
- *	@host: host to get the clock frequency for.
- *
- *	Returns current clock frequency regardless of gating.
- */
-unsigned int mmc_host_clk_rate(struct mmc_host *host)
-{
-	unsigned long freq;
-	unsigned long flags;
-
-	spin_lock_irqsave(&host->clk_lock, flags);
-	if (host->clk_gated)
-		freq = host->clk_old;
-	else
-		freq = host->ios.clock;
-	spin_unlock_irqrestore(&host->clk_lock, flags);
-	return freq;
-}
-
-/**
- *	mmc_host_clk_init - set up clock gating code
- *	@host: host with potential clock to control
- */
-static inline void mmc_host_clk_init(struct mmc_host *host)
-{
-	host->clk_requests = 0;
-	/* Hold MCI clock for 8 cycles by default */
-	host->clk_delay = 8;
-	/*
-	 * Default clock gating delay is 0ms to avoid wasting power.
-	 * This value can be tuned by writing into sysfs entry.
-	 */
-	host->clkgate_delay = 0;
-	host->clk_gated = false;
-	INIT_DELAYED_WORK(&host->clk_gate_work, mmc_host_clk_gate_work);
-	spin_lock_init(&host->clk_lock);
-	mutex_init(&host->clk_gate_mutex);
-}
-
-/**
- *	mmc_host_clk_exit - shut down clock gating code
- *	@host: host with potential clock to control
- */
-static inline void mmc_host_clk_exit(struct mmc_host *host)
-{
-	/*
-	 * Wait for any outstanding gate and then make sure we're
-	 * ungated before exiting.
-	 */
-	if (cancel_delayed_work_sync(&host->clk_gate_work))
-		mmc_host_clk_gate_delayed(host);
-	if (host->clk_gated)
-		mmc_host_clk_hold(host);
-	/* There should be only one user now */
-	WARN_ON(host->clk_requests > 1);
-}
-
-static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
-{
-	host->clkgate_delay_attr.show = clkgate_delay_show;
-	host->clkgate_delay_attr.store = clkgate_delay_store;
-	sysfs_attr_init(&host->clkgate_delay_attr.attr);
-	host->clkgate_delay_attr.attr.name = "clkgate_delay";
-	host->clkgate_delay_attr.attr.mode = S_IRUGO | S_IWUSR;
-	if (device_create_file(&host->class_dev, &host->clkgate_delay_attr))
-		pr_err("%s: Failed to create clkgate_delay sysfs entry\n",
-				mmc_hostname(host));
-}
-#else
-
-static inline void mmc_host_clk_init(struct mmc_host *host)
-{
-}
-
-static inline void mmc_host_clk_exit(struct mmc_host *host)
-{
-}
-
-static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
-{
-}
-
-#endif
-
 /**
  *	mmc_of_parse() - parse host's device-tree node
  *	@host: host whose node should be parsed.
@@ -474,8 +234,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->class_dev.class = &mmc_host_class;
 	device_initialize(&host->class_dev);
 
-	mmc_host_clk_init(host);
-
 	mutex_init(&host->slot.lock);
 	host->slot.cd_irq = -EINVAL;
 
@@ -530,7 +288,6 @@ int mmc_add_host(struct mmc_host *host)
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_host_debugfs(host);
 #endif
-	mmc_host_clk_sysfs_init(host);
 
 	mmc_start_host(host);
 	register_pm_notifier(&host->pm_notify);
@@ -560,8 +317,6 @@ void mmc_remove_host(struct mmc_host *host)
 	device_del(&host->class_dev);
 
 	led_trigger_unregister_simple(host->led);
-
-	mmc_host_clk_exit(host);
 }
 
 EXPORT_SYMBOL(mmc_remove_host);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f631f5a..8b57510 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1149,12 +1149,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		 * 4. execute tuning for HS200
 		 */
 		if ((host->caps2 & MMC_CAP2_HS200) &&
-		    card->host->ops->execute_tuning) {
-			mmc_host_clk_hold(card->host);
+		    card->host->ops->execute_tuning)
 			err = card->host->ops->execute_tuning(card->host,
 				MMC_SEND_TUNING_BLOCK_HS200);
-			mmc_host_clk_release(card->host);
-		}
+
 		if (err) {
 			pr_warning("%s: tuning execution failed\n",
 				   mmc_hostname(card->host));
diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
index 06ee1ae..5ada359 100644
--- a/drivers/mmc/core/quirks.c
+++ b/drivers/mmc/core/quirks.c
@@ -30,25 +30,7 @@
 #define SDIO_DEVICE_ID_STE_CW1200	0x2280
 #endif
 
-/*
- * This hook just adds a quirk for all sdio devices
- */
-static void add_quirk_for_sdio_devices(struct mmc_card *card, int data)
-{
-	if (mmc_card_sdio(card))
-		card->quirks |= data;
-}
-
 static const struct mmc_fixup mmc_fixup_methods[] = {
-	/* by default sdio devices are considered CLK_GATING broken */
-	/* good cards will be whitelisted as they are tested */
-	SDIO_FIXUP(SDIO_ANY_ID, SDIO_ANY_ID,
-		   add_quirk_for_sdio_devices,
-		   MMC_QUIRK_BROKEN_CLK_GATING),
-
-	SDIO_FIXUP(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
-		   remove_quirk, MMC_QUIRK_BROKEN_CLK_GATING),
-
 	SDIO_FIXUP(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
 		   add_quirk, MMC_QUIRK_NONSTD_FUNC_IF),
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 6f42050..d106f86 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -421,11 +421,9 @@ static int sd_select_driver_type(struct mmc_card *card, u8 *status)
 	 * information and let the hardware specific code
 	 * return what is possible given the options
 	 */
-	mmc_host_clk_hold(card->host);
 	drive_strength = card->host->ops->select_drive_strength(
 		card->sw_caps.uhs_max_dtr,
 		host_drv_type, card_drv_type);
-	mmc_host_clk_release(card->host);
 
 	err = mmc_sd_switch(card, 1, 2, drive_strength, status);
 	if (err)
@@ -656,12 +654,9 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
 	 */
 	if (!mmc_host_is_spi(card->host) && card->host->ops->execute_tuning &&
 			(card->sd_bus_speed == UHS_SDR50_BUS_SPEED ||
-			 card->sd_bus_speed == UHS_SDR104_BUS_SPEED)) {
-		mmc_host_clk_hold(card->host);
+			 card->sd_bus_speed == UHS_SDR104_BUS_SPEED))
 		err = card->host->ops->execute_tuning(card->host,
 						      MMC_SEND_TUNING_BLOCK);
-		mmc_host_clk_release(card->host);
-	}
 
 out:
 	kfree(status);
@@ -865,11 +860,8 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 	if (!reinit) {
 		int ro = -1;
 
-		if (host->ops->get_ro) {
-			mmc_host_clk_hold(card->host);
+		if (host->ops->get_ro)
 			ro = host->ops->get_ro(host);
-			mmc_host_clk_release(card->host);
-		}
 
 		if (ro < 0) {
 			pr_warning("%s: host does not "
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 4d721c6..625840a 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -569,12 +569,9 @@ static int mmc_sdio_init_uhs_card(struct mmc_card *card)
 	 */
 	if (!mmc_host_is_spi(card->host) && card->host->ops->execute_tuning &&
 			((card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR50) ||
-			 (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR104))) {
-		mmc_host_clk_hold(card->host);
+			 (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR104)))
 		err = card->host->ops->execute_tuning(card->host,
 						      MMC_SEND_TUNING_BLOCK);
-		mmc_host_clk_release(card->host);
-	}
 
 out:
 
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 3d8ceb4..9dd0462 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -149,21 +149,15 @@ static int sdio_irq_thread(void *_host)
 		}
 
 		set_current_state(TASK_INTERRUPTIBLE);
-		if (host->caps & MMC_CAP_SDIO_IRQ) {
-			mmc_host_clk_hold(host);
+		if (host->caps & MMC_CAP_SDIO_IRQ)
 			host->ops->enable_sdio_irq(host, 1);
-			mmc_host_clk_release(host);
-		}
 		if (!kthread_should_stop())
 			schedule_timeout(period);
 		set_current_state(TASK_RUNNING);
 	} while (!kthread_should_stop());
 
-	if (host->caps & MMC_CAP_SDIO_IRQ) {
-		mmc_host_clk_hold(host);
+	if (host->caps & MMC_CAP_SDIO_IRQ)
 		host->ops->enable_sdio_irq(host, 0);
-		mmc_host_clk_release(host);
-	}
 
 	pr_debug("%s: IRQ thread exiting with code %d\n",
 		 mmc_hostname(host), ret);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 176fdf8..aa4bd27 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -265,7 +265,6 @@ struct mmc_card {
 						/* for byte mode */
 #define MMC_QUIRK_NONSTD_SDIO	(1<<2)		/* non-standard SDIO card attached */
 						/* (missing CIA registers) */
-#define MMC_QUIRK_BROKEN_CLK_GATING (1<<3)	/* clock gating the sdio bus will make card fail */
 #define MMC_QUIRK_NONSTD_FUNC_IF (1<<4)		/* SDIO card has nonstd function interfaces */
 #define MMC_QUIRK_DISABLE_CD	(1<<5)		/* disconnect CD/DAT[3] resistor */
 #define MMC_QUIRK_INAND_CMD38	(1<<6)		/* iNAND devices have broken CMD38 */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 99f5709..4ce9357 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -285,18 +285,6 @@ struct mmc_host {
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-#ifdef CONFIG_MMC_CLKGATE
-	int			clk_requests;	/* internal reference counter */
-	unsigned int		clk_delay;	/* number of MCI clk hold cycles */
-	bool			clk_gated;	/* clock gated */
-	struct delayed_work	clk_gate_work; /* delayed clock gate */
-	unsigned int		clk_old;	/* old clock value cache */
-	spinlock_t		clk_lock;	/* lock for clk fields */
-	struct mutex		clk_gate_mutex;	/* mutex for clock gating */
-	struct device_attribute clkgate_delay_attr;
-	unsigned long           clkgate_delay;
-#endif
-
 	/* host specific block data */
 	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
 	unsigned short		max_segs;	/* see blk_queue_max_segments */
@@ -465,23 +453,8 @@ static inline int mmc_host_packed_wr(struct mmc_host *host)
 	return host->caps2 & MMC_CAP2_PACKED_WR;
 }
 
-#ifdef CONFIG_MMC_CLKGATE
-void mmc_host_clk_hold(struct mmc_host *host);
-void mmc_host_clk_release(struct mmc_host *host);
-unsigned int mmc_host_clk_rate(struct mmc_host *host);
-
-#else
-static inline void mmc_host_clk_hold(struct mmc_host *host)
-{
-}
-
-static inline void mmc_host_clk_release(struct mmc_host *host)
-{
-}
-
 static inline unsigned int mmc_host_clk_rate(struct mmc_host *host)
 {
 	return host->ios.clock;
 }
-#endif
 #endif /* LINUX_MMC_HOST_H */
-- 
1.7.9.5

