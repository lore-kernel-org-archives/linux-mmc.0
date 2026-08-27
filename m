Received: from mail-m15580.qiye.163.com (mail-m15580.qiye.163.com [101.71.155.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D8141A506;
	Thu, 27 Aug 2026 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822078; cv=none; b=DaoSORhzZspPgX9vTmDmvwd2ule2CXpPHAIH8qsZOqflEfgpmxh/KEKwoUnAaaXaDejGJBRHDzN2sf00mbt49Inry/ouOk8R1AWePkjiHnCIWciooCoCjNLobftLq2SY0pPf+82ObqwGpytyg2gY7mMR2uAoMCD0HHuYrPlcRN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822078; c=relaxed/simple;
	bh=DFLW4F7Ojv7CnJkShwmE1ADECF1ga2geEWNRbs9P3ic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SaWpFAiAFBm1A+1r4ydxgUJ8Z03iO4vxRxfO7NJt11rOR/FOnUxOTtBXEFSYD7Rcm4By1vPPZqUdfYG28yzq/kQnCvySaQYKXhIegUwkBxllMfAYgE6LuMoDOV8zol7xgEJ3vrCkOZQ2LqN8r/eUawbjAxtNjBNyysK1RvTuMpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=bXckE75n; arc=none smtp.client-ip=101.71.155.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="bXckE75n"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4b88a31b2;
	Thu, 27 Aug 2026 15:58:29 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/4] mmc: dw_mmc: add central watchdog and convert CTO onto it
Date: Thu, 27 Aug 2026 15:58:03 +0800
Message-Id: <1787817486-137277-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1787817486-137277-1-git-send-email-shawn.lin@rock-chips.com>
References: <1787817486-137277-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0423a415703a4kunm6c47a0ea1fec30
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGh5PQ1ZMH0oYH0waQ0
	tPTE9WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=bXckE75nkkLR+WxqL9tUHg8giwSgYeE66Vt+hUpzeTL4FKfNKkiGRAsxoAE7XLqY1WmVWvhUgIc8gQsPodRa0qSeh26U9PMIaCcEUPYVR0Wm+Qtfe50HT0M4pcjiC/3s0MMGn+ys4l9VHdlhNKSqlB8sggbXgIkQ9nFEkqH5pm0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=ecw8+3lvAvsbu68txk1AwjZokC0tDbvazgWTswP/ixc=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The driver keeps three independent fallback timers (cmd11, cto, dto)
whose callbacks all re-implement the same race handling: peek MINTSTS
in case the interrupt is in flight, check whether the event was
delivered meanwhile, verify host->state matches the leg being guarded,
and finally synthesize the missed event.  This series replaces them
with a single hrtimer watchdog.

This first step introduces the watchdog and moves the command timeout
onto it; cto_timer is deleted.  Later steps convert the data timeout
and the voltage-switch timer onto the same watch.

The new protocol relies on two simple facts which hold for all current
event producers:

  * every site posting EVENT_CMD_COMPLETE (dw_mci_cmd_interrupt() and
    the command-error branch of dw_mci_interrupt()) runs under
    irq_lock,
  * every site arming a watch does so under irq_lock as well.

Consequently a watchdog callback holding irq_lock can neither miss nor
race an already-delivered event: the bookkeeping part of the former
're-read MINTSTS' paranoia is subsumed by checking the awaited mask
against pending_events under the same lock the producers use.  The
hardware-latency part of that paranoia is kept verbatim, see below.
A callback that raced past every check nonetheless degrades to at most
one idempotent extra state machine run instead of completing a foreign
leg.

The callback classifies what expired by comparing the awaited set
against the named DW_MCI_WD_{CMD,DATA}_EVENTS masks so that subsequent
conversions only add call sites.  dw_mci_wd_arm() takes a separate
'already delivered' precheck mask because guarding the data legs must
tolerate a DATA_ERROR that arrived while still waiting for the paired
completion -- exactly like mod_timer() paths did before.

Behavioral notes for review:

  * dw_mci_wd_arm() replaces any previously armed watch.  During a
    voltage switch (CMD11) both cto_timer and cmd11_timer were armed
    concurrently before, racing each other with duplicated warnings;
    now only the last arm on that path survives.
  * The stale-timer defensiveness of dw_mci_clear_pending_cmd_complete()
    (WARN_ON + timer_delete_sync) is dropped because the callback is now
    idempotent by construction; timer_delete_sync from the BH would also
    be wrong-context sleeping on hrtimers.
  * Before declaring a timeout the callback re-reads MINTSTS: when the
    completion interrupt is already latched in hardware and only its
    handler has not been scheduled yet, the firing grants further
    DW_MCI_WD_INFLIGHT_GRACE_MS rounds instead of failing an about-to-
    complete transfer.  This replicates the interrupt-latency paranoia
    of the retired cto_timer()/dto_timer() callbacks; unlike them it
    keeps re-watching rather than going passive, so if that latched
    interrupt is ultimately lost the request still unwedges with a
    timeout error instead of hanging forever.

No functional change intended beyond the deduplication described above.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 216 ++++++++++++++++++++++++++++++----------------
 drivers/mmc/host/dw_mmc.h |  11 ++-
 2 files changed, 150 insertions(+), 77 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index cf5cecc..cefc873 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -44,6 +44,135 @@
 #define DW_MCI_FREQ_MAX	200000000	/* unit: HZ */
 #define DW_MCI_FREQ_MIN	100000		/* unit: HZ */
 
+/* Event sets guarded by the central watchdog, see below. */
+#define DW_MCI_WD_CMD_EVENTS	BIT(EVENT_CMD_COMPLETE)
+#define DW_MCI_WD_DATA_EVENTS	(BIT(EVENT_DATA_ERROR) | \
+				 BIT(EVENT_DATA_COMPLETE))
+/* Extra watch rounds granted while the completion IRQ is merely late. */
+#define DW_MCI_WD_INFLIGHT_GRACE_MS	10
+
+/*
+ * Central watchdog
+ * ================
+ *
+ * A single hrtimer guards the legs of a request (command, data, voltage
+ * switch) against the hardware going silent: whenever a completion event
+ * that was expected within a bounded time does not arrive in time, the
+ * callback synthesizes it so that the request state machine can error out.
+ *
+ * @wd_events holds the pending_events bits still being waited for and
+ * @wd_states the host->state values for which the watch is valid; both
+ * are protected by irq_lock.  Every producer of the guarded events posts
+ * them under irq_lock as well, so a callback holding irq_lock can never
+ * miss an already-delivered event.  A stale callback which raced past
+ * all checks therefore degrades to at most one redundant state-machine
+ * run instead of completing a foreign leg.  Arming replaces whatever
+ * watch was outstanding before: command and data legs are strictly
+ * serial, so consecutive arms on the same path collapse onto the latest
+ * deadline.
+ *
+ * On expiry, before declaring a timeout, the callback double-checks that
+ * the completion interrupt is not already latched in hardware; if it is,
+ * only the interrupt latency is to blame and the watch is granted extra
+ * rounds instead of failing a transfer that is about to complete.
+ */
+static void dw_mci_wd_deliver(struct dw_mci *host, unsigned long events)
+{
+	host->wd_events &= ~events;
+	if (!host->wd_events)
+		hrtimer_try_to_cancel(&host->wd_timer);
+}
+
+/*
+ * Arm a new watch for @events valid while host->state is one of @states,
+ * expiring after @ms milliseconds.  @already lists bits whose delivery
+ * makes the watch pointless before it is even armed: arming is skipped
+ * when any of them has been posted concurrently.  Must be called with
+ * irq_lock held.
+ */
+static void dw_mci_wd_arm(struct dw_mci *host, unsigned long ms,
+			  unsigned long already, unsigned long events,
+			  unsigned long states)
+{
+	lockdep_assert_held(&host->irq_lock);
+
+	if (host->pending_events & already) {
+		/*
+		 * The event was delivered concurrently; no need for a
+		 * watch anymore.
+		 */
+		host->wd_events = 0;
+		hrtimer_try_to_cancel(&host->wd_timer);
+		return;
+	}
+
+	host->wd_events = events;
+	host->wd_states = states;
+	hrtimer_start(&host->wd_timer, ms_to_ktime(ms), HRTIMER_MODE_REL);
+}
+
+/* Called from hardirq context on watchdog expiry. */
+static enum hrtimer_restart dw_mci_watchdog_fn(struct hrtimer *t)
+{
+	struct dw_mci *host = container_of(t, struct dw_mci, wd_timer);
+	unsigned long irqflags;
+	u32 pending;
+
+	spin_lock_irqsave(&host->irq_lock, irqflags);
+
+	/*
+	 * Last line of defense against a false timeout: when the completion
+	 * interrupt is already latched in MINTSTS but its handler has not
+	 * been scheduled yet, the leg is about to finish normally.  Warn
+	 * about the latency and keep watching instead of failing the
+	 * transfer; delivery by the real interrupt will stop the watch.
+	 * The retired per-timer callbacks went passive here and relied on
+	 * the latched interrupt arriving; rearming bounds the damage if
+	 * that assumption is ever broken.
+	 */
+	if (host->wd_events) {
+		pending = mci_readl(host, MINTSTS); /* read-only mask reg */
+		if ((host->wd_events == DW_MCI_WD_CMD_EVENTS &&
+		     (pending & (DW_MCI_CMD_ERROR_FLAGS |
+				 SDMMC_INT_CMD_DONE))) ||
+		    (host->wd_events == DW_MCI_WD_DATA_EVENTS &&
+		     (pending & (SDMMC_INT_DATA_OVER |
+				 DW_MCI_DATA_ERROR_FLAGS)))) {
+			dev_warn(host->dev,
+				 "Interrupt latency, state %d (watched %#lx)\n",
+				 host->state, host->wd_events);
+			hrtimer_forward_now(&host->wd_timer,
+					    ms_to_ktime(DW_MCI_WD_INFLIGHT_GRACE_MS));
+			spin_unlock_irqrestore(&host->irq_lock, irqflags);
+			return HRTIMER_RESTART;
+		}
+	}
+
+	if (host->wd_events == DW_MCI_WD_DATA_EVENTS) {
+		dev_warn(host->dev,
+			 "Data timeout, state %d\n", host->state);
+		host->data_status = SDMMC_INT_DRTO;
+		set_bit(EVENT_DATA_ERROR, &host->pending_events);
+		set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
+	} else if (host->wd_events) {
+		dev_warn(host->dev,
+			 "Command timeout, state %d (watched %#lx)\n",
+			 host->state, host->wd_events);
+		host->cmd_status = SDMMC_INT_RTO;
+		set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
+	}
+
+	if (host->wd_events)
+		queue_work(system_bh_wq, &host->bh_work);
+
+	host->wd_events = 0;
+	host->wd_states = 0;
+
+	spin_unlock_irqrestore(&host->irq_lock, irqflags);
+
+	return HRTIMER_NORESTART;
+}
+
 #define IDMAC_INT_CLR		(SDMMC_IDMAC_INT_AI | SDMMC_IDMAC_INT_NI | \
 				 SDMMC_IDMAC_INT_CES | SDMMC_IDMAC_INT_DU | \
 				 SDMMC_IDMAC_INT_FBE | SDMMC_IDMAC_INT_RI | \
