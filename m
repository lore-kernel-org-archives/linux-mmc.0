From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 07/31] mmc: sdhci: push card_tasklet into threaded irq
 handler
Date: Tue, 18 Feb 2014 15:09:38 +0000
Message-ID: <E1WFmIk-0006m0-Ah@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40456 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755933AbaBRPJk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:09:40 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>

There's no requirement to have the card tasklet separate now that we
have a threaded interrupt handler, so kill this and move the called
code into the threaded part of the handler.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/host/sdhci.c  | 23 +++++++++--------------
 include/linux/mmc/sdhci.h |  3 +--
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 79a989357ac7..dfec8aab1a4a 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.c
@@ -2124,15 +2124,6 @@ static const struct mmc_host_ops sdhci_ops = {
  *                                                                           *
 \*****************************************************************************/
 
-static void sdhci_tasklet_card(unsigned long param)
-{
-	struct sdhci_host *host = (struct sdhci_host*)param;
-
-	sdhci_card_event(host->mmc);
-
-	mmc_detect_change(host->mmc, msecs_to_jiffies(200));
-}
-
 static void sdhci_tasklet_finish(unsigned long param)
 {
 	struct sdhci_host *host;
@@ -2475,7 +2466,10 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 			sdhci_writel(host, intmask & (SDHCI_INT_CARD_INSERT |
 				     SDHCI_INT_CARD_REMOVE), SDHCI_INT_STATUS);
-			tasklet_schedule(&host->card_tasklet);
=+DO NOT APPLY+=
=+DO NOT APPLY+=			host->thread_isr |= intmask & (SDHCI_INT_CARD_INSERT |
=+DO NOT APPLY+=						       SDHCI_INT_CARD_REMOVE);
=+DO NOT APPLY+=			result = IRQ_WAKE_THREAD;
 		}
 
 		if (intmask & SDHCI_INT_CMD_MASK)
@@ -2532,6 +2526,11 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 	host->thread_isr = 0;
 	spin_unlock_irqrestore(&host->lock, flags);
 
=+DO NOT APPLY+=	if (isr & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
=+DO NOT APPLY+=		sdhci_card_event(host->mmc);
=+DO NOT APPLY+=		mmc_detect_change(host->mmc, msecs_to_jiffies(200));
=+DO NOT APPLY+=	}
=+DO NOT APPLY+=
 	if (isr & SDHCI_INT_CARD_INT) {
 		sdio_run_irqs(host->mmc);
 
@@ -3221,8 +3220,6 @@ int sdhci_add_host(struct sdhci_host *host)
 	/*
 	 * Init tasklets.
 	 */
-	tasklet_init(&host->card_tasklet,
-		sdhci_tasklet_card, (unsigned long)host);
 	tasklet_init(&host->finish_tasklet,
 		sdhci_tasklet_finish, (unsigned long)host);
 
@@ -3287,7 +3284,6 @@ int sdhci_add_host(struct sdhci_host *host)
 	free_irq(host->irq, host);
 #endif
 untasklet:
-	tasklet_kill(&host->card_tasklet);
 	tasklet_kill(&host->finish_tasklet);
 
 	return ret;
@@ -3331,7 +3327,6 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 	del_timer_sync(&host->timer);
 
-	tasklet_kill(&host->card_tasklet);
 	tasklet_kill(&host->finish_tasklet);
 
 	if (host->vmmc) {
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index db880b285793..da7b526bdbf1 100644
=-DO NOT APPLY-= a/include/linux/mmc/sdhci.h
=+DO NOT APPLY+= b/include/linux/mmc/sdhci.h
@@ -162,8 +162,7 @@ struct sdhci_host {
 	dma_addr_t adma_addr;	/* Mapped ADMA descr. table */
 	dma_addr_t align_addr;	/* Mapped bounce buffer */
 
-	struct tasklet_struct card_tasklet;	/* Tasklet structures */
-	struct tasklet_struct finish_tasklet;
=+DO NOT APPLY+=	struct tasklet_struct finish_tasklet;	/* Tasklet structures */
 
 	struct timer_list timer;	/* Timer for timeouts */
 
-- 
1.8.3.1

