From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 5/6] mmc: sh_mmcif: add DMA support
Date: Thu, 11 Nov 2010 08:41:00 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1011110835330.15747@axis700.grange>
References: <Pine.LNX.4.64.1011110815070.15747@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:48284 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1757794Ab0KKHk7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Nov 2010 02:40:59 -0500
In-Reply-To: <Pine.LNX.4.64.1011110815070.15747@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>

The MMCIF controller on sh-mobile platforms can use the DMA controller for data
transfers. Interface to the SH dmaengine driver to enable DMA.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

...This has been a nice exception: just one missing piece of the datasheet 
puzzle had to be guessed and it worked straight away just as expected;) At 
least so far... Nice!

 drivers/mmc/host/Kconfig     |    6 +
 drivers/mmc/host/sh_mmcif.c  |  239 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/mmc/sh_mmcif.h |   15 ++-
 3 files changed, 254 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index d618e86..859e352 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -466,6 +466,12 @@ config MMC_SH_MMCIF
 
 	  This driver supports MMCIF in sh7724/sh7757/sh7372.
 
+config SH_MMCIF_DMA
+	bool "Use DMA for MMCIF"
+	depends on MMC_SH_MMCIF
+	help
+	  Use SH dma-engine driver for data transfer
+
 config MMC_JZ4740
 	tristate "JZ4740 SD/Multimedia Card Interface support"
 	depends on MACH_JZ4740
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 51a0160..ff3c8da 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -20,6 +20,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/core.h>
 #include <linux/mmc/host.h>
@@ -185,8 +186,13 @@ struct sh_mmcif_host {
 	long timeout;
 	void __iomem *addr;
 	struct completion intr_wait;
-};
 
+	/* DMA support */
+	struct dma_chan		*chan_rx;
+	struct dma_chan		*chan_tx;
+	struct completion	dma_complete;
+	unsigned int            dma_sglen;
+};
 
 static inline void sh_mmcif_bitset(struct sh_mmcif_host *host,
 					unsigned int reg, u32 val)
@@ -200,6 +206,208 @@ static inline void sh_mmcif_bitclr(struct sh_mmcif_host *host,
 	writel(~val & readl(host->addr + reg), host->addr + reg);
 }
 
