From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 04/31] mmc: sdhci: clean up interrupt handling
Date: Tue, 18 Feb 2014 15:09:22 +0000
Message-ID: <E1WFmIU-0006lm-Vr@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40447 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756182AbaBRPJZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:09:25 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>

sdhci interrupt handling is a mess; there is a lot of code doing very
similar things.  Let's clean this up a bit:

1. set's clear down cmd, data and bus power interrupts in one go - we're
   always going to handle these.
2. use a do { } while () loop for looping while there are pending
   interrupts.
3. group clearing of bits in intmask into one place.

This results in the code becoming simpler and easier to read.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/host/sdhci.c | 124 ++++++++++++++++++++++-------------------------
 1 file changed, 58 insertions(+), 66 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9ddef4763541..d44033bc6f1b 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.c
@@ -2427,7 +2427,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 {
 	irqreturn_t result;
 	struct sdhci_host *host = dev_id;
-	u32 intmask, unexpected = 0;
=+DO NOT APPLY+=	u32 intmask, mask, unexpected = 0;
 	int cardint = 0, max_loops = 16;
 
 	spin_lock(&host->lock);
@@ -2440,88 +2440,80 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
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
=+DO NOT APPLY+=	do {
=+DO NOT APPLY+=		/* Clear selected interrupts. */
=+DO NOT APPLY+=		mask = intmask & (SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK |
=+DO NOT APPLY+=				  SDHCI_INT_BUS_POWER);
=+DO NOT APPLY+=		sdhci_writel(host, mask, SDHCI_INT_STATUS);
 
-	if (intmask & SDHCI_INT_CMD_MASK) {
-		sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK,
-			SDHCI_INT_STATUS);
-		sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK);
-	}
=+DO NOT APPLY+=		DBG("*** %s got interrupt: 0x%08x\n",
=+DO NOT APPLY+=			mmc_hostname(host->mmc), intmask);
 
-	if (intmask & SDHCI_INT_DATA_MASK) {
-		sdhci_writel(host, intmask & SDHCI_INT_DATA_MASK,
-			SDHCI_INT_STATUS);
-		sdhci_data_irq(host, intmask & SDHCI_INT_DATA_MASK);
-	}
=+DO NOT APPLY+=		if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
=+DO NOT APPLY+=			u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
=+DO NOT APPLY+=				      SDHCI_CARD_PRESENT;
 
-	intmask &= ~(SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK);
=+DO NOT APPLY+=			/*
=+DO NOT APPLY+=			 * There is a observation on i.mx esdhc.  INSERT
=+DO NOT APPLY+=			 * bit will be immediately set again when it gets
=+DO NOT APPLY+=			 * cleared, if a card is inserted.  We have to mask
=+DO NOT APPLY+=			 * the irq to prevent interrupt storm which will
=+DO NOT APPLY+=			 * freeze the system.  And the REMOVE gets the
=+DO NOT APPLY+=			 * same situation.
=+DO NOT APPLY+=			 *
=+DO NOT APPLY+=			 * More testing are needed here to ensure it works
=+DO NOT APPLY+=			 * for other platforms though.
=+DO NOT APPLY+=			 */
=+DO NOT APPLY+=			sdhci_mask_irqs(host, present ? SDHCI_INT_CARD_INSERT :
=+DO NOT APPLY+=							SDHCI_INT_CARD_REMOVE);
=+DO NOT APPLY+=			sdhci_unmask_irqs(host, present ? SDHCI_INT_CARD_REMOVE :
=+DO NOT APPLY+=							  SDHCI_INT_CARD_INSERT);
=+DO NOT APPLY+=
=+DO NOT APPLY+=			sdhci_writel(host, intmask & (SDHCI_INT_CARD_INSERT |
=+DO NOT APPLY+=				     SDHCI_INT_CARD_REMOVE), SDHCI_INT_STATUS);
=+DO NOT APPLY+=			tasklet_schedule(&host->card_tasklet);
=+DO NOT APPLY+=		}
 
-	intmask &= ~SDHCI_INT_ERROR;
=+DO NOT APPLY+=		if (intmask & SDHCI_INT_CMD_MASK)
=+DO NOT APPLY+=			sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK);
 
-	if (intmask & SDHCI_INT_BUS_POWER) {
-		pr_err("%s: Card is consuming too much power!\n",
-			mmc_hostname(host->mmc));
-		sdhci_writel(host, SDHCI_INT_BUS_POWER, SDHCI_INT_STATUS);
-	}
=+DO NOT APPLY+=		if (intmask & SDHCI_INT_DATA_MASK)
=+DO NOT APPLY+=			sdhci_data_irq(host, intmask & SDHCI_INT_DATA_MASK);
 
-	intmask &= ~SDHCI_INT_BUS_POWER;
=+DO NOT APPLY+=		if (intmask & SDHCI_INT_BUS_POWER)
=+DO NOT APPLY+=			pr_err("%s: Card is consuming too much power!\n",
=+DO NOT APPLY+=				mmc_hostname(host->mmc));
 
-	if (intmask & SDHCI_INT_CARD_INT)
-		cardint = 1;
=+DO NOT APPLY+=		if (intmask & SDHCI_INT_CARD_INT)
=+DO NOT APPLY+=			cardint = 1;
 
-	intmask &= ~SDHCI_INT_CARD_INT;
=+DO NOT APPLY+=		intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE |
=+DO NOT APPLY+=			     SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK |
=+DO NOT APPLY+=			     SDHCI_INT_ERROR | SDHCI_INT_BUS_POWER |
=+DO NOT APPLY+=			     SDHCI_INT_CARD_INT);
 
-	if (intmask) {
-		unexpected |= intmask;
-		sdhci_writel(host, intmask, SDHCI_INT_STATUS);
-	}
=+DO NOT APPLY+=		if (intmask) {
=+DO NOT APPLY+=			unexpected |= intmask;
=+DO NOT APPLY+=			sdhci_writel(host, intmask, SDHCI_INT_STATUS);
=+DO NOT APPLY+=		}
 
-	result = IRQ_HANDLED;
=+DO NOT APPLY+=		result = IRQ_HANDLED;
 
-	intmask = sdhci_readl(host, SDHCI_INT_STATUS);
=+DO NOT APPLY+=		intmask = sdhci_readl(host, SDHCI_INT_STATUS);
 
-	/*
-	 * If we know we'll call the driver to signal SDIO IRQ, disregard
-	 * further indications of Card Interrupt in the status to avoid a
-	 * needless loop.
-	 */
-	if (cardint)
-		intmask &= ~SDHCI_INT_CARD_INT;
-	if (intmask && --max_loops)
-		goto again;
=+DO NOT APPLY+=		/*
=+DO NOT APPLY+=		 * If we know we'll call the driver to signal SDIO IRQ,
=+DO NOT APPLY+=		 * disregard further indications of Card Interrupt in
=+DO NOT APPLY+=		 * the status to avoid a needless loop.
=+DO NOT APPLY+=		 */
=+DO NOT APPLY+=		if (cardint)
=+DO NOT APPLY+=			intmask &= ~SDHCI_INT_CARD_INT;
=+DO NOT APPLY+=	} while (intmask && --max_loops);
 out:
 	spin_unlock(&host->lock);
 
-- 
1.8.3.1

