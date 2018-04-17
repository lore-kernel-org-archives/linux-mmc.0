From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [RFC 1/2] dw_mmc: revert removal multislot support
Date: Tue, 17 Apr 2018 15:11:29 +0300
Message-ID: <20180417121130.25281-2-Eugeniy.Paltsev@synopsys.com>
References: <20180417121130.25281-1-Eugeniy.Paltsev@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180417121130.25281-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, shawn.lin@rock-chips.com, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

Revert "mmc: dw_mmc: remove the deprecated "num-slots""
Revert "mmc: dw_mmc: fix the wrong condition check of getting num-slots from DT"
Revert "mmc: dw_mmc: remove the unnecessary slot variable"
Revert "mmc: dw_mmc: update kernel-doc comments for dw_mci"
Revert "mmc: dw_mmc: use the 'slot' instead of 'cur_slot'"
Revert "mmc: dw_mmc: remove the 'id' arguments about functions relevant to slot"
Revert "mmc: dw_mmc: change the array of slots"
Revert "mmc: dw_mmc: remove the loop about finding slots"
Revert "mmc: dw_mmc: deprecated the "num-slots" property"
---
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |   5 +
 drivers/mmc/host/dw_mmc-exynos.c                   |   4 +-
 drivers/mmc/host/dw_mmc-pci.c                      |   1 +
 drivers/mmc/host/dw_mmc.c                          | 167 ++++++++++++++-------
 drivers/mmc/host/dw_mmc.h                          |  21 ++-
 5 files changed, 137 insertions(+), 61 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index 7e5e427a22ce..75c9fdca4aaf 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -59,6 +59,11 @@ Optional properties:
   is specified and the ciu clock is specified then we'll try to set the ciu
   clock to this at probe time.
 
+* num-slots (DEPRECATED): specifies the number of slots supported by the controller.
+  The number of physical slots actually used could be equal or less than the
+  value specified by num-slots. If this property is not specified, the value
+  of num-slot property is assumed to be 1.
+
 * fifo-depth: The maximum size of the tx/rx fifo's. If this property is not
   specified, the default value of the fifo size is determined from the
   controller registers.
diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index a84aa3f1ae85..6de892443207 100644
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
diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index 3ad07d7b2c97..ab8713297edb 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -29,6 +29,7 @@
 				MMC_CAP_SDIO_IRQ)
 
 static struct dw_mci_board pci_board_data = {
+	.num_slots			= 1,
 	.caps				= DW_MCI_CAPABILITIES,
 	.bus_hz				= 33 * 1000 * 1000,
 	.detect_delay_ms		= 200,
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 29a1afa81f66..f8b1e3528e99 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -372,7 +372,7 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
 	cmdr = stop->opcode | SDMMC_CMD_STOP |
 		SDMMC_CMD_RESP_CRC | SDMMC_CMD_RESP_EXP;
 
-	if (!test_bit(DW_MMC_CARD_NO_USE_HOLD, &host->slot->flags))
+	if (!test_bit(DW_MMC_CARD_NO_USE_HOLD, &host->cur_slot->flags))
 		cmdr |= SDMMC_CMD_USE_HOLD_REG;
 
 	return cmdr;
@@ -502,7 +502,7 @@ static void dw_mci_dmac_complete_dma(void *arg)
 	if ((host->use_dma == TRANS_MODE_EDMAC) &&
 	    data && (data->flags & MMC_DATA_READ))
 		/* Invalidate cache after read */
-		dma_sync_sg_for_cpu(mmc_dev(host->slot->mmc),
+		dma_sync_sg_for_cpu(mmc_dev(host->cur_slot->mmc),
 				    data->sg,
 				    data->sg_len,
 				    DMA_FROM_DEVICE);
@@ -844,7 +844,7 @@ static int dw_mci_edmac_start_dma(struct dw_mci *host,
 
 	/* Flush cache before write */
 	if (host->data->flags & MMC_DATA_WRITE)
-		dma_sync_sg_for_device(mmc_dev(host->slot->mmc), sgl,
+		dma_sync_sg_for_device(mmc_dev(host->cur_slot->mmc), sgl,
 				       sg_elems, DMA_TO_DEVICE);
 
 	dma_async_issue_pending(host->dms->ch);
@@ -1306,6 +1306,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 
 	mrq = slot->mrq;
 
+	host->cur_slot = slot;
 	host->mrq = mrq;
 
 	host->pending_events = 0;
@@ -1786,7 +1787,7 @@ static bool dw_mci_reset(struct dw_mci *host)
 
 ciu_out:
 	/* After a CTRL reset we need to have CIU set clock registers  */
-	mci_send_cmd(host->slot, SDMMC_CMD_UPD_CLK, 0);
+	mci_send_cmd(host->cur_slot, SDMMC_CMD_UPD_CLK, 0);
 
 	return ret;
 }
@@ -1813,11 +1814,11 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
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
@@ -2006,7 +2007,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			set_bit(EVENT_CMD_COMPLETE, &host->completed_events);
 			err = dw_mci_command_complete(host, cmd);
 			if (cmd == mrq->sbc && !err) {
-				__dw_mci_start_request(host, host->slot,
+				__dw_mci_start_request(host, host->cur_slot,
 						       mrq->cmd);
 				goto unlock;
 			}
@@ -2625,20 +2626,27 @@ static void dw_mci_cmd_interrupt(struct dw_mci *host, u32 status)
 
 static void dw_mci_handle_cd(struct dw_mci *host)
 {
-	struct dw_mci_slot *slot = host->slot;
+	int i;
+
+	for (i = 0; i < host->num_slots; i++) {
+		struct dw_mci_slot *slot = host->slot[i];
+
+		if (!slot)
+			continue;
 
-	if (slot->mmc->ops->card_event)
-		slot->mmc->ops->card_event(slot->mmc);
-	mmc_detect_change(slot->mmc,
-		msecs_to_jiffies(host->pdata->detect_delay_ms));
+		if (slot->mmc->ops->card_event)
+			slot->mmc->ops->card_event(slot->mmc);
+		mmc_detect_change(slot->mmc,
+			msecs_to_jiffies(host->pdata->detect_delay_ms));
+	}
 }
 
 static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 {
+	unsigned long irqflags;
 	struct dw_mci *host = dev_id;
 	u32 pending;
-	struct dw_mci_slot *slot = host->slot;
-	unsigned long irqflags;
+	int i;
 
 	pending = mci_readl(host, MINTSTS); /* read-only mask reg */
 
@@ -2726,11 +2734,19 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			dw_mci_handle_cd(host);
 		}
 
-		if (pending & SDMMC_INT_SDIO(slot->sdio_id)) {
-			mci_writel(host, RINTSTS,
-				   SDMMC_INT_SDIO(slot->sdio_id));
-			__dw_mci_enable_sdio_irq(slot, 0);
-			sdio_signal_irq(slot->mmc);
+		/* Handle SDIO Interrupts */
+		for (i = 0; i < host->num_slots; i++) {
+			struct dw_mci_slot *slot = host->slot[i];
+
+			if (!slot)
+				continue;
+
+			if (pending & SDMMC_INT_SDIO(slot->sdio_id)) {
+				mci_writel(host, RINTSTS,
+					   SDMMC_INT_SDIO(slot->sdio_id));
+				__dw_mci_enable_sdio_irq(slot, 0);
+				sdio_signal_irq(slot->mmc);
+			}
 		}
 
 	}
@@ -2812,7 +2828,7 @@ static int dw_mci_init_slot_caps(struct dw_mci_slot *slot)
 	return 0;
 }
 
-static int dw_mci_init_slot(struct dw_mci *host)
+static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 {
 	struct mmc_host *mmc;
 	struct dw_mci_slot *slot;
@@ -2823,11 +2839,11 @@ static int dw_mci_init_slot(struct dw_mci *host)
 		return -ENOMEM;
 
 	slot = mmc_priv(mmc);
-	slot->id = 0;
-	slot->sdio_id = host->sdio_id0 + slot->id;
+	slot->id = id;
+	slot->sdio_id = host->sdio_id0 + id;
 	slot->mmc = mmc;
 	slot->host = host;
-	host->slot = slot;
+	host->slot[id] = slot;
 
 	mmc->ops = &dw_mci_ops;
 
@@ -2888,11 +2904,11 @@ static int dw_mci_init_slot(struct dw_mci *host)
 	return ret;
 }
 
-static void dw_mci_cleanup_slot(struct dw_mci_slot *slot)
+static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
 {
 	/* Debugfs stuff is cleaned up by mmc core */
 	mmc_remove_host(slot->mmc);
-	slot->host->slot = NULL;
+	slot->host->slot[id] = NULL;
 	mmc_free_host(slot->mmc);
 }
 
@@ -3128,6 +3144,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 			return ERR_PTR(-EPROBE_DEFER);
 	}
 
+	/* find out number of slots supported */
+	device_property_read_u32(dev, "num-slots", &pdata->num_slots);
+
 	if (device_property_read_u32(dev, "fifo-depth", &pdata->fifo_depth))
 		dev_info(dev,
 			 "fifo-depth property not found, using value of FIFOTH register as default\n");
@@ -3163,21 +3182,29 @@ static void dw_mci_enable_cd(struct dw_mci *host)
 {
 	unsigned long irqflags;
 	u32 temp;
+	int i;
+	struct dw_mci_slot *slot;
 
 	/*
 	 * No need for CD if all slots have a non-error GPIO
 	 * as well as broken card detection is found.
 	 */
-	if (host->slot->mmc->caps & MMC_CAP_NEEDS_POLL)
-		return;
+	for (i = 0; i < host->num_slots; i++) {
+		slot = host->slot[i];
+		if (slot->mmc->caps & MMC_CAP_NEEDS_POLL)
+			return;
 
-	if (mmc_gpio_get_cd(host->slot->mmc) < 0) {
-		spin_lock_irqsave(&host->irq_lock, irqflags);
-		temp = mci_readl(host, INTMASK);
-		temp  |= SDMMC_INT_CD;
-		mci_writel(host, INTMASK, temp);
-		spin_unlock_irqrestore(&host->irq_lock, irqflags);
+		if (mmc_gpio_get_cd(slot->mmc) < 0)
+			break;
 	}
+	if (i == host->num_slots)
+		return;
+
+	spin_lock_irqsave(&host->irq_lock, irqflags);
+	temp = mci_readl(host, INTMASK);
+	temp  |= SDMMC_INT_CD;
+	mci_writel(host, INTMASK, temp);
+	spin_unlock_irqrestore(&host->irq_lock, irqflags);
 }
 
 int dw_mci_probe(struct dw_mci *host)
@@ -3185,6 +3212,7 @@ int dw_mci_probe(struct dw_mci *host)
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int width, i, ret = 0;
 	u32 fifo_size;
+	int init_slots = 0;
 
 	if (!host->pdata) {
 		host->pdata = dw_mci_parse_dt(host);
@@ -3345,6 +3373,19 @@ int dw_mci_probe(struct dw_mci *host)
 	if (ret)
 		goto err_dmaunmap;
 
+	if (host->pdata->num_slots)
+		host->num_slots = host->pdata->num_slots;
+	else
+		host->num_slots = 1;
+
+	if (host->num_slots < 1 ||
+	    host->num_slots > SDMMC_GET_SLOT_NUM(mci_readl(host, HCON))) {
+		dev_err(host->dev,
+			"Platform data must supply correct num_slots.\n");
+		ret = -ENODEV;
+		goto err_clk_ciu;
+	}
+
 	/*
 	 * Enable interrupts for command done, data over, data empty,
 	 * receive ready and error such as transmit, receive timeout, crc error
@@ -3360,9 +3401,20 @@ int dw_mci_probe(struct dw_mci *host)
 		 host->irq, width, fifo_size);
 
 	/* We need at least one slot to succeed */
-	ret = dw_mci_init_slot(host);
-	if (ret) {
-		dev_dbg(host->dev, "slot %d init failed\n", i);
+	for (i = 0; i < host->num_slots; i++) {
+		ret = dw_mci_init_slot(host, i);
+		if (ret)
+			dev_dbg(host->dev, "slot %d init failed\n", i);
+		else
+			init_slots++;
+	}
+
+	if (init_slots) {
+		dev_info(host->dev, "%d slots initialized\n", init_slots);
+	} else {
+		dev_dbg(host->dev,
+			"attempted to initialize %d slots, but failed on all\n",
+			host->num_slots);
 		goto err_dmaunmap;
 	}
 
@@ -3390,9 +3442,13 @@ EXPORT_SYMBOL(dw_mci_probe);
 
 void dw_mci_remove(struct dw_mci *host)
 {
-	dev_dbg(host->dev, "remove slot\n");
-	if (host->slot)
-		dw_mci_cleanup_slot(host->slot);
+	int i;
+
+	for (i = 0; i < host->num_slots; i++) {
+		dev_dbg(host->dev, "remove slot %d\n", i);
+		if (host->slot[i])
+			dw_mci_cleanup_slot(host->slot[i], i);
+	}
 
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
@@ -3424,9 +3480,9 @@ int dw_mci_runtime_suspend(struct device *dev)
 
 	clk_disable_unprepare(host->ciu_clk);
 
-	if (host->slot &&
-	    (mmc_can_gpio_cd(host->slot->mmc) ||
-	     !mmc_card_is_removable(host->slot->mmc)))
+	if (host->cur_slot &&
+	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
+	     !mmc_card_is_removable(host->cur_slot->mmc)))
 		clk_disable_unprepare(host->biu_clk);
 
 	return 0;
@@ -3435,12 +3491,12 @@ EXPORT_SYMBOL(dw_mci_runtime_suspend);
 
 int dw_mci_runtime_resume(struct device *dev)
 {
-	int ret = 0;
+	int i, ret = 0;
 	struct dw_mci *host = dev_get_drvdata(dev);
 
-	if (host->slot &&
-	    (mmc_can_gpio_cd(host->slot->mmc) ||
-	     !mmc_card_is_removable(host->slot->mmc))) {
+	if (host->cur_slot &&
+	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
+	     !mmc_card_is_removable(host->cur_slot->mmc))) {
 		ret = clk_prepare_enable(host->biu_clk);
 		if (ret)
 			return ret;
@@ -3475,12 +3531,17 @@ int dw_mci_runtime_resume(struct device *dev)
 		   DW_MCI_ERROR_FLAGS);
 	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
 
+	for (i = 0; i < host->num_slots; i++) {
+		struct dw_mci_slot *slot = host->slot[i];
 
-	if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
-		dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);
+		if (!slot)
+			continue;
+		if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
+			dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
 
-	/* Force setup bus to guarantee available clock output */
-	dw_mci_setup_bus(host->slot, true);
+		/* Force setup bus to guarantee available clock output */
+		dw_mci_setup_bus(slot, true);
+	}
 
 	/* Now that slots are all setup, we can enable card detect */
 	dw_mci_enable_cd(host);
@@ -3488,9 +3549,9 @@ int dw_mci_runtime_resume(struct device *dev)
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
index 46e9f8ec5398..92ece82c76f2 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -20,6 +20,8 @@
 #include <linux/reset.h>
 #include <linux/interrupt.h>
 
+#define MAX_MCI_SLOTS	2
+
 enum dw_mci_state {
 	STATE_IDLE = 0,
 	STATE_SENDING_CMD,
@@ -65,7 +67,8 @@ struct dw_mci_dma_slave {
  * @fifo_reg: Pointer to MMIO registers for data FIFO
  * @sg: Scatterlist entry currently being processed by PIO code, if any.
  * @sg_miter: PIO mapping scatterlist iterator.
- * @mrq: The request currently being processed on @slot,
+ * @cur_slot: The slot which is currently using the controller.
+ * @mrq: The request currently being processed on @cur_slot,
  *	or NULL if the controller is idle.
  * @cmd: The command currently being sent to the card, or NULL.
  * @data: The data currently being transferred, or NULL if no data
@@ -101,6 +104,7 @@ struct dw_mci_dma_slave {
  * @bus_hz: The rate of @mck in Hz. This forms the basis for MMC bus
  *	rate and timeout calculations.
  * @current_speed: Configured rate of the controller.
+ * @num_slots: Number of slots available.
  * @fifoth_val: The value of FIFOTH register.
  * @verid: Denote Version ID.
  * @dev: Device associated with the MMC controller.
@@ -132,17 +136,18 @@ struct dw_mci_dma_slave {
  * =======
  *
  * @lock is a softirq-safe spinlock protecting @queue as well as
- * @slot, @mrq and @state. These must always be updated
+ * @cur_slot, @mrq and @state. These must always be updated
  * at the same time while holding @lock.
- * The @mrq field of struct dw_mci_slot is also protected by @lock,
- * and must always be written at the same time as the slot is added to
- * @queue.
  *
  * @irq_lock is an irq-safe spinlock protecting the INTMASK register
  * to allow the interrupt handler to modify it directly.  Held for only long
  * enough to read-modify-write INTMASK and no other locks are grabbed when
  * holding this one.
  *
+ * The @mrq field of struct dw_mci_slot is also protected by @lock,
+ * and must always be written at the same time as the slot is added to
+ * @queue.
+ *
  * @pending_events and @completed_events are accessed using atomic bit
  * operations, so they don't need any locking.
  *
@@ -167,6 +172,7 @@ struct dw_mci {
 	struct scatterlist	*sg;
 	struct sg_mapping_iter	sg_miter;
 
+	struct dw_mci_slot	*cur_slot;
 	struct mmc_request	*mrq;
 	struct mmc_command	*cmd;
 	struct mmc_data		*data;
@@ -202,6 +208,7 @@ struct dw_mci {
 
 	u32			bus_hz;
 	u32			current_speed;
+	u32			num_slots;
 	u32			fifoth_val;
 	u16			verid;
 	struct device		*dev;
@@ -210,7 +217,7 @@ struct dw_mci {
 	void			*priv;
 	struct clk		*biu_clk;
 	struct clk		*ciu_clk;
-	struct dw_mci_slot	*slot;
+	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];
 
 	/* FIFO push and pull */
 	int			fifo_depth;
@@ -251,6 +258,8 @@ struct dma_pdata;
 
 /* Board platform data */
 struct dw_mci_board {
+	u32 num_slots;
+
 	unsigned int bus_hz; /* Clock speed at the cclk_in pad */
 
 	u32 caps;	/* Capabilities */
-- 
2.14.3
