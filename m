From: Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: [PATCH] mmc: dw_mmc: Add support for multiple SD cards on one host
 interface
Date: Sat, 30 Sep 2017 15:39:00 +0000
Message-ID: <AM5PR0701MB2657094CA5D94164E6D63A8DE47F0@AM5PR0701MB2657.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oln040092067026.outbound.protection.outlook.com ([40.92.67.26]:44448
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751099AbdI3PjD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 30 Sep 2017 11:39:03 -0400
Content-Language: de-DE
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>


Needs external logic to multiplex the clock signal,
which is controlled by a GPIO output pin.

Only the selected SD card receives the clock,
while the other SD card's clock is forced to LOW.
DATA and CMD lines can be connected to both SD cards.

On warm-start UBOOT should use a sequence of
CMD12 and CMD7 with RCA=0 to force any active SD card
to stop transmission and release the DATA bus.

Instantiate this in the device tree as:

 &mmc {
  select-gpio = <&portd 2 0>;
  cd-gpios = <&portb 28 1>,
             <&porta 18 1>;
 };

Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
---
 drivers/mmc/core/host.c   | 11 ++++----
 drivers/mmc/host/dw_mmc.c | 72 ++++++++++++++++++++++++++++++++++-------------
 drivers/mmc/host/dw_mmc.h | 13 +++++++--
 include/linux/mmc/host.h  |  7 ++++-
 4 files changed, 74 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index ad88deb..ba6c4a3 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -173,15 +173,16 @@ static void mmc_retune_timer(unsigned long data)
 }
 
 /**
- *	mmc_of_parse() - parse host's device-tree node
+ *	mmc_of_parse_ex() - parse host's device-tree node
  *	@host: host whose node should be parsed.
+ *	@idx: slot index.
  *
  * To keep the rest of the MMC subsystem unaware of whether DT has been
  * used to to instantiate and configure this host instance or not, we
  * parse the properties and set respective generic mmc-host flags and
  * parameters.
  */
-int mmc_of_parse(struct mmc_host *host)
+int mmc_of_parse_ex(struct mmc_host *host, int idx)
 {
 	struct device *dev = host->parent;
 	u32 bus_width;
@@ -238,7 +239,7 @@ int mmc_of_parse(struct mmc_host *host)
 		if (device_property_read_bool(dev, "broken-cd"))
 			host->caps |= MMC_CAP_NEEDS_POLL;
 
-		ret = mmc_gpiod_request_cd(host, "cd", 0, true,
+		ret = mmc_gpiod_request_cd(host, "cd", idx, true,
 					   0, &cd_gpio_invert);
 		if (!ret)
 			dev_info(host->parent, "Got CD GPIO\n");
@@ -263,7 +264,7 @@ int mmc_of_parse(struct mmc_host *host)
 	/* Parse Write Protection */
 	ro_cap_invert = device_property_read_bool(dev, "wp-inverted");
 
-	ret = mmc_gpiod_request_ro(host, "wp", 0, false, 0, &ro_gpio_invert);
+	ret = mmc_gpiod_request_ro(host, "wp", idx, false, 0, &ro_gpio_invert);
 	if (!ret)
 		dev_info(host->parent, "Got WP GPIO\n");
 	else if (ret != -ENOENT && ret != -ENOSYS)
@@ -337,7 +338,7 @@ int mmc_of_parse(struct mmc_host *host)
 	return mmc_pwrseq_alloc(host);
 }
 
-EXPORT_SYMBOL(mmc_of_parse);
+EXPORT_SYMBOL(mmc_of_parse_ex);
 
 /**
  *	mmc_alloc_host - initialise the per-host structure.
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 860313b..80bc4f3 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1221,6 +1221,9 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 	u32 clk_en_a;
 	u32 sdmmc_cmd_bits = SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT;
 
+	if (host->slot != slot)
+		return;
+
 	/* We must continue to set bit 28 in CMD until the change is complete */
 	if (host->state == STATE_WAITING_CMD11_DONE)
 		sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
@@ -1272,6 +1275,10 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 		/* inform CIU */
 		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
 
+		if (host->card_select)
+			gpiod_set_value(host->card_select,
+					slot != host->slots[0]);
+
 		/* enable clock; only low power if no SDIO */
 		clk_en_a = SDMMC_CLKEN_ENABLE << slot->id;
 		if (!test_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags))
