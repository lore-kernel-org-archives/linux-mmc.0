From: ludovic.desroches@atmel.com
Subject: [PATCH v2 4/8] mmc: atmel-mci: add pdc support and runtime capabilities detection
Date: Thu, 11 Aug 2011 17:25:44 +0200
Message-ID: <9f94e8b1ed64d2a7d96186a4fbf654b53c553314.1313071126.git.ludovic.desroches@atmel.com>
References: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
 <1313076348-3065-1-git-send-email-ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:32719 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab1HKOQQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Aug 2011 10:16:16 -0400
In-Reply-To: <1313076348-3065-1-git-send-email-ludovic.desroches@atmel.com>
In-Reply-To: <3408076e8bc2e7b3ad3bb4d3ae3859ab665a59aa.1313071125.git.ludovic.desroches@atmel.com>
References: <3408076e8bc2e7b3ad3bb4d3ae3859ab665a59aa.1313071125.git.ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Add the pdc support for atmel-mci. It makes at91-mci driver useless because
it was only used for the old atmel MCI core which has pdc but no dma support.
To allow removing at91-mci, the capabilites of the MCI core is detected at
runtime, then the driver will use pio, pdc or dma transfers.
Warning: at91rm9200 is not supported, to support it we need to use swab32 on
data but I have no board to test it.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci-regs.h |   14 +
 drivers/mmc/host/atmel-mci.c      |  528 ++++++++++++++++++++++++++++--------
 2 files changed, 424 insertions(+), 118 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci-regs.h b/drivers/mmc/host/atmel-mci-regs.h
index 7310b20..6dd2826 100644
--- a/drivers/mmc/host/atmel-mci-regs.h
+++ b/drivers/mmc/host/atmel-mci-regs.h
@@ -88,8 +88,14 @@
 # define ATMCI_BLKE			(  1 <<   3)	/* Data Block Ended */
 # define ATMCI_DTIP			(  1 <<   4)	/* Data Transfer In Progress */
 # define ATMCI_NOTBUSY			(  1 <<   5)	/* Data Not Busy */
+# define ATMCI_ENDRX			(  1 <<   6)    /* End of RX Buffer */
+# define ATMCI_ENDTX			(  1 <<   7)    /* End of TX Buffer */
 # define ATMCI_SDIOIRQA			(  1 <<   8)	/* SDIO IRQ in slot A */
 # define ATMCI_SDIOIRQB			(  1 <<   9)	/* SDIO IRQ in slot B */
+# define ATMCI_SDIOWAIT			(  1 <<  12)    /* SDIO Read Wait Operation Status */
+# define ATMCI_CSRCV			(  1 <<  13)    /* CE-ATA Completion Signal Received */
+# define ATMCI_RXBUFF			(  1 <<  14)    /* RX Buffer Full */
+# define ATMCI_TXBUFE			(  1 <<  15)    /* TX Buffer Empty */
 # define ATMCI_RINDE			(  1 <<  16)	/* Response Index Error */
 # define ATMCI_RDIRE			(  1 <<  17)	/* Response Direction Error */
 # define ATMCI_RCRCE			(  1 <<  18)	/* Response CRC Error */
@@ -97,6 +103,13 @@
 # define ATMCI_RTOE			(  1 <<  20)	/* Response Time-Out Error */
 # define ATMCI_DCRCE			(  1 <<  21)	/* Data CRC Error */
 # define ATMCI_DTOE			(  1 <<  22)	/* Data Time-Out Error */
+# define ATMCI_CSTOE			(  1 <<  23)    /* Completion Signql Time-out Error */
+# define ATMCI_BLKOVRE			(  1 <<  24)    /* DMA Block Overrun Error */
+# define ATMCI_DMADONE			(  1 <<  25)    /* DMA Transfer Done */
+# define ATMCI_FIFOEMPTY		(  1 <<  26)    /* FIFO Empty Flag */
+# define ATMCI_XFRDONE			(  1 <<  27)    /* Transfer Done Flag */
+# define ATMCI_ACKRCV			(  1 <<  28)    /* Boot Operation Acknowledge Received */
+# define ATMCI_ACKRCVE			(  1 <<  29)    /* Boot Operation Acknowledge Error */
 # define ATMCI_OVRE			(  1 <<  30)	/* RX Overrun Error */
 # define ATMCI_UNRE			(  1 <<  31)	/* TX Underrun Error */
 #define ATMCI_DMA			0x0050	/* DMA Configuration[2] */
@@ -114,6 +127,7 @@
 #define ATMCI_WPSR			0x00e8	/* Write Protection Status[2] */
 # define ATMCI_GET_WP_VS(x)		((x) & 0x0f)
 # define ATMCI_GET_WP_VSRC(x)		(((x) >> 8) & 0xffff)
