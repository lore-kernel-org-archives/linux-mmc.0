From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 06/31] mmc: sdhci: convert to new SDIO IRQ handling
Date: Tue, 18 Feb 2014 15:09:33 +0000
Message-ID: <E1WFmIf-0006lu-6w@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40452 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755933AbaBRPJf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:09:35 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>

Use a generic threaded interrupt handler for SDIO interrupt handling,
rather than allowing the SDIO core code to buggily spawn its own
thread.  This results in host drivers to be more in control of how
SDIO interrupts are acknowledged in the hardware, rather than having
the internals of the SDIO core placed upon them, possibly resulting
in sub-standard handling.

At least one SDHCI implementation specifies a very specific sequence
to deal with a card interrupt.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/host/sdhci.c  | 62 +++++++++++++++++++++++++++++------------------
 include/linux/mmc/sdhci.h |  2 ++
 2 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index dda992abf187..79a989357ac7 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.c
@@ -2424,10 +2424,10 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 
 static irqreturn_t sdhci_irq(int irq, void *dev_id)
 {
-	irqreturn_t result;
=+DO NOT APPLY+=	irqreturn_t result = IRQ_NONE;
 	struct sdhci_host *host = dev_id;
 	u32 intmask, mask, unexpected = 0;
-	int cardint = 0, max_loops = 16;
=+DO NOT APPLY+=	int max_loops = 16;
 
 	spin_lock(&host->lock);
 
@@ -2488,8 +2488,11 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 			pr_err("%s: Card is consuming too much power!\n",
 				mmc_hostname(host->mmc));
 
-		if (intmask & SDHCI_INT_CARD_INT)
-			cardint = 1;
=+DO NOT APPLY+=		if (intmask & SDHCI_INT_CARD_INT) {
=+DO NOT APPLY+=			sdhci_enable_sdio_irq_nolock(host, false);
=+DO NOT APPLY+=			host->thread_isr |= SDHCI_INT_CARD_INT;
=+DO NOT APPLY+=			result = IRQ_WAKE_THREAD;
=+DO NOT APPLY+=		}
 
 		intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE |
 			     SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK |
@@ -2501,17 +2504,10 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 			sdhci_writel(host, intmask, SDHCI_INT_STATUS);
 		}
 
-		result = IRQ_HANDLED;
=+DO NOT APPLY+=		if (result == IRQ_NONE)
=+DO NOT APPLY+=			result = IRQ_HANDLED;
 
 		intmask = sdhci_readl(host, SDHCI_INT_STATUS);
-
-		/*
-		 * If we know we'll call the driver to signal SDIO IRQ,
-		 * disregard further indications of Card Interrupt in
-		 * the status to avoid a needless loop.
-		 */
-		if (cardint)
-			intmask &= ~SDHCI_INT_CARD_INT;
 	} while (intmask && --max_loops);
 out:
 	spin_unlock(&host->lock);
@@ -2521,15 +2517,33 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 			   mmc_hostname(host->mmc), unexpected);
 		sdhci_dumpregs(host);
 	}
-	/*
-	 * We have to delay this as it calls back into the driver.
-	 */
-	if (cardint)
-		mmc_signal_sdio_irq(host->mmc);
 
 	return result;
 }
 
=+DO NOT APPLY+=static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
=+DO NOT APPLY+={
=+DO NOT APPLY+=	struct sdhci_host *host = dev_id;
=+DO NOT APPLY+=	unsigned long flags;
=+DO NOT APPLY+=	u32 isr;
=+DO NOT APPLY+=
=+DO NOT APPLY+=	spin_lock_irqsave(&host->lock, flags);
=+DO NOT APPLY+=	isr = host->thread_isr;
=+DO NOT APPLY+=	host->thread_isr = 0;
=+DO NOT APPLY+=	spin_unlock_irqrestore(&host->lock, flags);
=+DO NOT APPLY+=
=+DO NOT APPLY+=	if (isr & SDHCI_INT_CARD_INT) {
=+DO NOT APPLY+=		sdio_run_irqs(host->mmc);
=+DO NOT APPLY+=
=+DO NOT APPLY+=		spin_lock_irqsave(&host->lock, flags);
=+DO NOT APPLY+=		if (host->flags & SDHCI_SDIO_IRQ_ENABLED)
=+DO NOT APPLY+=			sdhci_enable_sdio_irq_nolock(host, true);
=+DO NOT APPLY+=		spin_unlock_irqrestore(&host->lock, flags);
=+DO NOT APPLY+=	}
=+DO NOT APPLY+=
=+DO NOT APPLY+=	return isr ? IRQ_HANDLED : IRQ_NONE;
=+DO NOT APPLY+=}
=+DO NOT APPLY+=
 /*****************************************************************************\
  *                                                                           *
  * Suspend/resume                                                            *
@@ -2599,8 +2613,9 @@ int sdhci_resume_host(struct sdhci_host *host)
 	}
 
 	if (!device_may_wakeup(mmc_dev(host->mmc))) {
-		ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
-				  mmc_hostname(host->mmc), host);
=+DO NOT APPLY+=		ret = request_threaded_irq(host->irq, sdhci_irq,
=+DO NOT APPLY+=					   sdhci_thread_irq, IRQF_SHARED,
=+DO NOT APPLY+=					   mmc_hostname(host->mmc), host);
 		if (ret)
 			return ret;
 	} else {
@@ -2679,7 +2694,7 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
 	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	synchronize_irq(host->irq);
=+DO NOT APPLY+=	synchronize_hardirq(host->irq);
 
 	spin_lock_irqsave(&host->lock, flags);
 	host->runtime_suspended = true;
@@ -2935,6 +2950,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	mmc->max_discard_to = (1 << 27) / host->timeout_clk;
 
 	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
=+DO NOT APPLY+=	mmc->caps2 |= MMC_CAP2_SDIO_NOTHREAD;
 
 	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
 		host->flags |= SDHCI_AUTO_CMD12;
@@ -3223,8 +3239,8 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	sdhci_init(host, 0);
 
-	ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
-		mmc_hostname(mmc), host);
=+DO NOT APPLY+=	ret = request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
=+DO NOT APPLY+=				   IRQF_SHARED,	mmc_hostname(mmc), host);
 	if (ret) {
 		pr_err("%s: Failed to request IRQ %d: %d\n",
 		       mmc_hostname(mmc), host->irq, ret);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 362927c48f97..db880b285793 100644
=-DO NOT APPLY-= a/include/linux/mmc/sdhci.h
=+DO NOT APPLY+= b/include/linux/mmc/sdhci.h
@@ -175,6 +175,8 @@ struct sdhci_host {
 	unsigned int            ocr_avail_mmc;
 	u32 ocr_mask;		/* available voltages */
 
=+DO NOT APPLY+=	u32			thread_isr;
=+DO NOT APPLY+=
 	wait_queue_head_t	buf_ready_int;	/* Waitqueue for Buffer Read Ready interrupt */
 	unsigned int		tuning_done;	/* Condition flag set when CMD19 succeeds */
 
-- 
1.8.3.1