@@ -1299,6 +1306,12 @@ static void __dw_mci_start_request(struct dw_mci *host,
 	struct mmc_data	*data;
 	u32 cmdflags;
 
+	if (host->slot != slot) {
+		host->slot = slot;
+		host->current_speed = 0;
+		dw_mci_setup_bus(slot, false);
+	}
+
 	mrq = slot->mrq;
 
 	host->mrq = mrq;
@@ -2581,12 +2594,16 @@ static void dw_mci_cmd_interrupt(struct dw_mci *host, u32 status)
 
 static void dw_mci_handle_cd(struct dw_mci *host)
 {
-	struct dw_mci_slot *slot = host->slot;
+	int i;
+
+	for (i = 0; i < host->num_slots; i++) {
+		struct dw_mci_slot *slot = host->slots[i];
 
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
@@ -2708,7 +2725,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int dw_mci_init_slot(struct dw_mci *host)
+static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 {
 	struct mmc_host *mmc;
 	struct dw_mci_slot *slot;
@@ -2725,7 +2742,7 @@ static int dw_mci_init_slot(struct dw_mci *host)
 	slot->sdio_id = host->sdio_id0 + slot->id;
 	slot->mmc = mmc;
 	slot->host = host;
-	host->slot = slot;
+	host->slots[id] = slot;
 
 	mmc->ops = &dw_mci_ops;
 	if (device_property_read_u32_array(host->dev, "clock-freq-min-max",
@@ -2772,7 +2789,7 @@ static int dw_mci_init_slot(struct dw_mci *host)
 	if (host->pdata->caps2)
 		mmc->caps2 = host->pdata->caps2;
 
-	ret = mmc_of_parse(mmc);
+	ret = mmc_of_parse_ex(mmc, id);
 	if (ret)
 		goto err_host_allocated;
 
@@ -2821,11 +2838,11 @@ static int dw_mci_init_slot(struct dw_mci *host)
 	return ret;
 }
 
-static void dw_mci_cleanup_slot(struct dw_mci_slot *slot)
+static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
 {
 	/* Debugfs stuff is cleaned up by mmc core */
 	mmc_remove_host(slot->mmc);
-	slot->host->slot = NULL;
+	slot->host->slots[id] = NULL;
 	mmc_free_host(slot->mmc);
 }
 
@@ -3073,6 +3090,15 @@ int dw_mci_probe(struct dw_mci *host)
 		}
 	}
 
+	host->card_select = devm_gpiod_get_optional(host->dev, "select",
+						    GPIOD_OUT_LOW);
+	if (IS_ERR(host->card_select)) {
+		dev_err(host->dev, "card select gpio not available\n");
+		return PTR_ERR(host->card_select);
+	}
+
+	host->num_slots = host->card_select ? 2 : 1;
+
 	host->biu_clk = devm_clk_get(host->dev, "biu");
 	if (IS_ERR(host->biu_clk)) {
 		dev_dbg(host->dev, "biu clock not available\n");
@@ -3241,11 +3267,13 @@ int dw_mci_probe(struct dw_mci *host)
 		 "DW MMC controller at irq %d,%d bit host data width,%u deep fifo\n",
 		 host->irq, width, fifo_size);
 
-	/* We need at least one slot to succeed */
-	ret = dw_mci_init_slot(host);
-	if (ret) {
-		dev_dbg(host->dev, "slot %d init failed\n", i);
-		goto err_dmaunmap;
+	/* We need all slots to succeed */
+	for (i = 0; i < host->num_slots; i++) {
+		ret = dw_mci_init_slot(host, i);
+		if (ret) {
+			dev_dbg(host->dev, "slot %d init failed\n", i);
+			goto err_dmaunmap;
+		}
 	}
 
 	/* Now that slots are all setup, we can enable card detect */
@@ -3272,9 +3300,13 @@ EXPORT_SYMBOL(dw_mci_probe);
 
 void dw_mci_remove(struct dw_mci *host)
 {
-	dev_dbg(host->dev, "remove slot\n");
-	if (host->slot)
-		dw_mci_cleanup_slot(host->slot);
+	int i;
+
+	for (i = 0; i < host->num_slots; i++) {
+		dev_dbg(host->dev, "remove slot %d\n", i);
+		if (host->slots[i])
+			dw_mci_cleanup_slot(host->slots[i], i);
+	}
 
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
@@ -3345,8 +3377,8 @@ int dw_mci_runtime_resume(struct device *dev)
 	 * Restore the initial value at FIFOTH register
 	 * And Invalidate the prev_blksz with zero
 	 */
-	 mci_writel(host, FIFOTH, host->fifoth_val);
-	 host->prev_blksz = 0;
+	mci_writel(host, FIFOTH, host->fifoth_val);
+	host->prev_blksz = 0;
 
 	/* Put in max timeout */
 	mci_writel(host, TMOUT, 0xFFFFFFFF);
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 34474ad..8863a9f 100644
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
@@ -65,8 +67,7 @@ struct dw_mci_dma_slave {
  * @fifo_reg: Pointer to MMIO registers for data FIFO
  * @sg: Scatterlist entry currently being processed by PIO code, if any.
  * @sg_miter: PIO mapping scatterlist iterator.
- * @cur_slot: The slot which is currently using the controller.
- * @mrq: The request currently being processed on @cur_slot,
+ * @mrq: The request currently being processed on @slot,
  *	or NULL if the controller is idle.
  * @cmd: The command currently being sent to the card, or NULL.
  * @data: The data currently being transferred, or NULL if no data
@@ -110,7 +111,8 @@ struct dw_mci_dma_slave {
  * @priv: Implementation defined private data.
  * @biu_clk: Pointer to bus interface unit clock instance.
  * @ciu_clk: Pointer to card interface unit clock instance.
- * @slot: Slots sharing this MMC controller.
+ * @slot: The slot which is currently using the controller.
+ * @slots: Slots sharing this MMC controller.
  * @fifo_depth: depth of FIFO.
  * @data_addr_override: override fifo reg offset with this value.
  * @wm_aligned: force fifo watermark equal with data length in PIO mode.
@@ -128,6 +130,7 @@ struct dw_mci_dma_slave {
  * @cmd11_timer: Timer for SD3.0 voltage switch over scheme.
  * @cto_timer: Timer for broken command transfer over scheme.
  * @dto_timer: Timer for broken data transfer over scheme.
+ * @card_select: The optional external card select output.
  *
  * Locking
  * =======
@@ -203,6 +206,7 @@ struct dw_mci {
 
 	u32			bus_hz;
 	u32			current_speed;
+	u32			num_slots;
 	u32			fifoth_val;
 	u16			verid;
 	struct device		*dev;
@@ -212,6 +216,7 @@ struct dw_mci {
 	struct clk		*biu_clk;
 	struct clk		*ciu_clk;
 	struct dw_mci_slot	*slot;
+	struct dw_mci_slot	*slots[MAX_MCI_SLOTS];
 
 	/* FIFO push and pull */
 	int			fifo_depth;
@@ -235,6 +240,8 @@ struct dw_mci {
 	struct timer_list       cmd11_timer;
 	struct timer_list       cto_timer;
 	struct timer_list       dto_timer;
+
+	struct gpio_desc	*card_select;
 };
 
 /* DMA ops for Internal/External DMAC interface */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index f3f2d07..ea39fa8 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -448,9 +448,14 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *);
 int mmc_add_host(struct mmc_host *);
 void mmc_remove_host(struct mmc_host *);
 void mmc_free_host(struct mmc_host *);
-int mmc_of_parse(struct mmc_host *host);
+int mmc_of_parse_ex(struct mmc_host *host, int idx);
 int mmc_of_parse_voltage(struct device_node *np, u32 *mask);
 
+static inline int mmc_of_parse(struct mmc_host *host)
+{
+	return mmc_of_parse_ex(host, 0);
+}
+
 static inline void *mmc_priv(struct mmc_host *host)
 {
 	return (void *)host->private;
-- 
2.7.4
