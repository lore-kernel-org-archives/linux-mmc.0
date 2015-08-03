From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] mmc: dw_mmc: Add external dma interface support
Date: Mon,  3 Aug 2015 11:27:19 +0800
Message-ID: <1438572439-654-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.134]:47426 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbbHCDb3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Aug 2015 23:31:29 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: dianders@chromium.org, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>, Jean Delvare <jdelvare@suse.de>, Alim Akhtar <alim.akhtar@samsung.com>, Andrew Bresticker <abrestic@chromium.org>, Stephen Boyd <sboyd@codeaurora.org>, Weijun Yang <Weijun.Yang@csr.com>, Scott Branden <sbranden@broadcom.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, addy ke <addy.ke@rock-chips.com>, Kevin Hao <haokexin@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

DesignWare MMC Controller can support two types of DMA
mode: external dma and internal dma. We get a RK312x platform
integrated dw_mmc and ARM pl330 dma controller. This patch add
edmac ops to suuport these platforms. I've tested it on RK312x
platform with edmac mode and RK3288 platform with idmac mode.

Patch is based on next of git://git.linaro.org/people/ulf.hansson/mmc

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- Fix typo of dev_info msg
- remove unused dmach from declaration of dw_mci_dma_slave

 drivers/mmc/host/Kconfig        |  24 +++++-
 drivers/mmc/host/dw_mmc-pltfm.c |   4 +
 drivers/mmc/host/dw_mmc.c       | 169 ++++++++++++++++++++++++++++++++++++++--
 include/linux/mmc/dw_mmc.h      |  18 ++++-
 4 files changed, 205 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 6a0f9c7..2a66b08 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -607,16 +607,36 @@ config MMC_DW
 	help
 	  This selects support for the Synopsys DesignWare Mobile Storage IP
 	  block, this provides host support for SD and MMC interfaces, in both
-	  PIO and external DMA modes.
+	  PIO, internal DMA mode and external DMA modes.
+
+choice
+	prompt "DesignWare MMC transfer mode"
+	depends on MMC_DW
+
+config MMC_DW_PIO
+	bool "Use PIO transfers only"
+	help
+	  Use PIO to transfer data between memory and the hardware.
+	  PIO is slower than DMA as it requires CPU instructions to
+	  move the data. This has been the traditional default for
+	  the DW MCI driver.
 
 config MMC_DW_IDMAC
 	bool "Internal DMAC interface"
-	depends on MMC_DW
 	help
 	  This selects support for the internal DMAC block within the Synopsys
 	  Designware Mobile Storage IP block. This disables the external DMA
 	  interface.
 
+config MMC_DW_EDMAC
+	bool "External DMAC interface"
+	help
+	  This selects support for the external DMAC block outside the Synopsys
+	  Designware Mobile Storage IP block. This disables the internal DMA
+	  interface.
+
+endchoice
+
 config MMC_DW_PLTFM
 	tristate "Synopsys Designware MCI Support as platform device"
 	depends on MMC_DW
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index ec6dbcd..9475b9f 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -59,6 +59,10 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 	host->pdata = pdev->dev.platform_data;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+#ifdef CONFIG_MMC_DW_EDMAC
+	/* Get registers' physical base address */
+	host->phy_regs = (void *)(regs->start);
+#endif
 	host->regs = devm_ioremap_resource(&pdev->dev, regs);
 	if (IS_ERR(host->regs))
 		return PTR_ERR(host->regs);
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 40e9d8e..88a8501 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -441,8 +441,9 @@ static void dw_mci_idmac_stop_dma(struct dw_mci *host)
 	mci_writel(host, BMOD, temp);
 }
 
-static void dw_mci_idmac_complete_dma(struct dw_mci *host)
+static void dw_mci_idmac_complete_dma(void *arg)
 {
+	struct dw_mci *host = arg;
 	struct mmc_data *data = host->data;
 
 	dev_vdbg(host->dev, "DMA complete\n");
@@ -527,7 +528,7 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
 	wmb();
 }
 
-static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
+static int dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
 {
 	u32 temp;
 
@@ -551,6 +552,8 @@ static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
 
 	/* Start it running */
 	mci_writel(host, PLDMND, 1);
+
+	return 0;
 }
 
 static int dw_mci_idmac_init(struct dw_mci *host)
@@ -634,6 +637,144 @@ static const struct dw_mci_dma_ops dw_mci_idmac_ops = {
 };
 #endif /* CONFIG_MMC_DW_IDMAC */
 
