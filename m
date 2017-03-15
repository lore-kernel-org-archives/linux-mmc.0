From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 5/5] mmc: meson-gx: switch to descriptor chain mode
Date: Wed, 15 Mar 2017 20:34:46 +0100
Message-ID: <57af6536-edf9-a2aa-40fe-a90338245d0e@gmail.com>
References: <f1f8dae2-e976-4d42-99dc-34d08cb3d628@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33907 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdCOTfE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2017 15:35:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id u132so6330232wmg.1
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2017 12:35:03 -0700 (PDT)
In-Reply-To: <f1f8dae2-e976-4d42-99dc-34d08cb3d628@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Switch the driver from using a linearized bounce buffer to descriptor
chain mode. This drastically improves performance.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 207 ++++++++++++++++++++++------------------
 1 file changed, 116 insertions(+), 91 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 425060da..d561065b 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -121,6 +121,13 @@
 #define SD_EMMC_CFG_CMD_GAP 16 /* in clock cycles */
 #define MUX_CLK_NUM_PARENTS 2
 
+struct sd_emmc_desc {
+	u32 cmd_cfg;
+	u32 cmd_arg;
+	u32 cmd_data;
+	u32 cmd_resp;
+};
+
 struct meson_host {
 	struct	device		*dev;
 	struct	mmc_host	*mmc;
@@ -136,19 +143,12 @@ struct meson_host {
 	struct clk_divider cfg_div;
 	struct clk *cfg_div_clk;
 
-	unsigned int bounce_buf_size;
-	void *bounce_buf;
-	dma_addr_t bounce_dma_addr;
+	struct sd_emmc_desc *descs;
+	dma_addr_t descs_dma_addr;
 
 	bool vqmmc_enabled;
 };
 
-struct sd_emmc_desc {
-	u32 cmd_cfg;
-	u32 cmd_arg;
-	u32 cmd_data;
-	u32 cmd_resp;
-};
 #define CMD_CFG_LENGTH_SHIFT 0
 #define CMD_CFG_LENGTH_MASK 0x1ff
 #define CMD_CFG_BLOCK_MODE BIT(9)
@@ -185,6 +185,36 @@ static struct mmc_command *meson_mmc_get_next_command(struct mmc_command *cmd)
 		return NULL;
 }
 
