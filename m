From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: [PATCH 3/8] sdhci: Use work structs instead of tasklets
Date: Fri, 24 May 2013 18:00:37 +0200
Message-ID: <1369411242-20515-4-git-send-email-jeremie.samuel.ext@parrot.com>
References: <1369411242-20515-1-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:35669 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755394Ab3EXQBc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 May 2013 12:01:32 -0400
In-Reply-To: <1369411242-20515-1-git-send-email-jeremie.samuel.ext@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: matthieu.castet@parrot.com, gregor.boirie@parrot.com, Jeremie Samuel <jeremie.samuel.ext@parrot.com>, Anton Vorontsov <avorontsov@mvista.com>

The driver can happily live without an atomic context and tasklets,
so turn the tasklets into the work structs.

Tasklets handlers still grab irqsave spinlocks, but we'll deal
with it in a separate patch.

Patch based on: http://thread.gmane.org/gmane.linux.kernel.mmc/2579.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
Signed-off-by: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
---
 drivers/mmc/host/sdhci.c  |   55 +++++++++++++++++++++------------------------
 include/linux/mmc/sdhci.h |    4 ++--
 2 files changed, 27 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7d7033b..063c20a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -967,7 +967,7 @@ static void sdhci_finish_data(struct sdhci_host *host)
 
 		sdhci_send_command(host, data->stop);
 	} else
-		tasklet_schedule(&host->finish_tasklet);
+		schedule_work(&host->finish_work);
 }
 
 static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
@@ -996,7 +996,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 				"inhibit bit(s).\n", mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
 			cmd->error = -EIO;
-			tasklet_schedule(&host->finish_tasklet);
+			schedule_work(&host->finish_work);
 			return;
 		}
 		timeout--;
@@ -1017,7 +1017,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		pr_err("%s: Unsupported response type!\n",
 			mmc_hostname(host->mmc));
 		cmd->error = -EINVAL;
-		tasklet_schedule(&host->finish_tasklet);
+		schedule_work(&host->finish_work);
 		return;
 	}
 
@@ -1078,7 +1078,7 @@ static void sdhci_finish_command(struct sdhci_host *host)
 			sdhci_finish_data(host);
 
 		if (!host->cmd->data)
-			tasklet_schedule(&host->finish_tasklet);
+			schedule_work(&host->finish_work);
 
 		host->cmd = NULL;
 	}
@@ -1357,7 +1357,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
 		host->mrq->cmd->error = -ENOMEDIUM;
-		tasklet_schedule(&host->finish_tasklet);
+		schedule_work(&host->finish_work);
 	} else {
 		u32 present_state;
 
@@ -2062,7 +2062,7 @@ static void sdhci_card_event(struct mmc_host *mmc)
 		sdhci_reset(host, SDHCI_RESET_DATA);
 
 		host->mrq->cmd->error = -ENOMEDIUM;
-		tasklet_schedule(&host->finish_tasklet);
+		schedule_work(&host->finish_work);
 	}
 
 	spin_unlock_irqrestore(&host->lock, flags);
