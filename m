From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 4/5] mmc: tmio: improve checkpatch cleanness
Date: Tue, 30 May 2017 14:50:53 +0200
Message-ID: <1496148654-20386-5-git-send-email-horms+renesas@verge.net.au>
References: <1496148654-20386-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1496148654-20386-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Trivial updates to improve checkpatch cleanness.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/renesas_sdhi.h  |   2 +-
 drivers/mmc/host/tmio_mmc.c      |   8 +--
 drivers/mmc/host/tmio_mmc.h      |  17 +++---
 drivers/mmc/host/tmio_mmc_core.c | 114 +++++++++++++++++++++++----------------
 include/linux/mfd/tmio.h         |  33 ++++++------
 5 files changed, 100 insertions(+), 74 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index eb3ea15ff92d..6b4a79508c6b 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -27,7 +27,7 @@ struct renesas_sdhi_of_data {
 	unsigned long capabilities2;
 	enum dma_slave_buswidth dma_buswidth;
 	dma_addr_t dma_rx_offset;
-	unsigned bus_shift;
+	unsigned int bus_shift;
 	int scc_offset;
 	struct renesas_sdhi_scc *taps;
 	int taps_num;
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 61cf36fb270b..64b7e9f18361 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -104,8 +104,8 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 		goto host_free;
 
 	ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq,
-				IRQF_TRIGGER_FALLING,
-				dev_name(&pdev->dev), host);
+			       IRQF_TRIGGER_FALLING,
+			       dev_name(&pdev->dev), host);
 	if (ret)
 		goto host_remove;
 
@@ -132,6 +132,7 @@ static int tmio_mmc_remove(struct platform_device *pdev)
 
 	if (mmc) {
 		struct tmio_mmc_host *host = mmc_priv(mmc);
+
 		tmio_mmc_host_remove(host);
 		if (cell->disable)
 			cell->disable(pdev);
@@ -145,8 +146,7 @@ static int tmio_mmc_remove(struct platform_device *pdev)
 static const struct dev_pm_ops tmio_mmc_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(tmio_mmc_suspend, tmio_mmc_resume)
 	SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
-			tmio_mmc_host_runtime_resume,
-			NULL)
+			   tmio_mmc_host_runtime_resume, NULL)
 };
 
 static struct platform_driver tmio_mmc_driver = {
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 768c8abaedda..6ad6704175dc 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -239,24 +239,26 @@ static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
 }
 
 static inline void sd_ctrl_read16_rep(struct tmio_mmc_host *host, int addr,
-		u16 *buf, int count)
+				      u16 *buf, int count)
 {
 	readsw(host->ctl + (addr << host->bus_shift), buf, count);
 }
 
-static inline u32 sd_ctrl_read16_and_16_as_32(struct tmio_mmc_host *host, int addr)
+static inline u32 sd_ctrl_read16_and_16_as_32(struct tmio_mmc_host *host,
+					      int addr)
 {
 	return readw(host->ctl + (addr << host->bus_shift)) |
 	       readw(host->ctl + ((addr + 2) << host->bus_shift)) << 16;
 }
 
 static inline void sd_ctrl_read32_rep(struct tmio_mmc_host *host, int addr,
-		u32 *buf, int count)
+				      u32 *buf, int count)
 {
 	readsl(host->ctl + (addr << host->bus_shift), buf, count);
 }
 
