From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RESEND 5/9] mmc: sdhci: Rework sdhci_enable_irq_wakeups()
Date: Tue,  9 Jan 2018 09:52:22 +0200
Message-ID: <1515484346-800-6-git-send-email-adrian.hunter@intel.com>
References: <1515484346-800-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:46300 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755127AbeAIHxL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 9 Jan 2018 02:53:11 -0500
In-Reply-To: <1515484346-800-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>

In preparation for adding more conditions for whether IRQ wakeup is
enabled, rework sdhci_enable_irq_wakeups() so that needed bits are added
instead of adding them all and then removing the unneeded bits.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a8129d091207..dd922923019a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2823,20 +2823,25 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
  */
 static bool sdhci_enable_irq_wakeups(struct sdhci_host *host)
 {
+	u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE |
+		  SDHCI_WAKE_ON_INT;
+	u32 irq_val = 0;
+	u8 wake_val = 0;
 	u8 val;
-	u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
-			| SDHCI_WAKE_ON_INT;
-	u32 irq_val = SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE |
-		      SDHCI_INT_CARD_INT;
 
-	val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
-	val |= mask ;
-	/* Avoid fake wake up */
-	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) {
-		val &= ~(SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE);
-		irq_val &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
+	if (!(host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)) {
+		wake_val |= SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE;
+		irq_val |= SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE;
 	}
+
+	wake_val |= SDHCI_WAKE_ON_INT;
+	irq_val |= SDHCI_INT_CARD_INT;
+
+	val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
+	val &= ~mask;
+	val |= wake_val;
 	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
+
 	sdhci_writel(host, irq_val, SDHCI_INT_ENABLE);
 
 	host->irq_wake_enabled = !enable_irq_wake(host->irq);
-- 
1.9.1

