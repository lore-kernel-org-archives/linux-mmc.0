From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/2] MMC: protect the tmio_mmc driver against a theoretical
 race
Date: Thu, 21 Apr 2011 09:20:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1104210914120.6893@axis700.grange>
References: <Pine.LNX.4.64.1104210911040.6893@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49453 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab1DUHUW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 03:20:22 -0400
In-Reply-To: <Pine.LNX.4.64.1104210911040.6893@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Ian Molton <ian@mnementh.co.uk>

The MMC subsystem does not guarantee, that host driver .request() and
.set_ios() callbacks are serialised. Such concurrent calls, however,
do not have to be meaningfully supported, drivers just have to make
sure to avoid any severe problems.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.h     |    1 +
 drivers/mmc/host/tmio_mmc_pio.c |   62 +++++++++++++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 099ed49..f353624 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -19,6 +19,7 @@
 #include <linux/highmem.h>
 #include <linux/mmc/tmio.h>
 #include <linux/pagemap.h>
+#include <linux/spinlock.h>
 
 /* Definitions for values the CTRL_SDIO_STATUS register can take. */
 #define TMIO_SDIO_STAT_IOIRQ	0x0001
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 62d37de..6e3271d 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -243,8 +243,12 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 	spin_lock_irqsave(&host->lock, flags);
 	mrq = host->mrq;
 
-	/* request already finished */
-	if (!mrq
+	/*
+	 * is request already finished? Since we use a non-blocking
+	 * cancel_delayed_work(), it can happen, that a .set_ios() call preempts
+	 * us, so, have to check for IS_ERR(host->mrq)
+	 */
+	if (IS_ERR_OR_NULL(mrq)
 	    || time_is_after_jiffies(host->last_req_ts +
 		msecs_to_jiffies(2000))) {
 		spin_unlock_irqrestore(&host->lock, flags);
@@ -264,16 +268,19 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 
 	host->cmd = NULL;
 	host->data = NULL;
-	host->mrq = NULL;
 	host->force_pio = false;
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	tmio_mmc_reset(host);
 
+	/* Ready for new calls */
+	host->mrq = NULL;
+
 	mmc_request_done(host->mmc, mrq);
 }
 
+/* called with host->lock held, interrupts disabled */
 static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 {
 	struct mmc_request *mrq = host->mrq;
@@ -281,13 +288,15 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 	if (!mrq)
 		return;
 
-	host->mrq = NULL;
 	host->cmd = NULL;
 	host->data = NULL;
 	host->force_pio = false;
 
 	cancel_delayed_work(&host->delayed_reset_work);
 
+	host->mrq = NULL;
+
+	/* FIXME: mmc_request_done() can schedule! */
 	mmc_request_done(host->mmc, mrq);
 }
 
@@ -685,15 +694,27 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
+	unsigned long flags;
 	int ret;
 
-	if (host->mrq)
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (host->mrq) {
 		pr_debug("request not null\n");
+		if (IS_ERR(host->mrq)) {
+			spin_unlock_irqrestore(&host->lock, flags);
+			mrq->cmd->error = -EAGAIN;
+			mmc_request_done(mmc, mrq);
+			return;
+		}
+	}
 
 	host->last_req_ts = jiffies;
 	wmb();
 	host->mrq = mrq;
 
+	spin_unlock_irqrestore(&host->lock, flags);
+
 	if (mrq->data) {
 		ret = tmio_mmc_start_data(host, mrq->data);
 		if (ret)
@@ -708,8 +729,8 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	}
 
 fail:
-	host->mrq = NULL;
 	host->force_pio = false;
+	host->mrq = NULL;
 	mrq->cmd->error = ret;
 	mmc_request_done(mmc, mrq);
 }
@@ -723,6 +744,29 @@ fail:
 static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	if (host->mrq) {
+		if (IS_ERR(host->mrq)) {
+			dev_dbg(&host->pdev->dev,
+				"%s.%d: concurrent .set_ios(), clk %u, mode %u\n",
+				current->comm, task_pid_nr(current),
+				ios->clock, ios->power_mode);
+			host->mrq = ERR_PTR(-EINTR);
+		} else {
+			dev_dbg(&host->pdev->dev,
+				"%s.%d: CMD%u active since %lu, now %lu!\n",
+				current->comm, task_pid_nr(current),
+				host->mrq->cmd->opcode, host->last_req_ts, jiffies);
+		}
+		spin_unlock_irqrestore(&host->lock, flags);
+		return;
+	}
+
+	host->mrq = ERR_PTR(-EBUSY);
+
+	spin_unlock_irqrestore(&host->lock, flags);
 
 	if (ios->clock)
 		tmio_mmc_set_clock(host, ios->clock);
@@ -753,6 +797,12 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	/* Let things settle. delay taken from winCE driver */
 	udelay(140);
+	if (PTR_ERR(host->mrq) == -EINTR)
+		dev_dbg(&host->pdev->dev,
+			"%s.%d: IOS interrupted: clk %u, mode %u",
+			current->comm, task_pid_nr(current),
+			ios->clock, ios->power_mode);
+	host->mrq = NULL;
 }
 
 static int tmio_mmc_get_ro(struct mmc_host *mmc)
-- 
1.7.2.5