-static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int addr, u16 val)
+static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int addr,
+				   u16 val)
 {
 	/* If there is a hook and it returns non-zero then there
 	 * is an error and the write should be skipped
@@ -267,19 +269,20 @@ static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int addr, u16 val
 }
 
 static inline void sd_ctrl_write16_rep(struct tmio_mmc_host *host, int addr,
-		u16 *buf, int count)
+				       u16 *buf, int count)
 {
 	writesw(host->ctl + (addr << host->bus_shift), buf, count);
 }
 
-static inline void sd_ctrl_write32_as_16_and_16(struct tmio_mmc_host *host, int addr, u32 val)
+static inline void sd_ctrl_write32_as_16_and_16(struct tmio_mmc_host *host,
+						int addr, u32 val)
 {
 	writew(val & 0xffff, host->ctl + (addr << host->bus_shift));
 	writew(val >> 16, host->ctl + ((addr + 2) << host->bus_shift));
 }
 
 static inline void sd_ctrl_write32_rep(struct tmio_mmc_host *host, int addr,
-		const u32 *buf, int count)
+				       const u32 *buf, int count)
 {
 	writesl(host->ctl + (addr << host->bus_shift), buf, count);
 }
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 70516abd50a1..07905c05f356 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -127,16 +127,17 @@ static int tmio_mmc_next_sg(struct tmio_mmc_host *host)
 
 #define STATUS_TO_TEXT(a, status, i) \
 	do { \
-		if (status & TMIO_STAT_##a) { \
-			if (i++) \
-				printk(" | "); \
-			printk(#a); \
+		if ((status) & TMIO_STAT_##a) { \
+			if ((i)++) \
+				printk(KERN_DEBUG, " | "); \
+			printk(KERN_DEBUG, #a); \
 		} \
 	} while (0)
 
 static void pr_debug_status(u32 status)
 {
 	int i = 0;
+
 	pr_debug("status: %08x = ", status);
 	STATUS_TO_TEXT(CARD_REMOVE, status, i);
 	STATUS_TO_TEXT(CARD_INSERT, status, i);
@@ -181,7 +182,8 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 					~TMIO_SDIO_STAT_IOIRQ;
 
 		/* Clear obsolete interrupts before enabling */
-		sdio_status = sd_ctrl_read16(host, CTL_SDIO_STATUS) & ~TMIO_SDIO_MASK_ALL;
+		sdio_status = sd_ctrl_read16(host, CTL_SDIO_STATUS) &
+			~TMIO_SDIO_MASK_ALL;
 		if (host->pdata->flags & TMIO_MMC_SDIO_STATUS_SETBITS)
 			sdio_status |= TMIO_SDIO_SETBITS_MASK;
 		sd_ctrl_write16(host, CTL_SDIO_STATUS, sdio_status);
@@ -222,7 +224,7 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 }
 
 static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
-				unsigned int new_clock)
+			       unsigned int new_clock)
 {
 	u32 clk = 0, clock;
 
@@ -283,16 +285,16 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 	 * cancel_delayed_work(), it can happen, that a .set_ios() call preempts
 	 * us, so, have to check for IS_ERR(host->mrq)
 	 */
-	if (IS_ERR_OR_NULL(mrq)
-	    || time_is_after_jiffies(host->last_req_ts +
-		msecs_to_jiffies(CMDREQ_TIMEOUT))) {
+	if (IS_ERR_OR_NULL(mrq) ||
+	    time_is_after_jiffies(host->last_req_ts +
+				  msecs_to_jiffies(CMDREQ_TIMEOUT))) {
 		spin_unlock_irqrestore(&host->lock, flags);
 		return;
 	}
 
 	dev_warn(&host->pdev->dev,
-		"timeout waiting for hardware interrupt (CMD%u)\n",
-		mrq->cmd->opcode);
+		 "timeout waiting for hardware interrupt (CMD%u)\n",
+		 mrq->cmd->opcode);
 
 	if (host->data)
 		host->data->error = -ETIMEDOUT;
@@ -330,7 +332,8 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 #define SECURITY_CMD   0x4000
 #define NO_CMD12_ISSUE 0x4000 /* TMIO_MMC_HAVE_CMD12_CTRL */
 
-static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command *cmd)
+static int tmio_mmc_start_command(struct tmio_mmc_host *host,
+				  struct mmc_command *cmd)
 {
 	struct mmc_data *data = host->data;
 	int c = cmd->opcode;
@@ -343,13 +346,22 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
 	}
 
 	switch (mmc_resp_type(cmd)) {
-	case MMC_RSP_NONE: c |= RESP_NONE; break;
+	case MMC_RSP_NONE:
+		c |= RESP_NONE;
+		break;
 	case MMC_RSP_R1:
 	case MMC_RSP_R1_NO_CRC:
-			   c |= RESP_R1;   break;
-	case MMC_RSP_R1B:  c |= RESP_R1B;  break;
-	case MMC_RSP_R2:   c |= RESP_R2;   break;
-	case MMC_RSP_R3:   c |= RESP_R3;   break;
+		c |= RESP_R1;
+		break;
+	case MMC_RSP_R1B:
+		c |= RESP_R1B;
+		break;
+	case MMC_RSP_R2:
+		c |= RESP_R2;
+		break;
+	case MMC_RSP_R3:
+		c |= RESP_R3;
+		break;
 	default:
 		pr_debug("Unknown response type %d\n", mmc_resp_type(cmd));
 		return -EINVAL;
@@ -365,15 +377,18 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
 	if (data) {
 		c |= DATA_PRESENT;
 		if (data->blocks > 1) {
-			sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, TMIO_STOP_SEC);
+			sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION,
+					TMIO_STOP_SEC);
 			c |= TRANSFER_MULTI;
 
 			/*
-			 * Disable auto CMD12 at IO_RW_EXTENDED and SET_BLOCK_COUNT
-			 * when doing multiple block transfer
+			 * Disable auto CMD12 at IO_RW_EXTENDED and
+			 * SET_BLOCK_COUNT when doing multiple block
+			 * transfer
 			 */
 			if ((host->pdata->flags & TMIO_MMC_HAVE_CMD12_CTRL) &&
-			    (cmd->opcode == SD_IO_RW_EXTENDED || host->mrq->sbc))
+			    (cmd->opcode == SD_IO_RW_EXTENDED ||
+			     host->mrq->sbc))
 				c |= NO_CMD12_ISSUE;
 		}
 		if (data->flags & MMC_DATA_READ)
