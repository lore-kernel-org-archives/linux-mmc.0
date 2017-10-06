From: Liming Sun <lsun@mellanox.com>
Subject: [PATCH 8/9] mmc: dw_mmc: Support two SD_MMC_CE-ATA cards
Date: Fri,  6 Oct 2017 15:21:31 -0400
Message-ID: <29e94dd7affaf2edabec3e32a047234921632c14.1507315433.git.lsun@mellanox.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40078 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752545AbdJFTWD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Oct 2017 15:22:03 -0400
In-Reply-To: <cover.1507315433.git.lsun@mellanox.com>
In-Reply-To: <cover.1507315433.git.lsun@mellanox.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Liming Sun <lsun@mellanox.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

The dw_mmc controller supports two cards, but the current
driver only supports one card. The issue was found on a system
with two SD_MMC_CE-ATA cards. In such case, none of the cards
could come up when both are enabled.

According to the DesignWare Cores Mobile Storage Host Databook,
DW-MMC supports MMC-Ver3.3-only mode and SD_MMC_CE-ATA mode. In
the latter case, the memory cards are connected in a star topology
where each card has its own bus. In this case, the 'card-number'
in several registers needs to be set so the demux logic of the
controller can send the command or data to only the selected
card. This logic doesn't seem to be fully implemented in the
current dw-mmc driver.

This commit has the following changes to solve the two-card issue.
  - Set the CTYPE register for multi-card case;
  - Set the CLKENA register for multi-card case;
  - Set the 'slot_num' field in CMD register;
  - Program the CDTHRCTL register for the SD_MMC_CE-ATA mode which
    is mentioned as a must in the databook for version 270a.

Signed-off-by: Liming Sun <lsun@mellanox.com>
Reviewed-by: Chris Metcalf <cmetcalf@mellanox.com>
---
 drivers/mmc/host/dw_mmc.c | 75 ++++++++++++++++++++++++++++++++++++++---------
 drivers/mmc/host/dw_mmc.h | 10 +++++++
 2 files changed, 71 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 150cd05..a3188c2 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -251,11 +251,36 @@ static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset)
 	return true;
 }
 
-static void dw_mci_wait_while_busy(struct dw_mci *host, u32 cmd_flags)
+static void dw_mci_wait_while_busy(struct dw_mci *host, u32 cmd_flags,
+				   struct dw_mci_slot *slot)
 {
 	u32 status;
 
 	/*
+	 * Only one memory card should be selected at a time for command or data
+	 * transfer. For example, when a data transfer from a card occurs, a new
+	 * command should not be sent to another card; within the same card, a
+	 * new command is allowed to read the status, or to stop or abort the
+	 * current data transfer.
+	 */
+	status = mci_readl(host, CMD);
+	if (SDMMC_GET_CARD_NUM(status) != slot->id) {
+		/* Check the last command of the other card. */
+		if (readl_poll_timeout_atomic(host->regs + SDMMC_CMD,
+					      status,
+					      !(status & SDMMC_CMD_START),
+					      10, 500 * USEC_PER_MSEC))
+			dev_err(host->dev, "CMD busy; trying anyway\n");
+
+		/* Check the busy state of the other card. */
+		if (readl_poll_timeout_atomic(host->regs + SDMMC_STATUS,
+					      status,
+					      !(status & SDMMC_STATUS_BUSY),
+					      10, 500 * USEC_PER_MSEC))
+			dev_err(host->dev, "STATUS busy; trying anyway\n");
+	}
+
+	/*
 	 * Databook says that before issuing a new data transfer command
 	 * we need to check to see if the card is busy.  Data transfer commands
 	 * all have SDMMC_CMD_PRV_DAT_WAIT set, so we'll key off that.
@@ -280,8 +305,9 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
 
 	mci_writel(host, CMDARG, arg);
 	wmb(); /* drain writebuffer */
-	dw_mci_wait_while_busy(host, cmd);
-	mci_writel(host, CMD, SDMMC_CMD_START | cmd);
+	dw_mci_wait_while_busy(host, cmd, slot);
+	mci_writel(host, CMD, SDMMC_CMD_START | cmd |
+		   SDMMC_CMD_CARD_NUM(slot->id));
 
 	if (readl_poll_timeout_atomic(host->regs + SDMMC_CMD, cmd_status,
 				      !(cmd_status & SDMMC_CMD_START),
@@ -423,13 +449,14 @@ static void dw_mci_start_command(struct dw_mci *host,
 
 	mci_writel(host, CMDARG, cmd->arg);
 	wmb(); /* drain writebuffer */
-	dw_mci_wait_while_busy(host, cmd_flags);
+	dw_mci_wait_while_busy(host, cmd_flags, host->cur_slot);
 
 	/* response expected command only */
 	if (cmd_flags & SDMMC_CMD_RESP_EXP)
 		dw_mci_set_cto(host);
 
-	mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START);
+	mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START |
+		   SDMMC_CMD_CARD_NUM(host->cur_slot->id));
 }
 
 static inline void send_stop_abort(struct dw_mci *host, struct mmc_data *data)
@@ -1069,7 +1096,9 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
 		enable = SDMMC_CARD_RD_THR_EN;
 
 	if (host->timing != MMC_TIMING_MMC_HS200 &&
-	    host->timing != MMC_TIMING_UHS_SDR104)
+	    host->timing != MMC_TIMING_UHS_SDR104 &&
+	    (host->timing != MMC_TIMING_MMC_HS ||
+	    host->verid < DW_MMC_270A))
 		goto disable;
 
 	blksz_depth = blksz / (1 << host->data_shift);
