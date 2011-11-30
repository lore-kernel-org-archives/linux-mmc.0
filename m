From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: sh_mmcif: process requests asynchronously
Date: Wed, 30 Nov 2011 16:07:43 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1111301553330.22197@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This patch converts the sh_mmcif MMC host driver to process requests 
asynchronously instead of waiting in its .request() method for completion. 
This is achieved by using threaded IRQs.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 824fee5..d077da4 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -123,6 +124,11 @@
 #define MASK_MRBSYTO		(1 << 1)
 #define MASK_MRSPTO		(1 << 0)
 
+#define START_CMD_MASK		(MASK_MCMDVIO | MASK_MBUFVIO | MASK_MWDATERR | \
+				 MASK_MRDATERR | MASK_MRIDXERR | MASK_MRSPERR | \
+				 MASK_MCCSTO | MASK_MCRCSTO | MASK_MWDATTO | \
+				 MASK_MRDATTO | MASK_MRBSYTO | MASK_MRSPTO)
+
 /* CE_HOST_STS1 */
 #define STS1_CMDSEQ		(1 << 31)
 
@@ -162,19 +169,38 @@ enum mmcif_state {
 	STATE_IOS,
 };
 
+enum mmcif_wait_for {
+	MMCIF_WAIT_FOR_REQUEST,
+	MMCIF_WAIT_FOR_CMD,
+	MMCIF_WAIT_FOR_MREAD,
+	MMCIF_WAIT_FOR_MWRITE,
+	MMCIF_WAIT_FOR_READ,
+	MMCIF_WAIT_FOR_WRITE,
+	MMCIF_WAIT_FOR_READ_END,
+	MMCIF_WAIT_FOR_WRITE_END,
+	MMCIF_WAIT_FOR_STOP,
+};
+
 struct sh_mmcif_host {
 	struct mmc_host *mmc;
 	struct mmc_data *data;
+	struct mmc_request *mrq;
 	struct platform_device *pd;
 	struct clk *hclk;
 	unsigned int clk;
 	int bus_width;
 	bool sd_error;
+	bool dying;
 	long timeout;
 	void __iomem *addr;
-	struct completion intr_wait;
+	u32 *pio_ptr;
+	spinlock_t lock;		/* protect host->state */
 	enum mmcif_state state;
-	spinlock_t lock;
+	enum mmcif_wait_for wait_for;
+	struct delayed_work timeout_work;
+	size_t blocksize;
+	int sg_idx;
+	int sg_blkidx;
 	bool power;
 	bool card_present;
 
@@ -409,7 +435,7 @@ static void sh_mmcif_sync_reset(struct sh_mmcif_host *host)
 static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
 {
 	u32 state1, state2;
-	int ret, timeout = 10000000;
+	int ret, timeout;
 
 	host->sd_error = false;
 
@@ -421,155 +447,97 @@ static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
 	if (state1 & STS1_CMDSEQ) {
 		sh_mmcif_bitset(host, MMCIF_CE_CMD_CTRL, CMD_CTRL_BREAK);
 		sh_mmcif_bitset(host, MMCIF_CE_CMD_CTRL, ~CMD_CTRL_BREAK);
-		while (1) {
-			timeout--;
-			if (timeout < 0) {
-				dev_err(&host->pd->dev,
-					"Forceed end of command sequence timeout err\n");
-				return -EIO;
-			}
+		for (timeout = 10000000; timeout; timeout--) {
 			if (!(sh_mmcif_readl(host->addr, MMCIF_CE_HOST_STS1)
-								& STS1_CMDSEQ))
+			      & STS1_CMDSEQ))
 				break;
 			mdelay(1);
 		}
+		if (!timeout) {
+			dev_err(&host->pd->dev,
+				"Forceed end of command sequence timeout err\n");
+			return -EIO;
+		}
 		sh_mmcif_sync_reset(host);
 		dev_dbg(&host->pd->dev, "Forced end of command sequence\n");
 		return -EIO;
 	}
 
 	if (state2 & STS2_CRC_ERR) {
-		dev_dbg(&host->pd->dev, ": Happened CRC error\n");
+		dev_dbg(&host->pd->dev, ": CRC error\n");
 		ret = -EIO;
 	} else if (state2 & STS2_TIMEOUT_ERR) {
-		dev_dbg(&host->pd->dev, ": Happened Timeout error\n");
+		dev_dbg(&host->pd->dev, ": Timeout\n");
 		ret = -ETIMEDOUT;
 	} else {
-		dev_dbg(&host->pd->dev, ": Happened End/Index error\n");
+		dev_dbg(&host->pd->dev, ": End/Index error\n");
 		ret = -EIO;
 	}
 	return ret;
 }
 
