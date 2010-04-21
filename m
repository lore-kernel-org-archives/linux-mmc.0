From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4/8] MMC: add DMA support to tmio_mmc driver, when used on
 SuperH
Date: Wed, 21 Apr 2010 17:37:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1004211733400.5292@axis700.grange>
References: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:55008 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755755Ab0DUPhG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Apr 2010 11:37:06 -0400
In-Reply-To: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>

SDHI controllers on SuperH, served by the tmio_mmc driver, can use slave DMA
for data transfer. This patch adds support for the dmaengine API to tmio_mmc
and the necessary interfacing to the sh_mobile_sdhi MFD driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

It could be further broken down into MMC and MFD parts if required, I 
think.

 drivers/mfd/sh_mobile_sdhi.c       |   25 +++-
 drivers/mmc/host/tmio_mmc.c        |  346 ++++++++++++++++++++++++++++++++----
 drivers/mmc/host/tmio_mmc.h        |   11 ++
 include/linux/mfd/sh_mobile_sdhi.h |    3 +
 include/linux/mfd/tmio.h           |   10 +
 5 files changed, 359 insertions(+), 36 deletions(-)

diff --git a/drivers/mfd/sh_mobile_sdhi.c b/drivers/mfd/sh_mobile_sdhi.c
index 468fd36..c368254 100644
--- a/drivers/mfd/sh_mobile_sdhi.c
+++ b/drivers/mfd/sh_mobile_sdhi.c
@@ -25,11 +25,15 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mfd/sh_mobile_sdhi.h>
+#include <linux/sh_dma.h>
 
 struct sh_mobile_sdhi {
 	struct clk *clk;
 	struct tmio_mmc_data mmc_data;
 	struct mfd_cell cell_mmc;
+	struct sh_dmae_slave param_tx;
+	struct sh_dmae_slave param_rx;
+	struct tmio_mmc_dma dma_priv;
 };
 
 static struct resource sh_mobile_sdhi_resources[] = {
@@ -63,6 +67,8 @@ static void sh_mobile_sdhi_set_pwr(struct platform_device *tmio, int state)
 static int __init sh_mobile_sdhi_probe(struct platform_device *pdev)
 {
 	struct sh_mobile_sdhi *priv;
+	struct tmio_mmc_data *mmc_data;
+	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 	struct resource *mem;
 	char clk_name[8];
 	int ret, irq;
@@ -84,6 +90,8 @@ static int __init sh_mobile_sdhi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	mmc_data = &priv->mmc_data;
+
 	snprintf(clk_name, sizeof(clk_name), "sdhi%d", pdev->id);
 	priv->clk = clk_get(&pdev->dev, clk_name);
 	if (IS_ERR(priv->clk)) {
@@ -95,12 +103,21 @@ static int __init sh_mobile_sdhi_probe(struct platform_device *pdev)
 
 	clk_enable(priv->clk);
 
-	priv->mmc_data.hclk = clk_get_rate(priv->clk);
-	priv->mmc_data.set_pwr = sh_mobile_sdhi_set_pwr;
-	priv->mmc_data.capabilities = MMC_CAP_MMC_HIGHSPEED;
+	mmc_data->hclk = clk_get_rate(priv->clk);
+	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
+	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
+
+	if (p && p->dma_slave_tx >= 0 && p->dma_slave_rx >= 0) {
+		priv->param_tx.slave_id = p->dma_slave_tx;
+		priv->param_rx.slave_id = p->dma_slave_rx;
+		priv->dma_priv.chan_priv_tx = &priv->param_tx;
+		priv->dma_priv.chan_priv_rx = &priv->param_rx;
+		mmc_data->dma = &priv->dma_priv;
+		mmc_data->flags = p->tmio_flags;
+	}
 
 	memcpy(&priv->cell_mmc, &sh_mobile_sdhi_cell, sizeof(priv->cell_mmc));
-	priv->cell_mmc.driver_data = &priv->mmc_data;
+	priv->cell_mmc.driver_data = mmc_data;
 	priv->cell_mmc.platform_data = &priv->cell_mmc;
 	priv->cell_mmc.data_size = sizeof(priv->cell_mmc);
 
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index b2b577f..fafd8c9 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -29,12 +29,21 @@
 #include <linux/irq.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
 #include <linux/mmc/host.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/tmio.h>
 
 #include "tmio_mmc.h"
 
+static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
+{
+#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
+	/* Switch DMA mode on or off - SuperH specific? */
+	sd_ctrl_write16(host, 0xd8, enable ? 2 : 0);
+#endif
+}
+
 static void tmio_mmc_set_clock(struct tmio_mmc_host *host, int new_clock)
 {
 	u32 clk = 0, clock;
@@ -131,8 +140,8 @@ tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command *cmd)
 
 	host->cmd = cmd;
 
-/* FIXME - this seems to be ok comented out but the spec suggest this bit should
- *         be set when issuing app commands.
+/* FIXME - this seems to be ok commented out but the spec suggest this bit
+ *         should be set when issuing app commands.
  *	if(cmd->flags & MMC_FLAG_ACMD)
  *		c |= APP_CMD;
  */
@@ -155,12 +164,12 @@ tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command *cmd)
 	return 0;
 }
 
-/* This chip always returns (at least?) as much data as you ask for.
+/*
+ * This chip always returns (at least?) as much data as you ask for.
  * I'm unsure what happens if you ask for less than a block. This should be
  * looked into to ensure that a funny length read doesnt hose the controller.
- *
  */
-static inline void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
+static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 {
 	struct mmc_data *data = host->data;
 	unsigned short *buf;
@@ -180,7 +189,7 @@ static inline void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 		count = data->blksz;
 
 	pr_debug("count: %08x offset: %08x flags %08x\n",
-	    count, host->sg_off, data->flags);
+		 count, host->sg_off, data->flags);
 
 	/* Transfer the data */
 	if (data->flags & MMC_DATA_READ)
@@ -198,15 +207,13 @@ static inline void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 	return;
 }
 