+#ifdef CONFIG_MMC_DW_EDMAC
+static void dw_mci_edmac_cleanup(struct dw_mci *host)
+{
+	struct mmc_data *data = host->data;
+
+	if (data && (!data->host_cookie))
+		dma_unmap_sg(host->dev, data->sg,
+			     data->sg_len, dw_mci_get_dma_dir(data));
+}
+
+static void dw_mci_edmac_stop_dma(struct dw_mci *host)
+{
+	dmaengine_terminate_all(host->dms->ch);
+}
+
+static void dw_mci_edmac_complete_dma(void *arg)
+{
+	struct dw_mci *host = arg;
+	struct mmc_data *data = host->data;
+
+	dev_vdbg(host->dev, "DMA complete\n");
+
+	if (data && data->flags & MMC_DATA_READ)
+		/* Invalidate cache after read */
+		dma_sync_sg_for_cpu(mmc_dev(host->cur_slot->mmc), data->sg,
+				    data->sg_len, DMA_FROM_DEVICE);
+
+	host->dma_ops->cleanup(host);
+
+	/*
+	* If the card was removed, data will be NULL. No point in trying to
+	* send the stop command or waiting for NBUSY in this case.
+	*/
+	if (data) {
+		set_bit(EVENT_XFER_COMPLETE, &host->pending_events);
+		tasklet_schedule(&host->tasklet);
+	}
+}
+
+static int dw_mci_edmac_start_dma(struct dw_mci *host,
+					    unsigned int sg_len)
+{
+	struct dma_slave_config cfg;
+	struct dma_async_tx_descriptor *desc = NULL;
+	struct scatterlist *sgl = host->data->sg;
+	const u32 mszs[] = {1, 4, 8, 16, 32, 64, 128, 256};
+	u32 sg_elems = host->data->sg_len;
+	u32 fifoth_val;
+	u32 fifo_offset = host->fifo_reg - host->regs;
+	int ret = 0;
+
+	/* Set external dma config: burst size, burst width */
+	cfg.dst_addr = (dma_addr_t)(host->phy_regs + fifo_offset);
+	cfg.src_addr = cfg.dst_addr;
+	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	/* Match burst msize with external dma config */
+	fifoth_val = mci_readl(host, FIFOTH);
+	cfg.dst_maxburst = mszs[(fifoth_val >> 28) & 0x7];
+	cfg.src_maxburst = cfg.dst_maxburst;
+
+	if (host->data->flags & MMC_DATA_WRITE)
+		cfg.direction = DMA_MEM_TO_DEV;
+	else /* MMC_DATA_READ */
+		cfg.direction = DMA_DEV_TO_MEM;
+
+	ret = dmaengine_slave_config(host->dms->ch, &cfg);
+	if (ret) {
+		dev_err(host->dev, "Failed to config edmac.\n");
+		return -EBUSY;
+	}
+
+	desc = dmaengine_prep_slave_sg(host->dms->ch, sgl,
+				       sg_len, cfg.direction,
+				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc) {
+		dev_err(host->dev, "Can't prepare slave sg.\n");
+		return -EBUSY;
+	}
+
+	/* Set dw_mci_edmac_complete_dma as callback */
+	desc->callback = dw_mci_edmac_complete_dma;
+	desc->callback_param = (void *)host;
+	dmaengine_submit(desc);
+
+	/* Flush cache before write */
+	if (host->data->flags & MMC_DATA_WRITE)
+		dma_sync_sg_for_device(mmc_dev(host->cur_slot->mmc), sgl,
+				       sg_elems, DMA_TO_DEVICE);
+
+	dma_async_issue_pending(host->dms->ch);
+
+	return 0;
+}
+
+static int dw_mci_edmac_init(struct dw_mci *host)
+{
+	/* Request external dma channel */
+	host->dms = kzalloc(sizeof(struct dw_mci_dma_slave), GFP_KERNEL);
+	if (!host->dms)
+		return -ENOMEM;
+
+	host->dms->ch = dma_request_slave_channel(host->dev, "dw_mci");
+	if (!host->dms->ch) {
+		dev_err(host->dev,
+			"Failed to get external DMA channel %d\n",
+			host->dms->ch->chan_id);
+		kfree(host->dms);
+		host->dms = NULL;
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static void dw_mci_edmac_exit(struct dw_mci *host)
+{
+	if (host->dms) {
+		if (host->dms->ch) {
+			dma_release_channel(host->dms->ch);
+			host->dms->ch = NULL;
+		}
+		kfree(host->dms);
+		host->dms = NULL;
+	}
+}
+
+static const struct dw_mci_dma_ops dw_mci_edmac_ops = {
+	.init = dw_mci_edmac_init,
+	.exit = dw_mci_edmac_exit,
+	.start = dw_mci_edmac_start_dma,
+	.stop = dw_mci_edmac_stop_dma,
+	.complete = dw_mci_edmac_complete_dma,
+	.cleanup = dw_mci_edmac_cleanup,
+};
+#endif /* CONFIG_MMC_DW_EDMAC */
+
 static int dw_mci_pre_dma_transfer(struct dw_mci *host,
 				   struct mmc_data *data,
 				   bool next)
@@ -712,7 +853,7 @@ static void dw_mci_post_req(struct mmc_host *mmc,
 
 static void dw_mci_adjust_fifoth(struct dw_mci *host, struct mmc_data *data)
 {
-#ifdef CONFIG_MMC_DW_IDMAC
+#if defined(CONFIG_MMC_DW_IDMAC) || defined(CONFIG_MMC_DW_EDMAC)
 	unsigned int blksz = data->blksz;
 	const u32 mszs[] = {1, 4, 8, 16, 32, 64, 128, 256};
 	u32 fifo_width = 1 << host->data_shift;
@@ -835,7 +976,11 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
 	mci_writel(host, INTMASK, temp);
 	spin_unlock_irqrestore(&host->irq_lock, irqflags);
 
-	host->dma_ops->start(host, sg_len);
+	if (host->dma_ops->start(host, sg_len)) {
+		/* We can't do DMA */
+		dev_err(host->dev, "%s: failed to start DMA.\n", __func__);
+		return -ENODEV;
+	}
 
 	return 0;
 }
@@ -2264,7 +2409,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_TI |
 							SDMMC_IDMAC_INT_RI);
 			mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_NI);
-			host->dma_ops->complete(host);
+			host->dma_ops->complete((void *)host);
 		}
 	} else {
 		pending = mci_readl(host, IDSTS);
@@ -2272,7 +2417,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			mci_writel(host, IDSTS, SDMMC_IDMAC_INT_TI |
 							SDMMC_IDMAC_INT_RI);
 			mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
-			host->dma_ops->complete(host);
+			host->dma_ops->complete((void *)host);
 		}
 	}
 #endif
