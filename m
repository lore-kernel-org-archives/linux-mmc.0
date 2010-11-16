From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 1/3] mmc: clean up clockgating code
Date: Tue, 16 Nov 2010 17:56:42 +0100
Message-ID: <1289926602-14011-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:54393 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754673Ab0KPQ5N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Nov 2010 11:57:13 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Linus Walleij <linus.walleij@stericsson.com>

This rids the unused boolean clk_pending_gate from the code
and renames the clk_disable_work to clk_gate_work in
analogy with the other names used for gating code.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/core/host.c  |   19 ++++++-------------
 include/linux/mmc/host.h |    3 +--
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index aacd9c5..f74b386 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -66,7 +66,6 @@ static void mmc_host_clk_gate_delayed(struct mmc_host *host)
 	unsigned long tick_ns;
 	unsigned long freq = host->ios.clock;
 	unsigned long flags;
-	int users;
 
 	if (!freq) {
 		pr_err("%s: frequency set to 0 in disable function, "
@@ -80,20 +79,18 @@ static void mmc_host_clk_gate_delayed(struct mmc_host *host)
 	 * clk_disable().
 	 */
 	spin_lock_irqsave(&host->clk_lock, flags);
-	users = host->clk_requests;
 
 	/*
 	 * Delay n bus cycles (at least 8 from MMC spec) before attempting
 	 * to disable the MCI block clock. The reference count may have
 	 * gone up again after this delay due to rescheduling!
 	 */
-	if (!users) {
+	if (!host->clk_requests) {
 		spin_unlock_irqrestore(&host->clk_lock, flags);
 		tick_ns = DIV_ROUND_UP(1000000000, freq);
 		ndelay(host->clk_delay * tick_ns);
 	} else {
 		/* New users appeared while waiting for this work */
-		host->clk_pending_gate = false;
 		spin_unlock_irqrestore(&host->clk_lock, flags);
 		return;
 	}
@@ -105,7 +102,6 @@ static void mmc_host_clk_gate_delayed(struct mmc_host *host)
 		spin_lock_irqsave(&host->clk_lock, flags);
 		pr_debug("%s: gated MCI clock\n", mmc_hostname(host));
 	}
-	host->clk_pending_gate = false;
 	spin_unlock_irqrestore(&host->clk_lock, flags);
 }
 
@@ -115,7 +111,7 @@ static void mmc_host_clk_gate_delayed(struct mmc_host *host)
 static void mmc_host_clk_gate_work(struct work_struct *work)
 {
 	struct mmc_host *host = container_of(work, struct mmc_host,
-					      clk_disable_work);
+					      clk_gate_work);
 
 	mmc_host_clk_gate_delayed(host);
 }
@@ -181,10 +177,8 @@ void mmc_host_clk_gate(struct mmc_host *host)
 	spin_lock_irqsave(&host->clk_lock, flags);
 	host->clk_requests--;
 	if (mmc_host_may_gate_card(host->card) &&
-	    !host->clk_requests) {
-		host->clk_pending_gate = true;
-		schedule_work(&host->clk_disable_work);
-	}
+	    !host->clk_requests)
+		schedule_work(&host->clk_gate_work);
 	spin_unlock_irqrestore(&host->clk_lock, flags);
 }
 
@@ -218,8 +212,7 @@ static inline void mmc_host_clk_init(struct mmc_host *host)
 	/* Hold MCI clock for 8 cycles by default */
 	host->clk_delay = 8;
 	host->clk_gated = false;
-	host->clk_pending_gate = false;
-	INIT_WORK(&host->clk_disable_work, mmc_host_clk_gate_work);
+	INIT_WORK(&host->clk_gate_work, mmc_host_clk_gate_work);
 	spin_lock_init(&host->clk_lock);
 }
 
@@ -233,7 +226,7 @@ static inline void mmc_host_clk_exit(struct mmc_host *host)
 	 * Wait for any outstanding gate and then make sure we're
 	 * ungated before exiting.
 	 */
-	if (cancel_work_sync(&host->clk_disable_work))
+	if (cancel_work_sync(&host->clk_gate_work))
 		mmc_host_clk_gate_delayed(host);
 	if (host->clk_gated)
 		mmc_host_clk_ungate(host);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index f108cee..955bc10 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -175,8 +175,7 @@ struct mmc_host {
 	int			clk_requests;	/* internal reference counter */
 	unsigned int		clk_delay;	/* number of MCI clk hold cycles */
 	bool			clk_gated;	/* clock gated */
-	bool			clk_pending_gate; /* pending clock gating */
-	struct work_struct	clk_disable_work; /* delayed clock disable */
+	struct work_struct	clk_gate_work; /* delayed clock gate */
 	unsigned int		clk_old;	/* old clock value cache */
 	spinlock_t		clk_lock;	/* lock for clk fields */
 #endif
-- 
1.6.3.3