@@ -2087,29 +2087,30 @@ static const struct mmc_host_ops sdhci_ops = {
  *                                                                           *
 \*****************************************************************************/
 
-static void sdhci_tasklet_card(unsigned long param)
+static void sdhci_card_detect_work(struct work_struct *wk)
 {
-	struct sdhci_host *host = (struct sdhci_host*)param;
+	struct sdhci_host *host = container_of(wk, struct sdhci_host,
+						   card_detect_work);
 
 	sdhci_card_event(host->mmc);
 
 	mmc_detect_change(host->mmc, msecs_to_jiffies(200));
 }
 
-static void sdhci_tasklet_finish(unsigned long param)
+static void sdhci_finish_work(struct work_struct *wk)
 {
 	struct sdhci_host *host;
 	unsigned long flags;
 	struct mmc_request *mrq;
 
-	host = (struct sdhci_host*)param;
+	host = container_of(wk, struct sdhci_host, finish_work);
 
 	spin_lock_irqsave(&host->lock, flags);
 
-        /*
-         * If this tasklet gets rescheduled while running, it will
-         * be run again afterwards but without any active request.
-         */
+	/*
+	 * If this work gets rescheduled while running, it will
+	 * be run again afterwards but without any active request.
+	 */
 	if (!host->mrq) {
 		spin_unlock_irqrestore(&host->lock, flags);
 		return;
@@ -2178,7 +2179,7 @@ static void sdhci_timeout_work(struct work_struct *wk)
 			else
 				host->mrq->cmd->error = -ETIMEDOUT;
 
-			tasklet_schedule(&host->finish_tasklet);
+			schedule_work(&host->finish_work);
 		}
 	}
 
@@ -2225,7 +2226,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
 		host->cmd->error = -EILSEQ;
 
 	if (host->cmd->error) {
-		tasklet_schedule(&host->finish_tasklet);
+		schedule_work(&host->finish_work);
 		return;
 	}
 
@@ -2434,7 +2435,7 @@ again:
 		sdhci_writel(host, intmask & (SDHCI_INT_CARD_INSERT |
 			     SDHCI_INT_CARD_REMOVE), SDHCI_INT_STATUS);
 		intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
-		tasklet_schedule(&host->card_tasklet);
+		schedule_work(&host->card_detect_work);
 	}
 
 	if (intmask & SDHCI_INT_CMD_MASK) {
@@ -3158,12 +3159,10 @@ int sdhci_add_host(struct sdhci_host *host)
 	mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
 
 	/*
-	 * Init tasklets.
+	 * Init work structs.
 	 */
-	tasklet_init(&host->card_tasklet,
-		sdhci_tasklet_card, (unsigned long)host);
-	tasklet_init(&host->finish_tasklet,
-		sdhci_tasklet_finish, (unsigned long)host);
+	INIT_WORK(&host->card_detect_work, sdhci_card_detect_work);
+	INIT_WORK(&host->finish_work, sdhci_finish_work);
 
 	INIT_DELAYED_WORK(&host->timeout_work, sdhci_timeout_work);
 
@@ -3180,7 +3179,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (ret) {
 		pr_err("%s: Failed to request IRQ %d: %d\n",
 		       mmc_hostname(mmc), host->irq, ret);
-		goto untasklet;
+		return ret;
 	}
 
 	sdhci_init(host, 0);
@@ -3224,10 +3223,6 @@ reset:
 	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
 	free_irq(host->irq, host);
 #endif
-untasklet:
-	tasklet_kill(&host->card_tasklet);
-	tasklet_kill(&host->finish_tasklet);
-
 	return ret;
 }
 
@@ -3247,7 +3242,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 				" transfer!\n", mmc_hostname(host->mmc));
 
 			host->mrq->cmd->error = -ENOMEDIUM;
-			tasklet_schedule(&host->finish_tasklet);
+			schedule_work(&host->finish_work);
 		}
 
 		spin_unlock_irqrestore(&host->lock, flags);
@@ -3269,8 +3264,8 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 	flush_delayed_work(&host->timeout_work);
 
-	tasklet_kill(&host->card_tasklet);
-	tasklet_kill(&host->finish_tasklet);
+	flush_work(&host->card_detect_work);
+	flush_work(&host->finish_work);
 
 	if (host->vmmc) {
 		regulator_disable(host->vmmc);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index d0f4845..152acb5 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -157,8 +157,8 @@ struct sdhci_host {
 	dma_addr_t adma_addr;	/* Mapped ADMA descr. table */
 	dma_addr_t align_addr;	/* Mapped bounce buffer */
 
-	struct tasklet_struct card_tasklet;	/* Tasklet structures */
-	struct tasklet_struct finish_tasklet;
+	struct work_struct	card_detect_work;
+	struct work_struct	finish_work;
 
 	struct delayed_work	timeout_work;	/* Work for timeouts */
 
-- 
1.7.10.4