-static int sh_mmcif_single_read(struct sh_mmcif_host *host,
-					struct mmc_request *mrq)
+static void sh_mmcif_single_read(struct sh_mmcif_host *host,
+				 struct mmc_request *mrq)
 {
-	struct mmc_data *data = mrq->data;
-	long time;
-	u32 blocksize, i, *p = sg_virt(data->sg);
+	host->blocksize = (sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET) &
+			   BLOCK_SIZE_MASK) + 3;
+
+	host->wait_for = MMCIF_WAIT_FOR_READ;
+	schedule_delayed_work(&host->timeout_work, host->timeout);
 
 	/* buf read enable */
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
-	time = wait_for_completion_interruptible_timeout(&host->intr_wait,
-			host->timeout);
-	if (time <= 0 || host->sd_error)
-		return sh_mmcif_error_manage(host);
-
-	blocksize = (BLOCK_SIZE_MASK &
-			sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET)) + 3;
-	for (i = 0; i < blocksize / 4; i++)
-		*p++ = sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
-
-	/* buffer read end */
-	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFRE);
-	time = wait_for_completion_interruptible_timeout(&host->intr_wait,
-			host->timeout);
-	if (time <= 0 || host->sd_error)
-		return sh_mmcif_error_manage(host);
-
-	return 0;
 }
 
-static int sh_mmcif_multi_read(struct sh_mmcif_host *host,
-					struct mmc_request *mrq)
+static void sh_mmcif_multi_read(struct sh_mmcif_host *host,
+				struct mmc_request *mrq)
 {
 	struct mmc_data *data = mrq->data;
-	long time;
-	u32 blocksize, i, j, sec, *p;
-
-	blocksize = BLOCK_SIZE_MASK & sh_mmcif_readl(host->addr,
-						     MMCIF_CE_BLOCK_SET);
-	for (j = 0; j < data->sg_len; j++) {
-		p = sg_virt(data->sg);
-		for (sec = 0; sec < data->sg->length / blocksize; sec++) {
-			sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
-			/* buf read enable */
-			time = wait_for_completion_interruptible_timeout(&host->intr_wait,
-				host->timeout);
-
-			if (time <= 0 || host->sd_error)
-				return sh_mmcif_error_manage(host);
-
-			for (i = 0; i < blocksize / 4; i++)
-				*p++ = sh_mmcif_readl(host->addr,
-						      MMCIF_CE_DATA);
-		}
-		if (j < data->sg_len - 1)
-			data->sg++;
-	}
-	return 0;
+
+	if (!data->sg_len || !data->sg->length)
+		return;
+
+	host->blocksize = sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET) &
+		BLOCK_SIZE_MASK;
+
+	host->wait_for = MMCIF_WAIT_FOR_MREAD;
+	host->sg_idx = 0;
+	host->sg_blkidx = 0;
+	host->pio_ptr = sg_virt(data->sg);
+	schedule_delayed_work(&host->timeout_work, host->timeout);
+	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
 }
 