-static inline void tmio_mmc_data_irq(struct tmio_mmc_host *host)
+static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
 {
 	struct mmc_data *data = host->data;
 	struct mmc_command *stop;
 
-	host->data = NULL;
-
 	if (!data) {
-		pr_debug("Spurious data end IRQ\n");
+		dev_warn(&host->pdev->dev, "Spurious data end IRQ\n");
 		return;
 	}
 	stop = data->stop;
@@ -227,10 +234,17 @@ static inline void tmio_mmc_data_irq(struct tmio_mmc_host *host)
 	 *        upper layers expect. For now, we do what works.
 	 */
 
-	if (data->flags & MMC_DATA_READ)
-		disable_mmc_irqs(host, TMIO_MASK_READOP);
-	else
-		disable_mmc_irqs(host, TMIO_MASK_WRITEOP);
+	if (data->flags & MMC_DATA_READ) {
+		if (!host->chan_rx)
+			disable_mmc_irqs(host, TMIO_MASK_READOP);
+		dev_dbg(&host->pdev->dev, "Complete Rx cookie %d, request %p\n",
+			host->cookie, host->mrq);
+	} else {
+		if (!host->chan_tx)
+			disable_mmc_irqs(host, TMIO_MASK_WRITEOP);
+		dev_dbg(&host->pdev->dev, "Complete Tx cookie %d, request %p\n",
+			host->cookie, host->mrq);
+	}
 
 	if (stop) {
 		if (stop->opcode == 12 && !stop->arg)
@@ -242,7 +256,35 @@ static inline void tmio_mmc_data_irq(struct tmio_mmc_host *host)
 	tmio_mmc_finish_request(host);
 }
 
-static inline void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
+static void tmio_mmc_isr_data_irq(struct tmio_mmc_host *host)
+{
+	struct mmc_data *data = host->data;
+
+	if (!data)
+		return;
+
+	if ((data->flags & MMC_DATA_WRITE) && host->chan_tx) {
+		/*
+		 * Has all data been written out yet? Testing on SuperH showed,
+		 * that in most cases the first interrupt comes already with the
+		 * BUSY status bit clear, but on some operations, like mount or
+		 * in the beginning of a write / sync / umount, there is one
+		 * DATAEND interrupt with the BUSY bit set, in this cases
+		 * waiting for one more interrupt fixes the problem.
+		 */
+		if (!(sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_CMD_BUSY)) {
+			disable_mmc_irqs(host, TMIO_STAT_DATAEND);
+			tasklet_schedule(&host->dma_complete);
+		}
+	} else if ((data->flags & MMC_DATA_READ) && host->chan_rx) {
+		disable_mmc_irqs(host, TMIO_STAT_DATAEND);
+		tasklet_schedule(&host->dma_complete);
+	} else {
+		tmio_mmc_data_irq(host);
+	}
+}
+
+static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 	unsigned int stat)
 {
 	struct mmc_command *cmd = host->cmd;
@@ -282,10 +324,16 @@ static inline void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 	 * If theres no data or we encountered an error, finish now.
 	 */
 	if (host->data && !cmd->error) {
-		if (host->data->flags & MMC_DATA_READ)
-			enable_mmc_irqs(host, TMIO_MASK_READOP);
-		else
-			enable_mmc_irqs(host, TMIO_MASK_WRITEOP);
+		if (host->data->flags & MMC_DATA_READ) {
+			if (!host->chan_rx)
+				enable_mmc_irqs(host, TMIO_MASK_READOP);
+		} else {
+			struct dma_chan *chan = host->chan_tx;
+			if (!chan)
+				enable_mmc_irqs(host, TMIO_MASK_WRITEOP);
+			else
+				tasklet_schedule(&host->dma_issue);
+		}
 	} else {
 		tmio_mmc_finish_request(host);
 	}
@@ -293,7 +341,6 @@ static inline void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 	return;
 }
 
