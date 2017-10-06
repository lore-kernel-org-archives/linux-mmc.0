From: Liming Sun <lsun@mellanox.com>
Subject: [PATCH 3/9] Revert "mmc: dw_mmc: use the 'slot' instead of 'cur_slot'"
Date: Fri,  6 Oct 2017 15:21:26 -0400
Message-ID: <3d034212389a67aa703ffb76a1e381c87c8fc945.1507315433.git.lsun@mellanox.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1507315433.git.lsun@mellanox.com>
In-Reply-To: <cover.1507315433.git.lsun@mellanox.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liming Sun <lsun@mellanox.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This reverts commit 42f989c002f235557e3a03feac3b2f16b17d53f6.

The Mellanox BlueField SoC requires multiple slot dw-mmc support.

Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |  4 ++--
 drivers/mmc/host/dw_mmc.c        | 33 +++++++++++++++++----------------
 drivers/mmc/host/dw_mmc.h        |  3 +++
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 3502679..25691cc 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -157,8 +157,8 @@ static void dw_mci_exynos_set_clksel_timing(struct dw_mci *host, u32 timing)
 	 * HOLD register should be bypassed in case there is no phase shift
 	 * applied on CMD/DATA that is sent to the card.
 	 */
-	if (!SDMMC_CLKSEL_GET_DRV_WD3(clksel) && host->slot)
-		set_bit(DW_MMC_CARD_NO_USE_HOLD, &host->slot->flags);
+	if (!SDMMC_CLKSEL_GET_DRV_WD3(clksel) && host->cur_slot)
+		set_bit(DW_MMC_CARD_NO_USE_HOLD, &host->cur_slot->flags);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c9f81db..62c0791 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -392,7 +392,7 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
 	cmdr = stop->opcode | SDMMC_CMD_STOP |
 		SDMMC_CMD_RESP_CRC | SDMMC_CMD_RESP_EXP;
 
-	if (!test_bit(DW_MMC_CARD_NO_USE_HOLD, &host->slot->flags))
+	if (!test_bit(DW_MMC_CARD_NO_USE_HOLD, &host->cur_slot->flags))
 		cmdr |= SDMMC_CMD_USE_HOLD_REG;
 
 	return cmdr;
@@ -499,7 +499,7 @@ static void dw_mci_dmac_complete_dma(void *arg)
 	if ((host->use_dma == TRANS_MODE_EDMAC) &&
 	    data && (data->flags & MMC_DATA_READ))
 		/* Invalidate cache after read */
-		dma_sync_sg_for_cpu(mmc_dev(host->slot->mmc),
+		dma_sync_sg_for_cpu(mmc_dev(host->cur_slot->mmc),
 				    data->sg,
 				    data->sg_len,
 				    DMA_FROM_DEVICE);
@@ -839,7 +839,7 @@ static int dw_mci_edmac_start_dma(struct dw_mci *host,
 
 	/* Flush cache before write */
 	if (host->data->flags & MMC_DATA_WRITE)
-		dma_sync_sg_for_device(mmc_dev(host->slot->mmc), sgl,
+		dma_sync_sg_for_device(mmc_dev(host->cur_slot->mmc), sgl,
 				       sg_elems, DMA_TO_DEVICE);
 
 	dma_async_issue_pending(host->dms->ch);
@@ -1301,6 +1301,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 
 	mrq = slot->mrq;
 
+	host->cur_slot = slot;
 	host->mrq = mrq;
 
 	host->pending_events = 0;
@@ -1781,7 +1782,7 @@ static bool dw_mci_reset(struct dw_mci *host)
 
 ciu_out:
 	/* After a CTRL reset we need to have CIU set clock registers  */
-	mci_send_cmd(host->slot, SDMMC_CMD_UPD_CLK, 0);
+	mci_send_cmd(host->cur_slot, SDMMC_CMD_UPD_CLK, 0);
 
 	return ret;
 }
@@ -1808,11 +1809,11 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
 	__acquires(&host->lock)
 {
 	struct dw_mci_slot *slot;
-	struct mmc_host	*prev_mmc = host->slot->mmc;
+	struct mmc_host	*prev_mmc = host->cur_slot->mmc;
 
 	WARN_ON(host->cmd || host->data);
 
-	host->slot->mrq = NULL;
+	host->cur_slot->mrq = NULL;
 	host->mrq = NULL;
 	if (!list_empty(&host->queue)) {
 		slot = list_entry(host->queue.next,
@@ -1962,7 +1963,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			err = dw_mci_command_complete(host, cmd);
 			if (cmd == mrq->sbc && !err) {
 				prev_state = state = STATE_SENDING_CMD;
-				__dw_mci_start_request(host, host->slot,
+				__dw_mci_start_request(host, host->cur_slot,
 						       mrq->cmd);
 				goto unlock;
 			}
@@ -3308,9 +3309,9 @@ int dw_mci_runtime_suspend(struct device *dev)
 
 	clk_disable_unprepare(host->ciu_clk);
 
-	if (host->slot &&
-	    (mmc_can_gpio_cd(host->slot->mmc) ||
-	     !mmc_card_is_removable(host->slot->mmc)))
+	if (host->cur_slot &&
+	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
+	     !mmc_card_is_removable(host->cur_slot->mmc)))
 		clk_disable_unprepare(host->biu_clk);
 
 	return 0;
@@ -3323,9 +3324,9 @@ int dw_mci_runtime_resume(struct device *dev)
 	struct dw_mci *host = dev_get_drvdata(dev);
 	struct dw_mci_slot *slot = host->slot;
 
-	if (host->slot &&
-	    (mmc_can_gpio_cd(host->slot->mmc) ||
-	     !mmc_card_is_removable(host->slot->mmc))) {
+	if (host->cur_slot &&
+	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
+	     !mmc_card_is_removable(host->cur_slot->mmc))) {
 		ret = clk_prepare_enable(host->biu_clk);
 		if (ret)
 			return ret;
@@ -3373,9 +3374,9 @@ int dw_mci_runtime_resume(struct device *dev)
 	return 0;
 
 err:
-	if (host->slot &&
-	    (mmc_can_gpio_cd(host->slot->mmc) ||
-	     !mmc_card_is_removable(host->slot->mmc)))
+	if (host->cur_slot &&
+	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
+	     !mmc_card_is_removable(host->cur_slot->mmc)))
 		clk_disable_unprepare(host->biu_clk);
 
 	return ret;
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 34474ad..20a956e 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -133,6 +133,7 @@ struct dw_mci_dma_slave {
  * =======
  *
  * @lock is a softirq-safe spinlock protecting @queue as well as
+ * @cur_slot, @mrq and @state. These must always be updated
  * at the same time while holding @lock.
  *
  * @irq_lock is an irq-safe spinlock protecting the INTMASK register
@@ -168,6 +169,7 @@ struct dw_mci {
 	struct scatterlist	*sg;
 	struct sg_mapping_iter	sg_miter;
 
+	struct dw_mci_slot	*cur_slot;
 	struct mmc_request	*mrq;
 	struct mmc_command	*cmd;
 	struct mmc_data		*data;
@@ -203,6 +205,7 @@ struct dw_mci {
 
 	u32			bus_hz;
 	u32			current_speed;
+	u32			num_slots;
 	u32			fifoth_val;
 	u16			verid;
 	struct device		*dev;
-- 
1.8.3.1
