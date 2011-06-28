From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 3/4] mmci: sync DATAEND irq with dma|pio transfer done
Date: Tue, 28 Jun 2011 09:57:40 +0200
Message-ID: <1309247860-17181-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>
List-Id: linux-mmc@vger.kernel.org

From: Ulf Hansson <ulf.hansson@stericsson.com>

The end of a dma|pio data transfer is synced with the
DATAEND irq. This will prevent the mmci driver from ending
the request before the dma|pio job is completely done.

For dma we use DMA_PREP_INTERRUPT to register a callback
function which is called when dma driver is done with job.

To also make sure we prevent hanging forever, waiting for
DATAEND irq or a dma|pio transfer to be done, we setup a timer
when either a DATAEND or dma|pio job is done. Once both
conditions have occured, the timer is cancelled and the data
transfer is completed.

If a timeout occurs, the data transfer is terminated in a
controlled manner and EAGAIN is returned to the framework.
A timeout value of 50 ms has been found to work well for
our usecases.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |  211 +++++++++++++++++++++++++++--------------------
 drivers/mmc/host/mmci.h |    7 ++-
 2 files changed, 126 insertions(+), 92 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index c73d054..93dcd2a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -37,6 +37,7 @@
 #include "mmci.h"
 
 #define DRIVER_NAME "mmci-pl18x"
+#define DATAEND_TIMEOUT_MS 50
 
 static unsigned int fmax = 515633;
 
@@ -209,6 +210,67 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
 	sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
 }
 