-static int sh_mmcif_single_write(struct sh_mmcif_host *host,
+static void sh_mmcif_single_write(struct sh_mmcif_host *host,
 					struct mmc_request *mrq)
 {
-	struct mmc_data *data = mrq->data;
-	long time;
-	u32 blocksize, i, *p = sg_virt(data->sg);
+	host->blocksize = (sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET) &
+			   BLOCK_SIZE_MASK) + 3;
 
-	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
+	host->wait_for = MMCIF_WAIT_FOR_WRITE;
+	schedule_delayed_work(&host->timeout_work, host->timeout);
 
 	/* buf write enable */
-	time = wait_for_completion_interruptible_timeout(&host->intr_wait,
-			host->timeout);
-	if (time <= 0 || host->sd_error)
-		return sh_mmcif_error_manage(host);
-
-	blocksize = (BLOCK_SIZE_MASK &
-			sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET)) + 3;
-	for (i = 0; i < blocksize / 4; i++)
-		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, *p++);
-
-	/* buffer write end */
-	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MDTRANE);
-
-	time = wait_for_completion_interruptible_timeout(&host->intr_wait,
-			host->timeout);
-	if (time <= 0 || host->sd_error)
-		return sh_mmcif_error_manage(host);
-
-	return 0;
+	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
 }
 
-static int sh_mmcif_multi_write(struct sh_mmcif_host *host,
-						struct mmc_request *mrq)
+static void sh_mmcif_multi_write(struct sh_mmcif_host *host,
+				struct mmc_request *mrq)
 {
 	struct mmc_data *data = mrq->data;
-	long time;
-	u32 i, sec, j, blocksize, *p;
 
-	blocksize = BLOCK_SIZE_MASK & sh_mmcif_readl(host->addr,
-						     MMCIF_CE_BLOCK_SET);
-
-	for (j = 0; j < data->sg_len; j++) {
-		p = sg_virt(data->sg);
-		for (sec = 0; sec < data->sg->length / blocksize; sec++) {
-			sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
-			/* buf write enable*/
-			time = wait_for_completion_interruptible_timeout(&host->intr_wait,
-				host->timeout);
+	if (!data->sg_len || !data->sg->length)
+		return;
 
-			if (time <= 0 || host->sd_error)
-				return sh_mmcif_error_manage(host);
+	host->blocksize = sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET) &
+		BLOCK_SIZE_MASK;
 
-			for (i = 0; i < blocksize / 4; i++)
-				sh_mmcif_writel(host->addr,
-						MMCIF_CE_DATA, *p++);
-		}
-		if (j < data->sg_len - 1)
-			data->sg++;
-	}
-	return 0;
+	host->wait_for = MMCIF_WAIT_FOR_MWRITE;
+	host->sg_idx = 0;
+	host->sg_blkidx = 0;
+	host->pio_ptr = sg_virt(data->sg);
+	schedule_delayed_work(&host->timeout_work, host->timeout);
+	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
 }
 
 static void sh_mmcif_get_response(struct sh_mmcif_host *host,
@@ -666,57 +634,48 @@ static u32 sh_mmcif_set_cmd(struct sh_mmcif_host *host,
 }
 
 static int sh_mmcif_data_trans(struct sh_mmcif_host *host,
-				struct mmc_request *mrq, u32 opc)
+			       struct mmc_request *mrq, u32 opc)
 {
-	int ret;
-
 	switch (opc) {
 	case MMC_READ_MULTIPLE_BLOCK:
-		ret = sh_mmcif_multi_read(host, mrq);
-		break;
+		sh_mmcif_multi_read(host, mrq);
+		return 0;
 	case MMC_WRITE_MULTIPLE_BLOCK:
-		ret = sh_mmcif_multi_write(host, mrq);
-		break;
+		sh_mmcif_multi_write(host, mrq);
+		return 0;
 	case MMC_WRITE_BLOCK:
-		ret = sh_mmcif_single_write(host, mrq);
-		break;
+		sh_mmcif_single_write(host, mrq);
+		return 0;
 	case MMC_READ_SINGLE_BLOCK:
 	case MMC_SEND_EXT_CSD:
-		ret = sh_mmcif_single_read(host, mrq);
-		break;
-	default:
-		dev_err(&host->pd->dev, "UNSUPPORTED CMD = d'%08d\n", opc);
-		ret = -EINVAL;
-		break;
+		sh_mmcif_single_read(host, mrq);
+		return 0;
 	}
-	return ret;
+	dev_err(&host->pd->dev, "UNSUPPORTED CMD = d'%08d\n", opc);
+	return -EINVAL;
 }
 
 static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
