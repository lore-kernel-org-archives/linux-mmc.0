From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 04/38] mmc: sdhci: convert to new SDIO IRQ handling
Date: Wed, 23 Apr 2014 20:06:30 +0100
Message-ID: <E1Wd2V4-0003uW-K0@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46355 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932381AbaDWTGd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:06:33 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

Use a generic threaded interrupt handler for SDIO interrupt handling,
rather than allowing the SDIO core code to buggily spawn its own
thread.  This results in host drivers to be more in control of how
SDIO interrupts are acknowledged in the hardware, rather than having
the internals of the SDIO core placed upon them, possibly resulting
in sub-standard handling.

At least one SDHCI implementation specifies a very specific sequence
to deal with a card interrupt.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c  | 62 +++++++++++++++++++++++++++++------------------
 include/linux/mmc/sdhci.h |  2 ++
 2 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 239d90d77ac4..a2b04cdc594d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2423,10 +2423,10 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 
 static irqreturn_t sdhci_irq(int irq, void *dev_id)
 {
-	irqreturn_t result;
+	irqreturn_t result = IRQ_NONE;
 	struct sdhci_host *host = dev_id;
 	u32 intmask, mask, unexpected = 0;
-	int cardint = 0, max_loops = 16;
+	int max_loops = 16;
 
 	spin_lock(&host->lock);
 
@@ -2485,8 +2485,11 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 			pr_err("%s: Card is consuming too much power!\n",
 				mmc_hostname(host->mmc));
 
-		if (intmask & SDHCI_INT_CARD_INT)
-			cardint = 1;
+		if (intmask & SDHCI_INT_CARD_INT) {
+			sdhci_enable_sdio_irq_nolock(host, false);
+			host->thread_isr |= SDHCI_INT_CARD_INT;
+			result = IRQ_WAKE_THREAD;
+		}
 
 		intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE |
 			     SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK |
@@ -2498,17 +2501,10 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 			sdhci_writel(host, intmask, SDHCI_INT_STATUS);
 		}
 
-		result = IRQ_HANDLED;
+		if (result == IRQ_NONE)
+			result = IRQ_HANDLED;
 
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
@@ -2518,15 +2514,33 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
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
 
+static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
+{
+	struct sdhci_host *host = dev_id;
+	unsigned long flags;
+	u32 isr;
+
+	spin_lock_irqsave(&host->lock, flags);
+	isr = host->thread_isr;
+	host->thread_isr = 0;
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (isr & SDHCI_INT_CARD_INT) {
+		sdio_run_irqs(host->mmc);
+
+		spin_lock_irqsave(&host->lock, flags);
+		if (host->flags & SDHCI_SDIO_IRQ_ENABLED)
+			sdhci_enable_sdio_irq_nolock(host, true);
+		spin_unlock_irqrestore(&host->lock, flags);
+	}
+
+	return isr ? IRQ_HANDLED : IRQ_NONE;
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Suspend/resume                                                            *
@@ -2596,8 +2610,9 @@ int sdhci_resume_host(struct sdhci_host *host)
 	}
 
 	if (!device_may_wakeup(mmc_dev(host->mmc))) {
-		ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
-				  mmc_hostname(host->mmc), host);
+		ret = request_threaded_irq(host->irq, sdhci_irq,
+					   sdhci_thread_irq, IRQF_SHARED,
+					   mmc_hostname(host->mmc), host);
 		if (ret)
 			return ret;
 	} else {
@@ -2676,7 +2691,7 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
 	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	synchronize_irq(host->irq);
+	synchronize_hardirq(host->irq);
 
 	spin_lock_irqsave(&host->lock, flags);
 	host->runtime_suspended = true;
@@ -2932,6 +2947,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	mmc->max_busy_timeout = (1 << 27) / host->timeout_clk;
 
 	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
+	mmc->caps2 |= MMC_CAP2_SDIO_NOTHREAD;
 
 	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
 		host->flags |= SDHCI_AUTO_CMD12;
@@ -3221,8 +3237,8 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	sdhci_init(host, 0);
 
-	ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
-		mmc_hostname(mmc), host);
+	ret = request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
+				   IRQF_SHARED,	mmc_hostname(mmc), host);
 	if (ret) {
 		pr_err("%s: Failed to request IRQ %d: %d\n",
 		       mmc_hostname(mmc), host->irq, ret);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 7be12b883485..d1aa97b77dd9 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -177,6 +177,8 @@ struct sdhci_host {
 	unsigned int            ocr_avail_mmc;
 	u32 ocr_mask;		/* available voltages */
 
+	u32			thread_isr;
+
 	wait_queue_head_t	buf_ready_int;	/* Waitqueue for Buffer Read Ready interrupt */
 	unsigned int		tuning_done;	/* Condition flag set when CMD19 succeeds */
 
-- 
1.8.3.1

