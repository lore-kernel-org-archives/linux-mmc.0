From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 1/2] [MMCI] add DMA support using dmaengine
Date: Thu, 11 Feb 2010 16:15:17 +0100
Message-ID: <1265901317-3837-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:58015 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753054Ab0BKPvz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Feb 2010 10:51:55 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: STEricsson_nomadik_linux@list.st.com, Alessandro Rubini <rubini@unipv.it>, Linus Walleij <linus.walleij@stericsson.com>, Dan Williams <dan.j.williams@intel.com>

This extends the MMCI/PL180/PL181 driver with generic
support for DMA operation using the DMA engine. This
approach is already used in the Atmel MCI driver,
execept that this modification relies totally on the
DMA engine to handle transfers, no calls to any custom
DMA API (as in the Atmel case) is involved. So by
compiling in a DMA engine and specifying 3 parameters
in the platform data we get DMA on the MMCI.

This also adds some kerneldoc the the mmci_platform_data
struct so it can be easier understood.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
This was tested with the recently included U300
COH 901 318 DMA driver in drivers/dma/coh901318*, and
it actually works like a charm, albeit pending a few bug
fixes in the COH 901 318 DMA. It was regression tested
by disabling the DMA engine and running just PIO (no
problems) and then also regression-compiled for Realview,
Versatile and Integrator.

Custom DMA controllers would perhaps need additional
callbacks for probe/submit dma/end dma/exit but I cannot
foresee any such use right now so let's keep it simple.

If this approach works for MMCI I will proceed to
implement something similar in the PL022 SPI driver.

If this is OK with involved parties I prefer to push
it through Russells patch tracker since the platform
config and related patches need to go that way.

BTW Russell, I've got a few more MMCI TODO:s (nicing it up
with dev_* macros and hopefully support for SDIO and
the power management callbacks used by OMAP come to
mind) so if you want to, I can assume maintenanceship
of it.
---
 drivers/mmc/host/mmci.c   |  274 ++++++++++++++++++++++++++++++++++++++-------
 drivers/mmc/host/mmci.h   |    6 +-
 include/linux/amba/mmci.h |   33 +++++-
 3 files changed, 268 insertions(+), 45 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 643818a..72f23e9 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2,6 +2,7 @@
  *  linux/drivers/mmc/host/mmci.c - ARM PrimeCell MMCI PL180/1 driver
  *
  *  Copyright (C) 2003 Deep Blue Solutions, Ltd, All Rights Reserved.
+ *  Copyright (C) 2010 ST-Ericsson AB.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -22,8 +23,10 @@
 #include <linux/clk.h>
 #include <linux/scatterlist.h>
 #include <linux/gpio.h>
-#include <linux/amba/mmci.h>
 #include <linux/regulator/consumer.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/amba/mmci.h>
 
 #include <asm/cacheflush.h>
 #include <asm/div64.h>
@@ -98,12 +101,195 @@ static void mmci_stop_data(struct mmci_host *host)
 	host->data = NULL;
 }
 