@@ -366,18 +495,17 @@ static inline void dw_mci_set_cto(struct dw_mci *host)
 	 * extra careful about synchronization here.  Specifically in hardware a
 	 * command timeout is _at most_ 5.1 ms, so that means we expect an
 	 * interrupt (either command done or timeout) to come rather quickly
-	 * after the mci_writel.  ...but just in case we have a long interrupt
-	 * latency let's add a bit of paranoia.
+	 * after the mci_writel.
 	 *
-	 * In general we'll assume that at least an interrupt will be asserted
-	 * in hardware by the time the cto_timer runs.  ...and if it hasn't
-	 * been asserted in hardware by that time then we'll assume it'll never
-	 * come.
+	 * dw_mci_wd_arm() skips arming when the event was already delivered,
+	 * and the watchdog callback rechecks under the same lock before
+	 * declaring a timeout, so both orderings of the race are covered.
 	 */
 	spin_lock_irqsave(&host->irq_lock, irqflags);
-	if (!test_bit(EVENT_CMD_COMPLETE, &host->pending_events))
-		mod_timer(&host->cto_timer,
-			jiffies + msecs_to_jiffies(cto_ms) + 1);
+	dw_mci_wd_arm(host, cto_ms, DW_MCI_WD_CMD_EVENTS,
+		      DW_MCI_WD_CMD_EVENTS,
+		      BIT(STATE_SENDING_CMD) | BIT(STATE_SENDING_STOP) |
+		      BIT(STATE_SENDING_CMD11));
 	spin_unlock_irqrestore(&host->irq_lock, irqflags);
 }
 
