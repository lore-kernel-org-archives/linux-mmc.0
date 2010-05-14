From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4c/9 v5] mmc: add DMA support to tmio_mmc driver, when used
 on SuperH
Date: Fri, 14 May 2010 21:18:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005142112190.6147@axis700.grange>
References: <Pine.LNX.4.64.1005131554030.4671@axis700.grange>
 <Pine.LNX.4.64.1005131608490.4671@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:55115 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757120Ab0ENTS2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 14 May 2010 15:18:28 -0400
In-Reply-To: <Pine.LNX.4.64.1005131608490.4671@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: dan.j.williams@intel.com, Magnus Damm <magnus.damm@gmail.com>, sameo@linux.intel.com, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

SDHI controllers on SuperH, served by the tmio_mmc driver, can use slave DMA
for data transfer. This patch adds support for the dmaengine API to the
tmio_mmc driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v4 -> v5:

1. renamed CONFIG_MFD_TMIO_DMA to CONFIG_TMIO_MMC_DMA
2. removed bogus "select MFD_CORE"

 drivers/mfd/Kconfig         |    6 +
 drivers/mmc/host/tmio_mmc.c |  361 +++++++++++++++++++++++++++++++++++++++----
 drivers/mmc/host/tmio_mmc.h |   13 ++
 3 files changed, 348 insertions(+), 32 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 2a5a0b7..45f404b 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -49,6 +49,7 @@ config MFD_SH_MOBILE_SDHI
 	bool "Support for SuperH Mobile SDHI"
 	depends on SUPERH || ARCH_SHMOBILE
 	select MFD_CORE
+	select TMIO_MMC_DMA
 	 ---help---
 	  This driver supports the SDHI hardware block found in many
 	  SuperH Mobile SoCs.
@@ -158,6 +159,11 @@ config MFD_TMIO
 	bool
 	default n
 
+config TMIO_MMC_DMA
+	bool
+	select DMA_ENGINE
+	select DMADEVICES
+
 config MFD_T7L66XB
 	bool "Support Toshiba T7L66XB"
 	depends on ARM && HAVE_CLK
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index b2b577f..4c9b308 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -29,6 +29,7 @@
 #include <linux/irq.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
 #include <linux/mmc/host.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/tmio.h>
@@ -131,8 +132,8 @@ tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command *cmd)
 
 	host->cmd = cmd;
 
-/* FIXME - this seems to be ok comented out but the spec suggest this bit should
- *         be set when issuing app commands.
+/* FIXME - this seems to be ok commented out but the spec suggest this bit
+ *         should be set when issuing app commands.
  *	if(cmd->flags & MMC_FLAG_ACMD)
  *		c |= APP_CMD;
  */
@@ -155,12 +156,12 @@ tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command *cmd)
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
@@ -180,7 +181,7 @@ static inline void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 		count = data->blksz;
 
 	pr_debug("count: %08x offset: %08x flags %08x\n",
-	    count, host->sg_off, data->flags);
+		 count, host->sg_off, data->flags);
 
 	/* Transfer the data */
 	if (data->flags & MMC_DATA_READ)
@@ -198,15 +199,13 @@ static inline void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 	return;
 }
 
-static inline void tmio_mmc_data_irq(struct tmio_mmc_host *host)
+static void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
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
@@ -219,7 +218,8 @@ static inline void tmio_mmc_data_irq(struct tmio_mmc_host *host)
 
 	pr_debug("Completed data request\n");
 
-	/*FIXME - other drivers allow an optional stop command of any given type
+	/*
+	 * FIXME: other drivers allow an optional stop command of any given type
 	 *        which we dont do, as the chip can auto generate them.
 	 *        Perhaps we can be smarter about when to use auto CMD12 and
 	 *        only issue the auto request when we know this is the desired
@@ -227,10 +227,17 @@ static inline void tmio_mmc_data_irq(struct tmio_mmc_host *host)
 	 *        upper layers expect. For now, we do what works.
 	 */
 
-	if (data->flags & MMC_DATA_READ)
-		disable_mmc_irqs(host, TMIO_MASK_READOP);
-	else
-		disable_mmc_irqs(host, TMIO_MASK_WRITEOP);
+	if (data->flags & MMC_DATA_READ) {
+		if (!host->chan_rx)
+			disable_mmc_irqs(host, TMIO_MASK_READOP);
+		dev_dbg(&host->pdev->dev, "Complete Rx request %p\n",
+			host->mrq);
+	} else {
+		if (!host->chan_tx)
+			disable_mmc_irqs(host, TMIO_MASK_WRITEOP);
+		dev_dbg(&host->pdev->dev, "Complete Tx request %p\n",
+			host->mrq);
+	}
 
 	if (stop) {
 		if (stop->opcode == 12 && !stop->arg)
@@ -242,7 +249,35 @@ static inline void tmio_mmc_data_irq(struct tmio_mmc_host *host)
 	tmio_mmc_finish_request(host);
 }
 
