From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 01/19] mmc: mmci: regroup and define dma operations
Date: Tue, 12 Jun 2018 15:14:22 +0200
Message-ID: <1528809280-31116-2-git-send-email-ludovic.Barre@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

Prepare mmci driver to manage dma interface by new property.
This patch defines and regroups dma operations for mmci drivers.
mmci_dma_XX prototypes are added to call member of mmci_dma_ops
if not null. Based on legacy need, a mmci dma interface has been
defined with:
-mmci_dma_setup
-mmci_dma_release
-mmci_dma_pre_req
-mmci_dma_start
-mmci_dma_finalize
-mmci_dma_post_req
-mmci_dma_error
-mmci_dma_get_next_data

A dma_priv is added to host structure to contain private dma needs.

Legacy dmaengine functions have been moved with just some adaptation on:
-dma_in_progress moves to dmaengine_priv structure, called in
 dmaengine_error and dmaengine_finalize.
-centralized dma_unmap_sg into dmaengine_unmap, called by
 dmaengine_error and dmaengine_finalize.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/Makefile   |   2 +-
 drivers/mmc/host/mmci.c     | 437 ++----------------------------------------
 drivers/mmc/host/mmci.h     |  95 ++++++++--
 drivers/mmc/host/mmci_dma.c | 450 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/mmci_dma.h |  31 +++
 5 files changed, 579 insertions(+), 436 deletions(-)
 create mode 100644 drivers/mmc/host/mmci_dma.c
 create mode 100644 drivers/mmc/host/mmci_dma.h

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 85dc132..daecaa98 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -4,7 +4,7 @@
 #
 
 obj-$(CONFIG_MMC_ARMMMCI) += armmmci.o
-armmmci-y := mmci.o
+armmmci-y := mmci.o mmci_dma.o
 armmmci-$(CONFIG_MMC_QCOM_DML) += mmci_qcom_dml.o
 obj-$(CONFIG_MMC_PXA)		+= pxamci.o
 obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f184977..8868be0 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -42,84 +42,13 @@
 #include <asm/io.h>
 
 #include "mmci.h"
+#include "mmci_dma.h"
 #include "mmci_qcom_dml.h"
 
 #define DRIVER_NAME "mmci-pl18x"
 
 static unsigned int fmax = 515633;
 
-/**
- * struct variant_data - MMCI variant-specific quirks
- * @clkreg: default value for MCICLOCK register
- * @clkreg_enable: enable value for MMCICLOCK register
- * @clkreg_8bit_bus_enable: enable value for 8 bit bus
- * @clkreg_neg_edge_enable: enable value for inverted data/cmd output
- * @datalength_bits: number of bits in the MMCIDATALENGTH register
- * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
- *	      is asserted (likewise for RX)
- * @fifohalfsize: number of bytes that can be written when MCI_TXFIFOHALFEMPTY
- *		  is asserted (likewise for RX)
- * @data_cmd_enable: enable value for data commands.
- * @st_sdio: enable ST specific SDIO logic
- * @st_clkdiv: true if using a ST-specific clock divider algorithm
- * @datactrl_mask_ddrmode: ddr mode mask in datactrl register.
- * @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl register
- * @blksz_datactrl4: true if Block size is at b4..b16 position in datactrl
- *		     register
- * @datactrl_mask_sdio: SDIO enable mask in datactrl register
- * @pwrreg_powerup: power up value for MMCIPOWER register
- * @f_max: maximum clk frequency supported by the controller.
- * @signal_direction: input/out direction of bus signals can be indicated
- * @pwrreg_clkgate: MMCIPOWER register must be used to gate the clock
- * @busy_detect: true if the variant supports busy detection on DAT0.
- * @busy_dpsm_flag: bitmask enabling busy detection in the DPSM
- * @busy_detect_flag: bitmask identifying the bit in the MMCISTATUS register
- *		      indicating that the card is busy
- * @busy_detect_mask: bitmask identifying the bit in the MMCIMASK0 to mask for
- *		      getting busy end detection interrupts
- * @pwrreg_nopower: bits in MMCIPOWER don't controls ext. power supply
- * @explicit_mclk_control: enable explicit mclk control in driver.
- * @qcom_fifo: enables qcom specific fifo pio read logic.
- * @qcom_dml: enables qcom specific dma glue for dma transfers.
- * @reversed_irq_handling: handle data irq before cmd irq.
- * @mmcimask1: true if variant have a MMCIMASK1 register.
- * @start_err: bitmask identifying the STARTBITERR bit inside MMCISTATUS
- *	       register.
- * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
- */
-struct variant_data {
-	unsigned int		clkreg;
-	unsigned int		clkreg_enable;
-	unsigned int		clkreg_8bit_bus_enable;
-	unsigned int		clkreg_neg_edge_enable;
-	unsigned int		datalength_bits;
-	unsigned int		fifosize;
-	unsigned int		fifohalfsize;
-	unsigned int		data_cmd_enable;
-	unsigned int		datactrl_mask_ddrmode;
-	unsigned int		datactrl_mask_sdio;
-	bool			st_sdio;
-	bool			st_clkdiv;
-	bool			blksz_datactrl16;
-	bool			blksz_datactrl4;
-	u32			pwrreg_powerup;
-	u32			f_max;
-	bool			signal_direction;
-	bool			pwrreg_clkgate;
-	bool			busy_detect;
-	u32			busy_dpsm_flag;
-	u32			busy_detect_flag;
-	u32			busy_detect_mask;
-	bool			pwrreg_nopower;
-	bool			explicit_mclk_control;
-	bool			qcom_fifo;
-	bool			qcom_dml;
-	bool			reversed_irq_handling;
-	bool			mmcimask1;
-	u32			start_err;
-	u32			opendrain;
-};
-
 static struct variant_data variant_arm = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