@@ -1881,14 +2009,6 @@ static bool dw_mci_clear_pending_cmd_complete(struct dw_mci *host)
 	if (!test_bit(EVENT_CMD_COMPLETE, &host->pending_events))
 		return false;
 
-	/*
-	 * Really be certain that the timer has stopped.  This is a bit of
-	 * paranoia and could only really happen if we had really bad
-	 * interrupt latency and the interrupt routine and timeout were
-	 * running concurrently so that the timer_delete() in the interrupt
-	 * handler couldn't run.
-	 */
-	WARN_ON(timer_delete_sync(&host->cto_timer));
 	clear_bit(EVENT_CMD_COMPLETE, &host->pending_events);
 
 	return true;
@@ -2633,7 +2753,7 @@ static void dw_mci_write_data_pio(struct dw_mci *host)
 
 static void dw_mci_cmd_interrupt(struct dw_mci *host, u32 status)
 {
-	timer_delete(&host->cto_timer);
+	dw_mci_wd_deliver(host, BIT(EVENT_CMD_COMPLETE));
 
 	if (!host->cmd_status)
 		host->cmd_status = status;
@@ -2680,7 +2800,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		if (pending & DW_MCI_CMD_ERROR_FLAGS) {
 			spin_lock(&host->irq_lock);
 
-			timer_delete(&host->cto_timer);
+			dw_mci_wd_deliver(host, BIT(EVENT_CMD_COMPLETE));
 			mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
 			host->cmd_status = pending;
 			smp_wmb(); /* drain writebuffer */
@@ -3008,61 +3128,6 @@ static void dw_mci_cmd11_timer(struct timer_list *t)
 	queue_work(system_bh_wq, &host->bh_work);
 }
 
-static void dw_mci_cto_timer(struct timer_list *t)
-{
-	struct dw_mci *host = timer_container_of(host, t, cto_timer);
-	unsigned long irqflags;
-	u32 pending;
-
-	spin_lock_irqsave(&host->irq_lock, irqflags);
-
-	/*
-	 * If somehow we have very bad interrupt latency it's remotely possible
-	 * that the timer could fire while the interrupt is still pending or
-	 * while the interrupt is midway through running.  Let's be paranoid
-	 * and detect those two cases.  Note that this is paranoia is somewhat
-	 * justified because in this function we don't actually cancel the
-	 * pending command in the controller--we just assume it will never come.
-	 */
-	pending = mci_readl(host, MINTSTS); /* read-only mask reg */
-	if (pending & (DW_MCI_CMD_ERROR_FLAGS | SDMMC_INT_CMD_DONE)) {
-		/* The interrupt should fire; no need to act but we can warn */
-		dev_warn(host->dev, "Unexpected interrupt latency\n");
-		goto exit;
-	}
-	if (test_bit(EVENT_CMD_COMPLETE, &host->pending_events)) {
-		/* Presumably interrupt handler couldn't delete the timer */
-		dev_warn(host->dev, "CTO timeout when already completed\n");
-		goto exit;
-	}
-
-	/*
-	 * Continued paranoia to make sure we're in the state we expect.
-	 * This paranoia isn't really justified but it seems good to be safe.
-	 */
-	switch (host->state) {
-	case STATE_SENDING_CMD11:
-	case STATE_SENDING_CMD:
-	case STATE_SENDING_STOP:
-		/*
-		 * If CMD_DONE interrupt does NOT come in sending command
-		 * state, we should notify the driver to terminate current
-		 * transfer and report a command timeout to the core.
-		 */
-		host->cmd_status = SDMMC_INT_RTO;
-		set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
-		queue_work(system_bh_wq, &host->bh_work);
-		break;
-	default:
-		dev_warn(host->dev, "Unexpected command timeout, state %d\n",
-			 host->state);
-		break;
-	}
-
-exit:
-	spin_unlock_irqrestore(&host->irq_lock, irqflags);
-}
-
 static void dw_mci_dto_timer(struct timer_list *t)
 {
 	struct dw_mci *host = timer_container_of(host, t, dto_timer);
@@ -3261,8 +3326,9 @@ int dw_mci_probe(struct dw_mci *host)
 		}
 	}
 
