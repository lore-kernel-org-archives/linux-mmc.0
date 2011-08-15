From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 1/4] mmc: tmio, sdhi: Split tmio_mmc_irq() based on registers
Date: Mon, 15 Aug 2011 14:51:25 +0900
Message-ID: <1313387488-28175-2-git-send-email-horms@verge.net.au>
References: <1313387488-28175-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1313387488-28175-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

This splits tmio_mmc_irq() in two based on the registers
used to handle the interrupts.

This involves two key changes to the logic:
1. Do not assume that only one interrupt has occurred.
   In particular because tmio_mmc_irq() handles interrupts
   from three sources. Also, because this allows
   the logic to be simplified.
2. Just ignore spurious interrupts.
   Its not clear to me that they can ever occur.

This patch also removes the commented-out handling of
CRC and other errors.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 drivers/mmc/host/tmio_mmc_pio.c |   71 +++++++++++++++-----------------------
 1 files changed, 28 insertions(+), 43 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 1f16357..e658cb4 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -543,43 +543,15 @@ out:
 	spin_unlock(&host->lock);
 }
 
-irqreturn_t tmio_mmc_irq(int irq, void *devid)
+static void __tmio_mmc_card_irq(struct tmio_mmc_host *host)
 {
-	struct tmio_mmc_host *host = devid;
 	struct mmc_host *mmc = host->mmc;
-	struct tmio_mmc_data *pdata = host->pdata;
 	unsigned int ireg, irq_mask, status;
-	unsigned int sdio_ireg, sdio_irq_mask, sdio_status;
-
-	pr_debug("MMC IRQ begin\n");
 
 	status = sd_ctrl_read32(host, CTL_STATUS);
 	irq_mask = sd_ctrl_read32(host, CTL_IRQ_MASK);
 	ireg = status & TMIO_MASK_IRQ & ~irq_mask;
 
-	sdio_ireg = 0;
-	if (!ireg && pdata->flags & TMIO_MMC_SDIO_IRQ) {
-		sdio_status = sd_ctrl_read16(host, CTL_SDIO_STATUS);
-		sdio_irq_mask = sd_ctrl_read16(host, CTL_SDIO_IRQ_MASK);
-		sdio_ireg = sdio_status & TMIO_SDIO_MASK_ALL & ~sdio_irq_mask;
-
-		sd_ctrl_write16(host, CTL_SDIO_STATUS, sdio_status & ~TMIO_SDIO_MASK_ALL);
-
-		if (sdio_ireg && !host->sdio_irq_enabled) {
-			pr_warning("tmio_mmc: Spurious SDIO IRQ, disabling! 0x%04x 0x%04x 0x%04x\n",
-				   sdio_status, sdio_irq_mask, sdio_ireg);
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
-
 	pr_debug_status(status);
 	pr_debug_status(ireg);
 
@@ -591,43 +563,56 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
 		     ((ireg & TMIO_STAT_CARD_INSERT) && !mmc->card)) &&
 		    !work_pending(&mmc->detect.work))
 			mmc_detect_change(host->mmc, msecs_to_jiffies(100));
-		goto out;
 	}
 
-	/* CRC and other errors */
-/*	if (ireg & TMIO_STAT_ERR_IRQ)
- *		handled |= tmio_error_irq(host, irq, stat);
- */
-
 	/* Command completion */
 	if (ireg & (TMIO_STAT_CMDRESPEND | TMIO_STAT_CMDTIMEOUT)) {
 		tmio_mmc_ack_mmc_irqs(host,
 			     TMIO_STAT_CMDRESPEND |
 			     TMIO_STAT_CMDTIMEOUT);
 		tmio_mmc_cmd_irq(host, status);
-		goto out;
 	}
 
 	/* Data transfer */
 	if (ireg & (TMIO_STAT_RXRDY | TMIO_STAT_TXRQ)) {
 		tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_RXRDY | TMIO_STAT_TXRQ);
 		tmio_mmc_pio_irq(host);
-		goto out;
 	}
 
 	/* Data transfer completion */
 	if (ireg & TMIO_STAT_DATAEND) {
 		tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_DATAEND);
 		tmio_mmc_data_irq(host);
-		goto out;
 	}
+}
 
-	pr_warning("tmio_mmc: Spurious irq, disabling! "
-		"0x%08x 0x%08x 0x%08x\n", status, irq_mask, ireg);
-	pr_debug_status(status);
-	tmio_mmc_disable_mmc_irqs(host, status & ~irq_mask);
+static void __tmio_mmc_sdio_irq(struct tmio_mmc_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	struct tmio_mmc_data *pdata = host->pdata;
+	unsigned int ireg, irq_mask, status;
+
+	if (!(pdata->flags & TMIO_MMC_SDIO_IRQ))
+		return;
+
+	status = sd_ctrl_read16(host, CTL_SDIO_STATUS);
+	irq_mask = sd_ctrl_read16(host, CTL_SDIO_IRQ_MASK);
+	ireg = status & TMIO_SDIO_MASK_ALL & ~irq_mask;
+
+	sd_ctrl_write16(host, CTL_SDIO_STATUS, status & ~TMIO_SDIO_MASK_ALL);
+
+	if (mmc->caps & MMC_CAP_SDIO_IRQ && ireg & TMIO_SDIO_STAT_IOIRQ)
+		mmc_signal_sdio_irq(mmc);
+}
+
+irqreturn_t tmio_mmc_irq(int irq, void *devid)
+{
+	struct tmio_mmc_host *host = devid;
+
+	pr_debug("MMC IRQ begin\n");
+	__tmio_mmc_card_irq(host);
+	__tmio_mmc_sdio_irq(host);
 
-out:
 	return IRQ_HANDLED;
 }
 EXPORT_SYMBOL(tmio_mmc_irq);
-- 
1.7.5.4

