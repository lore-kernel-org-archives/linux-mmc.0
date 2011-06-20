From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 1/4] mmc: sdhci: fix interrupt storm from card detection
Date: Mon, 20 Jun 2011 18:38:42 +0800
Message-ID: <1308566325-11600-2-git-send-email-shawn.guo@linaro.org>
References: <1308566325-11600-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37917 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab1FTK3F (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 06:29:05 -0400
Received: by iwn6 with SMTP id 6so1058030iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2011 03:29:04 -0700 (PDT)
In-Reply-To: <1308566325-11600-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Arnaud Patard <arnaud.patard@rtp-net.org>, Eric Benard <eric@eukrea.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>

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
 drivers/mmc/host/sdhci.c |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 91d9892..d94e2b4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -127,7 +127,9 @@ static void sdhci_mask_irqs(struct sdhci_host *host, u32 irqs)
 
 static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 {
-	u32 irqs = SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT;
+	u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
+		      SDHCI_CARD_PRESENT;
+	u32 irqs = present ? SDHCI_INT_CARD_REMOVE : SDHCI_INT_CARD_INSERT;
 
 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
 		return;
@@ -2154,13 +2156,30 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
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

