From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/4] mmc: sdhci: fix interrupt storm from card detection
Date: Fri, 10 Jun 2011 18:42:49 +0800
Message-ID: <1307702572-22066-2-git-send-email-shawn.guo@linaro.org>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:65070 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab1FJKeP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jun 2011 06:34:15 -0400
Received: by pvg12 with SMTP id 12so1164939pvg.19
        for <linux-mmc@vger.kernel.org>; Fri, 10 Jun 2011 03:34:15 -0700 (PDT)
In-Reply-To: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Eric Benard <eric@eukrea.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>

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
 drivers/mmc/host/sdhci.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 91d9892..71a2505 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2154,13 +2154,20 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		mmc_hostname(host->mmc), intmask);
 
 	if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
+		u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
+			      SDHCI_CARD_PRESENT;
+
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