+static void
+mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
+{
+	void __iomem *base = host->base;
+
+	DBG(host, "op %02x arg %08x flags %08x\n",
+	    cmd->opcode, cmd->arg, cmd->flags);
+
+	if (readl(base + MMCICOMMAND) & MCI_CPSM_ENABLE) {
+		writel(0, base + MMCICOMMAND);
+		udelay(1);
+	}
+
+	c |= cmd->opcode | MCI_CPSM_ENABLE;
+	if (cmd->flags & MMC_RSP_PRESENT) {
+		if (cmd->flags & MMC_RSP_136)
+			c |= MCI_CPSM_LONGRSP;
+		c |= MCI_CPSM_RESPONSE;
+	}
+	if (/*interrupt*/0)
+		c |= MCI_CPSM_INTERRUPT;
+
+	host->cmd = cmd;
+
+	writel(cmd->arg, base + MMCIARGUMENT);
+	writel(c, base + MMCICOMMAND);
+}
+
+/*
+ * All the DMA operation mode stuff goes inside this ifdef.
+ * This assumes that you have a generic DMA engine interface,
+ * no custom DMA interfaces are supported.
+ */
+#ifdef CONFIG_DMA_ENGINE
+static void __devinit mmci_setup_dma(struct mmci_host *host)
+{
+	struct mmci_platform_data *plat = host->plat;
+	dma_cap_mask_t mask;
+
+	/* Try to acquire a generic DMA engine channel */
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	/*
+	 * If only an RX channel is specified, the driver will
+	 * attempt to use it bidirectionally, however if it is
+	 * is specified but cannot be located, DMA will be disabled.
+	 */
+	host->dma_rx_channel = dma_request_channel(mask,
+						plat->dma_filter,
+						plat->dma_rx_param);
+	if (plat->dma_tx_param) {
+		host->dma_tx_channel = dma_request_channel(mask,
+							   plat->dma_filter,
+							   plat->dma_tx_param);
+		if (!host->dma_tx_channel) {
+			dma_release_channel(host->dma_rx_channel);
+			host->dma_rx_channel = NULL;
+		}
+	} else {
+		host->dma_tx_channel = host->dma_rx_channel;
+	}
+}
+
+static void __devexit mmci_disable_dma(struct mmci_host *host)
+{
+	if (host->dma_rx_channel)
+		dma_release_channel(host->dma_rx_channel);
+	if (host->dma_tx_channel)
+		dma_release_channel(host->dma_tx_channel);
+}
+
+static void mmci_dma_data_end(struct mmci_host *host)
+{
+	struct mmc_data *data = host->data;
+
+	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+		     (data->flags & MMC_DATA_WRITE)
+		     ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+}
+
+static void mmci_dma_data_error(struct mmci_host *host)
+{
+	struct mmc_data *data = host->data;
+	struct dma_chan *chan;
+
+	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
+	if (data->flags & MMC_DATA_READ)
+		chan = host->dma_rx_channel;
+	else
+		chan = host->dma_tx_channel;
+	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+		     (data->flags & MMC_DATA_WRITE)
+		     ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	chan->device->device_terminate_all(chan);
+}
+
+/*
+ * This one gets called repeatedly to copy data using
+ * DMA until there is no more data left to copy.
+ */
+static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
+{
+	struct mmc_data *data = host->data;
+	enum dma_data_direction direction;
+	struct dma_chan *chan;
+	struct dma_async_tx_descriptor *desc;
+	struct scatterlist *sg;
+	unsigned int sglen;
+	int i;
+
+	datactrl |= MCI_DPSM_DMAENABLE;
+	if (data->flags & MMC_DATA_READ) {
+		direction = DMA_FROM_DEVICE;
+		chan = host->dma_rx_channel;
+	} else {
+		direction = DMA_TO_DEVICE;
+		chan = host->dma_tx_channel;
+	}
+
+	/* Check for weird stuff in the sg list */
+	for_each_sg(data->sg, sg, data->sg_len, i) {
+		if (sg->offset & 3 || sg->length & 3)
+			return -EINVAL;
+	}
+
+	sglen = dma_map_sg(mmc_dev(host->mmc), data->sg,
+			   data->sg_len, direction);
+	if (sglen != data->sg_len)
+		goto unmap_exit;
+
+	desc = chan->device->device_prep_slave_sg(chan,
+					data->sg, data->sg_len, direction,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc)
+		goto unmap_exit;
+
+	host->dma_desc = desc;
+	dev_vdbg(mmc_dev(host->mmc), "Submit MMCI DMA job, sglen %d "
+		 "blksz %04x blks %04x flags %08x\n",
+		 sglen, data->blksz, data->blocks, data->flags);
+	desc->tx_submit(desc);
+	chan->device->device_issue_pending(chan);
+
+	/* Trigger the DMA transfer */
+	writel(datactrl, host->base + MMCIDATACTRL);
+	/*
+	 * Let the MMCI say when the data is ended and it's time
+	 * to fire next DMA request. When that happens, MMCI will
+	 * call mmci_data_end()
+	 */
+	writel(readl(host->base + MMCIMASK0) | MCI_DATAENDMASK,
+	       host->base + MMCIMASK0);
+	return 0;
+
+unmap_exit:
+	dma_unmap_sg(mmc_dev(host->mmc), data->sg, sglen, direction);
+	return -ENOMEM;
+}
+#else
+/* Blank functions if the DMA engine is not available */
+static inline void mmci_setup_dma(struct mmci_host *host)
+{
+}
+
+static inline void mmci_disable_dma(struct mmci_host *host)
+{
+}
+
+static inline void mmci_dma_data_end(struct mmci_host *host)
+{
+}
+
+static inline void mmci_dma_data_error(struct mmci_host *host)
+{
+}
+
+static inline int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
+{
+	return -ENOSYS;
+}
+#endif
+
 static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 {
 	unsigned int datactrl, timeout, irqmask;
 	unsigned long long clks;
 	void __iomem *base;
 	int blksz_bits;
+	int ret;
 
 	DBG(host, "blksz %04x blks %04x flags %08x\n",
 	    data->blksz, data->blocks, data->flags);
@@ -112,8 +298,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	host->size = data->blksz;
 	host->data_xfered = 0;
 
-	mmci_init_sg(host, data);
-
 	clks = (unsigned long long)data->timeout_ns * host->cclk;
 	do_div(clks, 1000000000UL);
 
@@ -127,13 +311,30 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	BUG_ON(1 << blksz_bits != data->blksz);
 
 	datactrl = MCI_DPSM_ENABLE | blksz_bits << 4;
-	if (data->flags & MMC_DATA_READ) {
+
+	if (data->flags & MMC_DATA_READ)
 		datactrl |= MCI_DPSM_DIRECTION;
+
+	if (host->dma_rx_channel) {
+		/*
+		 * Attempt to use DMA operation mode, if this
+		 * should fail, fall back to PIO mode
+		 */
+		ret = mmci_dma_start_data(host, datactrl);
+		if (!ret)
+			return;
+	}
+
+	/* IRQ mode, map the SG list for CPU reading/writing */
+	mmci_init_sg(host, data);
+
+	if (data->flags & MMC_DATA_READ) {
 		irqmask = MCI_RXFIFOHALFFULLMASK;
 
 		/*
-		 * If we have less than a FIFOSIZE of bytes to transfer,
-		 * trigger a PIO interrupt as soon as any data is available.
+		 * If we have less than a FIFOSIZE of bytes to
+		 * transfer, trigger a PIO interrupt as soon as any
+		 * data is available.
 		 */
 		if (host->size < MCI_FIFOSIZE)
 			irqmask |= MCI_RXDATAAVLBLMASK;
@@ -146,39 +347,12 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	}
 
 	writel(datactrl, base + MMCIDATACTRL);
+	/* No interrupt when data ends */
 	writel(readl(base + MMCIMASK0) & ~MCI_DATAENDMASK, base + MMCIMASK0);
 	writel(irqmask, base + MMCIMASK1);
 }
 
 static void
-mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
-{
-	void __iomem *base = host->base;
-
-	DBG(host, "op %02x arg %08x flags %08x\n",
-	    cmd->opcode, cmd->arg, cmd->flags);
-
-	if (readl(base + MMCICOMMAND) & MCI_CPSM_ENABLE) {
-		writel(0, base + MMCICOMMAND);
-		udelay(1);
-	}
-
-	c |= cmd->opcode | MCI_CPSM_ENABLE;
-	if (cmd->flags & MMC_RSP_PRESENT) {
-		if (cmd->flags & MMC_RSP_136)
-			c |= MCI_CPSM_LONGRSP;
-		c |= MCI_CPSM_RESPONSE;
-	}
-	if (/*interrupt*/0)
-		c |= MCI_CPSM_INTERRUPT;
-
-	host->cmd = cmd;
-
-	writel(cmd->arg, base + MMCIARGUMENT);
-	writel(c, base + MMCICOMMAND);
-}
-
-static void
 mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	      unsigned int status)
 {
@@ -197,6 +371,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 #endif
 	}
 	if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