+#define ATMCI_VERSION			0x00FC  /* Version */
 #define ATMCI_FIFO_APERTURE		0x0200	/* FIFO Aperture[2] */
 
 /* This is not including the FIFO Aperture on MCI2 */
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 87eeccc..efbee87 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -30,6 +30,7 @@
 
 #include <mach/atmel-mci.h>
 #include <linux/atmel-mci.h>
+#include <linux/atmel_pdc.h>
 
 #include <asm/io.h>
 #include <asm/unaligned.h>
@@ -58,18 +59,35 @@ enum atmel_mci_state {
 	STATE_DATA_ERROR,
 };
 
+enum atmci_xfer_dir {
+	XFER_RECEIVE = 0,
+	XFER_TRANSMIT,
+};
+
+enum atmci_pdc_buf {
+	PDC_FIRST_BUF = 0,
+	PDC_SECOND_BUF,
+};
+
+struct atmel_mci_caps {
+	bool    has_dma;
+	bool    has_pdc;
+	bool    has_cfg_reg;
+	bool    has_cstor_reg;
+	bool    has_highspeed;
+	bool    has_rwproof;
+};
+
 struct atmel_mci_dma {
-#ifdef CONFIG_MMC_ATMELMCI_DMA
 	struct dma_chan			*chan;
 	struct dma_async_tx_descriptor	*data_desc;
-#endif
 };
 
 /**
  * struct atmel_mci - MMC controller state shared between all slots
  * @lock: Spinlock protecting the queue and associated data.
  * @regs: Pointer to MMIO registers.
- * @sg: Scatterlist entry currently being processed by PIO code, if any.
+ * @sg: Scatterlist entry currently being processed by PIO or PDC code.
  * @pio_offset: Offset into the current scatterlist entry.
  * @cur_slot: The slot which is currently using the controller.
  * @mrq: The request currently being processed on @cur_slot,
@@ -77,6 +95,7 @@ struct atmel_mci_dma {
  * @cmd: The command currently being sent to the card, or NULL.
  * @data: The data currently being transferred, or NULL if no data
  *	transfer is in progress.
+ * @data_size: just data->blocks * data->blksz.
  * @dma: DMA client state.
  * @data_chan: DMA channel being used for the current data transfer.
  * @cmd_status: Snapshot of SR taken upon completion of the current
@@ -103,6 +122,13 @@ struct atmel_mci_dma {
  * @mck: The peripheral bus clock hooked up to the MMC controller.
  * @pdev: Platform device associated with the MMC controller.
  * @slot: Slots sharing this MMC controller.
+ * @caps: MCI capabilities depending on MCI version.
+ * @prepare_data: function to setup MCI before data transfer which
+ * depends on MCI capabilities.
+ * @submit_data: function to start data transfer which depends on MCI
+ * capabilities.
+ * @stop_transfer: function to stop data transfer which depends on MCI
+ * capabilities.
  *
  * Locking
  * =======
@@ -143,6 +169,7 @@ struct atmel_mci {
 	struct mmc_request	*mrq;
 	struct mmc_command	*cmd;
 	struct mmc_data		*data;
+	unsigned int		data_size;
 
 	struct atmel_mci_dma	dma;
 	struct dma_chan		*data_chan;
@@ -167,6 +194,12 @@ struct atmel_mci {
 	struct platform_device	*pdev;
 
 	struct atmel_mci_slot	*slot[ATMCI_MAX_NR_SLOTS];
+
+	struct atmel_mci_caps   caps;
+
+	u32 (*prepare_data)(struct atmel_mci *host, struct mmc_data *data);
+	void (*submit_data)(struct atmel_mci *host, struct mmc_data *data);
+	void (*stop_transfer)(struct atmel_mci *host);
 };
 
 /**
@@ -220,31 +253,6 @@ struct atmel_mci_slot {
 	set_bit(event, &host->pending_events)
 
 /*
- * Enable or disable features/registers based on
- * whether the processor supports them
- */
-static bool atmci_has_rwproof(void)
-{
-	if (cpu_is_at91sam9261() || cpu_is_at91rm9200())
-		return false;
-	else
-		return true;
-}
-
-/*
- * The new MCI2 module isn't 100% compatible with the old MCI module,
- * and it has a few nice features which we want to use...
- */
-static inline bool atmci_is_mci2(void)
-{
-	if (cpu_is_at91sam9g45())
-		return true;
-
-	return false;
-}
-
-
-/*
  * The debugfs stuff below is mostly optimized away when
  * CONFIG_DEBUG_FS is not set.
  */
