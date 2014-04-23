From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 02/38] mmc: sdhci: clean up interrupt handling
Date: Wed, 23 Apr 2014 20:06:20 +0100
Message-ID: <E1Wd2Uu-0003uN-Ca@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46346 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932491AbaDWTGW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:06:22 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

sdhci interrupt handling is a mess; there is a lot of code doing very
similar things.  Let's clean this up a bit:

1. set's clear down cmd, data and bus power interrupts in one go - we're
   always going to handle these.
2. use a do { } while () loop for looping while there are pending
   interrupts.
3. group clearing of bits in intmask into one place.

This results in the code becoming simpler and easier to read.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 124 ++++++++++++++++++++++-------------------------
 1 file changed, 58 insertions(+), 66 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9a79fc4b60ca..79838de6b278 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2426,7 +2426,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 {
 	irqreturn_t result;
 	struct sdhci_host *host = dev_id;
-	u32 intmask, unexpected = 0;
+	u32 intmask, mask, unexpected = 0;
 	int cardint = 0, max_loops = 16;
 
 	spin_lock(&host->lock);
@@ -2437,88 +2437,80 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 	}
 
 	intmask = sdhci_readl(host, SDHCI_INT_STATUS);
-
 	if (!intmask || intmask == 0xffffffff) {
 		result = IRQ_NONE;
 		goto out;
 	}
 
-again:
-	DBG("*** %s got interrupt: 0x%08x\n",
-		mmc_hostname(host->mmc), intmask);
-
-	if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
-		u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
-			      SDHCI_CARD_PRESENT;
-
-		/*
-		 * There is a observation on i.mx esdhc.  INSERT bit will be
-		 * immediately set again when it gets cleared, if a card is
-		 * inserted.  We have to mask the irq to prevent interrupt
-		 * storm which will freeze the system.  And the REMOVE gets
-		 * the same situation.
-		 *
-		 * More testing are needed here to ensure it works for other
-		 * platforms though.
-		 */
-		sdhci_mask_irqs(host, present ? SDHCI_INT_CARD_INSERT :
-						SDHCI_INT_CARD_REMOVE);
-		sdhci_unmask_irqs(host, present ? SDHCI_INT_CARD_REMOVE :
-						  SDHCI_INT_CARD_INSERT);
-
-		sdhci_writel(host, intmask & (SDHCI_INT_CARD_INSERT |
-			     SDHCI_INT_CARD_REMOVE), SDHCI_INT_STATUS);
-		intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
-		tasklet_schedule(&host->card_tasklet);
-	}
+	do {
+		/* Clear selected interrupts. */
+		mask = intmask & (SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK |
+				  SDHCI_INT_BUS_POWER);
+		sdhci_writel(host, mask, SDHCI_INT_STATUS);
 
-	if (intmask & SDHCI_INT_CMD_MASK) {
-		sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK,
-			SDHCI_INT_STATUS);
-		sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK);
-	}
+		DBG("*** %s got interrupt: 0x%08x\n",
+			mmc_hostname(host->mmc), intmask);
 
-	if (intmask & SDHCI_INT_DATA_MASK) {
-		sdhci_writel(host, intmask & SDHCI_INT_DATA_MASK,
-			SDHCI_INT_STATUS);
-		sdhci_data_irq(host, intmask & SDHCI_INT_DATA_MASK);
-	}
+		if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
+			u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
+				      SDHCI_CARD_PRESENT;
 
-	intmask &= ~(SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK);
+			/*
+			 * There is a observation on i.mx esdhc.  INSERT
+			 * bit will be immediately set again when it gets
+			 * cleared, if a card is inserted.  We have to mask
+			 * the irq to prevent interrupt storm which will
+			 * freeze the system.  And the REMOVE gets the
+			 * same situation.
+			 *
+			 * More testing are needed here to ensure it works
+			 * for other platforms though.
+			 */
+			sdhci_mask_irqs(host, present ? SDHCI_INT_CARD_INSERT :
+							SDHCI_INT_CARD_REMOVE);
+			sdhci_unmask_irqs(host, present ? SDHCI_INT_CARD_REMOVE :
+							  SDHCI_INT_CARD_INSERT);
+
+			sdhci_writel(host, intmask & (SDHCI_INT_CARD_INSERT |
+				     SDHCI_INT_CARD_REMOVE), SDHCI_INT_STATUS);
+			tasklet_schedule(&host->card_tasklet);
+		}
 
-	intmask &= ~SDHCI_INT_ERROR;
+		if (intmask & SDHCI_INT_CMD_MASK)
+			sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK);
 
-	if (intmask & SDHCI_INT_BUS_POWER) {
-		pr_err("%s: Card is consuming too much power!\n",
-			mmc_hostname(host->mmc));
-		sdhci_writel(host, SDHCI_INT_BUS_POWER, SDHCI_INT_STATUS);
-	}
+		if (intmask & SDHCI_INT_DATA_MASK)
+			sdhci_data_irq(host, intmask & SDHCI_INT_DATA_MASK);
 
-	intmask &= ~SDHCI_INT_BUS_POWER;
+		if (intmask & SDHCI_INT_BUS_POWER)
+			pr_err("%s: Card is consuming too much power!\n",
+				mmc_hostname(host->mmc));
 
-	if (intmask & SDHCI_INT_CARD_INT)
-		cardint = 1;
+		if (intmask & SDHCI_INT_CARD_INT)
+			cardint = 1;
 
-	intmask &= ~SDHCI_INT_CARD_INT;
+		intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE |
+			     SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK |
+			     SDHCI_INT_ERROR | SDHCI_INT_BUS_POWER |
+			     SDHCI_INT_CARD_INT);
 
-	if (intmask) {
-		unexpected |= intmask;
-		sdhci_writel(host, intmask, SDHCI_INT_STATUS);
-	}
+		if (intmask) {
+			unexpected |= intmask;
+			sdhci_writel(host, intmask, SDHCI_INT_STATUS);
+		}
 
-	result = IRQ_HANDLED;
+		result = IRQ_HANDLED;
 
-	intmask = sdhci_readl(host, SDHCI_INT_STATUS);
+		intmask = sdhci_readl(host, SDHCI_INT_STATUS);
 
-	/*
-	 * If we know we'll call the driver to signal SDIO IRQ, disregard
-	 * further indications of Card Interrupt in the status to avoid a
-	 * needless loop.
-	 */
-	if (cardint)
-		intmask &= ~SDHCI_INT_CARD_INT;
-	if (intmask && --max_loops)
-		goto again;
+		/*
+		 * If we know we'll call the driver to signal SDIO IRQ,
+		 * disregard further indications of Card Interrupt in
+		 * the status to avoid a needless loop.
+		 */
+		if (cardint)
+			intmask &= ~SDHCI_INT_CARD_INT;
+	} while (intmask && --max_loops);
 out:
 	spin_unlock(&host->lock);
 
-- 
1.8.3.1