@@ -2397,6 +2542,12 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 		mmc->max_seg_size = 0x1000;
 		mmc->max_req_size = mmc->max_seg_size * host->ring_size;
 		mmc->max_blk_count = mmc->max_req_size / 512;
+#elif defined(CONFIG_MMC_DW_EDMAC)
+		mmc->max_segs = 64;
+		mmc->max_blk_size = 65536;
+		mmc->max_blk_count = 65535;
+		mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
+		mmc->max_seg_size = mmc->max_req_size;
 #else
 		mmc->max_segs = 64;
 		mmc->max_blk_size = 65536; /* BLKSIZ is 16 bits */
@@ -2465,6 +2616,9 @@ static void dw_mci_init_dma(struct dw_mci *host)
 #ifdef CONFIG_MMC_DW_IDMAC
 	host->dma_ops = &dw_mci_idmac_ops;
 	dev_info(host->dev, "Using internal DMA controller.\n");
+#elif defined(CONFIG_MMC_DW_EDMAC)
+	host->dma_ops = &dw_mci_edmac_ops;
+	dev_info(host->dev, "Using external DMA controller.\n");
 #endif
 
 	if (!host->dma_ops)
@@ -2958,6 +3112,9 @@ EXPORT_SYMBOL(dw_mci_remove);
  */
 int dw_mci_suspend(struct dw_mci *host)
 {
+	if (host->use_dma && host->dma_ops->exit)
+		host->dma_ops->exit(host);
+
 	return 0;
 }
 EXPORT_SYMBOL(dw_mci_suspend);
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 5be9767..ff570eb 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -16,6 +16,9 @@
 
 #include <linux/scatterlist.h>
 #include <linux/mmc/core.h>
+#ifdef CONFIG_MMC_DW_EDMAC
+#include <linux/dmaengine.h>
+#endif
 
 #define MAX_MCI_SLOTS	2
 
@@ -40,6 +43,13 @@ enum {
 
 struct mmc_data;
 
+#ifdef CONFIG_MMC_DW_EDMAC
+struct dw_mci_dma_slave {
+	struct dma_chan *ch;
+	enum dma_transfer_direction direction;
+};
+#endif /* CONFIG_MMC_DW_EDMAC */
+
 /**
  * struct dw_mci - MMC controller state shared between all slots
  * @lock: Spinlock protecting the queue and associated data.
@@ -155,6 +165,10 @@ struct dw_mci {
 	const struct dw_mci_dma_ops	*dma_ops;
 #ifdef CONFIG_MMC_DW_IDMAC
 	unsigned int		ring_size;
+#elif defined(CONFIG_MMC_DW_EDMAC)
+	struct dw_mci_dma_slave *dms;
+	/* Registers's physical base address */
+	void                    *phy_regs;
 #else
 	struct dw_mci_dma_data	*dma_data;
 #endif
@@ -210,8 +224,8 @@ struct dw_mci {
 struct dw_mci_dma_ops {
 	/* DMA Ops */
 	int (*init)(struct dw_mci *host);
-	void (*start)(struct dw_mci *host, unsigned int sg_len);
-	void (*complete)(struct dw_mci *host);
+	int (*start)(struct dw_mci *host, unsigned int sg_len);
+	void (*complete)(void *host);
 	void (*stop)(struct dw_mci *host);
 	void (*cleanup)(struct dw_mci *host);
 	void (*exit)(struct dw_mci *host);
-- 
2.3.7