@@ -495,8 +510,6 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 
 	if (host->sg_off == host->sg_ptr->length)
 		tmio_mmc_next_sg(host);
-
-	return;
 }
 
 static void tmio_mmc_check_bounce_buffer(struct tmio_mmc_host *host)
@@ -504,6 +517,7 @@ static void tmio_mmc_check_bounce_buffer(struct tmio_mmc_host *host)
 	if (host->sg_ptr == &host->bounce_sg) {
 		unsigned long flags;
 		void *sg_vaddr = tmio_mmc_kmap_atomic(host->sg_orig, &flags);
+
 		memcpy(sg_vaddr, host->bounce_buf, host->bounce_sg.length);
 		tmio_mmc_kunmap_atomic(host->sg_orig, &flags, sg_vaddr);
 	}
@@ -568,6 +582,7 @@ EXPORT_SYMBOL_GPL(tmio_mmc_do_data_irq);
 static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
 {
 	struct mmc_data *data;
+
 	spin_lock(&host->lock);
 	data = host->data;
 
@@ -577,7 +592,8 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
 	if (stat & TMIO_STAT_CRCFAIL || stat & TMIO_STAT_STOPBIT_ERR ||
 	    stat & TMIO_STAT_TXUNDERRUN)
 		data->error = -EILSEQ;
-	if (host->chan_tx && (data->flags & MMC_DATA_WRITE) && !host->force_pio) {
+	if (host->chan_tx && (data->flags & MMC_DATA_WRITE) &&
+	    !host->force_pio) {
 		u32 status = sd_ctrl_read16_and_16_as_32(host, CTL_STATUS);
 		bool done = false;
 
@@ -601,19 +617,20 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
 			tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_DATAEND);
 			complete(&host->dma_dataend);
 		}
-	} else if (host->chan_rx && (data->flags & MMC_DATA_READ) && !host->force_pio) {
+	} else if (host->chan_rx && (data->flags & MMC_DATA_READ) &&
+		   !host->force_pio) {
 		tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_DATAEND);
 		complete(&host->dma_dataend);
 	} else {
 		tmio_mmc_do_data_irq(host);
-		tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_READOP | TMIO_MASK_WRITEOP);
+		tmio_mmc_disable_mmc_irqs(host,
+					  TMIO_MASK_READOP | TMIO_MASK_WRITEOP);
 	}
 out:
 	spin_unlock(&host->lock);
 }
 
-static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
-	unsigned int stat)
+static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host, unsigned int stat)
 {
 	struct mmc_command *cmd = host->cmd;
 	int i, addr;
@@ -656,12 +673,14 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 	if (host->data && (!cmd->error || cmd->error == -EILSEQ)) {
 		if (host->data->flags & MMC_DATA_READ) {
 			if (host->force_pio || !host->chan_rx)
-				tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_READOP);
+				tmio_mmc_enable_mmc_irqs(host,
+							 TMIO_MASK_READOP);
 			else
 				tasklet_schedule(&host->dma_issue);
 		} else {
 			if (host->force_pio || !host->chan_tx)
-				tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_WRITEOP);
+				tmio_mmc_enable_mmc_irqs(host,
+							 TMIO_MASK_WRITEOP);
 			else
 				tasklet_schedule(&host->dma_issue);
 		}
