From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 1/4] mmc: sdhci: fix interrupt storm from card detection
Date: Wed, 15 Jun 2011 19:15:19 +0800
Message-ID: <1308136522-3403-2-git-send-email-shawn.guo@linaro.org>
References: <1308136522-3403-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:58145 "EHLO
	TX2EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754209Ab1FOLKQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2011 07:10:16 -0400
In-Reply-To: <1308136522-3403-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Arnaud Patard <arnaud.patard@rtp-net.org>, Eric Benard <eric@eukrea.com>, Pavel Machek <pma@sysgo.com>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>

The issue was initially found by Eric Benard as below.

http://permalink.gmane.org/gmane.linux.ports.arm.kernel/108031

Not sure about other SDHCI based controller, but on Freescale eSDHC,
the SDHCI_INT_CARD_INSERT bits will be immediately set again when it
gets cleared, if a card is inserted. The driver need to mask the irq
to prevent interrupt storm which will freeze the system.  And the
SDHCI_INT_CARD_REMOVE gets the same situation.

The patch fixes the problem based on the initial idea from
Eric Benard.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Eric Benard <eric@eukrea.com>
---
 drivers/mmc/host/sdhci.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 91d9892..0dd10e4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2154,13 +2154,30 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		mmc_hostname(host->mmc), intmask);
 
 	if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
+		u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
+			      SDHCI_CARD_PRESENT;
+
+		/*
+		 * There is a observation on i.mx esdhc.  INSERT bit will be
+		 * immediately set again when it gets cleared, if a card is
+		 * inserted.  We have to mask the irq to prevent interrupt
+		 * storm which will freeze the system.  And the REMOVE gets
+		 * the same situation.
+		 *
+		 * More testing are needed here to ensure it works for other
+		 * platforms though.
+		 */
+		sdhci_mask_irqs(host, present ? SDHCI_INT_CARD_INSERT :
+						SDHCI_INT_CARD_REMOVE);
+		sdhci_unmask_irqs(host, present ? SDHCI_INT_CARD_REMOVE :
+						  SDHCI_INT_CARD_INSERT);
+
 		sdhci_writel(host, intmask & (SDHCI_INT_CARD_INSERT |
-			SDHCI_INT_CARD_REMOVE), SDHCI_INT_STATUS);
+			     SDHCI_INT_CARD_REMOVE), SDHCI_INT_STATUS);
+		intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
 		tasklet_schedule(&host->card_tasklet);
 	}
 
-	intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
-
 	if (intmask & SDHCI_INT_CMD_MASK) {
 		sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK,
 			SDHCI_INT_STATUS);
-- 
1.7.4.1