-static inline void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
+static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
+{
+	struct mmc_data *data = host->data;
+
+	if (!data)
+		return;
+
+	if (host->chan_tx && (data->flags & MMC_DATA_WRITE)) {
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
+	} else if (host->chan_rx && (data->flags & MMC_DATA_READ)) {
+		disable_mmc_irqs(host, TMIO_STAT_DATAEND);
+		tasklet_schedule(&host->dma_complete);
+	} else {
+		tmio_mmc_do_data_irq(host);
+	}
+}
+
+static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 	unsigned int stat)
 {
 	struct mmc_command *cmd = host->cmd;
@@ -282,10 +317,16 @@ static inline void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
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
@@ -293,7 +334,6 @@ static inline void tmio_mmc_cmd_irq(struct tmio_mmc_host *host,
 	return;
 }
 
-
 static irqreturn_t tmio_mmc_irq(int irq, void *devid)
 {
 	struct tmio_mmc_host *host = devid;
@@ -311,7 +351,7 @@ static irqreturn_t tmio_mmc_irq(int irq, void *devid)
 	if (!ireg) {
 		disable_mmc_irqs(host, status & ~irq_mask);
 
-		pr_debug("tmio_mmc: Spurious irq, disabling! "
+		pr_warning("tmio_mmc: Spurious irq, disabling! "
 			"0x%08x 0x%08x 0x%08x\n", status, irq_mask, ireg);
 		pr_debug_status(status);
 
@@ -363,16 +403,265 @@ out:
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_TMIO_MMC_DMA
+static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
+{
+#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
+	/* Switch DMA mode on or off - SuperH specific? */
+	sd_ctrl_write16(host, 0xd8, enable ? 2 : 0);
+#endif
+}
+
+static void tmio_dma_complete(void *arg)
+{
+	struct tmio_mmc_host *host = arg;
+
+	dev_dbg(&host->pdev->dev, "Command completed\n");
+
+	if (!host->data)
+		dev_warn(&host->pdev->dev, "NULL data in DMA completion!\n");
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
+	tmio_mmc_do_data_irq(host);
+}
+
+/* It might be necessary to make filter MFD specific */
+static bool tmio_mmc_filter(struct dma_chan *chan, void *arg)
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
+		host->chan_tx = dma_request_channel(mask, tmio_mmc_filter,
+						    pdata->dma->chan_priv_tx);
+		dev_dbg(&host->pdev->dev, "%s: TX: got channel %p\n", __func__,
+			host->chan_tx);
+
+		if (!host->chan_tx)
+			return;
+
+		host->chan_rx = dma_request_channel(mask, tmio_mmc_filter,
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
+#else
+static int tmio_mmc_start_dma(struct tmio_mmc_host *host,
+			       struct mmc_data *data)
+{
+	return 0;
+}
+
+static void tmio_mmc_request_dma(struct tmio_mmc_host *host,
+				 struct tmio_mmc_data *pdata)
+{
+	host->chan_tx = NULL;
+	host->chan_rx = NULL;
+}
+
+static void tmio_mmc_release_dma(struct tmio_mmc_host *host)
+{
+}
+#endif
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
 
@@ -383,7 +672,7 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 	sd_ctrl_write16(host, CTL_SD_XFER_LEN, data->blksz);
 	sd_ctrl_write16(host, CTL_XFER_BLK_COUNT, data->blocks);
 
-	return 0;
+	return tmio_mmc_start_dma(host, data);
 }
 
 /* Process requests from the MMC layer */
@@ -404,7 +693,6 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	}
 
 	ret = tmio_mmc_start_command(host, mrq->cmd);
-
 	if (!ret)
 		return;
 
@@ -459,10 +747,10 @@ static int tmio_mmc_get_ro(struct mmc_host *mmc)
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
@@ -515,6 +803,7 @@ static int __devinit tmio_mmc_probe(struct platform_device *dev)
 	struct tmio_mmc_host *host;
 	struct mmc_host *mmc;
 	int ret = -EINVAL;
+	u32 irq_mask = TMIO_MASK_CMD;
 
 	if (dev->num_resources != 2)
 		goto out;
@@ -578,13 +867,20 @@ static int __devinit tmio_mmc_probe(struct platform_device *dev)
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
 
@@ -609,6 +905,7 @@ static int __devexit tmio_mmc_remove(struct platform_device *dev)
 	if (mmc) {
 		struct tmio_mmc_host *host = mmc_priv(mmc);
 		mmc_remove_host(mmc);
+		tmio_mmc_release_dma(host);
 		free_irq(host->irq, host);
 		if (cell->disable)
 			cell->disable(dev);
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index dafecfb..64f7d5d 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -10,6 +10,8 @@
  */
 
 #include <linux/highmem.h>
+#include <linux/interrupt.h>
+#include <linux/dmaengine.h>
 
 #define CTL_SD_CMD 0x00
 #define CTL_ARG_REG 0x04
@@ -106,6 +108,17 @@ struct tmio_mmc_host {
 	unsigned int            sg_off;
 
 	struct platform_device *pdev;
+
+	/* DMA support */
+	struct dma_chan		*chan_rx;
+	struct dma_chan		*chan_tx;
+	struct tasklet_struct	dma_complete;
+	struct tasklet_struct	dma_issue;
+#ifdef CONFIG_TMIO_MMC_DMA
+	struct dma_async_tx_descriptor *desc;
+	unsigned int            dma_sglen;
+	dma_cookie_t		cookie;
+#endif
 };
 
 #include <linux/io.h>
-- 
1.6.2.4

