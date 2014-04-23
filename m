From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 05/38] mmc: sdhci: push card_tasklet into threaded irq handler
Date: Wed, 23 Apr 2014 20:06:35 +0100
Message-ID: <E1Wd2V9-0003ua-Ni@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46361 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932381AbaDWTGi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:06:38 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

There's no requirement to have the card tasklet separate now that we
have a threaded interrupt handler, so kill this and move the called
code into the threaded part of the handler.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c  | 23 +++++++++--------------
 include/linux/mmc/sdhci.h |  3 +--
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a2b04cdc594d..878c6eb5aa8b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2123,15 +2123,6 @@ static const struct mmc_host_ops sdhci_ops = {
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
@@ -2472,7 +2463,10 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 			sdhci_writel(host, intmask & (SDHCI_INT_CARD_INSERT |
 				     SDHCI_INT_CARD_REMOVE), SDHCI_INT_STATUS);
-			tasklet_schedule(&host->card_tasklet);
+
+			host->thread_isr |= intmask & (SDHCI_INT_CARD_INSERT |
+						       SDHCI_INT_CARD_REMOVE);
+			result = IRQ_WAKE_THREAD;
 		}
 
 		if (intmask & SDHCI_INT_CMD_MASK)
@@ -2529,6 +2523,11 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 	host->thread_isr = 0;
 	spin_unlock_irqrestore(&host->lock, flags);
 
+	if (isr & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
+		sdhci_card_event(host->mmc);
+		mmc_detect_change(host->mmc, msecs_to_jiffies(200));
+	}
+
 	if (isr & SDHCI_INT_CARD_INT) {
 		sdio_run_irqs(host->mmc);
 
@@ -3219,8 +3218,6 @@ int sdhci_add_host(struct sdhci_host *host)
 	/*
 	 * Init tasklets.
 	 */
-	tasklet_init(&host->card_tasklet,
-		sdhci_tasklet_card, (unsigned long)host);
 	tasklet_init(&host->finish_tasklet,
 		sdhci_tasklet_finish, (unsigned long)host);
 
@@ -3285,7 +3282,6 @@ int sdhci_add_host(struct sdhci_host *host)
 	free_irq(host->irq, host);
 #endif
 untasklet:
-	tasklet_kill(&host->card_tasklet);
 	tasklet_kill(&host->finish_tasklet);
 
 	return ret;
@@ -3329,7 +3325,6 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 	del_timer_sync(&host->timer);
 
-	tasklet_kill(&host->card_tasklet);
 	tasklet_kill(&host->finish_tasklet);
 
 	if (host->vmmc) {
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index d1aa97b77dd9..f1c8e14e8751 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -164,8 +164,7 @@ struct sdhci_host {
 	dma_addr_t adma_addr;	/* Mapped ADMA descr. table */
 	dma_addr_t align_addr;	/* Mapped bounce buffer */
 
-	struct tasklet_struct card_tasklet;	/* Tasklet structures */
-	struct tasklet_struct finish_tasklet;
+	struct tasklet_struct finish_tasklet;	/* Tasklet structures */
 
 	struct timer_list timer;	/* Timer for timeouts */
 
-- 
1.8.3.1