+		dev_dbg(mmc_dev(host->mmc), "MCI ERROR IRQ (status %08x)\n", status);
 		if (status & MCI_DATACRCFAIL)
 			data->error = -EILSEQ;
 		else if (status & MCI_DATATIMEOUT)
@@ -205,14 +380,19 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 			data->error = -EIO;
 		status |= MCI_DATAEND;
 
-		/*
-		 * We hit an error condition.  Ensure that any data
-		 * partially written to a page is properly coherent.
-		 */
-		if (host->sg_len && data->flags & MMC_DATA_READ)
-			flush_dcache_page(sg_page(host->sg_ptr));
+		if (host->dma_rx_channel) {
+			mmci_dma_data_error(host);
+		} else {
+			/*
+			 * We hit an error condition.  Ensure that any data
+			 * partially written to a page is properly coherent.
+			 */
+			if (host->sg_len && data->flags & MMC_DATA_READ)
+				flush_dcache_page(sg_page(host->sg_ptr));
+		}
 	}
 	if (status & MCI_DATAEND) {
+		mmci_dma_data_end(host);
 		mmci_stop_data(host);
 
 		if (!data->stop) {
@@ -708,6 +888,8 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 			goto err_gpio_wp;
 	}
 
+	mmci_setup_dma(host);
+
 	ret = request_irq(dev->irq[0], mmci_irq, IRQF_SHARED, DRIVER_NAME " (cmd)", host);
 	if (ret)
 		goto unmap;
@@ -723,9 +905,13 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 
 	mmc_add_host(mmc);
 
-	printk(KERN_INFO "%s: MMCI rev %x cfg %02x at 0x%016llx irq %d,%d\n",
-		mmc_hostname(mmc), amba_rev(dev), amba_config(dev),
-		(unsigned long long)dev->res.start, dev->irq[0], dev->irq[1]);
+	dev_info(&dev->dev, "%s: MMCI/PL180 manf %x rev %x cfg %02x at 0x%016llx\n",
+		 mmc_hostname(mmc), amba_manf(dev), amba_rev(dev), amba_config(dev),
+		 (unsigned long long)dev->res.start);
+	dev_info(&dev->dev, "IRQ %d, %d (pio), DMA RX %s, DMA TX %s\n",
+		 dev->irq[0], dev->irq[1],
+		 host->dma_rx_channel ? dma_chan_name(host->dma_rx_channel) : "NOT USED",
+		 host->dma_tx_channel ? dma_chan_name(host->dma_tx_channel) : "NOT USED");
 
 	init_timer(&host->timer);
 	host->timer.data = (unsigned long)host;
@@ -736,6 +922,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
 	return 0;
 
  irq0_free:
+	mmci_disable_dma(host);
 	free_irq(dev->irq[0], host);
  unmap:
 	if (host->gpio_wp != -ENOSYS)
@@ -776,6 +963,7 @@ static int __devexit mmci_remove(struct amba_device *dev)
 		writel(0, host->base + MMCICOMMAND);
 		writel(0, host->base + MMCIDATACTRL);
 
+		mmci_disable_dma(host);
 		free_irq(dev->irq[0], host);
 		free_irq(dev->irq[1], host);
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 1ceb9a9..c29bc6f 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -137,7 +137,6 @@
  * The size of the FIFO in bytes.
  */
 #define MCI_FIFOSIZE	(16*4)
-	
 #define MCI_FIFOHALFSIZE (MCI_FIFOSIZE / 2)
 
 #define NR_SG		16
@@ -175,7 +174,12 @@ struct mmci_host {
 	struct scatterlist	*sg_ptr;
 	unsigned int		sg_off;
 	unsigned int		size;
+
 	struct regulator	*vcc;
+	/* DMA stuff */
+	struct dma_chan		*dma_rx_channel;
+	struct dma_chan		*dma_tx_channel;
+	struct dma_async_tx_descriptor *dma_desc;
 };
 
 static inline void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
index 6b42417..a4937a8 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -6,13 +6,44 @@
 
 #include <linux/mmc/host.h>
 
+/**
+ * struct mmci_platform_data - platform configuration for the MMCI
+ * (also known as PL180) block.
+ * @ocr_mask: available voltages on the 4 pins from the block, this
+ * is ignored if a regulator is used, see the MMC_VDD_* masks in
+ * mmc/host.h
+ * @translate_vdd: a callback function to translate a MMC_VDD_*
+ * mask into a value to be binary or:ed and written into the
+ * MMCIPWR register of the block
+ * @status: if no GPIO read function was given to the block in
+ * gpio_wp (below) this function will be called to determine
+ * whether a card is present in the MMC slot or not
+ * @gpio_wp: read this GPIO pin to see if the card is write protected
+ * @gpio_cd: read this GPIO pin to detect card insertion
+ * @capabilities: the capabilities of the block as implemented in
+ * this platform, signify anything MMC_CAP_* from mmc/host.h
+ * @dma_filter: function used to select an apropriate RX and TX
+ * DMA channel to be used for DMA, if and only if you're deploying the
+ * generic DMA engine
+ * @dma_rx_param: parameter passed to the DMA allocation
+ * filter in order to select an apropriate RX channel. If
+ * there is a bidirectional RX+TX channel, then just specify
+ * this and leave dma_tx_param set to NULL
+ * @dma_tx_param: parameter passed to the DMA allocation
+ * filter in order to select an apropriate TX channel. If this
+ * is NULL the driver will attempt to use the RX channel as a
+ * bidirectional channel
+ */
 struct mmci_platform_data {
-	unsigned int ocr_mask;			/* available voltages */
+	unsigned int ocr_mask;
 	u32 (*translate_vdd)(struct device *, unsigned int);
 	unsigned int (*status)(struct device *);
 	int	gpio_wp;
 	int	gpio_cd;
 	unsigned long capabilities;
+	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
+	void *dma_rx_param;
+	void *dma_tx_param;
 };
 
 #endif
-- 
1.6.3.3

