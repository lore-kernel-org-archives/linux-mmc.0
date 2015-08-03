From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] mmc: dw_mmc: Fix coding style issues
Date: Mon,  3 Aug 2015 15:07:21 +0800
Message-ID: <1438585641-18946-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.130]:35800 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbbHCHK6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Aug 2015 03:10:58 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, dianders@chromium.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

This patch fixes the following issues reported by checkpatch.pl:
- use -EINVAL instead of -ENOSYS, to fix warning message:
   "ENOSYS means 'invalid syscall nr' and nothing else"
- split lines whose length is greater than 80 characters
- avoid quoted string split across lines
- use min_t instead of min, to fix warning message:
   "min() should probably be min_t(int, cnt, host->part_buf_count)"
- fix missing a blank line after declarations

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- Keep consistency of comments
- Rebase on https://patchwork.kernel.org/patch/6672581

 drivers/mmc/host/dw_mmc.c | 90 +++++++++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 34 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index e41fb74..3f070d9 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -238,8 +238,8 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 	struct dw_mci *host = slot->host;
 	const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
 	u32 cmdr;
-	cmd->error = -EINPROGRESS;
 
+	cmd->error = -EINPROGRESS;
 	cmdr = cmd->opcode;
 
 	if (cmd->opcode == MMC_STOP_TRANSMISSION ||
@@ -374,7 +374,7 @@ static void dw_mci_start_command(struct dw_mci *host,
 		 cmd->arg, cmd_flags);
 
 	mci_writel(host, CMDARG, cmd->arg);
-	wmb();
+	wmb(); /* drain writebuffer */
 	dw_mci_wait_while_busy(host, cmd_flags);
 
 	mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START);
