From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 09/31] mmc: sdhci: more efficient interrupt enable
 register handling
Date: Tue, 18 Feb 2014 15:09:48 +0000
Message-ID: <E1WFmIu-0006mK-PC@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40462 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755606AbaBRPJu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:09:50 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>

Rather than wasting cycles read-modify-writing the interrupt enable
registers, cache the value locally instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/host/sdhci.c  | 98 +++++++++++++++++++++++------------------------
 include/linux/mmc/sdhci.h |  3 ++
 2 files changed, 50 insertions(+), 51 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 576ded2406d9..84cd0fd820d9 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.c
@@ -131,27 +131,6 @@ static void sdhci_dumpregs(struct sdhci_host *host)
  *                                                                           *
 \*****************************************************************************/
 
-static void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
-{
-	u32 ier;
-
-	ier = sdhci_readl(host, SDHCI_INT_ENABLE);
-	ier &= ~clear;
-	ier |= set;
-	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
-	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
-}
-
-static void sdhci_unmask_irqs(struct sdhci_host *host, u32 irqs)
-{
-	sdhci_clear_set_irqs(host, 0, irqs);
-}
-
-static void sdhci_mask_irqs(struct sdhci_host *host, u32 irqs)
-{
-	sdhci_clear_set_irqs(host, irqs, 0);
-}
-
 static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 {
 	u32 present, irqs;
@@ -165,9 +144,12 @@ static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 	irqs = present ? SDHCI_INT_CARD_REMOVE : SDHCI_INT_CARD_INSERT;
 
 	if (enable)
-		sdhci_unmask_irqs(host, irqs);
=+DO NOT APPLY+=		host->ier |= irqs;
 	else
-		sdhci_mask_irqs(host, irqs);
=+DO NOT APPLY+=		host->ier &= ~irqs;
=+DO NOT APPLY+=
=+DO NOT APPLY+=	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
=+DO NOT APPLY+=	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
 
 static void sdhci_enable_card_detection(struct sdhci_host *host)
@@ -183,17 +165,12 @@ static void sdhci_disable_card_detection(struct sdhci_host *host)
 static void sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	unsigned long timeout;
-	u32 uninitialized_var(ier);
-
 	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
 		if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
 			SDHCI_CARD_PRESENT))
 			return;
 	}
 
-	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
-		ier = sdhci_readl(host, SDHCI_INT_ENABLE);
-
 	if (host->ops->platform_reset_enter)
 		host->ops->platform_reset_enter(host, mask);
 
@@ -224,8 +201,10 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 	if (host->ops->platform_reset_exit)
 		host->ops->platform_reset_exit(host, mask);
 
-	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
-		sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
=+DO NOT APPLY+=	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET) {
=+DO NOT APPLY+=		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
=+DO NOT APPLY+=		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
=+DO NOT APPLY+=	}
 
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
 		if ((host->ops->enable_dma) && (mask & SDHCI_RESET_ALL))
@@ -242,11 +221,14 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 	else
 		sdhci_reset(host, SDHCI_RESET_ALL);
 
-	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
-		SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
-		SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_INDEX |
-		SDHCI_INT_END_BIT | SDHCI_INT_CRC | SDHCI_INT_TIMEOUT |
-		SDHCI_INT_DATA_END | SDHCI_INT_RESPONSE);
=+DO NOT APPLY+=	host->ier = SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
=+DO NOT APPLY+=		    SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT |
=+DO NOT APPLY+=		    SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC |
=+DO NOT APPLY+=		    SDHCI_INT_TIMEOUT | SDHCI_INT_DATA_END |
=+DO NOT APPLY+=		    SDHCI_INT_RESPONSE;
=+DO NOT APPLY+=
=+DO NOT APPLY+=	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
=+DO NOT APPLY+=	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 
 	if (soft) {
 		/* force clock reconfiguration */
@@ -721,9 +703,12 @@ static void sdhci_set_transfer_irqs(struct sdhci_host *host)
 	u32 dma_irqs = SDHCI_INT_DMA_END | SDHCI_INT_ADMA_ERROR;
 
 	if (host->flags & SDHCI_REQ_USE_DMA)
-		sdhci_clear_set_irqs(host, pio_irqs, dma_irqs);
=+DO NOT APPLY+=		host->ier = (host->ier & ~pio_irqs) | dma_irqs;
 	else
-		sdhci_clear_set_irqs(host, dma_irqs, pio_irqs);
=+DO NOT APPLY+=		host->ier = (host->ier & ~dma_irqs) | pio_irqs;
=+DO NOT APPLY+=
=+DO NOT APPLY+=	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
=+DO NOT APPLY+=	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
 
 static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
@@ -1711,9 +1696,12 @@ static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
 {
 	if (!(host->flags & SDHCI_DEVICE_DEAD)) {
 		if (enable)
-			sdhci_unmask_irqs(host, SDHCI_INT_CARD_INT);
=+DO NOT APPLY+=			host->ier |= SDHCI_INT_CARD_INT;
 		else
-			sdhci_mask_irqs(host, SDHCI_INT_CARD_INT);
=+DO NOT APPLY+=			host->ier &= ~SDHCI_INT_CARD_INT;
=+DO NOT APPLY+=
=+DO NOT APPLY+=		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
=+DO NOT APPLY+=		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 		mmiowb();
 	}
 }
@@ -1855,7 +1843,6 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host;
 	u16 ctrl;
-	u32 ier;
 	int tuning_loop_counter = MAX_TUNING_LOOP;
 	unsigned long timeout;
 	int err = 0;
@@ -1909,8 +1896,8 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * to make sure we don't hit a controller bug, we _only_
 	 * enable Buffer Read Ready interrupt here.
 	 */
-	ier = sdhci_readl(host, SDHCI_INT_ENABLE);
-	sdhci_clear_set_irqs(host, ier, SDHCI_INT_DATA_AVAIL);
=+DO NOT APPLY+=	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
=+DO NOT APPLY+=	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_SIGNAL_ENABLE);
 
 	/*
 	 * Issue CMD19 repeatedly till Execute Tuning is set to 0 or the number
@@ -2043,7 +2030,8 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	if (err && (host->flags & SDHCI_USING_RETUNING_TIMER))
 		err = 0;
 
-	sdhci_clear_set_irqs(host, SDHCI_INT_DATA_AVAIL, ier);
=+DO NOT APPLY+=	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
=+DO NOT APPLY+=	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 	spin_unlock_irqrestore(&host->lock, flags);
 	sdhci_runtime_pm_put(host);
 
@@ -2458,10 +2446,12 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 			 * More testing are needed here to ensure it works
 			 * for other platforms though.
 			 */