@@ -130,6 +59,7 @@ static struct variant_data variant_arm = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.mmci_dma		= &dmaengine,
 };
 
 static struct variant_data variant_arm_extended_fifo = {
@@ -141,6 +71,7 @@ static struct variant_data variant_arm_extended_fifo = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.mmci_dma		= &dmaengine,
 };
 
 static struct variant_data variant_arm_extended_fifo_hwfc = {
@@ -153,6 +84,7 @@ static struct variant_data variant_arm_extended_fifo_hwfc = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.mmci_dma		= &dmaengine,
 };
 
 static struct variant_data variant_u300 = {
@@ -171,6 +103,7 @@ static struct variant_data variant_u300 = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.mmci_dma		= &dmaengine,
 };
 
 static struct variant_data variant_nomadik = {
@@ -190,6 +123,7 @@ static struct variant_data variant_nomadik = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.mmci_dma		= &dmaengine,
 };
 
 static struct variant_data variant_ux500 = {
@@ -215,6 +149,7 @@ static struct variant_data variant_ux500 = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.mmci_dma		= &dmaengine,
 };
 
 static struct variant_data variant_ux500v2 = {
@@ -242,6 +177,7 @@ static struct variant_data variant_ux500v2 = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_OD,
+	.mmci_dma		= &dmaengine,
 };
 
 static struct variant_data variant_stm32 = {
@@ -259,6 +195,7 @@ static struct variant_data variant_stm32 = {
 	.f_max			= 48000000,
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
+	.mmci_dma		= &dmaengine,
 };
 
 static struct variant_data variant_qcom = {
@@ -280,6 +217,7 @@ static struct variant_data variant_qcom = {
 	.mmcimask1		= true,
 	.start_err		= MCI_STARTBITERR,
 	.opendrain		= MCI_ROD,
+	.mmci_dma		= &dmaengine,
 };
 
 /* Busy detection for the ST Micro variant */
@@ -355,7 +293,7 @@ static void mmci_write_pwrreg(struct mmci_host *host, u32 pwr)
 /*
  * This must be called with host->lock held
  */
-static void mmci_write_datactrlreg(struct mmci_host *host, u32 datactrl)
+void mmci_write_datactrlreg(struct mmci_host *host, u32 datactrl)
 {
 	/* Keep busy mode in DPSM if enabled */
 	datactrl |= host->datactrl_reg & host->variant->busy_dpsm_flag;
@@ -480,281 +418,10 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
 }
 
-/*
- * All the DMA operation mode stuff goes inside this ifdef.
- * This assumes that you have a generic DMA device interface,
- * no custom DMA interfaces are supported.
- */
-#ifdef CONFIG_DMA_ENGINE
-static void mmci_dma_setup(struct mmci_host *host)
-{
-	const char *rxname, *txname;
-	struct variant_data *variant = host->variant;
-
-	host->dma_rx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "rx");
-	host->dma_tx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "tx");
-
-	/* initialize pre request cookie */
-	host->next_data.cookie = 1;
-
-	/*
-	 * If only an RX channel is specified, the driver will
-	 * attempt to use it bidirectionally, however if it is
-	 * is specified but cannot be located, DMA will be disabled.
-	 */
-	if (host->dma_rx_channel && !host->dma_tx_channel)
-		host->dma_tx_channel = host->dma_rx_channel;
-
-	if (host->dma_rx_channel)
-		rxname = dma_chan_name(host->dma_rx_channel);
-	else
-		rxname = "none";
-
-	if (host->dma_tx_channel)
-		txname = dma_chan_name(host->dma_tx_channel);
-	else
-		txname = "none";
-
-	dev_info(mmc_dev(host->mmc), "DMA channels RX %s, TX %s\n",
-		 rxname, txname);
-
-	/*
-	 * Limit the maximum segment size in any SG entry according to
-	 * the parameters of the DMA engine device.
-	 */
-	if (host->dma_tx_channel) {
-		struct device *dev = host->dma_tx_channel->device->dev;
-		unsigned int max_seg_size = dma_get_max_seg_size(dev);
-
-		if (max_seg_size < host->mmc->max_seg_size)
-			host->mmc->max_seg_size = max_seg_size;
-	}
-	if (host->dma_rx_channel) {
-		struct device *dev = host->dma_rx_channel->device->dev;
-		unsigned int max_seg_size = dma_get_max_seg_size(dev);
-
-		if (max_seg_size < host->mmc->max_seg_size)
-			host->mmc->max_seg_size = max_seg_size;
-	}
-
-	if (variant->qcom_dml && host->dma_rx_channel && host->dma_tx_channel)
-		if (dml_hw_init(host, host->mmc->parent->of_node))
-			variant->qcom_dml = false;
-}
-
-/*
- * This is used in or so inline it
- * so it can be discarded.
- */
-static inline void mmci_dma_release(struct mmci_host *host)
-{
-	if (host->dma_rx_channel)
-		dma_release_channel(host->dma_rx_channel);
-	if (host->dma_tx_channel)
-		dma_release_channel(host->dma_tx_channel);
-	host->dma_rx_channel = host->dma_tx_channel = NULL;
-}
-
-static void mmci_dma_data_error(struct mmci_host *host)
-{
-	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
-	dmaengine_terminate_all(host->dma_current);
-	host->dma_in_progress = false;
-	host->dma_current = NULL;
-	host->dma_desc_current = NULL;
-	host->data->host_cookie = 0;
-}
-
-static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
-{
-	struct dma_chan *chan;
-
-	if (data->flags & MMC_DATA_READ)
-		chan = host->dma_rx_channel;
-	else
-		chan = host->dma_tx_channel;
-
-	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len,
-		     mmc_get_dma_dir(data));
-}
-
-static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
-{
-	u32 status;
-	int i;
-
-	/* Wait up to 1ms for the DMA to complete */
-	for (i = 0; ; i++) {
-		status = readl(host->base + MMCISTATUS);
-		if (!(status & MCI_RXDATAAVLBLMASK) || i >= 100)
-			break;
-		udelay(10);
-	}
-
-	/*
-	 * Check to see whether we still have some data left in the FIFO -
-	 * this catches DMA controllers which are unable to monitor the
-	 * DMALBREQ and DMALSREQ signals while allowing us to DMA to non-
-	 * contiguous buffers.  On TX, we'll get a FIFO underrun error.
-	 */
-	if (status & MCI_RXDATAAVLBLMASK) {
-		mmci_dma_data_error(host);
-		if (!data->error)
-			data->error = -EIO;
-	}
-
-	if (!data->host_cookie)
-		mmci_dma_unmap(host, data);
-
-	/*
-	 * Use of DMA with scatter-gather is impossible.
-	 * Give up with DMA and switch back to PIO mode.
-	 */
-	if (status & MCI_RXDATAAVLBLMASK) {
-		dev_err(mmc_dev(host->mmc), "buggy DMA detected. Taking evasive action.\n");
-		mmci_dma_release(host);
-	}
-
-	host->dma_in_progress = false;
-	host->dma_current = NULL;
-	host->dma_desc_current = NULL;
-}
-
-/* prepares DMA channel and DMA descriptor, returns non-zero on failure */
-static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
-				struct dma_chan **dma_chan,
-				struct dma_async_tx_descriptor **dma_desc)
-{
-	struct variant_data *variant = host->variant;
-	struct dma_slave_config conf = {
-		.src_addr = host->phybase + MMCIFIFO,
-		.dst_addr = host->phybase + MMCIFIFO,
-		.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
-		.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
-		.src_maxburst = variant->fifohalfsize >> 2, /* # of words */
-		.dst_maxburst = variant->fifohalfsize >> 2, /* # of words */
-		.device_fc = false,
-	};
-	struct dma_chan *chan;
-	struct dma_device *device;
-	struct dma_async_tx_descriptor *desc;
-	int nr_sg;
-	unsigned long flags = DMA_CTRL_ACK;
-
-	if (data->flags & MMC_DATA_READ) {
-		conf.direction = DMA_DEV_TO_MEM;
-		chan = host->dma_rx_channel;
-	} else {
-		conf.direction = DMA_MEM_TO_DEV;
-		chan = host->dma_tx_channel;
-	}
-
-	/* If there's no DMA channel, fall back to PIO */
-	if (!chan)
-		return -EINVAL;
-
-	/* If less than or equal to the fifo size, don't bother with DMA */
-	if (data->blksz * data->blocks <= variant->fifosize)
-		return -EINVAL;
-
-	device = chan->device;
-	nr_sg = dma_map_sg(device->dev, data->sg, data->sg_len,
-			   mmc_get_dma_dir(data));
-	if (nr_sg == 0)
-		return -EINVAL;
-
-	if (host->variant->qcom_dml)
-		flags |= DMA_PREP_INTERRUPT;
-
-	dmaengine_slave_config(chan, &conf);
-	desc = dmaengine_prep_slave_sg(chan, data->sg, nr_sg,
-					    conf.direction, flags);
-	if (!desc)
-		goto unmap_exit;
-
-	*dma_chan = chan;
-	*dma_desc = desc;
-
-	return 0;
-
- unmap_exit:
-	dma_unmap_sg(device->dev, data->sg, data->sg_len,
-		     mmc_get_dma_dir(data));
-	return -ENOMEM;
-}
-
-static inline int mmci_dma_prep_data(struct mmci_host *host,
-				     struct mmc_data *data)
-{
-	/* Check if next job is already prepared. */
-	if (host->dma_current && host->dma_desc_current)
-		return 0;
-
-	/* No job were prepared thus do it now. */
-	return __mmci_dma_prep_data(host, data, &host->dma_current,
-				    &host->dma_desc_current);
-}
-
-static inline int mmci_dma_prep_next(struct mmci_host *host,
-				     struct mmc_data *data)
-{
-	struct mmci_host_next *nd = &host->next_data;
-	return __mmci_dma_prep_data(host, data, &nd->dma_chan, &nd->dma_desc);
-}
-
-static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
-{
-	int ret;
-	struct mmc_data *data = host->data;
-
-	ret = mmci_dma_prep_data(host, host->data);
-	if (ret)
-		return ret;
-
-	/* Okay, go for it. */
-	dev_vdbg(mmc_dev(host->mmc),
-		 "Submit MMCI DMA job, sglen %d blksz %04x blks %04x flags %08x\n",
-		 data->sg_len, data->blksz, data->blocks, data->flags);
-	host->dma_in_progress = true;
-	dmaengine_submit(host->dma_desc_current);
-	dma_async_issue_pending(host->dma_current);
-
-	if (host->variant->qcom_dml)
-		dml_start_xfer(host, data);
-
-	datactrl |= MCI_DPSM_DMAENABLE;
-
-	/* Trigger the DMA transfer */
-	mmci_write_datactrlreg(host, datactrl);
-
-	/*
-	 * Let the MMCI say when the data is ended and it's time
-	 * to fire next DMA request. When that happens, MMCI will
-	 * call mmci_data_end()
-	 */
-	writel(readl(host->base + MMCIMASK0) | MCI_DATAENDMASK,
-	       host->base + MMCIMASK0);
-	return 0;
-}
-
-static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
-{
-	struct mmci_host_next *next = &host->next_data;
-
-	WARN_ON(data->host_cookie && data->host_cookie != next->cookie);
-	WARN_ON(!data->host_cookie && (next->dma_desc || next->dma_chan));
-
-	host->dma_desc_current = next->dma_desc;
-	host->dma_current = next->dma_chan;
-	next->dma_desc = NULL;
-	next->dma_chan = NULL;
-}
-
 static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct mmci_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
