From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/3] mmc: dw_mmc: Convert to use MMC_CAP2_SDIO_IRQ_NOTHREAD for SDIO IRQs
Date: Tue, 18 Apr 2017 14:32:03 +0200
Message-ID: <1492518724-30511-3-git-send-email-ulf.hansson@linaro.org>
References: <1492518724-30511-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:34065 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753110AbdDRMcL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Apr 2017 08:32:11 -0400
Received: by mail-wr0-f173.google.com with SMTP id z109so101438901wrb.1
        for <linux-mmc@vger.kernel.org>; Tue, 18 Apr 2017 05:32:10 -0700 (PDT)
In-Reply-To: <1492518724-30511-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Brian Norris <briannorris@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@google.com>

Convert to use the more lightweight method for processing SDIO IRQs, which
involves the following changes:

- Enable MMC_CAP2_SDIO_IRQ_NOTHREAD when SDIO IRQ is supported.
- Mask SDIO IRQ when signaling it for processing.
- Re-enable (unmask) the SDIO IRQ from the ->ack_sdio_irq() callback.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/dw_mmc.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 249ded6..f086791 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1635,9 +1635,8 @@ static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
 	}
 }
 
-static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
+static void __dw_mci_enable_sdio_irq(struct dw_mci_slot *slot, int enb)
 {
-	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
 	unsigned long irqflags;
 	u32 int_mask;
@@ -1655,6 +1654,20 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
 	spin_unlock_irqrestore(&host->irq_lock, irqflags);
 }
 
+static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+
+	__dw_mci_enable_sdio_irq(slot, enb);
+}
+
+static void dw_mci_ack_sdio_irq(struct mmc_host *mmc)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+
+	__dw_mci_enable_sdio_irq(slot, 1);
+}
+
 static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
@@ -1756,6 +1769,7 @@ static const struct mmc_host_ops dw_mci_ops = {
 	.get_cd			= dw_mci_get_cd,
 	.hw_reset               = dw_mci_hw_reset,
 	.enable_sdio_irq	= dw_mci_enable_sdio_irq,
+	.ack_sdio_irq		= dw_mci_ack_sdio_irq,
 	.execute_tuning		= dw_mci_execute_tuning,
 	.card_busy		= dw_mci_card_busy,
 	.start_signal_voltage_switch = dw_mci_switch_voltage,
@@ -2645,9 +2659,14 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 				continue;
 
 			if (pending & SDMMC_INT_SDIO(slot->sdio_id)) {
+				u32 int_mask;
+
 				mci_writel(host, RINTSTS,
 					   SDMMC_INT_SDIO(slot->sdio_id));
-				mmc_signal_sdio_irq(slot->mmc);
+				int_mask = mci_readl(host, INTMASK);
+				int_mask &= ~SDMMC_INT_SDIO(slot->sdio_id);
+				mci_writel(host, INTMASK, int_mask);
+				sdio_signal_irq(slot->mmc);
 			}
 		}
 
@@ -2748,6 +2767,10 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (ret)
 		goto err_host_allocated;
 
+	/* Process SDIO IRQs through the sdio_irq_work. */
+	if (mmc->caps & MMC_CAP_SDIO_IRQ)
+		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
+
 	/* Useful defaults if platform data is unset. */
 	if (host->use_dma == TRANS_MODE_IDMAC) {
 		mmc->max_segs = host->ring_size;
-- 
2.7.4

