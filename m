From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 3/5] mmc: dw_mmc: Convert to use MMC_CAP2_SDIO_IRQ_NOTHREAD for SDIO IRQs
Date: Wed, 19 Apr 2017 23:17:09 +0200
Message-ID: <1492636631-28254-4-git-send-email-ulf.hansson@linaro.org>
References: <1492636631-28254-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35964 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967443AbdDSVRY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Apr 2017 17:17:24 -0400
Received: by mail-wm0-f45.google.com with SMTP id o81so89660336wmb.1
        for <linux-mmc@vger.kernel.org>; Wed, 19 Apr 2017 14:17:23 -0700 (PDT)
In-Reply-To: <1492636631-28254-1-git-send-email-ulf.hansson@linaro.org>
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
 drivers/mmc/host/dw_mmc.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index e45129f..635d76c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1642,9 +1642,8 @@ static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
 	}
 }
 
-static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
+static void __dw_mci_enable_sdio_irq(struct dw_mci_slot *slot, int enb)
 {
-	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
 	unsigned long irqflags;
 	u32 int_mask;
@@ -1662,6 +1661,20 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
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
@@ -1763,6 +1776,7 @@ static const struct mmc_host_ops dw_mci_ops = {
 	.get_cd			= dw_mci_get_cd,
 	.hw_reset               = dw_mci_hw_reset,
 	.enable_sdio_irq	= dw_mci_enable_sdio_irq,
+	.ack_sdio_irq		= dw_mci_ack_sdio_irq,
 	.execute_tuning		= dw_mci_execute_tuning,
 	.card_busy		= dw_mci_card_busy,
 	.start_signal_voltage_switch = dw_mci_switch_voltage,
@@ -2654,7 +2668,8 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			if (pending & SDMMC_INT_SDIO(slot->sdio_id)) {
 				mci_writel(host, RINTSTS,
 					   SDMMC_INT_SDIO(slot->sdio_id));
-				mmc_signal_sdio_irq(slot->mmc);
+				__dw_mci_enable_sdio_irq(slot, 0);
+				sdio_signal_irq(slot->mmc);
 			}
 		}
 
@@ -2755,6 +2770,10 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
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

