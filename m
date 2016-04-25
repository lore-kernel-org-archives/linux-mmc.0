From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH] mmc: sdhci: fix wakeup configuration
Date: Mon, 25 Apr 2016 15:15:24 +0200
Message-ID: <1461590124-23783-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

Activating wakeup event is not enough to get a wakeup signal. The
corresponding events have to be enabled in the Interrupt Status Enable
Register too.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
Hi,

I just updated sdhci_enable_irq_wakeups() not sdhci_disable_irq_wakeups()
because I don't think it is necessary to configure SDHCI_INT_ENABLE at this
step, it will be done with sdhci_init() or sdhci_enable_card_detection().

While I was writing this patch, several questions came to my mind:
- Is the naming correct? wakeup signal is not an irq. 'enable_irq_wakeups' can
  be a bit confusing.
- If we want to wakeup from irq, we may have to set SDHCI_INT_ENABLE and
  SDHCI_SIGNAL_ENABLE and not rely on a previous configuration, isn't it?

Regards

Ludovic

 drivers/mmc/host/sdhci.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b284924..6fc69ed 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2638,18 +2638,28 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 \*****************************************************************************/
 
 #ifdef CONFIG_PM
+/*
+ * To enable wakeup events, the corresponding events have to be enabled in
+ * the Interrupt Status Enable register too. See 'Table 1-6: Wakeup Signal
+ * Table' in the SD Host Controller Standard Specification.
+ */
 void sdhci_enable_irq_wakeups(struct sdhci_host *host)
 {
-	u8 val;
-	u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
-			| SDHCI_WAKE_ON_INT;
+	u8 wakeup_val;
+	u8 wakeup_mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE |
+			 SDHCI_WAKE_ON_INT;
+	u32 irq_val = SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE |
+		      SDHCI_INT_CARD_INT;
 
-	val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
-	val |= mask ;
+	wakeup_val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
+	wakeup_val |= wakeup_mask;
 	/* Avoid fake wake up */
-	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
-		val &= ~(SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE);
-	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
+	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) {
+		wakeup_val &= ~(SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE);
+		irq_val &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
+	}
+	sdhci_writeb(host, wakeup_val, SDHCI_WAKE_UP_CONTROL);
+	sdhci_writel(host, irq_val, SDHCI_INT_ENABLE);
 }
 EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
 
-- 
2.5.0
