From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/7] mmc: sdhci: Add quirk for always getting TC with stop cmd
Date: Wed, 24 Sep 2014 10:27:27 +0300
Message-ID: <1411543653-3728-2-git-send-email-adrian.hunter@intel.com>
References: <1411543653-3728-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23084 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966AbaIXHiP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 24 Sep 2014 03:38:15 -0400
In-Reply-To: <1411543653-3728-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Add a quirk for a host controller that always sets
a Transfer Complete interrupt status for the stop
command even when a busy response is not indicated.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c  | 8 ++++++--
 include/linux/mmc/sdhci.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7a8586f..abad5e5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2224,7 +2224,7 @@ static void sdhci_tuning_timer(unsigned long data)
  *                                                                           *
 \*****************************************************************************/
 
-static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
+static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
 {
 	BUG_ON(intmask == 0);
 
@@ -2271,6 +2271,9 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
 
 		/* The controller does not support the end-of-busy IRQ,
 		 * fall through and take the SDHCI_INT_RESPONSE */
+	} else if ((host->quirks2 & SDHCI_QUIRK2_STOP_WITH_TC) &&
+		   host->cmd->opcode == MMC_STOP_TRANSMISSION && !host->data) {
+		*mask &= ~SDHCI_INT_DATA_END;
 	}
 
 	if (intmask & SDHCI_INT_RESPONSE)
@@ -2481,7 +2484,8 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		}
 
 		if (intmask & SDHCI_INT_CMD_MASK)
-			sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK);
+			sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK,
+				      &intmask);
 
 		if (intmask & SDHCI_INT_DATA_MASK)
 			sdhci_data_irq(host, intmask & SDHCI_INT_DATA_MASK);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 0aa85ca..dba793e 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -98,6 +98,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_BROKEN_HS200			(1<<6)
 /* Controller does not support DDR50 */
 #define SDHCI_QUIRK2_BROKEN_DDR50			(1<<7)
+/* Stop command (CMD12) can set Transfer Complete when not using MMC_RSP_BUSY */
+#define SDHCI_QUIRK2_STOP_WITH_TC			(1<<8)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.8.3.2