-			sdhci_mask_irqs(host, present ? SDHCI_INT_CARD_INSERT :
-							SDHCI_INT_CARD_REMOVE);
-			sdhci_unmask_irqs(host, present ? SDHCI_INT_CARD_REMOVE :
-							  SDHCI_INT_CARD_INSERT);
=+DO NOT APPLY+=			host->ier &= ~(SDHCI_INT_CARD_INSERT |
=+DO NOT APPLY+=				       SDHCI_INT_CARD_REMOVE);
=+DO NOT APPLY+=			host->ier |= present ? SDHCI_INT_CARD_REMOVE :
=+DO NOT APPLY+=					       SDHCI_INT_CARD_INSERT;
=+DO NOT APPLY+=			sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
=+DO NOT APPLY+=			sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 
 			sdhci_writel(host, intmask & (SDHCI_INT_CARD_INSERT |
 				     SDHCI_INT_CARD_REMOVE), SDHCI_INT_STATUS);
@@ -2590,7 +2580,9 @@ int sdhci_suspend_host(struct sdhci_host *host)
 	}
 
 	if (!device_may_wakeup(mmc_dev(host->mmc))) {
-		sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
=+DO NOT APPLY+=		host->ier = 0;
=+DO NOT APPLY+=		sdhci_writel(host, 0, SDHCI_INT_ENABLE);
=+DO NOT APPLY+=		sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
 		free_irq(host->irq, host);
 	} else {
 		sdhci_enable_irq_wakeups(host);
@@ -2689,7 +2681,9 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
 	}
 
 	spin_lock_irqsave(&host->lock, flags);
-	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK & ~SDHCI_INT_CARD_INT);
=+DO NOT APPLY+=	host->ier &= SDHCI_INT_CARD_INT;
=+DO NOT APPLY+=	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
=+DO NOT APPLY+=	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	synchronize_hardirq(host->irq);
@@ -3279,7 +3273,8 @@ int sdhci_add_host(struct sdhci_host *host)
 #ifdef SDHCI_USE_LEDS_CLASS
 reset:
 	sdhci_reset(host, SDHCI_RESET_ALL);
-	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
=+DO NOT APPLY+=	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
=+DO NOT APPLY+=	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
 	free_irq(host->irq, host);
 #endif
 untasklet:
@@ -3321,7 +3316,8 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	if (!dead)
 		sdhci_reset(host, SDHCI_RESET_ALL);
 
-	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
=+DO NOT APPLY+=	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
=+DO NOT APPLY+=	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
 	free_irq(host->irq, host);
 
 	del_timer_sync(&host->timer);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index da7b526bdbf1..493c57aee4cb 100644
=-DO NOT APPLY-= a/include/linux/mmc/sdhci.h
=+DO NOT APPLY+= b/include/linux/mmc/sdhci.h
@@ -176,6 +176,9 @@ struct sdhci_host {
 
 	u32			thread_isr;
 
=+DO NOT APPLY+=	/* cached registers */
=+DO NOT APPLY+=	u32			ier;
=+DO NOT APPLY+=
 	wait_queue_head_t	buf_ready_int;	/* Waitqueue for Buffer Read Ready interrupt */
 	unsigned int		tuning_done;	/* Condition flag set when CMD19 succeeds */
 
-- 
1.8.3.1