@@ -674,7 +693,7 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 }
 
 static bool __tmio_mmc_card_detect_irq(struct tmio_mmc_host *host,
-				      int ireg, int status)
+				       int ireg, int status)
 {
 	struct mmc_host *mmc = host->mmc;
 
@@ -692,14 +711,13 @@ static bool __tmio_mmc_card_detect_irq(struct tmio_mmc_host *host,
 	return false;
 }
 
-static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_host *host,
-				 int ireg, int status)
+static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_host *host, int ireg,
+				  int status)
 {
 	/* Command completion */
 	if (ireg & (TMIO_STAT_CMDRESPEND | TMIO_STAT_CMDTIMEOUT)) {
-		tmio_mmc_ack_mmc_irqs(host,
-			     TMIO_STAT_CMDRESPEND |
-			     TMIO_STAT_CMDTIMEOUT);
+		tmio_mmc_ack_mmc_irqs(host, TMIO_STAT_CMDRESPEND |
+				      TMIO_STAT_CMDTIMEOUT);
 		tmio_mmc_cmd_irq(host, status);
 		return true;
 	}
@@ -770,7 +788,7 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
 EXPORT_SYMBOL_GPL(tmio_mmc_irq);
 
 static int tmio_mmc_start_data(struct tmio_mmc_host *host,
-	struct mmc_data *data)
+			       struct mmc_data *data)
 {
 	struct tmio_mmc_data *pdata = host->pdata;
 
@@ -824,8 +842,7 @@ static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		goto out;
 
 	if (host->tap_num * 2 >= sizeof(host->taps) * BITS_PER_BYTE) {
-		dev_warn_once(&host->pdev->dev,
-		      "Too many taps, skipping tuning. Please consider updating size of taps field of tmio_mmc_host\n");
+		dev_warn_once(&host->pdev->dev, "Too many taps, skipping tuning. Please consider updating size of taps field of tmio_mmc_host\n");
 		goto out;
 	}
 
@@ -856,7 +873,8 @@ static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	return ret;
 }
 
-static void tmio_process_mrq(struct tmio_mmc_host *host, struct mmc_request *mrq)
+static void tmio_process_mrq(struct tmio_mmc_host *host,
+			     struct mmc_request *mrq)
 {
 	struct mmc_command *cmd;
 	int ret;
@@ -1024,7 +1042,7 @@ static void tmio_mmc_power_off(struct tmio_mmc_host *host)
 }
 
 static void tmio_mmc_set_bus_width(struct tmio_mmc_host *host,
-				unsigned char bus_width)
+				   unsigned char bus_width)
 {
 	u16 reg = sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT)
 				& ~(CARD_OPT_WIDTH | CARD_OPT_WIDTH8);
@@ -1064,7 +1082,8 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			dev_dbg(dev,
 				"%s.%d: CMD%u active since %lu, now %lu!\n",
 				current->comm, task_pid_nr(current),
-				host->mrq->cmd->opcode, host->last_req_ts, jiffies);
+				host->mrq->cmd->opcode, host->last_req_ts,
+				jiffies);
 		}
 		spin_unlock_irqrestore(&host->lock, flags);
 
@@ -1111,11 +1130,13 @@ static int tmio_mmc_get_ro(struct mmc_host *mmc)
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct tmio_mmc_data *pdata = host->pdata;
 	int ret = mmc_gpio_get_ro(mmc);
+
 	if (ret >= 0)
 		return ret;
 
 	ret = !((pdata->flags & TMIO_MMC_WRPROTECT_DISABLE) ||
-		(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT));
+		(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) &
+		 TMIO_STAT_WRPROTECT));
 
 	return ret;
 }
@@ -1167,6 +1188,7 @@ static void tmio_mmc_of_parse(struct platform_device *pdev,
 			      struct tmio_mmc_data *pdata)
 {
 	const struct device_node *np = pdev->dev.of_node;
+
 	if (!np)
 		return;
 
@@ -1237,7 +1259,8 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 		return -ENOMEM;
 
 	tmio_mmc_ops.card_busy = _host->card_busy;
-	tmio_mmc_ops.start_signal_voltage_switch = _host->start_signal_voltage_switch;
+	tmio_mmc_ops.start_signal_voltage_switch =
+		_host->start_signal_voltage_switch;
 	mmc->ops = &tmio_mmc_ops;
 
 	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
@@ -1284,7 +1307,8 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	tmio_mmc_clk_stop(_host);
 	tmio_mmc_reset(_host);
 
-	_host->sdcard_irq_mask = sd_ctrl_read16_and_16_as_32(_host, CTL_IRQ_MASK);
+	_host->sdcard_irq_mask = sd_ctrl_read16_and_16_as_32(_host,
+							     CTL_IRQ_MASK);
 	tmio_mmc_disable_mmc_irqs(_host, TMIO_MASK_ALL);
 
 	/* Unmask the IRQs we want to know about */
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index c83c16b931a8..26e8f8c0a6db 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -13,15 +13,15 @@
 #define tmio_ioread16(addr) readw(addr)
 #define tmio_ioread16_rep(r, b, l) readsw(r, b, l)
 #define tmio_ioread32(addr) \
-	(((u32) readw((addr))) | (((u32) readw((addr) + 2)) << 16))
+	(((u32)readw((addr))) | (((u32)readw((addr) + 2)) << 16))
 
 #define tmio_iowrite8(val, addr) writeb((val), (addr))
 #define tmio_iowrite16(val, addr) writew((val), (addr))
 #define tmio_iowrite16_rep(r, b, l) writesw(r, b, l)
 #define tmio_iowrite32(val, addr) \
 	do { \
-	writew((val),       (addr)); \
-	writew((val) >> 16, (addr) + 2); \
+		writew((val),       (addr)); \
+		writew((val) >> 16, (addr) + 2); \
 	} while (0)
 
 #define CNF_CMD     0x04
@@ -55,57 +55,57 @@
 	} while (0)
 
 /* tmio MMC platform flags */