-			struct mmc_request *mrq, struct mmc_command *cmd)
+			       struct mmc_request *mrq)
 {
-	long time;
-	int ret = 0, mask = 0;
+	struct mmc_command *cmd = mrq->cmd;
 	u32 opc = cmd->opcode;
+	u32 mask;
 
 	switch (opc) {
-	/* respons busy check */
+	/* response busy check */
 	case MMC_SWITCH:
 	case MMC_STOP_TRANSMISSION:
 	case MMC_SET_WRITE_PROT:
 	case MMC_CLR_WRITE_PROT:
 	case MMC_ERASE:
 	case MMC_GEN_CMD:
-		mask = MASK_MRBSYE;
+		mask = START_CMD_MASK | MASK_MRBSYE;
 		break;
 	default:
-		mask = MASK_MCRSPE;
+		mask = START_CMD_MASK | MASK_MCRSPE;
 		break;
 	}
-	mask |=	MASK_MCMDVIO | MASK_MBUFVIO | MASK_MWDATERR |
-		MASK_MRDATERR | MASK_MRIDXERR | MASK_MRSPERR |
-		MASK_MCCSTO | MASK_MCRCSTO | MASK_MWDATTO |
-		MASK_MRDATTO | MASK_MRBSYTO | MASK_MRSPTO;
 
 	if (host->data) {
 		sh_mmcif_writel(host->addr, MMCIF_CE_BLOCK_SET, 0);
@@ -732,61 +691,14 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
 	/* set cmd */
 	sh_mmcif_writel(host->addr, MMCIF_CE_CMD_SET, opc);
 
-	time = wait_for_completion_interruptible_timeout(&host->intr_wait,
-		host->timeout);
-	if (time <= 0) {
-		cmd->error = sh_mmcif_error_manage(host);
-		return;
-	}
-	if (host->sd_error) {
-		switch (cmd->opcode) {
-		case MMC_ALL_SEND_CID:
-		case MMC_SELECT_CARD:
-		case MMC_APP_CMD:
-			cmd->error = -ETIMEDOUT;
-			break;
-		default:
-			dev_dbg(&host->pd->dev, "Cmd(d'%d) err\n",
-					cmd->opcode);
-			cmd->error = sh_mmcif_error_manage(host);
-			break;
-		}
-		host->sd_error = false;
-		return;
-	}
-	if (!(cmd->flags & MMC_RSP_PRESENT)) {
-		cmd->error = 0;
-		return;
-	}
-	sh_mmcif_get_response(host, cmd);
-	if (host->data) {
-		if (!host->dma_active) {
-			ret = sh_mmcif_data_trans(host, mrq, cmd->opcode);
-		} else {
-			long time =
-				wait_for_completion_interruptible_timeout(&host->dma_complete,
-									  host->timeout);
-			if (!time)
-				ret = -ETIMEDOUT;
-			else if (time < 0)
-				ret = time;
-			sh_mmcif_bitclr(host, MMCIF_CE_BUF_ACC,
-					BUF_ACC_DMAREN | BUF_ACC_DMAWEN);
-			host->dma_active = false;
-		}
-		if (ret < 0)
-			mrq->data->bytes_xfered = 0;
-		else
-			mrq->data->bytes_xfered =
-				mrq->data->blocks * mrq->data->blksz;
-	}
-	cmd->error = ret;
+	host->wait_for = MMCIF_WAIT_FOR_CMD;
+	schedule_delayed_work(&host->timeout_work, host->timeout);
 }
 
 static void sh_mmcif_stop_cmd(struct sh_mmcif_host *host,
-		struct mmc_request *mrq, struct mmc_command *cmd)
+			      struct mmc_request *mrq)
 {
-	long time;
+	struct mmc_command *cmd = mrq->stop;
 
 	if (mrq->cmd->opcode == MMC_READ_MULTIPLE_BLOCK)
 		sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MCMD12DRE);