+static enum dma_data_direction meson_mmc_get_data_dir(struct mmc_data *data)
+{
+	return data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+}
+
+static void meson_mmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct mmc_data *data = mrq->data;
+
+	if (!data)
+		return;
+
+	data->host_cookie = true;
+
+	data->sg_count = dma_map_sg(mmc_dev(mmc), data->sg, data->sg_len,
+				    meson_mmc_get_data_dir(data));
+	if (!data->sg_count)
+		dev_err(mmc_dev(mmc), "dma_map_sg failed");
+}
+
+static void meson_mmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
+			       int err)
+{
+	struct mmc_data *data = mrq->data;
+
+	if (data && data->sg_count)
+		dma_unmap_sg(mmc_dev(mmc), data->sg, data->sg_len,
+			     meson_mmc_get_data_dir(data));
+}
+
 static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
 {
 	struct mmc_host *mmc = host->mmc;
@@ -434,94 +464,91 @@ static void meson_mmc_request_done(struct mmc_host *mmc,
 static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 {
 	struct meson_host *host = mmc_priv(mmc);
-	struct sd_emmc_desc *desc, desc_tmp;
-	u32 cfg;
-	u8 blk_len, cmd_cfg_timeout;
-	unsigned int xfer_bytes = 0;
-
-	/* Setup descriptors */
-	dma_rmb();
-	desc = &desc_tmp;
-	memset(desc, 0, sizeof(struct sd_emmc_desc));
+	struct sd_emmc_desc *desc = host->descs;
+	struct mmc_data *data;
+	struct scatterlist *sg;
+	u32 cfg, cmd_cfg = 0;
+	u8 blk_len;
+	int i;
 
-	desc->cmd_cfg |= (cmd->opcode & CMD_CFG_CMD_INDEX_MASK)	<<
-		CMD_CFG_CMD_INDEX_SHIFT;
-	desc->cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
-	desc->cmd_arg = cmd->arg;
+	cmd_cfg |= (cmd->opcode & CMD_CFG_CMD_INDEX_MASK) <<
+		   CMD_CFG_CMD_INDEX_SHIFT;
+	cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
 
 	/* Response */
 	if (cmd->flags & MMC_RSP_PRESENT) {
-		desc->cmd_cfg &= ~CMD_CFG_NO_RESP;
+		cmd_cfg &= ~CMD_CFG_NO_RESP;
 		if (cmd->flags & MMC_RSP_136)
-			desc->cmd_cfg |= CMD_CFG_RESP_128;
-		desc->cmd_cfg |= CMD_CFG_RESP_NUM;
-		desc->cmd_resp = 0;
+			cmd_cfg |= CMD_CFG_RESP_128;
+		cmd_cfg |= CMD_CFG_RESP_NUM;
 
 		if (!(cmd->flags & MMC_RSP_CRC))
-			desc->cmd_cfg |= CMD_CFG_RESP_NOCRC;
+			cmd_cfg |= CMD_CFG_RESP_NOCRC;
 
 		if (cmd->flags & MMC_RSP_BUSY)
-			desc->cmd_cfg |= CMD_CFG_R1B;
+			cmd_cfg |= CMD_CFG_R1B;
 	} else {
-		desc->cmd_cfg |= CMD_CFG_NO_RESP;
+		cmd_cfg |= CMD_CFG_NO_RESP;
 	}
 
-	/* data? */
-	if (cmd->data) {
-		desc->cmd_cfg |= CMD_CFG_DATA_IO | CMD_CFG_BLOCK_MODE;
-		desc->cmd_cfg |= (cmd->data->blocks & CMD_CFG_LENGTH_MASK) <<
-				 CMD_CFG_LENGTH_SHIFT;
+	data = cmd->data;
+	if (data) {
+		data->bytes_xfered = 0;
+		cmd_cfg |= CMD_CFG_DATA_IO | CMD_CFG_BLOCK_MODE;
+		cmd_cfg |= ilog2(SD_EMMC_CMD_TIMEOUT_DATA) <<
+			   CMD_CFG_TIMEOUT_SHIFT;
+
+		if (data->flags & MMC_DATA_WRITE)
+			cmd_cfg |= CMD_CFG_DATA_WR;
 
 		/* check if block-size matches, if not update */
 		cfg = readl(host->regs + SD_EMMC_CFG);
 		blk_len = cfg & (CFG_BLK_LEN_MASK << CFG_BLK_LEN_SHIFT);
 		blk_len >>= CFG_BLK_LEN_SHIFT;
-		if (blk_len != ilog2(cmd->data->blksz)) {
+		if (blk_len != ilog2(data->blksz)) {
 			dev_dbg(host->dev, "%s: update blk_len %d -> %d\n",
-				__func__, blk_len, ilog2(cmd->data->blksz));
-			blk_len = ilog2(cmd->data->blksz);
+				__func__, blk_len, ilog2(data->blksz));
+			blk_len = ilog2(data->blksz);
 			cfg &= ~(CFG_BLK_LEN_MASK << CFG_BLK_LEN_SHIFT);
 			cfg |= blk_len << CFG_BLK_LEN_SHIFT;
 			writel(cfg, host->regs + SD_EMMC_CFG);
 		}
 
-		cmd->data->bytes_xfered = 0;
-		xfer_bytes = cmd->data->blksz * cmd->data->blocks;
-		if (cmd->data->flags & MMC_DATA_WRITE) {
-			desc->cmd_cfg |= CMD_CFG_DATA_WR;
-			WARN_ON(xfer_bytes > host->bounce_buf_size);
-			sg_copy_to_buffer(cmd->data->sg, cmd->data->sg_len,
-					  host->bounce_buf, xfer_bytes);
-			cmd->data->bytes_xfered = xfer_bytes;
-			dma_wmb();
-		} else {
-			desc->cmd_cfg &= ~CMD_CFG_DATA_WR;
+		for_each_sg(data->sg, sg, data->sg_len, i) {
+			desc[i].cmd_cfg = cmd_cfg;
+			sg_dma_len(sg) = sg->length;
+			desc[i].cmd_cfg |= (sg_dma_len(sg) / data->blksz)
+					   << CMD_CFG_LENGTH_SHIFT;
+			if (i > 0)
+				desc[i].cmd_cfg |= CMD_CFG_NO_CMD;
+			desc[i].cmd_arg = cmd->arg;
+			desc[i].cmd_resp = 0;
+			desc[i].cmd_data = sg_dma_address(sg);
 		}
-
-		desc->cmd_data = host->bounce_dma_addr & CMD_DATA_MASK;
-
-		cmd_cfg_timeout = ilog2(SD_EMMC_CMD_TIMEOUT_DATA);
+		desc[data->sg_len - 1].cmd_cfg |= CMD_CFG_END_OF_CHAIN;
 	} else {
-		desc->cmd_cfg &= ~CMD_CFG_DATA_IO;
-		cmd_cfg_timeout = ilog2(SD_EMMC_CMD_TIMEOUT);
+		cmd_cfg |= ilog2(SD_EMMC_CMD_TIMEOUT) << CMD_CFG_TIMEOUT_SHIFT;
+		cmd_cfg |= CMD_CFG_END_OF_CHAIN;
+		desc[0].cmd_cfg = cmd_cfg;
+		desc[0].cmd_arg = cmd->arg;
+		desc[0].cmd_resp = 0;
+		desc[0].cmd_data = 0;
 	}
-	desc->cmd_cfg |= (cmd_cfg_timeout & CMD_CFG_TIMEOUT_MASK) <<
-		CMD_CFG_TIMEOUT_SHIFT;
 
 	host->cmd = cmd;
 
-	/* Last descriptor */
-	desc->cmd_cfg |= CMD_CFG_END_OF_CHAIN;
-	writel(desc->cmd_cfg, host->regs + SD_EMMC_CMD_CFG);
-	writel(desc->cmd_data, host->regs + SD_EMMC_CMD_DAT);
-	writel(desc->cmd_resp, host->regs + SD_EMMC_CMD_RSP);
 	wmb(); /* ensure descriptor is written before kicked */
-	writel(desc->cmd_arg, host->regs + SD_EMMC_CMD_ARG);
+	cfg = host->descs_dma_addr | START_DESC_BUSY;
+	writel(cfg, host->regs + SD_EMMC_START);
 }
 
 static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct meson_host *host = mmc_priv(mmc);
+	bool needs_pre_post_req = mrq->data && !mrq->data->host_cookie;
+
+	if (needs_pre_post_req)
+		meson_mmc_pre_req(mmc, mrq);
 
 	/* Stop execution */
 	writel(0, host->regs + SD_EMMC_START);
@@ -530,6 +557,9 @@ static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		meson_mmc_start_cmd(mmc, mrq->sbc);
 	else
 		meson_mmc_start_cmd(mmc, mrq->cmd);
+
+	if (needs_pre_post_req)
+		meson_mmc_post_req(mmc, mrq, 0);
 }
 
 static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
@@ -550,6 +580,7 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 {
 	struct meson_host *host = dev_id;
 	struct mmc_command *cmd;
+	struct mmc_data *data;
 	u32 irq_en, status, raw_status;
 	irqreturn_t ret = IRQ_HANDLED;
 
@@ -561,6 +592,8 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (WARN_ON(!cmd))
 		return IRQ_NONE;
 
+	data = cmd->data;
+
 	spin_lock(&host->lock);
 	irq_en = readl(host->regs + SD_EMMC_IRQ_EN);
 	raw_status = readl(host->regs + SD_EMMC_STATUS);
@@ -598,12 +631,17 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 		dev_dbg(host->dev, "Unhandled IRQ: Descriptor timeout\n");
 		cmd->error = -ETIMEDOUT;
 	}
+
+	if (data && !cmd->error)
+		data->bytes_xfered = data->blksz * data->blocks;
+
 	if (status & IRQ_SDIO)
 		dev_dbg(host->dev, "Unhandled IRQ: SDIO.\n");
 
-	if (status & (IRQ_END_OF_CHAIN | IRQ_RESP_STATUS))
-		ret = IRQ_WAKE_THREAD;
-	else  {
+	if (status & (IRQ_END_OF_CHAIN | IRQ_RESP_STATUS)) {
+		if (meson_mmc_get_next_command(cmd))
+			ret = IRQ_WAKE_THREAD;
+	} else  {
 		dev_warn(host->dev, "Unknown IRQ! status=0x%04x: MMC CMD%u arg=0x%08x flags=0x%08x stop=%d\n",
 			 status, cmd->opcode, cmd->arg,
 			 cmd->flags, cmd->mrq->stop ? 1 : 0);
@@ -632,26 +670,12 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 {
 	struct meson_host *host = dev_id;
 	struct mmc_command *next_cmd, *cmd = host->cmd;
-	struct mmc_data *data;
-	unsigned int xfer_bytes;
 
 	if (WARN_ON(!cmd))
 		return IRQ_NONE;
 
-	data = cmd->data;
-	if (data && data->flags & MMC_DATA_READ) {
-		xfer_bytes = data->blksz * data->blocks;
-		WARN_ON(xfer_bytes > host->bounce_buf_size);
-		sg_copy_from_buffer(data->sg, data->sg_len,
-				    host->bounce_buf, xfer_bytes);
-		data->bytes_xfered = xfer_bytes;
-	}
-
 	next_cmd = meson_mmc_get_next_command(cmd);
-	if (next_cmd)
-		meson_mmc_start_cmd(host->mmc, next_cmd);
-	else
-		meson_mmc_request_done(host->mmc, cmd->mrq);
+	meson_mmc_start_cmd(host->mmc, next_cmd);
 
 	return IRQ_HANDLED;
 }
@@ -685,6 +709,8 @@ static const struct mmc_host_ops meson_mmc_ops = {
 	.request	= meson_mmc_request,
 	.set_ios	= meson_mmc_set_ios,
 	.get_cd         = meson_mmc_get_cd,
+	.pre_req	= meson_mmc_pre_req,
+	.post_req	= meson_mmc_post_req,
 };
 
 static int meson_mmc_probe(struct platform_device *pdev)
@@ -764,15 +790,14 @@ static int meson_mmc_probe(struct platform_device *pdev)
 
 	mmc->caps |= MMC_CAP_CMD23;
 	mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
-	mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
-
-	/* data bounce buffer */
-	host->bounce_buf_size = mmc->max_req_size;
-	host->bounce_buf =
-		dma_alloc_coherent(host->dev, host->bounce_buf_size,
-				   &host->bounce_dma_addr, GFP_KERNEL);
-	if (host->bounce_buf == NULL) {
-		dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
+	mmc->max_segs = PAGE_SIZE / sizeof(struct sd_emmc_desc);
+	mmc->max_seg_size = mmc->max_blk_count * mmc->max_blk_size;
+	mmc->max_req_size = mmc->max_seg_size * mmc->max_segs;
+
+	host->descs = dma_alloc_coherent(host->dev, PAGE_SIZE,
+					 &host->descs_dma_addr, GFP_KERNEL);
+	if (!host->descs) {
+		dev_err(host->dev, "Allocating descriptor DMA buffer failed\n");
 		ret = -ENOMEM;
 		goto err_div_clk;
 	}
@@ -797,8 +822,8 @@ static int meson_mmc_remove(struct platform_device *pdev)
 	/* disable interrupts */
 	writel(0, host->regs + SD_EMMC_IRQ_EN);
 
-	dma_free_coherent(host->dev, host->bounce_buf_size,
-			  host->bounce_buf, host->bounce_dma_addr);
+	dma_free_coherent(host->dev, PAGE_SIZE, host->descs,
+			  host->descs_dma_addr);
 
 	clk_disable_unprepare(host->cfg_div_clk);
 	clk_disable_unprepare(host->core_clk);
-- 
2.12.0