-#define TMIO_MMC_WRPROTECT_DISABLE	(1 << 0)
+#define TMIO_MMC_WRPROTECT_DISABLE	BIT(0)
 /*
  * Some controllers can support a 2-byte block size when the bus width
  * is configured in 4-bit mode.
  */
-#define TMIO_MMC_BLKSZ_2BYTES		(1 << 1)
+#define TMIO_MMC_BLKSZ_2BYTES		BIT(1)
 /*
  * Some controllers can support SDIO IRQ signalling.
  */
-#define TMIO_MMC_SDIO_IRQ		(1 << 2)
+#define TMIO_MMC_SDIO_IRQ		BIT(2)
 
 /* Some features are only available or tested on R-Car Gen2 or later */
-#define TMIO_MMC_MIN_RCAR2		(1 << 3)
+#define TMIO_MMC_MIN_RCAR2		BIT(3)
 
 /*
  * Some controllers require waiting for the SD bus to become
  * idle before writing to some registers.
  */
-#define TMIO_MMC_HAS_IDLE_WAIT		(1 << 4)
+#define TMIO_MMC_HAS_IDLE_WAIT		BIT(4)
 /*
  * A GPIO is used for card hotplug detection. We need an extra flag for this,
  * because 0 is a valid GPIO number too, and requiring users to specify
  * cd_gpio < 0 to disable GPIO hotplug would break backwards compatibility.
  */
-#define TMIO_MMC_USE_GPIO_CD		(1 << 5)
+#define TMIO_MMC_USE_GPIO_CD		BIT(5)
 
 /*
  * Some controllers doesn't have over 0x100 register.
  * it is used to checking accessibility of
  * CTL_SD_CARD_CLK_CTL / CTL_CLK_AND_WAIT_CTL
  */
-#define TMIO_MMC_HAVE_HIGH_REG		(1 << 6)
+#define TMIO_MMC_HAVE_HIGH_REG		BIT(6)
 
 /*
  * Some controllers have CMD12 automatically
  * issue/non-issue register
  */
-#define TMIO_MMC_HAVE_CMD12_CTRL	(1 << 7)
+#define TMIO_MMC_HAVE_CMD12_CTRL	BIT(7)
 
 /* Controller has some SDIO status bits which must be 1 */
-#define TMIO_MMC_SDIO_STATUS_SETBITS	(1 << 8)
+#define TMIO_MMC_SDIO_STATUS_SETBITS	BIT(8)
 
 /*
  * Some controllers have a 32-bit wide data port register
  */
-#define TMIO_MMC_32BIT_DATA_PORT	(1 << 9)
+#define TMIO_MMC_32BIT_DATA_PORT	BIT(9)
 
 /*
  * Some controllers allows to set SDx actual clock
  */
-#define TMIO_MMC_CLK_ACTUAL		(1 << 10)
+#define TMIO_MMC_CLK_ACTUAL		BIT(10)
 
 int tmio_core_mmc_enable(void __iomem *cnf, int shift, unsigned long base);
 int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned long base);
@@ -146,9 +146,9 @@ struct tmio_nand_data {
 
 struct tmio_fb_data {
 	int			(*lcd_set_power)(struct platform_device *fb_dev,
-								bool on);
+						 bool on);
 	int			(*lcd_mode)(struct platform_device *fb_dev,
-					const struct fb_videomode *mode);
+					    const struct fb_videomode *mode);
 	int			num_modes;
 	struct fb_videomode	*modes;
 
@@ -157,5 +157,4 @@ struct tmio_fb_data {
 	int			width;
 };
 
-
 #endif
-- 
2.1.4