@@ -798,14 +710,8 @@ static void sh_mmcif_stop_cmd(struct sh_mmcif_host *host,
 		return;
 	}
 
-	time = wait_for_completion_interruptible_timeout(&host->intr_wait,
-			host->timeout);
-	if (time <= 0 || host->sd_error) {
-		cmd->error = sh_mmcif_error_manage(host);
-		return;
-	}
-	sh_mmcif_get_cmd12response(host, cmd);
-	cmd->error = 0;
+	host->wait_for = MMCIF_WAIT_FOR_STOP;
+	schedule_delayed_work(&host->timeout_work, host->timeout);
 }
 
 static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
@@ -813,6 +719,8 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	struct sh_mmcif_host *host = mmc_priv(mmc);
 	unsigned long flags;
 
+	dev_info(mmc->parent, "%s(%u), data %p\n", __func__, mrq->cmd->opcode, mrq->data);
+
 	spin_lock_irqsave(&host->lock, flags);
 	if (host->state != STATE_IDLE) {
 		spin_unlock_irqrestore(&host->lock, flags);
@@ -844,23 +752,11 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	default:
 		break;
 	}
+
+	host->mrq = mrq;
 	host->data = mrq->data;
-	if (mrq->data) {
-		if (mrq->data->flags & MMC_DATA_READ) {
-			if (host->chan_rx)
-				sh_mmcif_start_dma_rx(host);
-		} else {
-			if (host->chan_tx)
-				sh_mmcif_start_dma_tx(host);
-		}
-	}
-	sh_mmcif_start_cmd(host, mrq, mrq->cmd);
-	host->data = NULL;
 
-	if (!mrq->cmd->error && mrq->stop)
-		sh_mmcif_stop_cmd(host, mrq, mrq->stop);
-	host->state = STATE_IDLE;
-	mmc_request_done(mmc, mrq);
+	sh_mmcif_start_cmd(host, mrq);
 }
 
 static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
@@ -935,9 +831,268 @@ static struct mmc_host_ops sh_mmcif_ops = {
 	.get_cd		= sh_mmcif_get_cd,
 };
 