-	struct mmci_host_next *nd = &host->next_data;
 
 	if (!data)
 		return;
@@ -764,8 +431,7 @@ static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (mmci_validate_data(host, data))
 		return;
 
-	if (!mmci_dma_prep_next(host, data))
-		data->host_cookie = ++nd->cookie < 0 ? 1 : nd->cookie;
+	mmci_dma_pre_req(host, data);
 }
 
 static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
@@ -777,67 +443,9 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 	if (!data || !data->host_cookie)
 		return;
 
-	mmci_dma_unmap(host, data);
-
-	if (err) {
-		struct mmci_host_next *next = &host->next_data;
-		struct dma_chan *chan;
-		if (data->flags & MMC_DATA_READ)
-			chan = host->dma_rx_channel;
-		else
-			chan = host->dma_tx_channel;
-		dmaengine_terminate_all(chan);
-
-		if (host->dma_desc_current == next->dma_desc)
-			host->dma_desc_current = NULL;
-
-		if (host->dma_current == next->dma_chan) {
-			host->dma_in_progress = false;
-			host->dma_current = NULL;
-		}
-
-		next->dma_desc = NULL;
-		next->dma_chan = NULL;
-		data->host_cookie = 0;
-	}
-}
-
-#else
-/* Blank functions if the DMA engine is not available */
-static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
-{
-}
-static inline void mmci_dma_setup(struct mmci_host *host)
-{
-}
-
-static inline void mmci_dma_release(struct mmci_host *host)
-{
-}
-
-static inline void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
-{
-}
-
-static inline void mmci_dma_finalize(struct mmci_host *host,
-				     struct mmc_data *data)
-{
-}
-
-static inline void mmci_dma_data_error(struct mmci_host *host)
-{
-}
-
-static inline int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
-{
-	return -ENOSYS;
+	mmci_dma_post_req(host, data, err);
 }
 