@@ -379,7 +387,7 @@ static int atmci_regs_show(struct seq_file *s, void *v)
 			buf[ATMCI_BLKR / 4],
 			buf[ATMCI_BLKR / 4] & 0xffff,
 			(buf[ATMCI_BLKR / 4] >> 16) & 0xffff);
-	if (atmci_is_mci2())
+	if (host->caps.has_cstor_reg)
 		seq_printf(s, "CSTOR:\t0x%08x\n", buf[ATMCI_CSTOR / 4]);
 
 	/* Don't read RSPR and RDR; it will consume the data there */
@@ -387,7 +395,7 @@ static int atmci_regs_show(struct seq_file *s, void *v)
 	atmci_show_status_reg(s, "SR", buf[ATMCI_SR / 4]);
 	atmci_show_status_reg(s, "IMR", buf[ATMCI_IMR / 4]);
 
-	if (atmci_is_mci2()) {
+	if (host->caps.has_dma) {
 		u32 val;
 
 		val = buf[ATMCI_DMA / 4];
@@ -396,6 +404,9 @@ static int atmci_regs_show(struct seq_file *s, void *v)
 				((val >> 4) & 3) ?
 					1 << (((val >> 4) & 3) + 1) : 1,
 				val & ATMCI_DMAEN ? " DMAEN" : "");
+	}
+	if (host->caps.has_cfg_reg) {
+		u32 val;
 
 		val = buf[ATMCI_CFG / 4];
 		seq_printf(s, "CFG:\t0x%08x%s%s%s%s\n",
@@ -574,33 +585,109 @@ static void atmci_send_stop_cmd(struct atmel_mci *host, struct mmc_data *data)
 	atmci_writel(host, ATMCI_IER, ATMCI_CMDRDY);
 }
 
-#ifdef CONFIG_MMC_ATMELMCI_DMA
-static void atmci_dma_cleanup(struct atmel_mci *host)
+/*
+ * Configure given PDC buffer taking care of alignement issues.
+ * Update host->data_size and host->sg.
+ */
+static void atmci_pdc_set_single_buf(struct atmel_mci *host,
+	enum atmci_xfer_dir dir, enum atmci_pdc_buf buf_nb)
+{
+	u32 pointer_reg, counter_reg;
+
+	if (dir == XFER_RECEIVE) {
+		pointer_reg = ATMEL_PDC_RPR;
+		counter_reg = ATMEL_PDC_RCR;
+	} else {
+		pointer_reg = ATMEL_PDC_TPR;
+		counter_reg = ATMEL_PDC_TCR;
+	}
+
+	if (buf_nb == PDC_SECOND_BUF) {
+		pointer_reg += 0x10;
+		counter_reg += 0x10;
+	}
+
+	atmci_writel(host, pointer_reg, sg_dma_address(host->sg));
+	if (host->data_size <= PAGE_SIZE) {
+		if (host->data_size & 0x3) {
+			/* If size is different from modulo 4, transfer bytes */
+			atmci_writel(host, counter_reg, host->data_size);
+			atmci_writel(host, ATMCI_MR, host->mode_reg | ATMCI_MR_PDCFBYTE);
+		} else {
+			/* Else transfer 32-bits words */
+			atmci_writel(host, counter_reg, host->data_size / 4);
+		}
+		host->data_size = 0;
+	} else {
+		/* We assume the size of a page is 32-bits aligned */
+		atmci_writel(host, counter_reg, PAGE_SIZE / 4);
+		host->data_size -= PAGE_SIZE;
+		if (host->data_size)
+			host->sg = sg_next(host->sg);
+	}
+}
+
+/*
+ * Configure PDC buffer according to the data size ie configuring one or two
+ * buffers. Don't use this function if you want to configure only the second
+ * buffer. In this case, use atmci_pdc_set_single_buf.
+ */
+static void atmci_pdc_set_both_buf(struct atmel_mci *host, int dir)
 {
-	struct mmc_data			*data = host->data;
+	atmci_pdc_set_single_buf(host, dir, PDC_FIRST_BUF);
+	if (host->data_size)
+		atmci_pdc_set_single_buf(host, dir, PDC_SECOND_BUF);
+}
+
+/*
+ * Unmap sg lists, called when transfer is finished.
+ */
+static void atmci_pdc_cleanup(struct atmel_mci *host)
+{
+	struct mmc_data         *data = host->data;
 
 	if (data)
-		dma_unmap_sg(host->dma.chan->device->dev,
-			     data->sg, data->sg_len,
-			     ((data->flags & MMC_DATA_WRITE)
-			      ? DMA_TO_DEVICE : DMA_FROM_DEVICE));
+		dma_unmap_sg(&host->pdev->dev,
+				data->sg, data->sg_len,
+				((data->flags & MMC_DATA_WRITE)
+				 ? DMA_TO_DEVICE : DMA_FROM_DEVICE));
 }
 
-static void atmci_stop_dma(struct atmel_mci *host)
+/*
+ * Disable PDC transfers. Update pending flags to EVENT_XFER_COMPLETE after
+ * having received ATMCI_TXBUFE or ATMCI_RXBUFF interrupt. Enable ATMCI_NOTBUSY
+ * interrupt needed for both transfer directions.
+ */
+static void atmci_pdc_complete(struct atmel_mci *host)
 {
-	struct dma_chan *chan = host->data_chan;
+	atmci_writel(host, ATMEL_PDC_PTCR, ATMEL_PDC_RXTDIS | ATMEL_PDC_TXTDIS);
+	atmci_pdc_cleanup(host);
 
-	if (chan) {
-		dmaengine_terminate_all(chan);
-		atmci_dma_cleanup(host);
-	} else {
-		/* Data transfer was stopped by the interrupt handler */
+	/*
+	 * If the card was removed, data will be NULL. No point trying
+	 * to send the stop command or waiting for NBUSY in this case.
+	 */
+	if (host->data) {
 		atmci_set_pending(host, EVENT_XFER_COMPLETE);
+		tasklet_schedule(&host->tasklet);
 		atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
 	}
 }
 
-/* This function is called by the DMA driver from tasklet context. */
+static void atmci_dma_cleanup(struct atmel_mci *host)
+{
+	struct mmc_data                 *data = host->data;
+
+	if (data)
+		dma_unmap_sg(host->dma.chan->device->dev,
+				data->sg, data->sg_len,
+				((data->flags & MMC_DATA_WRITE)
+				 ? DMA_TO_DEVICE : DMA_FROM_DEVICE));
+}
+
+/*
+ * This function is called by the DMA driver from tasklet context.
+ */
 static void atmci_dma_complete(void *arg)
 {
 	struct atmel_mci	*host = arg;
@@ -608,7 +695,7 @@ static void atmci_dma_complete(void *arg)
 
 	dev_vdbg(&host->pdev->dev, "DMA complete\n");
 
-	if (atmci_is_mci2())
+	if (host->caps.has_dma)
 		/* Disable DMA hardware handshaking on MCI */
 		atmci_writel(host, ATMCI_DMA, atmci_readl(host, ATMCI_DMA) & ~ATMCI_DMAEN);
 
@@ -646,7 +733,90 @@ static void atmci_dma_complete(void *arg)
 	}
 }
 
-static int
+/*
+ * Returns a mask of interrupt flags to be enabled after the whole
+ * request has been prepared.
+ */
+static u32 atmci_prepare_data(struct atmel_mci *host, struct mmc_data *data)
+{
+	u32 iflags;
+
+	data->error = -EINPROGRESS;
+
+	host->sg = data->sg;
+	host->data = data;
+	host->data_chan = NULL;
+
+	iflags = ATMCI_DATA_ERROR_FLAGS;
+
+	/*
+	 * Errata: MMC data write operation with less than 12
+	 * bytes is impossible.
+	 *
+	 * Errata: MCI Transmit Data Register (TDR) FIFO
+	 * corruption when length is not multiple of 4.
+	 */
+	if (data->blocks * data->blksz < 12
+			|| (data->blocks * data->blksz) & 3)
+		host->need_reset = true;
+
+	host->pio_offset = 0;
+	if (data->flags & MMC_DATA_READ)
+		iflags |= ATMCI_RXRDY;
+	else
+		iflags |= ATMCI_TXRDY;
+
+	return iflags;
+}
+
+/*
+ * Set interrupt flags and set block length into the MCI mode register even
+ * if this value is also accessible in the MCI block register. It seems to be
+ * necessary before the High Speed MCI version. It also map sg and configure
+ * PDC registers.
+ */
+static u32
+atmci_prepare_data_pdc(struct atmel_mci *host, struct mmc_data *data)
+{
+	u32 iflags, tmp;
+	unsigned int sg_len;
+	enum dma_data_direction dir;
+
+	data->error = -EINPROGRESS;
+
+	host->data = data;
+	host->sg = data->sg;
+	iflags = ATMCI_DATA_ERROR_FLAGS;
+
+	/* Enable pdc mode */
+	atmci_writel(host, ATMCI_MR, host->mode_reg | ATMCI_MR_PDCMODE);
+
+	if (data->flags & MMC_DATA_READ) {
+		dir = DMA_FROM_DEVICE;
+		iflags |= ATMCI_ENDRX | ATMCI_RXBUFF;
+	} else {
+		dir = DMA_TO_DEVICE;
+		iflags |= ATMCI_ENDTX | ATMCI_TXBUFE;
+	}
+
+	/* Set BLKLEN */
+	tmp = atmci_readl(host, ATMCI_MR);
+	tmp &= 0x0000ffff;
+	tmp |= ATMCI_BLKLEN(data->blksz);
+	atmci_writel(host, ATMCI_MR, tmp);
+
+	/* Configure PDC */
+	host->data_size = data->blocks * data->blksz;
+	sg_len = dma_map_sg(&host->pdev->dev, data->sg, data->sg_len, dir);
+	BUG_ON(sg_len < host->data_size / PAGE_SIZE);
+	if (host->data_size)
+		atmci_pdc_set_both_buf(host,
+			((dir == DMA_FROM_DEVICE)?XFER_RECEIVE:XFER_TRANSMIT));
+
+	return iflags;
+}
+
+static u32
 atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 {
 	struct dma_chan			*chan;
@@ -655,20 +825,29 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 	unsigned int			i;
 	enum dma_data_direction		direction;
 	unsigned int			sglen;
+	u32 iflags;
+
+	data->error = -EINPROGRESS;
+
+	WARN_ON(host->data);
+	host->sg = NULL;
+	host->data = data;
+
+	iflags = ATMCI_DATA_ERROR_FLAGS;
 
 	/*
 	 * We don't do DMA on "complex" transfers, i.e. with
 	 * non-word-aligned buffers or lengths. Also, we don't bother
 	 * with all the DMA setup overhead for short transfers.
 	 */
-	if (data->blocks * data->blksz < ATATMCI_DMA_THRESHOLD)
-		return -EINVAL;
+	if (data->blocks * data->blksz < ATMCI_DMA_THRESHOLD)
+		return atmci_prepare_data(host, data);
 	if (data->blksz & 3)
-		return -EINVAL;
+		return atmci_prepare_data(host, data);
 
 	for_each_sg(data->sg, sg, data->sg_len, i) {
 		if (sg->offset & 3 || sg->length & 3)
-			return -EINVAL;
+			return atmci_prepare_data(host, data);
 	}
 
 	/* If we don't have a channel, we can't do DMA */
@@ -679,7 +858,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 	if (!chan)
 		return -ENODEV;
 
-	if (atmci_is_mci2())
+	if (host->caps.has_dma)
 		atmci_writel(host, ATMCI_DMA, ATMCI_DMA_CHKSIZE(3) | ATMCI_DMAEN);
 
 	if (data->flags & MMC_DATA_READ)
@@ -688,7 +867,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 		direction = DMA_TO_DEVICE;
 
 	sglen = dma_map_sg(chan->device->dev, data->sg,
-			   data->sg_len, direction);
+			data->sg_len, direction);
 
 	desc = chan->device->device_prep_slave_sg(chan,
 			data->sg, sglen, direction,
@@ -700,13 +879,32 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 	desc->callback = atmci_dma_complete;
 	desc->callback_param = host;
 
-	return 0;
+	return iflags;
 unmap_exit:
 	dma_unmap_sg(chan->device->dev, data->sg, data->sg_len, direction);
 	return -ENOMEM;
 }
 
-static void atmci_submit_data(struct atmel_mci *host)
+static void
+atmci_submit_data(struct atmel_mci *host, struct mmc_data *data)
+{
+	return;
+}
+
+/*
+ * Start PDC according to transfer direction.
+ */
+static void
+atmci_submit_data_pdc(struct atmel_mci *host, struct mmc_data *data)
+{
+	if (data->flags & MMC_DATA_READ)
+		atmci_writel(host, ATMEL_PDC_PTCR, ATMEL_PDC_RXTEN);
+	else
+		atmci_writel(host, ATMEL_PDC_PTCR, ATMEL_PDC_TXTEN);
+}
+
+static void
+atmci_submit_data_dma(struct atmel_mci *host, struct mmc_data *data)
 {
 	struct dma_chan			*chan = host->data_chan;
 	struct dma_async_tx_descriptor	*desc = host->dma.data_desc;
@@ -717,64 +915,39 @@ static void atmci_submit_data(struct atmel_mci *host)
 	}
 }
 