@@ -383,6 +383,7 @@ static void dw_mci_start_command(struct dw_mci *host,
 static inline void send_stop_abort(struct dw_mci *host, struct mmc_data *data)
 {
 	struct mmc_command *stop = data->stop ? data->stop : &host->stop_abort;
+
 	dw_mci_start_command(host, stop, host->stop_cmdr);
 }
 
@@ -467,6 +468,7 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
 {
 	unsigned int desc_len;
 	int i;
+
 	if (host->dma_64bit_address == 1) {
 		struct idmac_desc_64addr *desc_first, *desc_last, *desc;
 
@@ -474,6 +476,7 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
 
 		for (i = 0; i < sg_len; i++) {
 			unsigned int length = sg_dma_len(&data->sg[i]);
+
 			u64 mem_addr = sg_dma_address(&data->sg[i]);
 
 			for ( ; length ; desc++) {
@@ -518,6 +521,7 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
 
 		for (i = 0; i < sg_len; i++) {
 			unsigned int length = sg_dma_len(&data->sg[i]);
+
 			u32 mem_addr = sg_dma_address(&data->sg[i]);
 
 			for ( ; length ; desc++) {
@@ -557,7 +561,7 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
 		desc_last->des0 |= cpu_to_le32(IDMAC_DES0_LD);
 	}
 
-	wmb();
+	wmb(); /* drain writebuffer */
 }
 
 static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
@@ -575,6 +579,7 @@ static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
 	temp |= SDMMC_CTRL_USE_IDMAC;
 	mci_writel(host, CTRL, temp);
 
+	/* drain writebuffer */
 	wmb();
 
 	/* Enable the IDMAC */
@@ -622,7 +627,9 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 		host->ring_size = PAGE_SIZE / sizeof(struct idmac_desc);
 
 		/* Forward link the descriptor list */
-		for (i = 0, p = host->sg_cpu; i < host->ring_size - 1; i++, p++) {
+		for (i = 0, p = host->sg_cpu;
+		     i < host->ring_size - 1;
+		     i++, p++) {
 			p->des3 = cpu_to_le32(host->sg_dma +
 					(sizeof(struct idmac_desc) * (i + 1)));
 			p->des1 = 0;
@@ -751,7 +758,7 @@ static void dw_mci_adjust_fifoth(struct dw_mci *host, struct mmc_data *data)
 	u32 fifo_width = 1 << host->data_shift;
 	u32 blksz_depth = blksz / fifo_width, fifoth_val;
 	u32 msize = 0, rx_wmark = 1, tx_wmark, tx_wmark_invers;
-	int idx = (sizeof(mszs) / sizeof(mszs[0])) - 1;
+	int idx = ARRAY_SIZE(mszs) - 1;
 
 	tx_wmark = (host->fifo_depth) / 2;
 	tx_wmark_invers = host->fifo_depth - tx_wmark;
@@ -876,6 +883,7 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
 static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
 {
 	unsigned long irqflags;
+	int flags = SG_MITER_ATOMIC;
 	u32 temp;
 
 	data->error = -EINPROGRESS;
@@ -892,7 +900,6 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
 	}
 
 	if (dw_mci_submit_data_dma(host, data)) {
-		int flags = SG_MITER_ATOMIC;
 		if (host->data->flags & MMC_DATA_READ)
 			flags |= SG_MITER_TO_SG;
 		else
@@ -939,7 +946,7 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
 	unsigned int cmd_status = 0;
 
 	mci_writel(host, CMDARG, arg);
-	wmb();
+	wmb(); /* drain writebuffer */
 	dw_mci_wait_while_busy(host, cmd);
 	mci_writel(host, CMD, SDMMC_CMD_START | cmd);
 
@@ -1052,7 +1059,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
 
 	if (data) {
 		dw_mci_submit_data(host, data);
-		wmb();
+		wmb(); /* drain writebuffer */
 	}
 
 	dw_mci_start_command(host, cmd, cmdflags);
@@ -1417,14 +1424,15 @@ static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
-	int err = -ENOSYS;
+	int err = -EINVAL;
 
 	if (drv_data && drv_data->execute_tuning)
 		err = drv_data->execute_tuning(slot);
 	return err;
 }
 
-static int dw_mci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
+static int dw_mci_prepare_hs400_tuning(struct mmc_host *mmc,
+				       struct mmc_ios *ios)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
@@ -1776,7 +1784,7 @@ static int dw_mci_push_part_bytes(struct dw_mci *host, void *buf, int cnt)
 /* pull first bytes from part_buf, only use during pull */
 static int dw_mci_pull_part_bytes(struct dw_mci *host, void *buf, int cnt)
 {
-	cnt = min(cnt, (int)host->part_buf_count);
+	cnt = min_t(int, cnt, host->part_buf_count);
 	if (cnt) {
 		memcpy(buf, (void *)&host->part_buf + host->part_buf_start,
 		       cnt);
@@ -1802,6 +1810,7 @@ static void dw_mci_push_data16(struct dw_mci *host, void *buf, int cnt)
 	/* try and push anything in the part_buf */
 	if (unlikely(host->part_buf_count)) {
 		int len = dw_mci_push_part_bytes(host, buf, cnt);
+
 		buf += len;
 		cnt -= len;
 		if (host->part_buf_count == 2) {
@@ -1828,6 +1837,7 @@ static void dw_mci_push_data16(struct dw_mci *host, void *buf, int cnt)
 #endif
 	{
 		u16 *pdata = buf;
+
 		for (; cnt >= 2; cnt -= 2)
 			mci_fifo_writew(host->fifo_reg, *pdata++);
 		buf = pdata;
@@ -1852,6 +1862,7 @@ static void dw_mci_pull_data16(struct dw_mci *host, void *buf, int cnt)
 			int len = min(cnt & -2, (int)sizeof(aligned_buf));
 			int items = len >> 1;
 			int i;
+
 			for (i = 0; i < items; ++i)
 				aligned_buf[i] = mci_fifo_readw(host->fifo_reg);
 			/* memcpy from aligned buffer into output buffer */
@@ -1863,6 +1874,7 @@ static void dw_mci_pull_data16(struct dw_mci *host, void *buf, int cnt)
 #endif
 	{
 		u16 *pdata = buf;
+
 		for (; cnt >= 2; cnt -= 2)
 			*pdata++ = mci_fifo_readw(host->fifo_reg);
 		buf = pdata;
@@ -1881,6 +1893,7 @@ static void dw_mci_push_data32(struct dw_mci *host, void *buf, int cnt)
 	/* try and push anything in the part_buf */
 	if (unlikely(host->part_buf_count)) {
 		int len = dw_mci_push_part_bytes(host, buf, cnt);
+
 		buf += len;
 		cnt -= len;
 		if (host->part_buf_count == 4) {
@@ -1907,6 +1920,7 @@ static void dw_mci_push_data32(struct dw_mci *host, void *buf, int cnt)
 #endif
 	{
 		u32 *pdata = buf;
+
 		for (; cnt >= 4; cnt -= 4)
 			mci_fifo_writel(host->fifo_reg, *pdata++);
 		buf = pdata;
@@ -1931,6 +1945,7 @@ static void dw_mci_pull_data32(struct dw_mci *host, void *buf, int cnt)
 			int len = min(cnt & -4, (int)sizeof(aligned_buf));
 			int items = len >> 2;
 			int i;
+
 			for (i = 0; i < items; ++i)
 				aligned_buf[i] = mci_fifo_readl(host->fifo_reg);
 			/* memcpy from aligned buffer into output buffer */
@@ -1942,6 +1957,7 @@ static void dw_mci_pull_data32(struct dw_mci *host, void *buf, int cnt)
 #endif
 	{
 		u32 *pdata = buf;
+
 		for (; cnt >= 4; cnt -= 4)
 			*pdata++ = mci_fifo_readl(host->fifo_reg);
 		buf = pdata;
@@ -1960,6 +1976,7 @@ static void dw_mci_push_data64(struct dw_mci *host, void *buf, int cnt)
 	/* try and push anything in the part_buf */
 	if (unlikely(host->part_buf_count)) {
 		int len = dw_mci_push_part_bytes(host, buf, cnt);
+
 		buf += len;
 		cnt -= len;
 
@@ -1987,6 +2004,7 @@ static void dw_mci_push_data64(struct dw_mci *host, void *buf, int cnt)
 #endif
 	{
 		u64 *pdata = buf;
+
 		for (; cnt >= 8; cnt -= 8)
 			mci_fifo_writeq(host->fifo_reg, *pdata++);
 		buf = pdata;
@@ -2011,6 +2029,7 @@ static void dw_mci_pull_data64(struct dw_mci *host, void *buf, int cnt)
 			int len = min(cnt & -8, (int)sizeof(aligned_buf));
 			int items = len >> 3;
 			int i;
+
 			for (i = 0; i < items; ++i)
 				aligned_buf[i] = mci_fifo_readq(host->fifo_reg);
 
@@ -2023,6 +2042,7 @@ static void dw_mci_pull_data64(struct dw_mci *host, void *buf, int cnt)
 #endif
 	{
 		u64 *pdata = buf;
+
 		for (; cnt >= 8; cnt -= 8)
 			*pdata++ = mci_fifo_readq(host->fifo_reg);
 		buf = pdata;
@@ -2098,7 +2118,7 @@ static void dw_mci_read_data_pio(struct dw_mci *host, bool dto)
 done:
 	sg_miter_stop(sg_miter);
 	host->sg = NULL;
-	smp_wmb();
+	smp_wmb(); /* drain writebuffer */
 	set_bit(EVENT_XFER_COMPLETE, &host->pending_events);
 }
 
@@ -2152,7 +2172,7 @@ static void dw_mci_write_data_pio(struct dw_mci *host)
 done:
 	sg_miter_stop(sg_miter);
 	host->sg = NULL;
-	smp_wmb();
+	smp_wmb(); /* drain writebuffer */
 	set_bit(EVENT_XFER_COMPLETE, &host->pending_events);
 }
 
@@ -2161,7 +2181,7 @@ static void dw_mci_cmd_interrupt(struct dw_mci *host, u32 status)
 	if (!host->cmd_status)
 		host->cmd_status = status;
 
-	smp_wmb();
+	smp_wmb(); /* drain writebuffer */
 
 	set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
 	tasklet_schedule(&host->tasklet);
@@ -2225,7 +2245,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		if (pending & DW_MCI_CMD_ERROR_FLAGS) {
 			mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
 			host->cmd_status = pending;
-			smp_wmb();
+			smp_wmb(); /* drain writebuffer */
 			set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
 		}
 
@@ -2233,7 +2253,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			/* if there is an error report DATA_ERROR */
 			mci_writel(host, RINTSTS, DW_MCI_DATA_ERROR_FLAGS);
 			host->data_status = pending;
-			smp_wmb();
+			smp_wmb(); /* drain writebuffer */
 			set_bit(EVENT_DATA_ERROR, &host->pending_events);
 			tasklet_schedule(&host->tasklet);
 		}
@@ -2242,7 +2262,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			mci_writel(host, RINTSTS, SDMMC_INT_DATA_OVER);
 			if (!host->data_status)
 				host->data_status = pending;
-			smp_wmb();
+			smp_wmb(); /* drain writebuffer */
 			if (host->dir_status == DW_MCI_RECV_STATUS) {
 				if (host->sg != NULL)
 					dw_mci_read_data_pio(host, true);
@@ -2506,8 +2526,8 @@ static void dw_mci_init_dma(struct dw_mci *host)
 	if (host->dma_ops->init && host->dma_ops->start &&
 	    host->dma_ops->stop && host->dma_ops->cleanup) {
 		if (host->dma_ops->init(host)) {
-			dev_err(host->dev, "%s: Unable to initialize "
-				"DMA Controller.\n", __func__);
+			dev_err(host->dev, "%s: Unable to initialize DMA Controller.\n",
+				__func__);
 			goto no_dma;
 		}
 	} else {
@@ -2521,7 +2541,6 @@ static void dw_mci_init_dma(struct dw_mci *host)
 no_dma:
 	dev_info(host->dev, "Using PIO mode.\n");
 	host->use_dma = 0;
-	return;
 }
 
 static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset)
@@ -2575,6 +2594,7 @@ static bool dw_mci_reset(struct dw_mci *host)
 		if (host->use_dma) {
 			unsigned long timeout = jiffies + msecs_to_jiffies(500);
 			u32 status;
+
 			do {
 				status = mci_readl(host, STATUS);
 				if (!(status & SDMMC_STATUS_DMA_REQ))
@@ -2584,8 +2604,8 @@ static bool dw_mci_reset(struct dw_mci *host)
 
 			if (status & SDMMC_STATUS_DMA_REQ) {
 				dev_err(host->dev,
-					"%s: Timeout waiting for dma_req to "
-					"clear during reset\n", __func__);
+					"%s: Timeout waiting for dma_req to clear during reset\n",
+					__func__);
 				goto ciu_out;
 			}
 
@@ -2596,8 +2616,8 @@ static bool dw_mci_reset(struct dw_mci *host)
 	} else {
 		/* if the controller reset bit did clear, then set clock regs */
 		if (!(mci_readl(host, CTRL) & SDMMC_CTRL_RESET)) {
-			dev_err(host->dev, "%s: fifo/dma reset bits didn't "
-				"clear but ciu was reset, doing clock update\n",
+			dev_err(host->dev,
+				"%s: fifo/dma reset bits didn't clear but ciu was reset, doing clock update\n",
 				__func__);
 			goto ciu_out;
 		}
@@ -2658,8 +2678,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	/* find out number of slots supported */
 	if (of_property_read_u32(dev->of_node, "num-slots",
 				&pdata->num_slots)) {
-		dev_info(dev, "num-slots property not found, "
-				"assuming 1 slot is available\n");
+		dev_info(dev,
+			 "num-slots property not found, assuming 1 slot is available\n");
 		pdata->num_slots = 1;
 	}
 
@@ -2669,8 +2689,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 			pdata->quirks |= of_quirks[idx].id;
 
 	if (of_property_read_u32(np, "fifo-depth", &pdata->fifo_depth))
-		dev_info(dev, "fifo-depth property not found, using "
-				"value of FIFOTH register as default\n");
+		dev_info(dev,
+			 "fifo-depth property not found, using value of FIFOTH register as default\n");
 
 	of_property_read_u32(np, "card-detect-delay", &pdata->detect_delay_ms);
 
@@ -2907,11 +2927,11 @@ int dw_mci_probe(struct dw_mci *host)
 	mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
 		   SDMMC_INT_TXDR | SDMMC_INT_RXDR |
 		   DW_MCI_ERROR_FLAGS);
-	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE); /* Enable mci interrupt */
+	/* Enable mci interrupt */
+	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
 
-	dev_info(host->dev, "DW MMC controller at irq %d, "
-		 "%d bit host data width, "
-		 "%u deep fifo\n",
+	dev_info(host->dev,
+		 "DW MMC controller at irq %d,%d bit host data width,%u deep fifo\n",
 		 host->irq, width, fifo_size);
 
 	/* We need at least one slot to succeed */
@@ -2926,8 +2946,9 @@ int dw_mci_probe(struct dw_mci *host)
 	if (init_slots) {
 		dev_info(host->dev, "%d slots initialized\n", init_slots);
 	} else {
-		dev_dbg(host->dev, "attempted to initialize %d slots, "
-					"but failed on all\n", host->num_slots);
+		dev_dbg(host->dev,
+			"attempted to initialize %d slots, but failed on all\n",
+			host->num_slots);
 		goto err_dmaunmap;
 	}
 
@@ -3025,6 +3046,7 @@ int dw_mci_resume(struct dw_mci *host)
 
 	for (i = 0; i < host->num_slots; i++) {
 		struct dw_mci_slot *slot = host->slot[i];
+
 		if (!slot)
 			continue;
 		if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER) {
-- 
2.3.7