-#define mmci_pre_request NULL
-#define mmci_post_request NULL
-
-#endif
-
 static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 {
 	struct variant_data *variant = host->variant;
@@ -904,7 +512,7 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	 * Attempt to use DMA operation mode, if this
 	 * should fail, fall back to PIO mode
 	 */
-	if (!mmci_dma_start_data(host, datactrl))
+	if (!mmci_dma_start(host, datactrl))
 		return;
 
 	/* IRQ mode, map the SG list for CPU reading/writing */
@@ -979,10 +587,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		u32 remain, success;
 
 		/* Terminate the DMA transfer */
-		if (dma_inprogress(host)) {
-			mmci_dma_data_error(host);
-			mmci_dma_unmap(host, data);
-		}
+		mmci_dma_error(host);
 
 		/*
 		 * Calculate how far we are into the transfer.  Note that
@@ -1020,8 +625,8 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");
 
 	if (status & MCI_DATAEND || data->error) {
-		if (dma_inprogress(host))
-			mmci_dma_finalize(host, data);
+		mmci_dma_finalize(host, data);
+
 		mmci_stop_data(host);
 
 		if (!data->error)
@@ -1128,10 +733,8 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	if ((!sbc && !cmd->data) || cmd->error) {
 		if (host->data) {
 			/* Terminate the DMA transfer */
-			if (dma_inprogress(host)) {
-				mmci_dma_data_error(host);
-				mmci_dma_unmap(host, host->data);
-			}
+			mmci_dma_error(host);
+
 			mmci_stop_data(host);
 		}
 		mmci_request_end(host, host->mrq);
@@ -1399,7 +1002,7 @@ static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	host->mrq = mrq;
 
 	if (mrq->data)
-		mmci_get_next_data(host, mrq->data);
+		mmci_dma_get_next_data(host, mrq->data);
 
 	if (mrq->data && mrq->data->flags & MMC_DATA_READ)
 		mmci_start_data(host, mrq->data);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index f91cdf7..a73bb98 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -195,13 +195,81 @@
 #define MMCI_PINCTRL_STATE_OPENDRAIN "opendrain"
 
 struct clk;
-struct variant_data;
 struct dma_chan;
 