-static void sh_mmcif_detect(struct mmc_host *mmc)
+static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
+{
+	struct mmc_command *cmd = host->mrq->cmd;
+	long time;
+
+	if (host->sd_error) {
+		switch (cmd->opcode) {
+		case MMC_ALL_SEND_CID:
+		case MMC_SELECT_CARD:
+		case MMC_APP_CMD:
+			cmd->error = -ETIMEDOUT;
+			host->sd_error = false;
+			break;
+		default:
+			cmd->error = sh_mmcif_error_manage(host);
+			dev_dbg(&host->pd->dev, "Cmd(d'%d) error %d\n",
+				cmd->opcode, cmd->error);
+			break;
+		}
+		return false;
+	}
+	if (!(cmd->flags & MMC_RSP_PRESENT)) {
+		cmd->error = 0;
+		return false;
+	}
+
+	sh_mmcif_get_response(host, cmd);
+
+	if (!host->data)
+		return false;
+
+	if (host->mrq->data->flags & MMC_DATA_READ) {
+		if (host->chan_rx)
+			sh_mmcif_start_dma_rx(host);
+	} else {
+		if (host->chan_tx)
+			sh_mmcif_start_dma_tx(host);
+	}
+
+	if (!host->dma_active) {
+		host->data->error = sh_mmcif_data_trans(host, host->mrq, cmd->opcode);
+		if (!host->data->error)
+			return true;
+		return false;
+	}
+
+	/* Running in the IRQ thread, can sleep */
+	time = wait_for_completion_interruptible_timeout(&host->dma_complete,
+							 host->timeout);
+	if (host->sd_error) {
+		/* Woken up by an error IRQ: abort DMA */
+		if (host->data->flags & MMC_DATA_READ)
+			dmaengine_terminate_all(host->chan_rx);
+		else
+			dmaengine_terminate_all(host->chan_tx);
+		host->data->error = sh_mmcif_error_manage(host);
+	} else if (!time) {
+		host->data->error = -ETIMEDOUT;
+	} else if (time < 0) {
+		host->data->error = time;
+	}
+	sh_mmcif_bitclr(host, MMCIF_CE_BUF_ACC,
+			BUF_ACC_DMAREN | BUF_ACC_DMAWEN);
+	host->dma_active = false;
+
+	if (host->data->error)
+		host->data->bytes_xfered = 0;
+
+	return false;
+}
+
+static bool sh_mmcif_next_block(struct sh_mmcif_host *host, u32 *p)
 {
-	mmc_detect_change(mmc, 0);
+	struct mmc_data *data = host->mrq->data;
+
+	host->sg_blkidx += host->blocksize;
+
+	/* data->sg->length must be a multiple of host->blocksize? */
+	BUG_ON(host->sg_blkidx > data->sg->length);
+
+	if (host->sg_blkidx == data->sg->length) {
+		host->sg_blkidx = 0;
+		if (++host->sg_idx < data->sg_len)
+			host->pio_ptr = sg_virt(++data->sg);
+	} else {
+		host->pio_ptr = p;
+	}
+
+	if (host->sg_idx == data->sg_len)
+		return false;
+
+	return true;
+}
+
+static bool sh_mmcif_mread_block(struct sh_mmcif_host *host)
+{
+	struct mmc_data *data = host->mrq->data;
+	u32 *p = host->pio_ptr;
+	int i;
+
+	if (host->sd_error) {
+		data->error = sh_mmcif_error_manage(host);
+		return false;
+	}
+
+	BUG_ON(!data->sg->length);
+
+	for (i = 0; i < host->blocksize / 4; i++)
+		*p++ = sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
+
+	if (!sh_mmcif_next_block(host, p))
+		return false;
+
+	schedule_delayed_work(&host->timeout_work, host->timeout);
+	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
+
+	return true;
+}
+
+static bool sh_mmcif_mwrite_block(struct sh_mmcif_host *host)
+{
+	struct mmc_data *data = host->mrq->data;
+	u32 *p = host->pio_ptr;
+	int i;
+
+	if (host->sd_error) {
+		data->error = sh_mmcif_error_manage(host);
+		return false;
+	}
+
+	BUG_ON(!data->sg->length);
+
+	for (i = 0; i < host->blocksize / 4; i++)
+		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, *p++);
+
+	if (!sh_mmcif_next_block(host, p))
+		return false;
+
+	schedule_delayed_work(&host->timeout_work, host->timeout);
+	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
+
+	return true;
+}
+
+static bool sh_mmcif_read_block(struct sh_mmcif_host *host)
+{
+	struct mmc_data *data = host->mrq->data;
+	u32 *p = sg_virt(data->sg);
+	int i;
+
+	if (host->sd_error) {
+		data->error = sh_mmcif_error_manage(host);
+		return false;
+	}
+
+	for (i = 0; i < host->blocksize / 4; i++)
+		*p++ = sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
+
+	/* buffer read end */
+	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFRE);
+	host->wait_for = MMCIF_WAIT_FOR_READ_END;
+
+	return true;
+}
+
+static bool sh_mmcif_write_block(struct sh_mmcif_host *host)
+{
+	struct mmc_data *data = host->mrq->data;
+	u32 *p = sg_virt(data->sg);
+	int i;
+
+	if (host->sd_error) {
+		data->error = sh_mmcif_error_manage(host);
+		return false;
+	}
+
+	for (i = 0; i < host->blocksize / 4; i++)
+		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, *p++);
+
+	/* buffer write end */
+	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MDTRANE);
+	host->wait_for = MMCIF_WAIT_FOR_WRITE_END;
+
+	return true;
+}
+
+static irqreturn_t sh_mmcif_irqt(int irq, void *dev_id)
+{
+	struct sh_mmcif_host *host = dev_id;
+	struct mmc_request *mrq = host->mrq;
+
+	cancel_delayed_work_sync(&host->timeout_work);
+
+	/*
+	 * All handlers return true, if processing continues, and false, if the
+	 * request has to be completed - successfully or not
+	 */
+	switch (host->wait_for) {
+	case MMCIF_WAIT_FOR_REQUEST:
+		/* We're too late, the timeout has already kicked in */
+		return IRQ_HANDLED;
+	case MMCIF_WAIT_FOR_CMD:
+		if (sh_mmcif_end_cmd(host))
+			/* Wait for data */
+			return IRQ_HANDLED;
+		break;
+	case MMCIF_WAIT_FOR_MREAD:
+		if (sh_mmcif_mread_block(host))
+			/* Wait for more data */
+			return IRQ_HANDLED;
+		break;
+	case MMCIF_WAIT_FOR_READ:
+		if (sh_mmcif_read_block(host))
+			/* Wait for data end */
+			return IRQ_HANDLED;
+		break;
+	case MMCIF_WAIT_FOR_MWRITE:
+		if (sh_mmcif_mwrite_block(host))
+			/* Wait data to write */
+			return IRQ_HANDLED;
+		break;
+	case MMCIF_WAIT_FOR_WRITE:
+		if (sh_mmcif_write_block(host))
+			/* Wait for data end */
+			return IRQ_HANDLED;
+		break;
+	case MMCIF_WAIT_FOR_STOP:
+		if (host->sd_error) {
+			mrq->stop->error = sh_mmcif_error_manage(host);
+			break;
+		}
+		sh_mmcif_get_cmd12response(host, mrq->stop);
+		mrq->stop->error = 0;
+		break;
+	case MMCIF_WAIT_FOR_READ_END:
+	case MMCIF_WAIT_FOR_WRITE_END:
+		if (host->sd_error)
+			mrq->data->error = sh_mmcif_error_manage(host);
+		break;
+	default:
+		BUG();
+	}
+
+	if (host->wait_for != MMCIF_WAIT_FOR_STOP) {
+		host->data = NULL;
+
+		if (!mrq->cmd->error && mrq->data && !mrq->data->error)
+			mrq->data->bytes_xfered =
+				mrq->data->blocks * mrq->data->blksz;
+
+		if (mrq->stop && !mrq->cmd->error && (!mrq->data || !mrq->data->error)) {
+			sh_mmcif_stop_cmd(host, mrq);
+			if (!mrq->stop->error)
+				return IRQ_HANDLED;
+		}
+	}
+
+	host->wait_for = MMCIF_WAIT_FOR_REQUEST;
+	host->state = STATE_IDLE;
+	mmc_request_done(host->mmc, mrq);
+
+	return IRQ_HANDLED;
 }
 
 static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