+	hrtimer_setup(&host->wd_timer, dw_mci_watchdog_fn, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	timer_setup(&host->cmd11_timer, dw_mci_cmd11_timer, 0);
-	timer_setup(&host->cto_timer, dw_mci_cto_timer, 0);
 	timer_setup(&host->dto_timer, dw_mci_dto_timer, 0);
 
 	spin_lock_init(&host->lock);
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 38610c8..7a14f3f 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -122,8 +122,12 @@ struct dw_mci_dma_slave {
  * @irq_flags: The flags to be passed to request_irq.
  * @irq: The irq value to be passed to request_irq.
  * @sdio_irq: SDIO interrupt bit in interrupt registers.
+ * @wd_timer: Central watchdog guarding request legs against hardware going
+ *	silent; fires when an expected completion event fails to arrive in
+ *	time so that the state machine can synthesize an error.
+ * @wd_events: pending_events bits still awaited by the armed watch.
+ * @wd_states: host->state values for which the armed watch is valid.
  * @cmd11_timer: Timer for SD3.0 voltage switch over scheme.
- * @cto_timer: Timer for broken command transfer over scheme.
  * @dto_timer: Timer for broken data transfer over scheme.
  * @mmc: The mmc_host representing this dw_mci.
  * @flags: Random state bits associated with the host.
@@ -235,8 +239,11 @@ struct dw_mci {
 
 	int			sdio_irq;
 
+	struct hrtimer		wd_timer;
+	unsigned long		wd_events;
+	unsigned long		wd_states;
+
 	struct timer_list       cmd11_timer;
-	struct timer_list       cto_timer;
 	struct timer_list       dto_timer;
 
 #ifdef CONFIG_FAULT_INJECTION
-- 
2.7.4

