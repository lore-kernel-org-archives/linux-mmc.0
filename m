From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 2/4] mmc: tmio: Provide separate interrupt handlers
Date: Fri, 19 Aug 2011 10:10:19 +0900
Message-ID: <1313716221-20136-3-git-send-email-horms@verge.net.au>
References: <1313716221-20136-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1313716221-20136-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Provide separate interrupt handlers which may be used by platforms where
SDHI has three interrupt sources.

This patch also removes the commented-out handling of CRC and other errors.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

* SDCARD portion tested on AP4/Mackerel
* SDIO portion untested

v4
* As suggested by Guennadi Liakhovetski
  - Use bool as return type for __tmio_mmc_sdcard_irq() and
    __tmio_mmc_card_detect_irq()

v3
* Rebase for updated "mmc: tmio: Cache interrupt masks"
* As suggested by Guennadi Liakhovetski
  - Do not alter logic to handle more than one interupt at once
  - Add missing "static" to declartion of __tmio_mmc_sdcard_irq()

v2
* As suggested by Guennadi Liakhovetski
  - Combine 3 patches into one
  - Reduce the number of __tmio_..._irq() functions
  - Rename "...card_access..." functions as "...sdcard..."
---
 drivers/mmc/host/tmio_mmc.h     |    3 +
 drivers/mmc/host/tmio_mmc_pio.c |  131 ++++++++++++++++++++++++--------------
 2 files changed, 86 insertions(+), 48 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 1cf8db5..3020f98 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -97,6 +97,9 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host);
 void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 irqreturn_t tmio_mmc_irq(int irq, void *devid);
+irqreturn_t tmio_mmc_sdcard_irq(int irq, void *devid);
+irqreturn_t tmio_mmc_card_detect_irq(int irq, void *devid);
+irqreturn_t tmio_mmc_sdio_irq(int irq, void *devid);
 
 static inline char *tmio_mmc_kmap_atomic(struct scatterlist *sg,
 					 unsigned long *flags)
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index f0c7830..6275e3d 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -545,44 +545,20 @@ out:
 	spin_unlock(&host->lock);
 }
 
-irqreturn_t tmio_mmc_irq(int irq, void *devid)
+static void tmio_mmc_card_irq_status(struct tmio_mmc_host *host,
+				       int *ireg, int *status)
 {
-	struct tmio_mmc_host *host = devid;
-	struct mmc_host *mmc = host->mmc;
-	struct tmio_mmc_data *pdata = host->pdata;
-	unsigned int ireg, status;
-	unsigned int sdio_ireg, sdio_status;
-
-	pr_debug("MMC IRQ begin\n");
-
-	status = sd_ctrl_read32(host, CTL_STATUS);
-	ireg = status & TMIO_MASK_IRQ & ~host->sdcard_irq_mask;
+	*status = sd_ctrl_read32(host, CTL_STATUS);
+	*ireg = *status & TMIO_MASK_IRQ & ~host->sdcard_irq_mask;
 
-	sdio_ireg = 0;
-	if (!ireg && pdata->flags & TMIO_MMC_SDIO_IRQ) {
-		sdio_status = sd_ctrl_read16(host, CTL_SDIO_STATUS);
-		sdio_ireg = sdio_status & TMIO_SDIO_MASK_ALL &
-				~host->sdio_irq_mask;
-
-		sd_ctrl_write16(host, CTL_SDIO_STATUS, sdio_status & ~TMIO_SDIO_MASK_ALL);
-
-		if (sdio_ireg && !host->sdio_irq_enabled) {
-			pr_warning("tmio_mmc: Spurious SDIO IRQ, disabling! 0x%04x 0x%04x 0x%04x\n",
-				   sdio_status, host->sdio_irq_mask, sdio_ireg);
-			tmio_mmc_enable_sdio_irq(mmc, 0);
-			goto out;
-		}
-
-		if (mmc->caps & MMC_CAP_SDIO_IRQ &&
-			sdio_ireg & TMIO_SDIO_STAT_IOIRQ)
-			mmc_signal_sdio_irq(mmc);
-
-		if (sdio_ireg)
-			goto out;
-	}
+	pr_debug_status(*status);
+	pr_debug_status(*ireg);
+}
 