@@ -991,14 +1146,58 @@ static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
 		host->sd_error = true;
 		dev_dbg(&host->pd->dev, "int err state = %08x\n", state);
 	}
-	if (state & ~(INT_CMD12RBE | INT_CMD12CRE))
-		complete(&host->intr_wait);
-	else
+	if (state & ~(INT_CMD12RBE | INT_CMD12CRE)) {
+		if (host->dma_active)
+			mmcif_dma_complete(host);
+		else
+			return IRQ_WAKE_THREAD;
+	} else {
 		dev_dbg(&host->pd->dev, "Unexpected IRQ 0x%x\n", state);
+	}
 
 	return IRQ_HANDLED;
 }
 
+static void mmcif_timeout_work(struct work_struct *work)
+{
+	struct delayed_work *d = container_of(work, struct delayed_work, work);
+	struct sh_mmcif_host *host = container_of(d, struct sh_mmcif_host, timeout_work);
+	struct mmc_request *mrq = host->mrq;
+
+	if (host->dying)
+		/* Don't run after mmc_remove_host() */
+		return;
+
+	/*
+	 * Handle races with cancel_delayed_work(), unless
+	 * cancel_delayed_work_sync() is used
+	 */
+	switch (host->wait_for) {
+	case MMCIF_WAIT_FOR_CMD:
+		mrq->cmd->error = sh_mmcif_error_manage(host);
+		break;
+	case MMCIF_WAIT_FOR_STOP:
+		mrq->stop->error = sh_mmcif_error_manage(host);
+		break;
+	case MMCIF_WAIT_FOR_MREAD:
+	case MMCIF_WAIT_FOR_MWRITE:
+	case MMCIF_WAIT_FOR_READ:
+	case MMCIF_WAIT_FOR_WRITE:
+	case MMCIF_WAIT_FOR_READ_END:
+	case MMCIF_WAIT_FOR_WRITE_END:
+		host->data->error = sh_mmcif_error_manage(host);
+		break;
+	default:
+		BUG();
+	}
+
+	host->state = STATE_IDLE;
+	host->wait_for = MMCIF_WAIT_FOR_REQUEST;
+	host->data = NULL;
+	host->mrq = NULL;
+	mmc_request_done(host->mmc, mrq);
+}
+
 static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 {
 	int ret = 0, irq[2];
@@ -1052,7 +1251,6 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	host->clk = clk_get_rate(host->hclk);
 	host->pd = pdev;
 
-	init_completion(&host->intr_wait);
 	spin_lock_init(&host->lock);
 
 	mmc->ops = &sh_mmcif_ops;
@@ -1089,19 +1287,21 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 
 	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
 
-	ret = request_irq(irq[0], sh_mmcif_intr, 0, "sh_mmc:error", host);
+	ret = request_threaded_irq(irq[0], sh_mmcif_intr, sh_mmcif_irqt, 0, "sh_mmc:error", host);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq error (sh_mmc:error)\n");
 		goto clean_up3;
 	}
