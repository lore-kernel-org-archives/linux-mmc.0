From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v2] mmc: sdhci: fix wakeup configuration
Date: Fri, 13 May 2016 15:16:02 +0200
Message-ID: <1463145362-7773-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:13887 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbcEMNPa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 May 2016 09:15:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.ferre@atmel.com, kliu5@marvell.com, jlfu@marvell.com, jszhang@marvell.com, Ludovic Desroches <ludovic.desroches@atmel.com>

Activating wakeup event is not enough to get a wakeup signal. The
corresponding events have to be enabled in the Interrupt Status Enable
Register too. It follows the specification and is needed at least by
sdhci-of-at91.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/sdhci.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

Changes:
- v2:
  - update commit message and comments
  - do not rename val and mask variables

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e010ea4..e351859 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2605,18 +2605,31 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 \*****************************************************************************/
 
 #ifdef CONFIG_PM
+/*
+ * To enable wakeup events, the corresponding events have to be enabled in
+ * the Interrupt Status Enable register too. See 'Table 1-6: Wakeup Signal
+ * Table' in the SD Host Controller Standard Specification.
+ * It is useless to restore SDHCI_INT_ENABLE state in
+ * sdhci_disable_irq_wakeups() since it will be set by
+ * sdhci_enable_card_detection() or sdhci_init().
+ */
 void sdhci_enable_irq_wakeups(struct sdhci_host *host)
 {
 	u8 val;
 	u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
 			| SDHCI_WAKE_ON_INT;
+	u32 irq_val = SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE |
+		      SDHCI_INT_CARD_INT;
 
 	val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
 	val |= mask ;
 	/* Avoid fake wake up */
-	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
+	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) {
 		val &= ~(SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE);
+		irq_val &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
+	}
 	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
+	sdhci_writel(host, irq_val, SDHCI_INT_ENABLE);
 }
 EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
 
-- 
2.5.0