-	pr_debug_status(status);
-	pr_debug_status(ireg);
+static bool __tmio_mmc_card_detect_irq(struct tmio_mmc_host *host,
+				      int ireg, int status)
+{
+	struct mmc_host *mmc = host->mmc;
 
 	/* Card insert / remove attempts */
 	if (ireg & (TMIO_STAT_CARD_INSERT | TMIO_STAT_CARD_REMOVE)) {
@@ -592,43 +568,102 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
 		     ((ireg & TMIO_STAT_CARD_INSERT) && !mmc->card)) &&
 		    !work_pending(&mmc->detect.work))
 			mmc_detect_change(host->mmc, msecs_to_jiffies(100));
-		goto out;
+		return true;
 	}
 
-	/* CRC and other errors */
-/*	if (ireg & TMIO_STAT_ERR_IRQ)
- *		handled |= tmio_error_irq(host, irq, stat);
- */
+	return false;
+}
+
+irqreturn_t tmio_mmc_card_detect_irq(int irq, void *devid)
+{
+	unsigned int ireg, status;
+	struct tmio_mmc_host *host = devid;
 
+	tmio_mmc_card_irq_status(host, &ireg, &status);
+	__tmio_mmc_card_detect_irq(host, ireg, status);
+
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL(tmio_mmc_card_detect_irq);
+
+static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_host *host,
+				 int ireg, int status)
+{
 	/* Command completion */
 	if (ireg & (TMIO_STAT_CMDRESPEND | TMIO_STAT_CMDTIMEOUT)) {
 		tmio_mmc_ack_mmc_irqs(host,
 			     TMIO_STAT_CMDRESPEND |
 			     TMIO_STAT_CMDTIMEOUT);
 		tmio_mmc_cmd_irq(host, status);
-		goto out;
+		return true;
 	}
 
 	/* Data transfer */
 	if (ireg & (TMIO_STAT_RXRDY | TMIO_STAT_TXRQ)) {
 		tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_RXRDY | TMIO_STAT_TXRQ);
 		tmio_mmc_pio_irq(host);
-		goto out;
+		return true;
 	}
 
 	/* Data transfer completion */
 	if (ireg & TMIO_STAT_DATAEND) {
 		tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_DATAEND);
 		tmio_mmc_data_irq(host);
-		goto out;
+		return true;
 	}
 
-	pr_warning("tmio_mmc: Spurious irq, disabling! "
-		"0x%08x 0x%08x 0x%08x\n", status, host->sdcard_irq_mask, ireg);
-	pr_debug_status(status);
-	tmio_mmc_disable_mmc_irqs(host, status & ~host->sdcard_irq_mask);
+	return false;
+}
+
+irqreturn_t tmio_mmc_sdcard_irq(int irq, void *devid)
+{
+	unsigned int ireg, status;
+	struct tmio_mmc_host *host = devid;
+
+	tmio_mmc_card_irq_status(host, &ireg, &status);
+	__tmio_mmc_sdcard_irq(host, ireg, status);
+
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL(tmio_mmc_sdcard_irq);
+
+irqreturn_t tmio_mmc_sdio_irq(int irq, void *devid)
+{
+	struct tmio_mmc_host *host = devid;
+	struct mmc_host *mmc = host->mmc;
+	struct tmio_mmc_data *pdata = host->pdata;
+	unsigned int ireg, status;
+
+	if (!(pdata->flags & TMIO_MMC_SDIO_IRQ))
+		return IRQ_HANDLED;
+
+	status = sd_ctrl_read16(host, CTL_SDIO_STATUS);
+	ireg = status & TMIO_SDIO_MASK_ALL & ~host->sdcard_irq_mask;
+
+	sd_ctrl_write16(host, CTL_SDIO_STATUS, status & ~TMIO_SDIO_MASK_ALL);
+
+	if (mmc->caps & MMC_CAP_SDIO_IRQ && ireg & TMIO_SDIO_STAT_IOIRQ)
+		mmc_signal_sdio_irq(mmc);
+
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL(tmio_mmc_sdio_irq);
+
+irqreturn_t tmio_mmc_irq(int irq, void *devid)
+{
+	struct tmio_mmc_host *host = devid;
+	unsigned int ireg, status;
+
+	pr_debug("MMC IRQ begin\n");
+
+	tmio_mmc_card_irq_status(host, &ireg, &status);
+	if (__tmio_mmc_card_detect_irq(host, ireg, status))
+		return IRQ_HANDLED;
+	if (__tmio_mmc_sdcard_irq(host, ireg, status))
+		return IRQ_HANDLED;
+
+	tmio_mmc_sdio_irq(irq, devid);
 
-out:
 	return IRQ_HANDLED;
 }
 EXPORT_SYMBOL(tmio_mmc_irq);
-- 
1.7.5.4