-#else /* CONFIG_MMC_ATMELMCI_DMA */
-
-static int atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
+static void atmci_stop_transfer(struct atmel_mci *host)
 {
-	return -ENOSYS;
-}
-
-static void atmci_submit_data(struct atmel_mci *host) {}
-
-static void atmci_stop_dma(struct atmel_mci *host)
-{
-	/* Data transfer was stopped by the interrupt handler */
 	atmci_set_pending(host, EVENT_XFER_COMPLETE);
 	atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
 }
 
-#endif /* CONFIG_MMC_ATMELMCI_DMA */
-
 /*
- * Returns a mask of interrupt flags to be enabled after the whole
- * request has been prepared.
+ * Stop data transfer because error(s) occured.
  */
-static u32 atmci_prepare_data(struct atmel_mci *host, struct mmc_data *data)
+static void atmci_stop_transfer_pdc(struct atmel_mci *host)
 {
-	u32 iflags;
-
-	data->error = -EINPROGRESS;
-
-	WARN_ON(host->data);
-	host->sg = NULL;
-	host->data = data;
-
-	iflags = ATMCI_DATA_ERROR_FLAGS;
-	if (atmci_prepare_data_dma(host, data)) {
-		host->data_chan = NULL;
+	atmci_set_pending(host, EVENT_XFER_COMPLETE);
+	atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
+}
 
-		/*
-		 * Errata: MMC data write operation with less than 12
-		 * bytes is impossible.
-		 *
-		 * Errata: MCI Transmit Data Register (TDR) FIFO
-		 * corruption when length is not multiple of 4.
-		 */
-		if (data->blocks * data->blksz < 12
-				|| (data->blocks * data->blksz) & 3)
-			host->need_reset = true;
+static void atmci_stop_transfer_dma(struct atmel_mci *host)
+{
+	struct dma_chan *chan = host->data_chan;
 
-		host->sg = data->sg;
-		host->pio_offset = 0;
-		if (data->flags & MMC_DATA_READ)
-			iflags |= ATMCI_RXRDY;
-		else
-			iflags |= ATMCI_TXRDY;
+	if (chan) {
+		dmaengine_terminate_all(chan);
+		atmci_dma_cleanup(host);
+	} else {
+		/* Data transfer was stopped by the interrupt handler */
+		atmci_set_pending(host, EVENT_XFER_COMPLETE);
+		atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
 	}
-
-	return iflags;
 }
 
+/*
+ * Start a request: prepare data if needed, prepare the command and activate
+ * interrupts.
+ */
 static void atmci_start_request(struct atmel_mci *host,
 		struct atmel_mci_slot *slot)
 {
@@ -796,7 +969,7 @@ static void atmci_start_request(struct atmel_mci *host,
 		atmci_writel(host, ATMCI_CR, ATMCI_CR_SWRST);
 		atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIEN);
 		atmci_writel(host, ATMCI_MR, host->mode_reg);
-		if (atmci_is_mci2())
+		if (host->caps.has_cfg_reg)
 			atmci_writel(host, ATMCI_CFG, host->cfg_reg);
 		host->need_reset = false;
 	}
@@ -824,7 +997,7 @@ static void atmci_start_request(struct atmel_mci *host,
 		dev_vdbg(&slot->mmc->class_dev, "BLKR=0x%08x\n",
 			ATMCI_BCNT(data->blocks) | ATMCI_BLKLEN(data->blksz));
 
-		iflags |= atmci_prepare_data(host, data);
+		iflags |= host->prepare_data(host, data);
 	}
 
 	iflags |= ATMCI_CMDRDY;
@@ -833,7 +1006,7 @@ static void atmci_start_request(struct atmel_mci *host,
 	atmci_start_command(host, cmd, cmdflags);
 
 	if (data)
-		atmci_submit_data(host);
+		host->submit_data(host, data);
 
 	if (mrq->stop) {
 		host->stop_cmdr = atmci_prepare_command(slot->mmc, mrq->stop);
@@ -929,7 +1102,7 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			clk_enable(host->mck);
 			atmci_writel(host, ATMCI_CR, ATMCI_CR_SWRST);
 			atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIEN);
-			if (atmci_is_mci2())
+			if (host->caps.has_cfg_reg)
 				atmci_writel(host, ATMCI_CFG, host->cfg_reg);
 		}
 
@@ -960,10 +1133,10 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		 * stopping the clock when the FIFO is full/empty.
 		 * This state is not expected to last for long.
 		 */
-		if (atmci_has_rwproof())
+		if (host->caps.has_rwproof)
 			host->mode_reg |= (ATMCI_MR_WRPROOF | ATMCI_MR_RDPROOF);
 
-		if (atmci_is_mci2()) {
+		if (host->caps.has_cfg_reg) {
 			/* setup High Speed mode in relation with card capacity */
 			if (ios->timing == MMC_TIMING_SD_HS)
 				host->cfg_reg |= ATMCI_CFG_HSMODE;
@@ -973,7 +1146,7 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 		if (list_empty(&host->queue)) {
 			atmci_writel(host, ATMCI_MR, host->mode_reg);
-			if (atmci_is_mci2())
+			if (host->caps.has_cfg_reg)
 				atmci_writel(host, ATMCI_CFG, host->cfg_reg);
 		} else {
 			host->need_clock_update = true;
@@ -1088,7 +1261,7 @@ static void atmci_request_end(struct atmel_mci *host, struct mmc_request *mrq)
 	 */
 	if (host->need_clock_update) {
 		atmci_writel(host, ATMCI_MR, host->mode_reg);
-		if (atmci_is_mci2())
+		if (host->caps.has_cfg_reg)
 			atmci_writel(host, ATMCI_CFG, host->cfg_reg);
 	}
 
@@ -1137,7 +1310,7 @@ static void atmci_command_complete(struct atmel_mci *host,
 			"command error: status=0x%08x\n", status);
 
 		if (cmd->data) {
-			atmci_stop_dma(host);
+			host->stop_transfer(host);
 			host->data = NULL;
 			atmci_writel(host, ATMCI_IDR, ATMCI_NOTBUSY
 					| ATMCI_TXRDY | ATMCI_RXRDY
@@ -1195,7 +1368,7 @@ static void atmci_detect_change(unsigned long data)
 				atmci_writel(host, ATMCI_CR, ATMCI_CR_SWRST);
 				atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIEN);
 				atmci_writel(host, ATMCI_MR, host->mode_reg);
-				if (atmci_is_mci2())
+				if (host->caps.has_cfg_reg)
 					atmci_writel(host, ATMCI_CFG, host->cfg_reg);
 
 				host->data = NULL;
@@ -1211,7 +1384,7 @@ static void atmci_detect_change(unsigned long data)
 					/* fall through */
 				case STATE_SENDING_DATA:
 					mrq->data->error = -ENOMEDIUM;
-					atmci_stop_dma(host);
+					host->stop_transfer(host);
 					break;
 				case STATE_DATA_BUSY:
 				case STATE_DATA_ERROR:
@@ -1290,7 +1463,7 @@ static void atmci_tasklet_func(unsigned long priv)
 		case STATE_SENDING_DATA:
 			if (atmci_test_and_clear_pending(host,
 						EVENT_DATA_ERROR)) {
-				atmci_stop_dma(host);
+				host->stop_transfer(host);
 				if (data->stop)
 					atmci_send_stop_cmd(host, data);
 				state = STATE_DATA_ERROR;
@@ -1556,6 +1729,56 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 			atmci_set_pending(host, EVENT_DATA_ERROR);
 			tasklet_schedule(&host->tasklet);
 		}
+
+		if (pending & ATMCI_ENDTX) {
+			atmci_writel(host, ATMCI_IDR, ATMCI_ENDTX);
+			if (host->data_size) {
+				atmci_pdc_set_single_buf(host,
+						XFER_TRANSMIT, PDC_SECOND_BUF);
+				atmci_writel(host, ATMCI_IER, ATMCI_ENDTX);
+			}
+		}
+
+		if (pending & ATMCI_TXBUFE) {
+			atmci_writel(host, ATMCI_IDR, ATMCI_TXBUFE);
+			/*
+			 * We can receive this interruption before having configured
+			 * the second pdc buffer, so we need to reconfigure first and
+			 * second buffers again
+			 */
+			if (host->data_size) {
+				atmci_pdc_set_both_buf(host, XFER_TRANSMIT);
+				atmci_writel(host, ATMCI_IER, ATMCI_TXBUFE);
+			} else {
+				atmci_pdc_complete(host);
+			}
+		}
+
+		if (pending & ATMCI_ENDRX) {
+			atmci_writel(host, ATMCI_IDR, ATMCI_ENDRX);
+
+			if (host->data_size) {
+				atmci_pdc_set_single_buf(host,
+						XFER_RECEIVE, PDC_SECOND_BUF);
+				atmci_writel(host, ATMCI_IER, ATMCI_ENDRX);
+			}
+		}
+
+		if (pending & ATMCI_RXBUFF) {
+			atmci_writel(host, ATMCI_IDR, ATMCI_RXBUFF);
+			/*
+			 * We can receive this interruption before having configured
+			 * the second pdc buffer, so we need to reconfigure first and
+			 * second buffers again
+			 */
+			if (host->data_size) {
+				atmci_pdc_set_both_buf(host, XFER_RECEIVE);
+				atmci_writel(host, ATMCI_IER, ATMCI_RXBUFF);
+			} else {
+				atmci_pdc_complete(host);
+			}
+		}
+
 		if (pending & ATMCI_NOTBUSY) {
 			atmci_writel(host, ATMCI_IDR,
 					ATMCI_DATA_ERROR_FLAGS | ATMCI_NOTBUSY);
@@ -1622,7 +1845,7 @@ static int __init atmci_init_slot(struct atmel_mci *host,
 	mmc->ocr_avail	= MMC_VDD_32_33 | MMC_VDD_33_34;
 	if (sdio_irq)
 		mmc->caps |= MMC_CAP_SDIO_IRQ;
-	if (atmci_is_mci2())
+	if (host->caps.has_highspeed)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
 	if (slot_data->bus_width >= 4)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
@@ -1705,7 +1928,6 @@ static void __exit atmci_cleanup_slot(struct atmel_mci_slot *slot,
 	mmc_free_host(slot->mmc);
 }
 
-#ifdef CONFIG_MMC_ATMELMCI_DMA
 static bool atmci_filter(struct dma_chan *chan, void *slave)
 {
 	struct mci_dma_data	*sl = slave;
@@ -1747,9 +1969,61 @@ static void atmci_configure_dma(struct atmel_mci *host)
 					"Using %s for DMA transfers\n",
 					dma_chan_name(host->dma.chan));
 }
+
+static inline unsigned int atmci_get_version(struct atmel_mci *host)
+{
+	return atmci_readl(host, ATMCI_VERSION) & 0x00000fff;
+}
+
+/*
+ * HSMCI (High Speed MCI) module is not fully compatible with MCI module.
+ * HSMCI provides DMA support and a new config register but no more supports
+ * PDC.
+ */
+static void __init atmci_get_cap(struct atmel_mci *host)
+{
+	unsigned int version;
+
+	version = atmci_get_version(host);
+	dev_info(&host->pdev->dev,
+			"version: 0x%x\n", version);
+
+	host->caps.has_dma = 0;
+	host->caps.has_pdc = 0;
+	host->caps.has_cfg_reg = 0;
+	host->caps.has_cstor_reg = 0;
+	host->caps.has_highspeed = 0;
+	host->caps.has_rwproof = 0;
+
+	/* keep only major version number */
+	switch (version & 0xf00) {
+		case 0x100:
+		case 0x200:
+			host->caps.has_pdc = 1;
+			host->caps.has_rwproof = 1;
+			break;
+		case 0x300:
+		case 0x400:
+		case 0x500:
+#ifdef CONFIG_AT_HDMAC
+			host->caps.has_dma = 1;
 #else
-static void atmci_configure_dma(struct atmel_mci *host) {}
+			host->caps.has_dma = 0;
+			dev_info(&host->pdev->dev,
+					"has dma capability but dma engine is not selected, "
+					"then use pio\n");
 #endif
+			host->caps.has_cfg_reg = 1;
+			host->caps.has_cstor_reg = 1;
+			host->caps.has_highspeed = 1;
+			host->caps.has_rwproof = 1;
+			break;
+		default:
+			dev_warn(&host->pdev->dev,
+					"Unmanaged mci version, set minimum capabilities\n");
+			break;
+	}
+}
 
 static int __init atmci_probe(struct platform_device *pdev)
 {
@@ -1802,7 +2076,27 @@ static int __init atmci_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_request_irq;
 
-	atmci_configure_dma(host);
+	/* Get MCI capabilities and set operations according to it */
+	atmci_get_cap(host);
+	if (host->caps.has_dma) {
+		dev_info(&pdev->dev, "using DMA\n");
+		host->prepare_data = &atmci_prepare_data_dma;
+		host->submit_data = &atmci_submit_data_dma;
+		host->stop_transfer = &atmci_stop_transfer_dma;
+	} else if (host->caps.has_pdc) {
+		dev_info(&pdev->dev, "using PDC\n");
+		host->prepare_data = &atmci_prepare_data_pdc;
+		host->submit_data = &atmci_submit_data_pdc;
+		host->stop_transfer = &atmci_stop_transfer_pdc;
+	} else {
+		dev_info(&pdev->dev, "no DMA, no PDC\n");
+		host->prepare_data = &atmci_prepare_data;
+		host->submit_data = &atmci_submit_data;
+		host->stop_transfer = &atmci_stop_transfer;
+	}
+
+	if (host->caps.has_dma)
+		atmci_configure_dma(host);
 
 	platform_set_drvdata(pdev, host);
 
@@ -1834,10 +2128,8 @@ static int __init atmci_probe(struct platform_device *pdev)
 	return 0;
 
 err_init_slot:
-#ifdef CONFIG_MMC_ATMELMCI_DMA
 	if (host->dma.chan)
 		dma_release_channel(host->dma.chan);
-#endif
 	free_irq(irq, host);
 err_request_irq:
 	iounmap(host->regs);
-- 
1.7.0.4

