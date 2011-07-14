From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v3] mmc: tmio: fix recursive spinlock, don't schedule with
 interrupts disabled
Date: Thu, 14 Jul 2011 12:12:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1107141209460.10688@axis700.grange>
References: <Pine.LNX.4.64.1106151549050.23363@axis700.grange>
 <Pine.LNX.4.64.1106201803520.11365@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:53660 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab1GNKNJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2011 06:13:09 -0400
In-Reply-To: <Pine.LNX.4.64.1106201803520.11365@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Magnus Damm <damm@opensource.se>

Calling mmc_request_done() under a spinlock with interrupts disabled
leads to a recursive spin-lock on request retry path and to
scheduling in atomic context. This patch fixes both these problems
by moving mmc_request_done() to the scheduler workqueue.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
This is a bug-fix: without it the system Oopses with LOCKDEP enabled, so, 
it should really go in 3.0. OTOH it is pretty intrusine and non-trivial, 
so, reviews and tests are highly appreciated! Also, unfortunately, I 
wasn't able to test it well enough with SDIO, because the driver for the 
only SDIO card, that I have, reproducibly crashes the kernel:

http://www.spinics.net/lists/kernel/msg1203334.html

So, mainly tested with SD-cards and only lightly with SDIO.

v3: no functional changes, only updated on top of current mmc-next

v2:

1. added a mutex to properly complete each .set_ios() call instead of 
returning an error, when racing with another one. 

2. oritect data inside tmio_mmc_finish_request()

3. don't reschedule card detection, if one is already pending

 drivers/mmc/host/tmio_mmc.h     |    6 +++++-
 drivers/mmc/host/tmio_mmc_pio.c |   35 +++++++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 0c22df0..a2d6f9f 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -18,6 +18,7 @@
 
 #include <linux/highmem.h>
 #include <linux/mmc/tmio.h>
+#include <linux/mutex.h>
 #include <linux/pagemap.h>
 #include <linux/spinlock.h>
 
@@ -73,8 +74,11 @@ struct tmio_mmc_host {
 
 	/* Track lost interrupts */
 	struct delayed_work	delayed_reset_work;
-	spinlock_t		lock;
+	struct work_struct	done;
+
+	spinlock_t		lock;		/* protect host private data */
 	unsigned long		last_req_ts;
+	struct mutex		ios_lock;	/* protect set_ios() context */
 };
 
 int tmio_mmc_host_probe(struct tmio_mmc_host **host,
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index f7dd3b1..a2f76ad 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -250,10 +250,16 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 /* called with host->lock held, interrupts disabled */
 static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 {
-	struct mmc_request *mrq = host->mrq;
+	struct mmc_request *mrq;
+	unsigned long flags;
 
-	if (!mrq)
+	spin_lock_irqsave(&host->lock, flags);
+
+	mrq = host->mrq;
+	if (IS_ERR_OR_NULL(mrq)) {
+		spin_unlock_irqrestore(&host->lock, flags);
 		return;
+	}
 
 	host->cmd = NULL;
 	host->data = NULL;
@@ -262,11 +268,18 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 	cancel_delayed_work(&host->delayed_reset_work);
 
 	host->mrq = NULL;
+	spin_unlock_irqrestore(&host->lock, flags);
 
-	/* FIXME: mmc_request_done() can schedule! */
 	mmc_request_done(host->mmc, mrq);
 }
 
+static void tmio_mmc_done_work(struct work_struct *work)
+{
+	struct tmio_mmc_host *host = container_of(work, struct tmio_mmc_host,
+						  done);
+	tmio_mmc_finish_request(host);
+}
+
 /* These are the bitmasks the tmio chip requires to implement the MMC response
  * types. Note that R1 and R6 are the same in this scheme. */
 #define APP_CMD        0x0040
@@ -433,7 +446,7 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 			BUG();
 	}
 
-	tmio_mmc_finish_request(host);
+	schedule_work(&host->done);
 }
 
 static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
@@ -523,7 +536,7 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 				tasklet_schedule(&host->dma_issue);
 		}
 	} else {
-		tmio_mmc_finish_request(host);
+		schedule_work(&host->done);
 	}
 
 out:
@@ -573,7 +586,8 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
 	if (ireg & (TMIO_STAT_CARD_INSERT | TMIO_STAT_CARD_REMOVE)) {
 		tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_CARD_INSERT |
 			TMIO_STAT_CARD_REMOVE);
-		mmc_detect_change(host->mmc, msecs_to_jiffies(100));
+		if (!work_pending(&host->mmc->detect.work))
+			mmc_detect_change(host->mmc, msecs_to_jiffies(100));
 		goto out;
 	}
 
@@ -703,6 +717,8 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct tmio_mmc_data *pdata = host->pdata;
 	unsigned long flags;
 
+	mutex_lock(&host->ios_lock);
+
 	spin_lock_irqsave(&host->lock, flags);
 	if (host->mrq) {
 		if (IS_ERR(host->mrq)) {
@@ -718,6 +734,8 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 				host->mrq->cmd->opcode, host->last_req_ts, jiffies);
 		}
 		spin_unlock_irqrestore(&host->lock, flags);
+
+		mutex_unlock(&host->ios_lock);
 		return;
 	}
 
@@ -771,6 +789,8 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			current->comm, task_pid_nr(current),
 			ios->clock, ios->power_mode);
 	host->mrq = NULL;
+
+	mutex_unlock(&host->ios_lock);
 }
 
 static int tmio_mmc_get_ro(struct mmc_host *mmc)
@@ -867,9 +887,11 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 		tmio_mmc_enable_sdio_irq(mmc, 0);
 
 	spin_lock_init(&_host->lock);
+	mutex_init(&_host->ios_lock);
 
 	/* Init delayed work for request timeouts */
 	INIT_DELAYED_WORK(&_host->delayed_reset_work, tmio_mmc_reset_work);
+	INIT_WORK(&_host->done, tmio_mmc_done_work);
 
 	/* See if we also get DMA */
 	tmio_mmc_request_dma(_host, pdata);
@@ -917,6 +939,7 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 		pm_runtime_get_sync(&pdev->dev);
 
 	mmc_remove_host(host->mmc);
+	cancel_work_sync(&host->done);
 	cancel_delayed_work_sync(&host->delayed_reset_work);
 	tmio_mmc_release_dma(host);
 
-- 
1.7.2.5