+#ifdef CONFIG_SH_MMCIF_DMA
+static void mmcif_dma_complete(void *arg)
+{
+	struct sh_mmcif_host *host = arg;
+	dev_dbg(&host->pd->dev, "Command completed\n");
+
+	if (WARN(!host->data, "%s: NULL data in DMA completion!\n",
+		 dev_name(&host->pd->dev)))
+		return;
+
+	if (host->data->flags & MMC_DATA_READ)
+		dma_unmap_sg(&host->pd->dev, host->data->sg, host->dma_sglen,
+			     DMA_FROM_DEVICE);
+	else
+		dma_unmap_sg(&host->pd->dev, host->data->sg, host->dma_sglen,
+			     DMA_TO_DEVICE);
+
+	complete(&host->dma_complete);
+}
+
+static void sh_mmcif_start_dma_rx(struct sh_mmcif_host *host)
+{
+	struct scatterlist *sg = host->data->sg;
+	struct dma_async_tx_descriptor *desc = NULL;
+	struct dma_chan *chan = host->chan_rx;
+	dma_cookie_t cookie = -EINVAL;
+	int ret;
+
+	ret = dma_map_sg(&host->pd->dev, sg, host->data->sg_len, DMA_FROM_DEVICE);
+	if (ret > 0) {
+		host->dma_sglen = ret;
+		desc = chan->device->device_prep_slave_sg(chan, sg, ret,
+			DMA_FROM_DEVICE, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	}
+
+	if (desc) {
+		desc->callback = mmcif_dma_complete;
+		desc->callback_param = host;
+		cookie = desc->tx_submit(desc);
+		if (cookie < 0) {
+			desc = NULL;
+			ret = cookie;
+		} else {
+			sh_mmcif_bitset(host, MMCIF_CE_BUF_ACC, BUF_ACC_DMAREN);
+			chan->device->device_issue_pending(chan);
+		}
+	}
+	dev_dbg(&host->pd->dev, "%s(): mapped %d -> %d, cookie %d\n",
+		__func__, host->data->sg_len, ret, cookie);
+
+	if (!desc) {
+		/* DMA failed, fall back to PIO */
+		if (ret >= 0)
+			ret = -EIO;
+		host->chan_rx = NULL;
+		host->dma_sglen = 0;
+		dma_release_channel(chan);
+		/* Free the Tx channel too */
+		chan = host->chan_tx;
+		if (chan) {
+			host->chan_tx = NULL;
+			dma_release_channel(chan);
+		}
+		dev_warn(&host->pd->dev,
+			 "DMA failed: %d, falling back to PIO\n", ret);
+		sh_mmcif_bitclr(host, MMCIF_CE_BUF_ACC, BUF_ACC_DMAREN | BUF_ACC_DMAWEN);
+	}
+
+	dev_dbg(&host->pd->dev, "%s(): desc %p, cookie %d, sg[%d]\n", __func__,
+		desc, cookie, host->data->sg_len);
+}
+
+static void sh_mmcif_start_dma_tx(struct sh_mmcif_host *host)
+{
+	struct scatterlist *sg = host->data->sg;
+	struct dma_async_tx_descriptor *desc = NULL;
+	struct dma_chan *chan = host->chan_tx;
+	dma_cookie_t cookie = -EINVAL;
+	int ret;
+
+	ret = dma_map_sg(&host->pd->dev, sg, host->data->sg_len, DMA_TO_DEVICE);
+	if (ret > 0) {
+		host->dma_sglen = ret;
+		desc = chan->device->device_prep_slave_sg(chan, sg, ret,
+			DMA_TO_DEVICE, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	}
+
+	if (desc) {
+		desc->callback = mmcif_dma_complete;
+		desc->callback_param = host;
+		cookie = desc->tx_submit(desc);
+		if (cookie < 0) {
+			desc = NULL;
+			ret = cookie;
+		} else {
+			sh_mmcif_bitset(host, MMCIF_CE_BUF_ACC, BUF_ACC_DMAWEN);
+			chan->device->device_issue_pending(chan);
+		}
+	}
+	dev_dbg(&host->pd->dev, "%s(): mapped %d -> %d, cookie %d\n",
+		__func__, host->data->sg_len, ret, cookie);
+
+	if (!desc) {
+		/* DMA failed, fall back to PIO */
+		if (ret >= 0)
+			ret = -EIO;
+		host->chan_tx = NULL;
+		host->dma_sglen = 0;
+		dma_release_channel(chan);
+		/* Free the Rx channel too */
+		chan = host->chan_rx;
+		if (chan) {
+			host->chan_rx = NULL;
+			dma_release_channel(chan);
+		}
+		dev_warn(&host->pd->dev,
+			 "DMA failed: %d, falling back to PIO\n", ret);
+		sh_mmcif_bitclr(host, MMCIF_CE_BUF_ACC, BUF_ACC_DMAREN | BUF_ACC_DMAWEN);
+	}
+
+	dev_dbg(&host->pd->dev, "%s(): desc %p, cookie %d\n", __func__,
+		desc, cookie);
+}
+
+static bool sh_mmcif_filter(struct dma_chan *chan, void *arg)
+{
+	dev_dbg(chan->device->dev, "%s: slave data %p\n", __func__, arg);
+	chan->private = arg;
+	return true;
+}
+
+static void sh_mmcif_request_dma(struct sh_mmcif_host *host,
+				 struct sh_mmcif_plat_data *pdata)
+{
+	host->dma_sglen = 0;
+
+	/* We can only either use DMA for both Tx and Rx or not use it at all */
+	if (pdata->dma) {
+		dma_cap_mask_t mask;
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+
+		host->chan_tx = dma_request_channel(mask, sh_mmcif_filter,
+						    &pdata->dma->chan_priv_tx);
+		dev_dbg(&host->pd->dev, "%s: TX: got channel %p\n", __func__,
+			host->chan_tx);
+
+		if (!host->chan_tx)
+			return;
+
+		host->chan_rx = dma_request_channel(mask, sh_mmcif_filter,
+						    &pdata->dma->chan_priv_rx);
+		dev_dbg(&host->pd->dev, "%s: RX: got channel %p\n", __func__,
+			host->chan_rx);
+
+		if (!host->chan_rx) {
+			dma_release_channel(host->chan_tx);
+			host->chan_tx = NULL;
+			return;
+		}
+
+		init_completion(&host->dma_complete);
+	}
+}
+
+static void sh_mmcif_release_dma(struct sh_mmcif_host *host)
+{
+	sh_mmcif_bitclr(host, MMCIF_CE_BUF_ACC, BUF_ACC_DMAREN | BUF_ACC_DMAWEN);
+	/* Descriptors are freed automatically */
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
+	host->dma_sglen = 0;
+}
+#else
+static void sh_mmcif_start_dma_tx(struct sh_mmcif_host *host)
+{
+}
+
+static void sh_mmcif_start_dma_rx(struct sh_mmcif_host *host)
+{
+}
+
+static void sh_mmcif_request_dma(struct sh_mmcif_host *host,
+				 struct sh_mmcif_plat_data *pdata)
+{
+	/* host->chan_tx, host->chan_tx and host->dma_sglen are all zero */
+}
+
+static void sh_mmcif_release_dma(struct sh_mmcif_host *host)
+{
+}
+#endif
 
 static void sh_mmcif_clock_control(struct sh_mmcif_host *host, unsigned int clk)
 {
@@ -587,7 +795,20 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
 	}
 	sh_mmcif_get_response(host, cmd);
 	if (host->data) {
-		ret = sh_mmcif_data_trans(host, mrq, cmd->opcode);
+		if (!host->dma_sglen) {
+			ret = sh_mmcif_data_trans(host, mrq, cmd->opcode);
+		} else {
+			long time =
+				wait_for_completion_interruptible_timeout(&host->dma_complete,
+									  host->timeout);
+			if (!time)
+				ret = -ETIMEDOUT;
+			else if (time < 0)
+				ret = time;
+			sh_mmcif_bitclr(host, MMCIF_CE_BUF_ACC,
+					BUF_ACC_DMAREN | BUF_ACC_DMAWEN);
+			host->dma_sglen = 0;
+		}
 		if (ret < 0)
 			mrq->data->bytes_xfered = 0;
 		else
@@ -645,6 +866,15 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		break;
 	}
 	host->data = mrq->data;
+	if (mrq->data) {
+		if (mrq->data->flags & MMC_DATA_READ) {
+			if (host->chan_rx)
+				sh_mmcif_start_dma_rx(host);
+		} else {
+			if (host->chan_tx)
+				sh_mmcif_start_dma_tx(host);
+		}
+	}
 	sh_mmcif_start_cmd(host, mrq, mrq->cmd);
 	host->data = NULL;
 
@@ -837,6 +1067,10 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 
 	sh_mmcif_sync_reset(host);
 	platform_set_drvdata(pdev, host);
+
+	/* See if we also get DMA */
+	sh_mmcif_request_dma(host, pd);
+
 	mmc_add_host(mmc);
 
 	ret = request_irq(irq[0], sh_mmcif_intr, 0, "sh_mmc:error", host);
@@ -875,6 +1109,7 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
 	int irq[2];
 
 	mmc_remove_host(host->mmc);
+	sh_mmcif_release_dma(host);
 
 	if (host->addr)
 		iounmap(host->addr);
diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index d19e211..fcf3d11 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -14,8 +14,9 @@
 #ifndef __SH_MMCIF_H__
 #define __SH_MMCIF_H__
 
-#include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/sh_dma.h>
 
 /*
  * MMCIF : CE_CLK_CTRL [19:16]
@@ -31,13 +32,19 @@
  * 1111 : Peripheral clock (sup_pclk set '1')
  */
 
+struct sh_mmcif_dma {
+	struct sh_dmae_slave chan_priv_tx;
+	struct sh_dmae_slave chan_priv_rx;
+};
+
 struct sh_mmcif_plat_data {
 	void (*set_pwr)(struct platform_device *pdev, int state);
 	void (*down_pwr)(struct platform_device *pdev);
 	int (*get_cd)(struct platform_device *pdef);
-	u8	sup_pclk;	/* 1 :SH7757, 0: SH7724/SH7372 */
-	unsigned long caps;
-	u32	ocr;
+	struct sh_mmcif_dma	*dma;
+	u8			sup_pclk;	/* 1 :SH7757, 0: SH7724/SH7372 */
+	unsigned long		caps;
+	u32			ocr;
 };
 
 #define MMCIF_CE_CMD_SET	0x00000000
-- 
1.7.2.3

