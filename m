From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] mmc: meson-gx: switch to descriptor chain mode
Date: Fri, 31 Mar 2017 07:46:49 +0200
Message-ID: <5a569499-5d5d-8c87-4a88-d6afb0171805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33896 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbdCaFrS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Mar 2017 01:47:18 -0400
Received: by mail-wr0-f196.google.com with SMTP id w43so17469961wrb.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Mar 2017 22:47:16 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Switch the driver from using a linearized bounce buffer to descriptor
chain mode. This drastically improves performance.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
Remark:
- This patch depends on "mmc: sdio: fix alignment issue in struct sdio_func"
  having been applied before, else SDIO is broken.
---
 drivers/mmc/host/meson-gx-mmc.c | 143 ++++++++++++++++++++++++----------------
 1 file changed, 87 insertions(+), 56 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 0036680b..1a64cb91 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -109,8 +109,16 @@
 #define SD_EMMC_CMD_TIMEOUT 1024 /* in ms */
 #define SD_EMMC_CMD_TIMEOUT_DATA 4096 /* in ms */
 #define SD_EMMC_CFG_CMD_GAP 16 /* in clock cycles */
+#define SD_EMMC_DESC_BUF_LEN PAGE_SIZE
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
@@ -126,20 +134,12 @@ struct meson_host {
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
-
 #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
 #define CMD_CFG_BLOCK_MODE BIT(9)
 #define CMD_CFG_R1B BIT(10)
@@ -186,6 +186,31 @@ static struct mmc_command *meson_mmc_get_next_command(struct mmc_command *cmd)
 		return NULL;
 }
 
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
+				    mmc_get_dma_dir(data));
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
+			     mmc_get_dma_dir(data));
+}
+
 static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
 {
 	struct mmc_host *mmc = host->mmc;
@@ -476,9 +501,11 @@ static void meson_mmc_set_response_bits(struct mmc_command *cmd, u32 *cmd_cfg)
 static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 {
 	struct meson_host *host = mmc_priv(mmc);
+	struct sd_emmc_desc *desc = host->descs;
 	struct mmc_data *data = cmd->data;
-	u32 cmd_cfg = 0, cmd_data = 0;
-	unsigned int xfer_bytes = 0;
+	u32 cfg, cmd_cfg = 0;
+	struct scatterlist *sg;
+	int i;
 
 	/* Setup descriptors */
 	dma_rmb();
@@ -490,57 +517,68 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 
 	/* data? */
 	if (data) {
+		data->bytes_xfered = 0;
 		cmd_cfg |= CMD_CFG_DATA_IO;
 		cmd_cfg |= FIELD_PREP(CMD_CFG_TIMEOUT_MASK,
 				      ilog2(meson_mmc_get_timeout_msecs(data)));
+		if (data->flags & MMC_DATA_WRITE)
+			cmd_cfg |= CMD_CFG_DATA_WR;
 
 		if (data->blocks > 1) {
 			cmd_cfg |= CMD_CFG_BLOCK_MODE;
-			cmd_cfg |= FIELD_PREP(CMD_CFG_LENGTH_MASK,
-					      data->blocks);
 			meson_mmc_set_blksz(mmc, data->blksz);
-		} else {
-			cmd_cfg |= FIELD_PREP(CMD_CFG_LENGTH_MASK, data->blksz);
 		}
 
-		data->bytes_xfered = 0;
-		xfer_bytes = data->blksz * data->blocks;
-		if (data->flags & MMC_DATA_WRITE) {
-			cmd_cfg |= CMD_CFG_DATA_WR;
-			WARN_ON(xfer_bytes > host->bounce_buf_size);
-			sg_copy_to_buffer(data->sg, data->sg_len,
-					  host->bounce_buf, xfer_bytes);
-			dma_wmb();
-		}
+		for_each_sg(data->sg, sg, data->sg_count, i) {
+			unsigned int len = sg_dma_len(sg);
+
+			/* check proper alignment for 64 bit DMA */
+			WARN_ON(sg_dma_address(sg) & 0x7);
 
-		cmd_data = host->bounce_dma_addr & CMD_DATA_MASK;
+			if (data->blocks > 1)
+				len /= data->blksz;
+
+			desc[i].cmd_cfg = cmd_cfg;
+			desc[i].cmd_cfg |= FIELD_PREP(CMD_CFG_LENGTH_MASK, len);
+			if (i > 0)
+				desc[i].cmd_cfg |= CMD_CFG_NO_CMD;
+			desc[i].cmd_arg = cmd->arg;
+			desc[i].cmd_resp = 0;
+			desc[i].cmd_data = sg_dma_address(sg);
+		}
+		desc[data->sg_count - 1].cmd_cfg |= CMD_CFG_END_OF_CHAIN;
 	} else {
 		cmd_cfg |= FIELD_PREP(CMD_CFG_TIMEOUT_MASK,
 				      ilog2(SD_EMMC_CMD_TIMEOUT));
+		cmd_cfg |= CMD_CFG_END_OF_CHAIN;
+		desc[0].cmd_cfg = cmd_cfg;
+		desc[0].cmd_arg = cmd->arg;
+		desc[0].cmd_resp = 0;
+		desc[0].cmd_data = 0;
 	}
 
 	host->cmd = cmd;
 
-	/* Last descriptor */
-	cmd_cfg |= CMD_CFG_END_OF_CHAIN;
-	writel(cmd_cfg, host->regs + SD_EMMC_CMD_CFG);
-	writel(cmd_data, host->regs + SD_EMMC_CMD_DAT);
-	writel(0, host->regs + SD_EMMC_CMD_RSP);
 	wmb(); /* ensure descriptor is written before kicked */
-	writel(cmd->arg, host->regs + SD_EMMC_CMD_ARG);
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
 
-	if (mrq->sbc)
-		meson_mmc_start_cmd(mmc, mrq->sbc);
-	else
-		meson_mmc_start_cmd(mmc, mrq->cmd);
+	meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
+
+	if (needs_pre_post_req)
+		meson_mmc_post_req(mmc, mrq, 0);
 }
 
 static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
@@ -618,7 +656,9 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (status & (IRQ_END_OF_CHAIN | IRQ_RESP_STATUS)) {
 		if (data && !cmd->error)
 			data->bytes_xfered = data->blksz * data->blocks;
-		ret = IRQ_WAKE_THREAD;
+
+		if (meson_mmc_get_next_command(cmd))
+			ret = IRQ_WAKE_THREAD;
 	} else {
 		dev_warn(host->dev, "Unknown IRQ! status=0x%04x: MMC CMD%u arg=0x%08x flags=0x%08x stop=%d\n",
 			 status, cmd->opcode, cmd->arg,
@@ -648,20 +688,10 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
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
-	}
-
 	next_cmd = meson_mmc_get_next_command(cmd);
 	if (next_cmd)
 		meson_mmc_start_cmd(host->mmc, next_cmd);
@@ -701,6 +731,8 @@ static const struct mmc_host_ops meson_mmc_ops = {
 	.request	= meson_mmc_request,
 	.set_ios	= meson_mmc_set_ios,
 	.get_cd         = meson_mmc_get_cd,
+	.pre_req	= meson_mmc_pre_req,
+	.post_req	= meson_mmc_post_req,
 };
 
 static int meson_mmc_probe(struct platform_device *pdev)
@@ -781,14 +813,13 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	mmc->caps |= MMC_CAP_CMD23;
 	mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
 	mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
+	mmc->max_segs = SD_EMMC_DESC_BUF_LEN / sizeof(struct sd_emmc_desc);
+	mmc->max_seg_size = mmc->max_req_size;
 
-	/* data bounce buffer */
-	host->bounce_buf_size = mmc->max_req_size;
-	host->bounce_buf =
-		dma_alloc_coherent(host->dev, host->bounce_buf_size,
-				   &host->bounce_dma_addr, GFP_KERNEL);
-	if (host->bounce_buf == NULL) {
-		dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
+	host->descs = dma_alloc_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
+					 &host->descs_dma_addr, GFP_KERNEL);
+	if (!host->descs) {
+		dev_err(host->dev, "Allocating DMA descriptor buffer failed\n");
 		ret = -ENOMEM;
 		goto err_div_clk;
 	}
@@ -816,8 +847,8 @@ static int meson_mmc_remove(struct platform_device *pdev)
 	/* disable interrupts */
 	writel(0, host->regs + SD_EMMC_IRQ_EN);
 
-	dma_free_coherent(host->dev, host->bounce_buf_size,
-			  host->bounce_buf, host->bounce_dma_addr);
+	dma_free_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
+			  host->descs, host->descs_dma_addr);
 
 	clk_disable_unprepare(host->cfg_div_clk);
 	clk_disable_unprepare(host->core_clk);
-- 
2.12.1

