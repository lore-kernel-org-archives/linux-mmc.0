From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: [PATCH 1/1] mmc: core: Use delayed work in clock gating framework
Date: Wed, 19 Oct 2011 20:18:33 +0530
Message-ID: <1319035713-4979-1-git-send-email-sthumma@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.orglinux-mmc@vger.kernel.org
Cc: Sujit Reddy Thumma <sthumma@codeaurora.org>, linux-arm-msm@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

Current clock gating framework disables the MCI clock as soon as the
request is completed and enables it when a request arrives. This aggressive
clock gating framework when enabled cause following issues:

When there are back-to-back requests from the Queue layer, we unnecessarily
end up disabling and enabling the clocks between these requests since 8 MCLK
clock cycles is a very short duration compared to the time delay between
back to back requests reaching the MMC layer. This overhead can effect the
overall performance depending on how long the clock enable and disable
calls take which is platform dependent. For example on some platforms we
can have clock control not on the local processor, but on a different
subsystem and the time taken to perform the clock enable/disable can add
significant overhead.

Also if the host controller driver decides to disable the host clock too
when mmc_set_ios function is called with ios.clock=0, it adds additional
delay and it is highly possible that the next request had already arrived
and unnecessarily blocked in enabling the clocks. This is seen frequently
when the processor is executing at high speeds and in multi-core platforms
thus reduces the overall throughput compared to if clock gating is disabled.

Fix this by delaying turning off the clocks by posting request on
delayed workqueue. Also cancel the unscheduled pending work, if any,
when there is access to card.

Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
---
 drivers/mmc/core/host.c  |   11 +++++++----
 include/linux/mmc/host.h |    3 ++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index ca2e4f5..b7b51da 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -113,7 +113,7 @@ static void mmc_host_clk_gate_delayed(struct mmc_host *host)
 static void mmc_host_clk_gate_work(struct work_struct *work)
 {
 	struct mmc_host *host = container_of(work, struct mmc_host,
-					      clk_gate_work);
+					      clk_gate_work.work);
 
 	mmc_host_clk_gate_delayed(host);
 }
@@ -130,6 +130,8 @@ void mmc_host_clk_hold(struct mmc_host *host)
 {
 	unsigned long flags;
 
+	/* cancel any clock gating work scheduled by mmc_host_clk_release() */
+	cancel_delayed_work_sync(&host->clk_gate_work);
 	mutex_lock(&host->clk_gate_mutex);
 	spin_lock_irqsave(&host->clk_lock, flags);
 	if (host->clk_gated) {
@@ -179,7 +181,8 @@ void mmc_host_clk_release(struct mmc_host *host)
 	host->clk_requests--;
 	if (mmc_host_may_gate_card(host->card) &&
 	    !host->clk_requests)
-		queue_work(system_nrt_wq, &host->clk_gate_work);
+		queue_delayed_work(system_nrt_wq, &host->clk_gate_work,
+				msecs_to_jiffies(MMC_CLK_GATE_DELAY));
 	spin_unlock_irqrestore(&host->clk_lock, flags);
 }
 
@@ -213,7 +216,7 @@ static inline void mmc_host_clk_init(struct mmc_host *host)
 	/* Hold MCI clock for 8 cycles by default */
 	host->clk_delay = 8;
 	host->clk_gated = false;
-	INIT_WORK(&host->clk_gate_work, mmc_host_clk_gate_work);
+	INIT_DELAYED_WORK(&host->clk_gate_work, mmc_host_clk_gate_work);
 	spin_lock_init(&host->clk_lock);
 	mutex_init(&host->clk_gate_mutex);
 }
@@ -228,7 +231,7 @@ static inline void mmc_host_clk_exit(struct mmc_host *host)
 	 * Wait for any outstanding gate and then make sure we're
 	 * ungated before exiting.
 	 */
-	if (cancel_work_sync(&host->clk_gate_work))
+	if (cancel_delayed_work_sync(&host->clk_gate_work))
 		mmc_host_clk_gate_delayed(host);
 	if (host->clk_gated)
 		mmc_host_clk_hold(host);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 16e9338..8d6ba4c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -252,10 +252,11 @@ struct mmc_host {
 	int			clk_requests;	/* internal reference counter */
 	unsigned int		clk_delay;	/* number of MCI clk hold cycles */
 	bool			clk_gated;	/* clock gated */
-	struct work_struct	clk_gate_work; /* delayed clock gate */
+	struct delayed_work	clk_gate_work; /* delayed clock gate */
 	unsigned int		clk_old;	/* old clock value cache */
 	spinlock_t		clk_lock;	/* lock for clk fields */
 	struct mutex		clk_gate_mutex;	/* mutex for clock gating */
+#define MMC_CLK_GATE_DELAY	50		/* in milliseconds*/
 #endif
 
 	/* host specific block data */
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