-struct mmci_host_next {
-	struct dma_async_tx_descriptor	*dma_desc;
-	struct dma_chan			*dma_chan;
-	s32				cookie;
+/**
+ * struct variant_data - MMCI variant-specific quirks
+ * @clkreg: default value for MCICLOCK register
+ * @clkreg_enable: enable value for MMCICLOCK register
+ * @clkreg_8bit_bus_enable: enable value for 8 bit bus
+ * @clkreg_neg_edge_enable: enable value for inverted data/cmd output
+ * @datalength_bits: number of bits in the MMCIDATALENGTH register
+ * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
+ *	      is asserted (likewise for RX)
+ * @fifohalfsize: number of bytes that can be written when MCI_TXFIFOHALFEMPTY
+ *		  is asserted (likewise for RX)
+ * @data_cmd_enable: enable value for data commands.
+ * @st_sdio: enable ST specific SDIO logic
+ * @st_clkdiv: true if using a ST-specific clock divider algorithm
+ * @datactrl_mask_ddrmode: ddr mode mask in datactrl register.
+ * @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl
+ *                    register
+ * @blksz_datactrl4: true if Block size is at b4..b16 position in datactrl
+ *		     register
+ * @datactrl_mask_sdio: SDIO enable mask in datactrl register
+ * @pwrreg_powerup: power up value for MMCIPOWER register
+ * @f_max: maximum clk frequency supported by the controller.
+ * @signal_direction: input/out direction of bus signals can be indicated
+ * @pwrreg_clkgate: MMCIPOWER register must be used to gate the clock
+ * @busy_detect: true if the variant supports busy detection on DAT0.
+ * @busy_dpsm_flag: bitmask enabling busy detection in the DPSM
+ * @busy_detect_flag: bitmask identifying the bit in the MMCISTATUS register
+ *		      indicating that the card is busy
+ * @busy_detect_mask: bitmask identifying the bit in the MMCIMASK0 to mask for
+ *		      getting busy end detection interrupts
+ * @pwrreg_nopower: bits in MMCIPOWER don't controls ext. power supply
+ * @explicit_mclk_control: enable explicit mclk control in driver.
+ * @qcom_fifo: enables qcom specific fifo pio read logic.
+ * @qcom_dml: enables qcom specific dma glue for dma transfers.
+ * @reversed_irq_handling: handle data irq before cmd irq.
+ * @mmcimask1: true if variant have a MMCIMASK1 register.
+ * @start_err: bitmask identifying the STARTBITERR bit inside MMCISTATUS
+ *	       register.
+ * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
+ * @mmci_dma: Pointer to platform-specific DMA callbacks.
+ */
+struct variant_data {
+	unsigned int		clkreg;
+	unsigned int		clkreg_enable;
+	unsigned int		clkreg_8bit_bus_enable;
+	unsigned int		clkreg_neg_edge_enable;
+	unsigned int		datalength_bits;
+	unsigned int		fifosize;
+	unsigned int		fifohalfsize;
+	unsigned int		data_cmd_enable;
+	unsigned int		datactrl_mask_ddrmode;
+	unsigned int		datactrl_mask_sdio;
+	bool			st_sdio;
+	bool			st_clkdiv;
+	bool			blksz_datactrl16;
+	bool			blksz_datactrl4;
+	u32			pwrreg_powerup;
+	u32			f_max;
+	bool			signal_direction;
+	bool			pwrreg_clkgate;
+	bool			busy_detect;
+	u32			busy_dpsm_flag;
+	u32			busy_detect_flag;
+	u32			busy_detect_mask;
+	bool			pwrreg_nopower;
+	bool			explicit_mclk_control;
+	bool			qcom_fifo;
+	bool			qcom_dml;
+	bool			reversed_irq_handling;
+	bool			mmcimask1;
+	u32			start_err;
+	u32			opendrain;
+	struct mmci_dma_ops	*mmci_dma;
 };
 
 struct mmci_host {
@@ -244,18 +312,9 @@ struct mmci_host {
 	unsigned int		size;
 	int (*get_rx_fifocnt)(struct mmci_host *h, u32 status, int remain);
 
-#ifdef CONFIG_DMA_ENGINE
-	/* DMA stuff */
-	struct dma_chan		*dma_current;
-	struct dma_chan		*dma_rx_channel;
-	struct dma_chan		*dma_tx_channel;
-	struct dma_async_tx_descriptor	*dma_desc_current;
-	struct mmci_host_next	next_data;
-	bool			dma_in_progress;
-
-#define dma_inprogress(host)	((host)->dma_in_progress)
-#else
-#define dma_inprogress(host)	(0)
-#endif
+	void			*dma_priv;
 };
 
+extern struct mmci_dma_ops dmaengine;
+
+void mmci_write_datactrlreg(struct mmci_host *host, u32 datactrl);
diff --git a/drivers/mmc/host/mmci_dma.c b/drivers/mmc/host/mmci_dma.c
new file mode 100644
index 0000000..98a542d
--- /dev/null
+++ b/drivers/mmc/host/mmci_dma.c
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Ludovic.barre@st.com for STMicroelectronics.
+ */
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
+#include <linux/scatterlist.h>
+
+#include "mmci.h"
+#include "mmci_dma.h"
+#include "mmci_qcom_dml.h"
+
+int mmci_dma_setup(struct mmci_host *host)
+{
+	struct mmci_dma_ops *mmci_dma = host->variant->mmci_dma;
+
+	if (mmci_dma && mmci_dma->setup)
+		return mmci_dma->setup(host);
+
+	return 0;
+}
+
+void mmci_dma_release(struct mmci_host *host)
+{
+	struct mmci_dma_ops *mmci_dma = host->variant->mmci_dma;
+
+	if (mmci_dma && mmci_dma->release)
+		mmci_dma->release(host);
+}
+
+void mmci_dma_pre_req(struct mmci_host *host, struct mmc_data *data)
+{
+	struct mmci_dma_ops *mmci_dma = host->variant->mmci_dma;
+
+	if (mmci_dma && mmci_dma->pre_req)
+		mmci_dma->pre_req(host, data);
+}
+
+int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
+{
+	struct mmci_dma_ops *mmci_dma = host->variant->mmci_dma;
+
+	if (mmci_dma && mmci_dma->start)
+		return mmci_dma->start(host, datactrl);
+
+	return -EINVAL;
+}
+
+void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
+{
+	struct mmci_dma_ops *mmci_dma = host->variant->mmci_dma;
+
+	if (mmci_dma && mmci_dma->finalize)
+		mmci_dma->finalize(host, data);
+}
+
+void mmci_dma_post_req(struct mmci_host *host,
+		       struct mmc_data *data, int err)
+{
+	struct mmci_dma_ops *mmci_dma = host->variant->mmci_dma;
+
+	if (mmci_dma && mmci_dma->post_req)
+		mmci_dma->post_req(host, data, err);
+}
+
+void mmci_dma_error(struct mmci_host *host)
+{
+	struct mmci_dma_ops *mmci_dma = host->variant->mmci_dma;
+
+	if (mmci_dma && mmci_dma->error)
+		mmci_dma->error(host);
+}
+
+void mmci_dma_get_next_data(struct mmci_host *host, struct mmc_data *data)
+{
+	struct mmci_dma_ops *mmci_dma = host->variant->mmci_dma;
+
+	if (mmci_dma && mmci_dma->get_next_data)
+		mmci_dma->get_next_data(host, data);
+}
+
+#ifdef CONFIG_DMA_ENGINE
+struct dmaengine_next {
+	struct dma_async_tx_descriptor *dma_desc;
+	struct dma_chan	*dma_chan;
+	s32 cookie;
+};
+
+struct dmaengine_priv {
+	struct dma_chan	*dma_current;
+	struct dma_chan	*dma_rx_channel;
+	struct dma_chan	*dma_tx_channel;
+	struct dma_async_tx_descriptor	*dma_desc_current;
+	struct dmaengine_next next_data;
+	bool dma_in_progress;
+};
+
+#define dma_inprogress(dmae) ((dmae)->dma_in_progress)
+
+static int dmaengine_setup(struct mmci_host *host)
+{
+	const char *rxname, *txname;
+	struct variant_data *variant = host->variant;
+	struct dmaengine_priv *dmae;
+
+	dmae = devm_kzalloc(mmc_dev(host->mmc), sizeof(*dmae), GFP_KERNEL);
+	if (!dmae)
+		return -ENOMEM;
+
+	host->dma_priv = dmae;
+
+	dmae->dma_rx_channel = dma_request_slave_channel(mmc_dev(host->mmc),
+							 "rx");
+	dmae->dma_tx_channel = dma_request_slave_channel(mmc_dev(host->mmc),
+							 "tx");
+
+	/* initialize pre request cookie */
+	dmae->next_data.cookie = 1;
+
+	/*
+	 * If only an RX channel is specified, the driver will
+	 * attempt to use it bidirectionally, however if it is
+	 * is specified but cannot be located, DMA will be disabled.
+	 */
+	if (dmae->dma_rx_channel && !dmae->dma_tx_channel)
+		dmae->dma_tx_channel = dmae->dma_rx_channel;
+
+	if (dmae->dma_rx_channel)
+		rxname = dma_chan_name(dmae->dma_rx_channel);
+	else
+		rxname = "none";
+
+	if (dmae->dma_tx_channel)
+		txname = dma_chan_name(dmae->dma_tx_channel);
+	else
+		txname = "none";
+
+	dev_info(mmc_dev(host->mmc), "DMA channels RX %s, TX %s\n",
+		 rxname, txname);
+
+	/*
+	 * Limit the maximum segment size in any SG entry according to
+	 * the parameters of the DMA engine device.
+	 */
+	if (dmae->dma_tx_channel) {
+		struct device *dev = dmae->dma_tx_channel->device->dev;
+		unsigned int max_seg_size = dma_get_max_seg_size(dev);
+
+		if (max_seg_size < host->mmc->max_seg_size)
+			host->mmc->max_seg_size = max_seg_size;
+	}
+	if (dmae->dma_rx_channel) {
+		struct device *dev = dmae->dma_rx_channel->device->dev;
+		unsigned int max_seg_size = dma_get_max_seg_size(dev);
+
+		if (max_seg_size < host->mmc->max_seg_size)
+			host->mmc->max_seg_size = max_seg_size;
+	}
+
+	if (variant->qcom_dml && dmae->dma_rx_channel && dmae->dma_tx_channel)
+		if (dml_hw_init(host, host->mmc->parent->of_node))
+			variant->qcom_dml = false;
+
+	return 0;
+}
+
+static inline void dmaengine_release(struct mmci_host *host)
+{
+	struct dmaengine_priv *dmae = host->dma_priv;
+
+	if (dmae->dma_rx_channel)
+		dma_release_channel(dmae->dma_rx_channel);
+	if (dmae->dma_tx_channel)
+		dma_release_channel(dmae->dma_tx_channel);
+
+	dmae->dma_rx_channel = dmae->dma_tx_channel = NULL;
+}
+
+static void dmaengine_unmap(struct mmci_host *host, struct mmc_data *data)
+{
+	struct dmaengine_priv *dmae = host->dma_priv;
+	struct dma_chan *chan;
+
+	if (data->flags & MMC_DATA_READ)
+		chan = dmae->dma_rx_channel;
+	else
+		chan = dmae->dma_tx_channel;
+
+	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len,
+		     mmc_get_dma_dir(data));
+}
+
+static void dmaengine_error(struct mmci_host *host)
+{
+	struct dmaengine_priv *dmae = host->dma_priv;
+
+	if (!dma_inprogress(dmae))
+		return;
+
+	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
+	dmaengine_terminate_all(dmae->dma_current);
+	dmae->dma_in_progress = false;
+	dmae->dma_current = NULL;
+	dmae->dma_desc_current = NULL;
+	host->data->host_cookie = 0;
+
+	dmaengine_unmap(host, host->data);
+}
+
+static void dmaengine_finalize(struct mmci_host *host, struct mmc_data *data)
+{
+	struct dmaengine_priv *dmae = host->dma_priv;
+	u32 status;
+	int i;
+
+	if (!dma_inprogress(dmae))
+		return;
+
+	/* Wait up to 1ms for the DMA to complete */
+	for (i = 0; ; i++) {
+		status = readl(host->base + MMCISTATUS);
+		if (!(status & MCI_RXDATAAVLBLMASK) || i >= 100)
+			break;
+		udelay(10);
+	}
+
+	/*
+	 * Check to see whether we still have some data left in the FIFO -
+	 * this catches DMA controllers which are unable to monitor the
+	 * DMALBREQ and DMALSREQ signals while allowing us to DMA to non-
+	 * contiguous buffers.  On TX, we'll get a FIFO underrun error.
+	 */
+	if (status & MCI_RXDATAAVLBLMASK) {
+		dmaengine_error(host);
+		if (!data->error)
+			data->error = -EIO;
+	}
+
+	if (!data->host_cookie)
+		dmaengine_unmap(host, data);
+
+	/*
+	 * Use of DMA with scatter-gather is impossible.
+	 * Give up with DMA and switch back to PIO mode.
+	 */
+	if (status & MCI_RXDATAAVLBLMASK) {
+		dev_err(mmc_dev(host->mmc),
+			"buggy DMA detected. Taking evasive action.\n");
+		dmaengine_release(host);
+	}
+
+	dmae->dma_in_progress = false;
+	dmae->dma_current = NULL;
+	dmae->dma_desc_current = NULL;
+}
+
+/* prepares DMA channel and DMA descriptor, returns non-zero on failure */
+static int __dmaengine_prep_data(struct mmci_host *host, struct mmc_data *data,
+				 struct dma_chan **dma_chan,
+				 struct dma_async_tx_descriptor **dma_desc)
+{
+	struct dmaengine_priv *dmae = host->dma_priv;
+	struct variant_data *variant = host->variant;
+	struct dma_slave_config conf = {
+		.src_addr = host->phybase + MMCIFIFO,
+		.dst_addr = host->phybase + MMCIFIFO,
+		.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+		.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+		.src_maxburst = variant->fifohalfsize >> 2, /* # of words */
+		.dst_maxburst = variant->fifohalfsize >> 2, /* # of words */
+		.device_fc = false,
+	};
+	struct dma_chan *chan;
+	struct dma_device *device;
+	struct dma_async_tx_descriptor *desc;
+	int nr_sg;
+	unsigned long flags = DMA_CTRL_ACK;
+
+	if (data->flags & MMC_DATA_READ) {
+		conf.direction = DMA_DEV_TO_MEM;
+		chan = dmae->dma_rx_channel;
+	} else {
+		conf.direction = DMA_MEM_TO_DEV;
+		chan = dmae->dma_tx_channel;
+	}
+
+	/* If there's no DMA channel, fall back to PIO */
+	if (!chan)
+		return -EINVAL;
+
+	/* If less than or equal to the fifo size, don't bother with DMA */
+	if (data->blksz * data->blocks <= variant->fifosize)
+		return -EINVAL;
+
+	device = chan->device;
+	nr_sg = dma_map_sg(device->dev, data->sg, data->sg_len,
+			   mmc_get_dma_dir(data));
+	if (nr_sg == 0)
+		return -EINVAL;
+
+	if (host->variant->qcom_dml)
+		flags |= DMA_PREP_INTERRUPT;
+
+	dmaengine_slave_config(chan, &conf);
+	desc = dmaengine_prep_slave_sg(chan, data->sg, nr_sg,
+				       conf.direction, flags);
+	if (!desc)
+		goto unmap_exit;
+
+	*dma_chan = chan;
+	*dma_desc = desc;
+
+	return 0;
+
+ unmap_exit:
+	dmaengine_unmap(host, data);
+	return -ENOMEM;
+}
+
+static inline int dmaengine_prep_data(struct mmci_host *host,
+				      struct mmc_data *data)
+{
+	struct dmaengine_priv *dmae = host->dma_priv;
+
+	/* Check if next job is already prepared. */
+	if (dmae->dma_current && dmae->dma_desc_current)
+		return 0;
+
+	/* No job were prepared thus do it now. */
+	return __dmaengine_prep_data(host, data, &dmae->dma_current,
+				     &dmae->dma_desc_current);
+}
+
+static inline int dmaengine_prep_next(struct mmci_host *host,
+				      struct mmc_data *data)
+{
+	struct dmaengine_priv *dmae = host->dma_priv;
+	struct dmaengine_next *nd = &dmae->next_data;
+
+	return __dmaengine_prep_data(host, data, &nd->dma_chan, &nd->dma_desc);
+}
+
+static int dmaengine_start(struct mmci_host *host, unsigned int datactrl)
+{
+	struct dmaengine_priv *dmae = host->dma_priv;
+	struct mmc_data *data = host->data;
+	int ret;
+
+	ret = dmaengine_prep_data(host, host->data);
+	if (ret)
+		return ret;
+
+	/* Okay, go for it. */
+	dev_vdbg(mmc_dev(host->mmc),
+		 "Submit MMCI DMA job, sglen %d blksz %04x blks %04x flags %08x\n",
+		 data->sg_len, data->blksz, data->blocks, data->flags);
+	dmae->dma_in_progress = true;
+	dmaengine_submit(dmae->dma_desc_current);
+	dma_async_issue_pending(dmae->dma_current);
+
+	if (host->variant->qcom_dml)
+		dml_start_xfer(host, data);
+
+	datactrl |= MCI_DPSM_DMAENABLE;
+
+	/* Trigger the DMA transfer */
+	mmci_write_datactrlreg(host, datactrl);
+
+	/*
+	 * Let the MMCI say when the data is ended and it's time
+	 * to fire next DMA request. When that happens, MMCI will
+	 * call mmci_data_end()
+	 */
+	writel(readl(host->base + MMCIMASK0) | MCI_DATAENDMASK,
+	       host->base + MMCIMASK0);
+	return 0;
+}
+
+static void dmaengine_get_next_data(struct mmci_host *host,
+				    struct mmc_data *data)
+{
+	struct dmaengine_priv *dmae = host->dma_priv;
+	struct dmaengine_next *next = &dmae->next_data;
+
+	WARN_ON(data->host_cookie && data->host_cookie != next->cookie);
+	WARN_ON(!data->host_cookie && (next->dma_desc || next->dma_chan));
+
+	dmae->dma_desc_current = next->dma_desc;
+	dmae->dma_current = next->dma_chan;
+	next->dma_desc = NULL;
+	next->dma_chan = NULL;
+}
+
+static void dmaengine_pre_req(struct mmci_host *host, struct mmc_data *data)
+{
+	struct dmaengine_priv *dmae = host->dma_priv;
+	struct dmaengine_next *nd = &dmae->next_data;
+
+	if (!dmaengine_prep_next(host, data))
+		data->host_cookie = ++nd->cookie < 0 ? 1 : nd->cookie;
+}
+
+static void dmaengine_post_req(struct mmci_host *host,
+			       struct mmc_data *data, int err)
+{
+	struct dmaengine_priv *dmae = host->dma_priv;
+
+	dmaengine_unmap(host, data);
+
+	if (err) {
+		struct dmaengine_next *next = &dmae->next_data;
+		struct dma_chan *chan;
+
+		if (data->flags & MMC_DATA_READ)
+			chan = dmae->dma_rx_channel;
+		else
+			chan = dmae->dma_tx_channel;
+		dmaengine_terminate_all(chan);
+
+		if (dmae->dma_desc_current == next->dma_desc)
+			dmae->dma_desc_current = NULL;
+
+		if (dmae->dma_current == next->dma_chan) {
+			dmae->dma_in_progress = false;
+			dmae->dma_current = NULL;
+		}
+
+		next->dma_desc = NULL;
+		next->dma_chan = NULL;
+		data->host_cookie = 0;
+	}
+}
+
+struct mmci_dma_ops dmaengine = {
+	.setup = dmaengine_setup,
+	.release = dmaengine_release,
+	.pre_req = dmaengine_pre_req,
+	.start = dmaengine_start,
+	.finalize = dmaengine_finalize,
+	.post_req = dmaengine_post_req,
+	.error = dmaengine_error,
+	.get_next_data = dmaengine_get_next_data,
+};
+#else
+struct mmci_dma_ops dmaengine = {};
+#endif
diff --git a/drivers/mmc/host/mmci_dma.h b/drivers/mmc/host/mmci_dma.h
new file mode 100644
index 0000000..33e4e8a
--- /dev/null
+++ b/drivers/mmc/host/mmci_dma.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Ludovic.barre@st.com for STMicroelectronics.
+ */
+#ifndef __MMC_DMA_H__
+#define __MMC_DMA_H__
+
+struct mmci_dma_ops {
+	int (*setup)(struct mmci_host *host);
+	void (*release)(struct mmci_host *host);
+	void (*pre_req)(struct mmci_host *host, struct mmc_data *data);
+	int (*start)(struct mmci_host *host, unsigned int datactrl);
+	void (*finalize)(struct mmci_host *host, struct mmc_data *data);
+	void (*post_req)(struct mmci_host *host,
+			 struct mmc_data *data, int err);
+	void (*error)(struct mmci_host *host);
+	void (*get_next_data)(struct mmci_host *host, struct mmc_data *data);
+};
+
+int mmci_dma_setup(struct mmci_host *host);
+int mmci_dma_start(struct mmci_host *host, unsigned int datactrl);
+void mmci_dma_release(struct mmci_host *host);
+void mmci_dma_pre_req(struct mmci_host *host, struct mmc_data *data);
+void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data);
+void mmci_dma_post_req(struct mmci_host *host,
+		       struct mmc_data *data, int err);
+void mmci_dma_error(struct mmci_host *host);
+void mmci_dma_get_next_data(struct mmci_host *host, struct mmc_data *data);
+
+#endif /* __MMC_DMA_H__ */
-- 
2.7.4
