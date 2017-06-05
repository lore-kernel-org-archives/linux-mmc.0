From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 5/6] mmc: dw_mmc: use the 'slot' instead of 'cur_slot'
Date: Mon, 05 Jun 2017 13:41:34 +0900
Message-ID: <20170605044135.18304-6-jh80.chung@samsung.com>
References: <20170605044135.18304-1-jh80.chung@samsung.com>
        <CGME20170605044137epcas1p44c44e94f8514d5115daaa83593d57c98@epcas1p4.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:62584 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdFEElk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jun 2017 00:41:40 -0400
In-reply-to: <20170605044135.18304-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

Remove the 'cur_slot'. Instead, just use 'slot'.
There is no multiple slots, so we need to consider only one slot.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |  4 ++--
 drivers/mmc/host/dw_mmc.c        | 33 ++++++++++++++++-----------------
 drivers/mmc/host/dw_mmc.h        |  3 ---
 3 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 25691cc..3502679 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -157,8 +157,8 @@ static void dw_mci_exynos_set_clksel_timing(struct dw_mci *host, u32 timing)
 	 * HOLD register should be bypassed in case there is no phase shift
 	 * applied on CMD/DATA that is sent to the card.
 	 */
-	if (!SDMMC_CLKSEL_GET_DRV_WD3(clksel) && host->cur_slot)
-		set_bit(DW_MMC_CARD_NO_USE_HOLD, &host->cur_slot->flags);
+	if (!SDMMC_CLKSEL_GET_DRV_WD3(clksel) && host->slot)
+		set_bit(DW_MMC_CARD_NO_USE_HOLD, &host->slot->flags);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 8a4fa88..97a8b0c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -392,7 +392,7 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
 	cmdr = stop->opcode | SDMMC_CMD_STOP |
 		SDMMC_CMD_RESP_CRC | SDMMC_CMD_RESP_EXP;
 
-	if (!test_bit(DW_MMC_CARD_NO_USE_HOLD, &host->cur_slot->flags))
+	if (!test_bit(DW_MMC_CARD_NO_USE_HOLD, &host->slot->flags))
 		cmdr |= SDMMC_CMD_USE_HOLD_REG;
 
 	return cmdr;
@@ -480,7 +480,7 @@ static void dw_mci_dmac_complete_dma(void *arg)
 	if ((host->use_dma == TRANS_MODE_EDMAC) &&
 	    data && (data->flags & MMC_DATA_READ))
 		/* Invalidate cache after read */
-		dma_sync_sg_for_cpu(mmc_dev(host->cur_slot->mmc),
+		dma_sync_sg_for_cpu(mmc_dev(host->slot->mmc),
 				    data->sg,
 				    data->sg_len,
 				    DMA_FROM_DEVICE);
@@ -820,7 +820,7 @@ static int dw_mci_edmac_start_dma(struct dw_mci *host,
 
 	/* Flush cache before write */
 	if (host->data->flags & MMC_DATA_WRITE)
-		dma_sync_sg_for_device(mmc_dev(host->cur_slot->mmc), sgl,
+		dma_sync_sg_for_device(mmc_dev(host->slot->mmc), sgl,
 				       sg_elems, DMA_TO_DEVICE);
 
 	dma_async_issue_pending(host->dms->ch);
@@ -1282,7 +1282,6 @@ static void __dw_mci_start_request(struct dw_mci *host,
 
 	mrq = slot->mrq;
 
-	host->cur_slot = slot;
 	host->mrq = mrq;
 
 	host->pending_events = 0;
@@ -1763,7 +1762,7 @@ static bool dw_mci_reset(struct dw_mci *host)
 
 ciu_out:
 	/* After a CTRL reset we need to have CIU set clock registers  */
-	mci_send_cmd(host->cur_slot, SDMMC_CMD_UPD_CLK, 0);
+	mci_send_cmd(host->slot, SDMMC_CMD_UPD_CLK, 0);
 
 	return ret;
 }
@@ -1790,11 +1789,11 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
 	__acquires(&host->lock)
 {
 	struct dw_mci_slot *slot;
-	struct mmc_host	*prev_mmc = host->cur_slot->mmc;
+	struct mmc_host	*prev_mmc = host->slot->mmc;
 
 	WARN_ON(host->cmd || host->data);
 
-	host->cur_slot->mrq = NULL;
+	host->slot->mrq = NULL;
 	host->mrq = NULL;
 	if (!list_empty(&host->queue)) {
 		slot = list_entry(host->queue.next,
@@ -1944,7 +1943,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			err = dw_mci_command_complete(host, cmd);
 			if (cmd == mrq->sbc && !err) {
 				prev_state = state = STATE_SENDING_CMD;
-				__dw_mci_start_request(host, host->cur_slot,
+				__dw_mci_start_request(host, host->slot,
 						       mrq->cmd);
 				goto unlock;
 			}
@@ -3261,9 +3260,9 @@ int dw_mci_runtime_suspend(struct device *dev)
 
 	clk_disable_unprepare(host->ciu_clk);
 
-	if (host->cur_slot &&
-	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
-	     !mmc_card_is_removable(host->cur_slot->mmc)))
+	if (host->slot &&
+	    (mmc_can_gpio_cd(host->slot->mmc) ||
+	     !mmc_card_is_removable(host->slot->mmc)))
 		clk_disable_unprepare(host->biu_clk);
 
 	return 0;
@@ -3276,9 +3275,9 @@ int dw_mci_runtime_resume(struct device *dev)
 	struct dw_mci *host = dev_get_drvdata(dev);
 	struct dw_mci_slot *slot = host->slot;
 
-	if (host->cur_slot &&
-	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
-	     !mmc_card_is_removable(host->cur_slot->mmc))) {
+	if (host->slot &&
+	    (mmc_can_gpio_cd(host->slot->mmc) ||
+	     !mmc_card_is_removable(host->slot->mmc))) {
 		ret = clk_prepare_enable(host->biu_clk);
 		if (ret)
 			return ret;
@@ -3326,9 +3325,9 @@ int dw_mci_runtime_resume(struct device *dev)
 	return 0;
 
 err:
-	if (host->cur_slot &&
-	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
-	     !mmc_card_is_removable(host->cur_slot->mmc)))
+	if (host->slot &&
+	    (mmc_can_gpio_cd(host->slot->mmc) ||
+	     !mmc_card_is_removable(host->slot->mmc)))
 		clk_disable_unprepare(host->biu_clk);
 
 	return ret;
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 1ec8f40..75da375 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -132,7 +132,6 @@ struct dw_mci_dma_slave {
  * =======
  *
  * @lock is a softirq-safe spinlock protecting @queue as well as
- * @cur_slot, @mrq and @state. These must always be updated
  * at the same time while holding @lock.
  *
  * @irq_lock is an irq-safe spinlock protecting the INTMASK register
@@ -168,7 +167,6 @@ struct dw_mci {
 	struct scatterlist	*sg;
 	struct sg_mapping_iter	sg_miter;
 
-	struct dw_mci_slot	*cur_slot;
 	struct mmc_request	*mrq;
 	struct mmc_command	*cmd;
 	struct mmc_data		*data;
@@ -204,7 +202,6 @@ struct dw_mci {
 
 	u32			bus_hz;
 	u32			current_speed;
-	u32			num_slots;
 	u32			fifoth_val;
 	u16			verid;
 	struct device		*dev;
-- 
2.10.2