@@ -1216,19 +1245,28 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
 static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 {
 	struct dw_mci *host = slot->host;
-	unsigned int clock = slot->clock;
+	unsigned int clock = slot->clock, old_clock;
 	u32 div;
-	u32 clk_en_a;
+	u32 clk_en_a, ctype;
 	u32 sdmmc_cmd_bits = SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT;
 
 	/* We must continue to set bit 28 in CMD until the change is complete */
 	if (host->state == STATE_WAITING_CMD11_DONE)
 		sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
 
+	/* Save the information for other slots. */
+	clk_en_a = mci_readl(host, CLKENA) &
+		   ~((SDMMC_CLKEN_ENABLE | SDMMC_CLKEN_LOW_PWR) << slot->id);
+	ctype = mci_readl(host, CTYPE) & ~(0x10001 << slot->id);
+
+	/* Only one clock is used in MMC-Ver3.3-only mode. */
+	old_clock = (host->card_type == DW_CARD_TYPE_MMC_ONLY) ?
+			host->current_speed : slot->__clk_old;
+
 	if (!clock) {
-		mci_writel(host, CLKENA, 0);
+		mci_writel(host, CLKENA, clk_en_a);
 		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
-	} else if (clock != host->current_speed || force_clkinit) {
+	} else if (clock != old_clock || force_clkinit) {
 		div = host->bus_hz / clock;
 		if (host->bus_hz % clock && host->bus_hz > clock)
 			/*
@@ -1273,7 +1311,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
 
 		/* enable clock; only low power if no SDIO */
-		clk_en_a = SDMMC_CLKEN_ENABLE << slot->id;
+		clk_en_a |= SDMMC_CLKEN_ENABLE << slot->id;
 		if (!test_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags))
 			clk_en_a |= SDMMC_CLKEN_LOW_PWR << slot->id;
 		mci_writel(host, CLKENA, clk_en_a);
@@ -1288,7 +1326,11 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 	host->current_speed = clock;
 
 	/* Set the current slot bus width */
-	mci_writel(host, CTYPE, (slot->ctype << slot->id));
+	if (slot->ctype == SDMMC_CTYPE_8BIT)
+		ctype |= 0x10000 << slot->id;
+	else
+		ctype |= slot->ctype << slot->id;
+	mci_writel(host, CTYPE, ctype);
 }
 
 static void __dw_mci_start_request(struct dw_mci *host,
@@ -3084,7 +3126,7 @@ int dw_mci_probe(struct dw_mci *host)
 {
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int width, i, ret = 0;
-	u32 fifo_size;
+	u32 fifo_size, hcon;
 	int init_slots = 0;
 
 	if (!host->pdata) {
@@ -3164,11 +3206,14 @@ int dw_mci_probe(struct dw_mci *host)
 	spin_lock_init(&host->irq_lock);
 	INIT_LIST_HEAD(&host->queue);
 
+	/* Read the Hardware Configuration Register (HCON). */
+	hcon = mci_readl(host, HCON);
+
 	/*
 	 * Get the host data width - this assumes that HCON has been set with
 	 * the correct values.
 	 */
-	i = SDMMC_GET_HDATA_WIDTH(mci_readl(host, HCON));
+	i = SDMMC_GET_HDATA_WIDTH(hcon);
 	if (!i) {
 		host->push_data = dw_mci_push_data16;
 		host->pull_data = dw_mci_pull_data16;
@@ -3251,6 +3296,8 @@ int dw_mci_probe(struct dw_mci *host)
 	if (ret)
 		goto err_dmaunmap;
 
+	host->card_type = SDMMC_GET_CARD_TYPE(hcon);
+
 	if (host->pdata->num_slots)
 		host->num_slots = host->pdata->num_slots;
 	else
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index e62cafc..a0a4348 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -106,6 +106,7 @@ struct dw_mci_dma_slave {
  * @num_slots: Number of slots available.
  * @fifoth_val: The value of FIFOTH register.
  * @verid: Denote Version ID.
+ * @card_type: The card type obtained from the HCON register.
  * @dev: Device associated with the MMC controller.
  * @pdata: Platform data associated with the MMC controller.
  * @drv_data: Driver specific data for identified variant of the controller
@@ -210,6 +211,7 @@ struct dw_mci {
 	u32			num_slots;
 	u32			fifoth_val;
 	u16			verid;
+	u8			card_type;
 	struct device		*dev;
 	struct dw_mci_board	*pdata;
 	const struct dw_mci_drv_data	*drv_data;
@@ -280,6 +282,7 @@ struct dw_mci_board {
 };
 
 #define DW_MMC_240A		0x240a
+#define DW_MMC_270A		0x270a
 #define DW_MMC_280A		0x280a
 
 #define SDMMC_CTRL		0x000
@@ -409,6 +412,8 @@ struct dw_mci_board {
 #define SDMMC_CMD_RESP_LONG		BIT(7)
 #define SDMMC_CMD_RESP_EXP		BIT(6)
 #define SDMMC_CMD_INDX(n)		((n) & 0x1F)
+#define SDMMC_CMD_CARD_NUM(n)		((n & 0x1F) << 16)
+#define SDMMC_GET_CARD_NUM(x)		(((x)>>16) & 0x1F)
 /* Status register defines */
 #define SDMMC_GET_FCNT(x)		(((x)>>17) & 0x1FFF)
 #define SDMMC_STATUS_DMA_REQ		BIT(31)
@@ -422,6 +427,7 @@ struct dw_mci_board {
 #define DMA_INTERFACE_DWDMA		(0x1)
 #define DMA_INTERFACE_GDMA		(0x2)
 #define DMA_INTERFACE_NODMA		(0x3)
+#define SDMMC_GET_CARD_TYPE(x)		((x) & 0x1)
 #define SDMMC_GET_TRANS_MODE(x)		(((x)>>16) & 0x3)
 #define SDMMC_GET_SLOT_NUM(x)		((((x)>>1) & 0x1F) + 1)
 #define SDMMC_GET_HDATA_WIDTH(x)	(((x)>>7) & 0x7)
@@ -452,6 +458,10 @@ struct dw_mci_board {
 #define SDMMC_CTRL_ALL_RESET_FLAGS \
 	(SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET | SDMMC_CTRL_DMA_RESET)
 
+/* Card types */
+#define DW_CARD_TYPE_MMC_ONLY		0
+#define DW_CARD_TYPE_SD_MMC		1
+
 /* FIFO register access macros. These should not change the data endian-ness
  * as they are written to memory to be dealt with by the upper layers */
 #define mci_fifo_readw(__reg)	__raw_readw(__reg)
-- 
1.8.3.1