-
 static irqreturn_t tmio_mmc_irq(int irq, void *devid)
 {
 	struct tmio_mmc_host *host = devid;
@@ -311,7 +358,7 @@ static irqreturn_t tmio_mmc_irq(int irq, void *devid)
 	if (!ireg) {
 		disable_mmc_irqs(host, status & ~irq_mask);
 
-		pr_debug("tmio_mmc: Spurious irq, disabling! "
+		pr_warning("tmio_mmc: Spurious irq, disabling! "
 			"0x%08x 0x%08x 0x%08x\n", status, irq_mask, ireg);
 		pr_debug_status(status);
 
@@ -346,7 +393,7 @@ static irqreturn_t tmio_mmc_irq(int irq, void *devid)
 		/* Data transfer completion */
 		if (ireg & TMIO_STAT_DATAEND) {
 			ack_mmc_irqs(host, TMIO_STAT_DATAEND);
-			tmio_mmc_data_irq(host);
+			tmio_mmc_isr_data_irq(host);
 		}
 
 		/* Check status - keep going until we've handled it all */
@@ -363,16 +410,157 @@ out:
 	return IRQ_HANDLED;
 }
 
+static void tmio_dma_complete(void *arg)
+{
+	struct tmio_mmc_host *host = arg;
+	struct mfd_cell	*cell = host->pdev->dev.platform_data;
+	struct tmio_mmc_data *pdata = cell->driver_data;
+
+	dev_dbg(&host->pdev->dev, "Command completed\n");
+
+	if (!host->data)
+		dev_warn(&host->pdev->dev, "NULL data in DMA completion!\n");
+	else if ((host->data->flags & MMC_DATA_READ) &&
+		 (pdata->flags & TMIO_IMMEDIATE_RX_COMPLETE))
+		tasklet_schedule(&host->dma_complete);
+	else
+		enable_mmc_irqs(host, TMIO_STAT_DATAEND);
+}
+
+static int tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
+{
+	struct scatterlist *sg = host->sg_ptr;
+	struct dma_async_tx_descriptor *desc = NULL;
+	struct dma_chan *chan = host->chan_rx;
+	int ret;
+
+	ret = dma_map_sg(&host->pdev->dev, sg, host->sg_len, DMA_FROM_DEVICE);
+	if (ret > 0) {
+		host->dma_sglen = ret;
+		desc = chan->device->device_prep_slave_sg(chan, sg, ret,
+			DMA_FROM_DEVICE, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	}
+
+	if (desc) {
+		host->desc = desc;
+		desc->callback = tmio_dma_complete;
+		desc->callback_param = host;
+		host->cookie = desc->tx_submit(desc);
+		if (host->cookie < 0) {
+			host->desc = NULL;
+			ret = host->cookie;
+		} else {
+			chan->device->device_issue_pending(chan);
+		}
+	}
+	dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
+		__func__, host->sg_len, ret, host->cookie, host->mrq);
+
+	if (!host->desc) {
+		/* DMA failed, fall back to PIO */
+		if (ret >= 0)
+			ret = -EIO;
+		host->chan_rx = NULL;
+		dma_release_channel(chan);
+		/* Free the Tx channel too */
+		chan = host->chan_tx;
+		if (chan) {
+			host->chan_tx = NULL;
+			dma_release_channel(chan);
+		}
+		dev_warn(&host->pdev->dev,
+			 "DMA failed: %d, falling back to PIO\n", ret);
+		tmio_mmc_enable_dma(host, false);
+		reset(host);
+		/* Fail this request, let above layers recover */
+		host->mrq->cmd->error = ret;
+		tmio_mmc_finish_request(host);
+	}
+
+	dev_dbg(&host->pdev->dev, "%s(): desc %p, cookie %d, sg[%d]\n", __func__,
+		desc, host->cookie, host->sg_len);
+
+	return ret > 0 ? 0 : ret;
+}
+
+static int tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
+{
+	struct scatterlist *sg = host->sg_ptr;
+	struct dma_async_tx_descriptor *desc = NULL;
+	struct dma_chan *chan = host->chan_tx;
+	int ret;
+
+	ret = dma_map_sg(&host->pdev->dev, sg, host->sg_len, DMA_TO_DEVICE);
+	if (ret > 0) {
+		host->dma_sglen = ret;
+		desc = chan->device->device_prep_slave_sg(chan, sg, ret,
+			DMA_TO_DEVICE, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	}
+
+	if (desc) {
+		host->desc = desc;
+		desc->callback = tmio_dma_complete;
+		desc->callback_param = host;
+		host->cookie = desc->tx_submit(desc);
+		if (host->cookie < 0) {
+			host->desc = NULL;
+			ret = host->cookie;
+		}
+	}
+	dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
+		__func__, host->sg_len, ret, host->cookie, host->mrq);
+
+	if (!host->desc) {
+		/* DMA failed, fall back to PIO */
+		if (ret >= 0)
+			ret = -EIO;
+		host->chan_tx = NULL;
+		dma_release_channel(chan);
+		/* Free the Rx channel too */
+		chan = host->chan_rx;
+		if (chan) {
+			host->chan_rx = NULL;
+			dma_release_channel(chan);
+		}
+		dev_warn(&host->pdev->dev,
+			 "DMA failed: %d, falling back to PIO\n", ret);
+		tmio_mmc_enable_dma(host, false);
+		reset(host);
+		/* Fail this request, let above layers recover */
+		host->mrq->cmd->error = ret;
+		tmio_mmc_finish_request(host);
+	}
+
+	dev_dbg(&host->pdev->dev, "%s(): desc %p, cookie %d\n", __func__,
+		desc, host->cookie);
+
+	return ret > 0 ? 0 : ret;
+}
+
+static int tmio_mmc_start_dma(struct tmio_mmc_host *host,
+			       struct mmc_data *data)
+{
+	if (data->flags & MMC_DATA_READ) {
+		if (host->chan_rx)
+			return tmio_mmc_start_dma_rx(host);
+	} else {
+		if (host->chan_tx)
+			return tmio_mmc_start_dma_tx(host);
+	}
+
+	return 0;
+}
+
 static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 	struct mmc_data *data)
 {
 	pr_debug("setup data transfer: blocksize %08x  nr_blocks %d\n",
-	    data->blksz, data->blocks);
+		 data->blksz, data->blocks);
 
 	/* Hardware cannot perform 1 and 2 byte requests in 4 bit mode */
 	if (data->blksz < 4 && host->mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
-		printk(KERN_ERR "%s: %d byte block unsupported in 4 bit mode\n",
-			mmc_hostname(host->mmc), data->blksz);
+		pr_err("%s: %d byte block unsupported in 4 bit mode\n",
+		       mmc_hostname(host->mmc), data->blksz);
 		return -EINVAL;
 	}
 
@@ -383,7 +571,7 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 	sd_ctrl_write16(host, CTL_SD_XFER_LEN, data->blksz);
 	sd_ctrl_write16(host, CTL_XFER_BLK_COUNT, data->blocks);
 
-	return 0;
+	return tmio_mmc_start_dma(host, data);
 }
 
 /* Process requests from the MMC layer */