-	ret = request_irq(irq[1], sh_mmcif_intr, 0, "sh_mmc:int", host);
+	ret = request_threaded_irq(irq[1], sh_mmcif_intr, sh_mmcif_irqt, 0, "sh_mmc:int", host);
 	if (ret) {
 		free_irq(irq[0], host);
 		dev_err(&pdev->dev, "request_irq error (sh_mmc:int)\n");
 		goto clean_up3;
 	}
 
-	sh_mmcif_detect(host->mmc);
+	INIT_DELAYED_WORK(&host->timeout_work, mmcif_timeout_work);
+
+	mmc_detect_change(host->mmc, 0);
 
 	dev_info(&pdev->dev, "driver version %s\n", DRIVER_VERSION);
 	dev_dbg(&pdev->dev, "chip ver H'%04x\n",
@@ -1127,11 +1327,19 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
 	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
 	int irq[2];
 
+	host->dying = true;
 	pm_runtime_get_sync(&pdev->dev);
 
 	mmc_remove_host(host->mmc);
 	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
 
+	/*
+	 * FIXME: cancel_delayed_work(_sync)() and free_irq() race with the
+	 * mmc_remove_host() call above. But swapping order doesn't help either
+	 * (a query on the linux-mmc mailing list didn't bring any replies).
+	 */
+	cancel_delayed_work_sync(&host->timeout_work);
+
 	if (host->addr)
 		iounmap(host->addr);
 