+static void
+mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
+{
+	void __iomem *base = host->base;
+
+	dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
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
+static void mmci_complete_data_xfer(struct mmci_host *host)
+{
+	struct mmc_data *data = host->data;
+
+	if (((host->size == 0) && host->dataend) || data->error) {
+
+		/*
+		 * The data transfer is done and then there is no need for the
+		 * a delayed work any more, thus remove it.
+		 */
+		host->dataend_timeout_active = false;
+		__cancel_delayed_work(&host->dataend_timeout);
+
+		mmci_stop_data(host);
+
+		if (!data->error)
+			data->bytes_xfered = data->blksz * data->blocks;
+
+		if (!data->stop)
+			mmci_request_end(host, data->mrq);
+		else
+			mmci_start_command(host, data->stop, 0);
+	} else {
+		/*
+		 * Schedule a delayed work to make sure we do not end up
+		 * forever waiting for a data transfer to be finished.
+		 */
+		host->dataend_timeout_active = true;
+		schedule_delayed_work(&host->dataend_timeout,
+				msecs_to_jiffies(DATAEND_TIMEOUT_MS));
+	}
+}
+
 /*
  * All the DMA operation mode stuff goes inside this ifdef.
  * This assumes that you have a generic DMA device interface,
@@ -306,28 +368,6 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 {
 	struct dma_chan *chan = host->dma_current;
 	enum dma_data_direction dir;
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
-		dmaengine_terminate_all(chan);
-		if (!data->error)
-			data->error = -EIO;
-	}
 
 	if (data->flags & MMC_DATA_WRITE) {
 		dir = DMA_TO_DEVICE;
@@ -336,21 +376,31 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
 	}
 
 	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len, dir);
+	host->dma_current = NULL;
+}
 
-	/*
-	 * Use of DMA with scatter-gather is impossible.
-	 * Give up with DMA and switch back to PIO mode.
-	 */
-	if (status & MCI_RXDATAAVLBLMASK) {
-		dev_err(mmc_dev(host->mmc), "buggy DMA detected. Taking evasive action.\n");
-		mmci_dma_release(host);
-	}
+static void mmci_dma_callback(void *arg)
+{
+	unsigned long flags;
+	struct mmci_host *host = arg;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	mmci_dma_unmap(host, host->data);
+
+	/* Mark that the entire data is transferred. */
+	host->size = 0;
+
+	mmci_complete_data_xfer(host);
+
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static void mmci_dma_data_error(struct mmci_host *host)
 {
 	dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
 	dmaengine_terminate_all(host->dma_current);
+	host->dma_current = NULL;
 }
 
 static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
@@ -370,8 +420,6 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	struct dma_async_tx_descriptor *desc;
 	int nr_sg;
 
-	host->dma_current = NULL;
-
 	if (data->flags & MMC_DATA_READ) {
 		conf.direction = DMA_FROM_DEVICE;
 		chan = host->dma_rx_channel;
@@ -395,10 +443,15 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 
 	dmaengine_slave_config(chan, &conf);
 	desc = device->device_prep_slave_sg(chan, data->sg, nr_sg,
-					    conf.direction, DMA_CTRL_ACK);
+					    conf.direction,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
 	if (!desc)
 		goto unmap_exit;
 
+	/* Setup dma callback function. */
+	desc->callback = mmci_dma_callback;
+	desc->callback_param = host;
+
 	/* Okay, go for it. */
 	host->dma_current = chan;
 
@@ -413,13 +466,6 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
 	/* Trigger the DMA transfer */
 	writel(datactrl, host->base + MMCIDATACTRL);
 
-	/*
-	 * Let the MMCI say when the data is ended and it's time
-	 * to fire next DMA request. When that happens, MMCI will
-	 * call mmci_data_end()
-	 */
-	writel(readl(host->base + MMCIMASK0) | MCI_DATAENDMASK,
-	       host->base + MMCIMASK0);
 	return 0;
 
 unmap_exit:
@@ -451,6 +497,27 @@ static inline int mmci_dma_start_data(struct mmci_host *host, unsigned int datac
 }
 #endif
 
+static void mmci_dataend_timeout(struct work_struct *work)
+{
+	unsigned long flags;
+	struct mmci_host *host =
+		container_of(work, struct mmci_host, dataend_timeout.work);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (host->dataend_timeout_active) {
+		dev_err(mmc_dev(host->mmc), "datatransfer timeout!\n");
+
+		if (dma_inprogress(host))
+			mmci_dma_data_error(host);
+
+		host->data->error = -EAGAIN;
+		mmci_complete_data_xfer(host);
+	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
 static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 {
 	struct variant_data *variant = host->variant;
@@ -464,6 +531,7 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 
 	host->data = data;
 	host->size = data->blksz * data->blocks;
+	host->dataend = false;
 	data->bytes_xfered = 0;
 
 	clks = (unsigned long long)data->timeout_ns * host->cclk;
@@ -520,39 +588,10 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 			datactrl |= MCI_ST_DPSM_SDIOEN;
 
 	writel(datactrl, base + MMCIDATACTRL);
-	writel(readl(base + MMCIMASK0) & ~MCI_DATAENDMASK, base + MMCIMASK0);
 	mmci_set_mask1(host, irqmask);
 }
 
 static void
-mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
-{
-	void __iomem *base = host->base;
-
-	dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
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
@@ -599,21 +638,11 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	if (status & MCI_DATABLOCKEND)
 		dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");
 
-	if (status & MCI_DATAEND || data->error) {
-		if (dma_inprogress(host))
-			mmci_dma_unmap(host, data);
-		mmci_stop_data(host);
-
-		if (!data->error)
-			/* The error clause is handled above, success! */
-			data->bytes_xfered = data->blksz * data->blocks;
+	if (status & MCI_DATAEND)
+		host->dataend = true;
 
-		if (!data->stop) {
-			mmci_request_end(host, data->mrq);
-		} else {
-			mmci_start_command(host, data->stop, 0);
-		}
-	}
+	if (host->dataend || data->error)
+		mmci_complete_data_xfer(host);
 }
 
 static void
@@ -636,8 +665,11 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	}
 
 	if (!cmd->data || cmd->error) {
-		if (host->data)
+		if (host->data) {
+			if (dma_inprogress(host))
+				mmci_dma_data_error(host);
 			mmci_stop_data(host);
+		}
 		mmci_request_end(host, cmd->mrq);
 	} else if (!(cmd->data->flags & MMC_DATA_READ)) {
 		mmci_start_data(host, cmd->data);
@@ -793,15 +825,10 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 	if (status & MCI_RXACTIVE && host->size < variant->fifohalfsize)
 		mmci_set_mask1(host, MCI_RXDATAAVLBLMASK);
 
-	/*
-	 * If we run out of data, disable the data IRQs; this
-	 * prevents a race where the FIFO becomes empty before
-	 * the chip itself has disabled the data path, and
-	 * stops us racing with our data end IRQ.
-	 */
+	/* If we run out of data, disable the data IRQs. */
 	if (host->size == 0) {
 		mmci_set_mask1(host, 0);
-		writel(readl(base + MMCIMASK0) | MCI_DATAENDMASK, base + MMCIMASK0);
+		mmci_complete_data_xfer(host);
 	}
 
 	return IRQ_HANDLED;
@@ -1200,6 +1227,7 @@ static int __devinit mmci_probe(struct amba_device *dev,
 		 dev->irq[0], dev->irq[1]);
 
 	mmci_dma_setup(host);
+	INIT_DELAYED_WORK(&host->dataend_timeout, mmci_dataend_timeout);
 
 	mmc_add_host(mmc);
 
@@ -1247,6 +1275,7 @@ static int __devexit mmci_remove(struct amba_device *dev)
 		writel(0, host->base + MMCIDATACTRL);
 
 		mmci_dma_release(host);
+		cancel_delayed_work(&host->dataend_timeout);
 		free_irq(dev->irq[0], host);
 		if (!host->singleirq)
 			free_irq(dev->irq[1], host);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 2164e8c..79156a0 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -153,7 +153,7 @@
 #define MCI_IRQENABLE	\
 	(MCI_CMDCRCFAILMASK|MCI_DATACRCFAILMASK|MCI_CMDTIMEOUTMASK|	\
 	MCI_DATATIMEOUTMASK|MCI_TXUNDERRUNMASK|MCI_RXOVERRUNMASK|	\
-	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_STARTBITERRMASK)
+	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_STARTBITERRMASK|MCI_DATAENDMASK)
 
 /* These interrupts are directed to IRQ1 when two IRQ lines are available */
 #define MCI_IRQ1MASK \
@@ -198,6 +198,11 @@ struct mmci_host {
 	unsigned int		size;
 	struct regulator	*vcc;
 
+	/* sync of DATAEND irq */
+	bool			dataend;
+	bool			dataend_timeout_active;
+	struct delayed_work	dataend_timeout;
+
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
 	struct dma_chan		*dma_current;
-- 
1.7.3.2