@@ -404,7 +592,6 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	}
 
 	ret = tmio_mmc_start_command(host, mrq->cmd);
-
 	if (!ret)
 		return;
 
@@ -459,10 +646,10 @@ static int tmio_mmc_get_ro(struct mmc_host *mmc)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 
-	return (sd_ctrl_read16(host, CTL_STATUS) & TMIO_STAT_WRPROTECT) ? 0 : 1;
+	return (sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT) ? 0 : 1;
 }
 
-static struct mmc_host_ops tmio_mmc_ops = {
+static const struct mmc_host_ops tmio_mmc_ops = {
 	.request	= tmio_mmc_request,
 	.set_ios	= tmio_mmc_set_ios,
 	.get_ro         = tmio_mmc_get_ro,
@@ -507,6 +694,92 @@ out:
 #define tmio_mmc_resume NULL
 #endif
 
+static void tmio_issue_tasklet_fn(unsigned long priv)
+{
+	struct tmio_mmc_host *host = (struct tmio_mmc_host *)priv;
+	struct dma_chan *chan = host->chan_tx;
+
+	chan->device->device_issue_pending(chan);
+}
+
+static void tmio_tasklet_fn(unsigned long arg)
+{
+	struct tmio_mmc_host *host = (struct tmio_mmc_host *)arg;
+
+	if (host->data->flags & MMC_DATA_READ)
+		dma_unmap_sg(&host->pdev->dev, host->sg_ptr, host->dma_sglen,
+			     DMA_FROM_DEVICE);
+	else
+		dma_unmap_sg(&host->pdev->dev, host->sg_ptr, host->dma_sglen,
+			     DMA_TO_DEVICE);
+
+	tmio_mmc_data_irq(host);
+}
+
+/* It might be necessary to make filter MFD specific */
+static bool filter(struct dma_chan *chan, void *arg)
+{
+	dev_dbg(chan->device->dev, "%s: slave data %p\n", __func__, arg);
+	chan->private = arg;
+	return true;
+}
+
+static void tmio_mmc_request_dma(struct tmio_mmc_host *host,
+				 struct tmio_mmc_data *pdata)
+{
+	host->cookie = -EINVAL;
+	host->desc = NULL;
+
+	/* We can only either use DMA for both Tx and Rx or not use it at all */
+	if (pdata->dma) {
+		dma_cap_mask_t mask;
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+
+		host->chan_tx = dma_request_channel(mask, filter,
+						    pdata->dma->chan_priv_tx);
+		dev_dbg(&host->pdev->dev, "%s: TX: got channel %p\n", __func__,
+			host->chan_tx);
+
+		if (!host->chan_tx)
+			return;
+
+		host->chan_rx = dma_request_channel(mask, filter,
+						    pdata->dma->chan_priv_rx);
+		dev_dbg(&host->pdev->dev, "%s: RX: got channel %p\n", __func__,
+			host->chan_rx);
+
+		if (!host->chan_rx) {
+			dma_release_channel(host->chan_tx);
+			host->chan_tx = NULL;
+			return;
+		}
+
+		tasklet_init(&host->dma_complete, tmio_tasklet_fn, (unsigned long)host);
+		tasklet_init(&host->dma_issue, tmio_issue_tasklet_fn, (unsigned long)host);
+
+		tmio_mmc_enable_dma(host, true);
+	}
+}
+
+static void tmio_mmc_release_dma(struct tmio_mmc_host *host)
+{
+	if (host->chan_tx) {
+		struct dma_chan *chan = host->chan_tx;
+		host->chan_tx = NULL;
+		dma_release_channel(chan);
+	}
+	if (host->chan_rx) {
+		struct dma_chan *chan = host->chan_rx;
+		host->chan_rx = NULL;
+		dma_release_channel(chan);
+	}
+
+	host->cookie = -EINVAL;
+	host->desc = NULL;
+}
+
 static int __devinit tmio_mmc_probe(struct platform_device *dev)
 {
 	struct mfd_cell	*cell = (struct mfd_cell *)dev->dev.platform_data;
@@ -515,6 +788,7 @@ static int __devinit tmio_mmc_probe(struct platform_device *dev)
 	struct tmio_mmc_host *host;
 	struct mmc_host *mmc;
 	int ret = -EINVAL;
+	u32 irq_mask = TMIO_MASK_CMD;
 
 	if (dev->num_resources != 2)
 		goto out;
@@ -578,13 +852,20 @@ static int __devinit tmio_mmc_probe(struct platform_device *dev)
 	if (ret)
 		goto cell_disable;
 
+	/* See if we also get DMA */
+	tmio_mmc_request_dma(host, pdata);
+
 	mmc_add_host(mmc);
 
-	printk(KERN_INFO "%s at 0x%08lx irq %d\n", mmc_hostname(host->mmc),
-	       (unsigned long)host->ctl, host->irq);
+	pr_info("%s at 0x%08lx irq %d\n", mmc_hostname(host->mmc),
+		(unsigned long)host->ctl, host->irq);
 
 	/* Unmask the IRQs we want to know about */
-	enable_mmc_irqs(host, TMIO_MASK_IRQ);
+	if (!host->chan_rx)
+		irq_mask |= TMIO_MASK_READOP;
+	if (!host->chan_tx)
+		irq_mask |= TMIO_MASK_WRITEOP;
+	enable_mmc_irqs(host, irq_mask);
 
 	return 0;
 
@@ -609,6 +890,7 @@ static int __devexit tmio_mmc_remove(struct platform_device *dev)
 	if (mmc) {
 		struct tmio_mmc_host *host = mmc_priv(mmc);
 		mmc_remove_host(mmc);
+		tmio_mmc_release_dma(host);
 		free_irq(host->irq, host);
 		if (cell->disable)
 			cell->disable(dev);
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index dafecfb..1008d1e 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -10,6 +10,8 @@
  */
 
 #include <linux/highmem.h>
+#include <linux/interrupt.h>
+#include <linux/dmaengine.h>
 
 #define CTL_SD_CMD 0x00
 #define CTL_ARG_REG 0x04
@@ -106,6 +108,15 @@ struct tmio_mmc_host {
 	unsigned int            sg_off;
 
 	struct platform_device *pdev;
+
+	/* DMA support */
+	struct dma_chan		*chan_rx;
+	struct dma_chan		*chan_tx;
+	struct dma_async_tx_descriptor *desc;
+	unsigned int            dma_sglen;
+	struct tasklet_struct	dma_complete;
+	struct tasklet_struct	dma_issue;
+	dma_cookie_t		cookie;
 };
 
 #include <linux/io.h>
diff --git a/include/linux/mfd/sh_mobile_sdhi.h b/include/linux/mfd/sh_mobile_sdhi.h
index 3bcd716..c7b47f8 100644
--- a/include/linux/mfd/sh_mobile_sdhi.h
+++ b/include/linux/mfd/sh_mobile_sdhi.h
@@ -2,6 +2,9 @@
 #define __SH_MOBILE_SDHI_H__
 
 struct sh_mobile_sdhi_info {
+	int dma_slave_tx;
+	int dma_slave_rx;
+	unsigned long tmio_flags;
 	void (*set_pwr)(struct platform_device *pdev, int state);
 };
 
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index c3f7dff..9882b45 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -55,12 +55,22 @@ int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned long base);
 void tmio_core_mmc_pwr(void __iomem *cnf, int shift, int state);
 void tmio_core_mmc_clk_div(void __iomem *cnf, int shift, int state);
 
+struct tmio_mmc_dma {
+	void *chan_priv_tx;
+	void *chan_priv_rx;
+};
+
+/* MFD flags */
+#define TMIO_IMMEDIATE_RX_COMPLETE	(1 << 0)
+
 /*
  * data for the MMC controller
  */
 struct tmio_mmc_data {
 	unsigned int			hclk;
 	unsigned long			capabilities;
+	unsigned long			flags;
+	struct tmio_mmc_dma		*dma;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 };
-- 
1.6.2.4

