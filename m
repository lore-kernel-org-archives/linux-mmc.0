From: ludovic.desroches@atmel.com
Subject: [RFC PATCH 2/9] mmc: atmel-mci: change atmci_readl and atmci_writel macros
Date: Thu, 28 Jul 2011 16:29:51 +0200
Message-ID: <1311863398-31579-3-git-send-email-ludovic.desroches@atmel.com>
References: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:13202 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438Ab1G1NYO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jul 2011 09:24:14 -0400
In-Reply-To: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: patrice.vilchez@atmel.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Change atmci_readl and atmci_writel macros: remove string concatenation.
We can use these macros with registers which are not prefix by ATMCI_.
It's the case if we want to write PDC registers which are common to
several devices so they are not prefixed with ATMCI_.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci-regs.h |    4 +-
 drivers/mmc/host/atmel-mci.c      |  126 ++++++++++++++++++------------------
 2 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci-regs.h b/drivers/mmc/host/atmel-mci-regs.h
index 29331ab..8574e91 100644
--- a/drivers/mmc/host/atmel-mci-regs.h
+++ b/drivers/mmc/host/atmel-mci-regs.h
@@ -121,8 +121,8 @@
 
 /* Register access macros */
 #define atmci_readl(port,reg)				\
-	__raw_readl((port)->regs + ATMCI_##reg)
+	__raw_readl((port)->regs + reg)
 #define atmci_writel(port,reg,value)			\
-	__raw_writel((value), (port)->regs + ATMCI_##reg)
+	__raw_writel((value), (port)->regs + reg)
 
 #endif /* __DRIVERS_MMC_ATMEL_MCI_H__ */
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index c2a0949..87eeccc 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -499,7 +499,7 @@ static void atmci_set_timeout(struct atmel_mci *host,
 
 	dev_vdbg(&slot->mmc->class_dev, "setting timeout to %u cycles\n",
 			dtocyc << dtomul_to_shift[dtomul]);
-	atmci_writel(host, DTOR, (ATMCI_DTOMUL(dtomul) | ATMCI_DTOCYC(dtocyc)));
+	atmci_writel(host, ATMCI_DTOR, (ATMCI_DTOMUL(dtomul) | ATMCI_DTOCYC(dtocyc)));
 }
 
 /*
@@ -564,14 +564,14 @@ static void atmci_start_command(struct atmel_mci *host,
 			"start command: ARGR=0x%08x CMDR=0x%08x\n",
 			cmd->arg, cmd_flags);
 
-	atmci_writel(host, ARGR, cmd->arg);
-	atmci_writel(host, CMDR, cmd_flags);
+	atmci_writel(host, ATMCI_ARGR, cmd->arg);
+	atmci_writel(host, ATMCI_CMDR, cmd_flags);
 }
 
 static void atmci_send_stop_cmd(struct atmel_mci *host, struct mmc_data *data)
 {
 	atmci_start_command(host, data->stop, host->stop_cmdr);
-	atmci_writel(host, IER, ATMCI_CMDRDY);
+	atmci_writel(host, ATMCI_IER, ATMCI_CMDRDY);
 }
 
 #ifdef CONFIG_MMC_ATMELMCI_DMA
@@ -596,7 +596,7 @@ static void atmci_stop_dma(struct atmel_mci *host)
 	} else {
 		/* Data transfer was stopped by the interrupt handler */
 		atmci_set_pending(host, EVENT_XFER_COMPLETE);
-		atmci_writel(host, IER, ATMCI_NOTBUSY);
+		atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
 	}
 }
 
@@ -610,7 +610,7 @@ static void atmci_dma_complete(void *arg)
 
 	if (atmci_is_mci2())
 		/* Disable DMA hardware handshaking on MCI */
-		atmci_writel(host, DMA, atmci_readl(host, DMA) & ~ATMCI_DMAEN);
+		atmci_writel(host, ATMCI_DMA, atmci_readl(host, ATMCI_DMA) & ~ATMCI_DMAEN);
 
 	atmci_dma_cleanup(host);
 
@@ -642,7 +642,7 @@ static void atmci_dma_complete(void *arg)
 		 * completion callback" rule of the dma engine
 		 * framework.
 		 */
-		atmci_writel(host, IER, ATMCI_NOTBUSY);
+		atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
 	}
 }
 
@@ -680,7 +680,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 		return -ENODEV;
 
 	if (atmci_is_mci2())
-		atmci_writel(host, DMA, ATMCI_DMA_CHKSIZE(3) | ATMCI_DMAEN);
+		atmci_writel(host, ATMCI_DMA, ATMCI_DMA_CHKSIZE(3) | ATMCI_DMAEN);
 
 	if (data->flags & MMC_DATA_READ)
 		direction = DMA_FROM_DEVICE;
@@ -730,7 +730,7 @@ static void atmci_stop_dma(struct atmel_mci *host)
 {
 	/* Data transfer was stopped by the interrupt handler */
 	atmci_set_pending(host, EVENT_XFER_COMPLETE);
-	atmci_writel(host, IER, ATMCI_NOTBUSY);
+	atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
 }
 
 #endif /* CONFIG_MMC_ATMELMCI_DMA */
@@ -793,24 +793,24 @@ static void atmci_start_request(struct atmel_mci *host,
 	host->data_status = 0;
 
 	if (host->need_reset) {
-		atmci_writel(host, CR, ATMCI_CR_SWRST);
-		atmci_writel(host, CR, ATMCI_CR_MCIEN);
-		atmci_writel(host, MR, host->mode_reg);
+		atmci_writel(host, ATMCI_CR, ATMCI_CR_SWRST);
+		atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIEN);
+		atmci_writel(host, ATMCI_MR, host->mode_reg);
 		if (atmci_is_mci2())
-			atmci_writel(host, CFG, host->cfg_reg);
+			atmci_writel(host, ATMCI_CFG, host->cfg_reg);
 		host->need_reset = false;
 	}
-	atmci_writel(host, SDCR, slot->sdc_reg);
+	atmci_writel(host, ATMCI_SDCR, slot->sdc_reg);
 
-	iflags = atmci_readl(host, IMR);
+	iflags = atmci_readl(host, ATMCI_IMR);
 	if (iflags & ~(ATMCI_SDIOIRQA | ATMCI_SDIOIRQB))
 		dev_warn(&slot->mmc->class_dev, "WARNING: IMR=0x%08x\n",
 				iflags);
 
 	if (unlikely(test_and_clear_bit(ATMCI_CARD_NEED_INIT, &slot->flags))) {
 		/* Send init sequence (74 clock cycles) */
-		atmci_writel(host, CMDR, ATMCI_CMDR_SPCMD_INIT);
-		while (!(atmci_readl(host, SR) & ATMCI_CMDRDY))
+		atmci_writel(host, ATMCI_CMDR, ATMCI_CMDR_SPCMD_INIT);
+		while (!(atmci_readl(host, ATMCI_SR) & ATMCI_CMDRDY))
 			cpu_relax();
 	}
 	iflags = 0;
@@ -819,7 +819,7 @@ static void atmci_start_request(struct atmel_mci *host,
 		atmci_set_timeout(host, slot, data);
 
 		/* Must set block count/size before sending command */
-		atmci_writel(host, BLKR, ATMCI_BCNT(data->blocks)
+		atmci_writel(host, ATMCI_BLKR, ATMCI_BCNT(data->blocks)
 				| ATMCI_BLKLEN(data->blksz));
 		dev_vdbg(&slot->mmc->class_dev, "BLKR=0x%08x\n",
 			ATMCI_BCNT(data->blocks) | ATMCI_BLKLEN(data->blksz));
@@ -852,7 +852,7 @@ static void atmci_start_request(struct atmel_mci *host,
 	 * conditions (e.g. command and data complete, but stop not
 	 * prepared yet.)
 	 */
-	atmci_writel(host, IER, iflags);
+	atmci_writel(host, ATMCI_IER, iflags);
 }
 
 static void atmci_queue_request(struct atmel_mci *host,
@@ -927,10 +927,10 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		spin_lock_bh(&host->lock);
 		if (!host->mode_reg) {
 			clk_enable(host->mck);
-			atmci_writel(host, CR, ATMCI_CR_SWRST);
-			atmci_writel(host, CR, ATMCI_CR_MCIEN);
+			atmci_writel(host, ATMCI_CR, ATMCI_CR_SWRST);
+			atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIEN);
 			if (atmci_is_mci2())
-				atmci_writel(host, CFG, host->cfg_reg);
+				atmci_writel(host, ATMCI_CFG, host->cfg_reg);
 		}
 
 		/*
@@ -972,9 +972,9 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 
 		if (list_empty(&host->queue)) {
-			atmci_writel(host, MR, host->mode_reg);
+			atmci_writel(host, ATMCI_MR, host->mode_reg);
 			if (atmci_is_mci2())
-				atmci_writel(host, CFG, host->cfg_reg);
+				atmci_writel(host, ATMCI_CFG, host->cfg_reg);
 		} else {
 			host->need_clock_update = true;
 		}
@@ -992,9 +992,9 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			}
 		}
 		if (!any_slot_active) {
-			atmci_writel(host, CR, ATMCI_CR_MCIDIS);
+			atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIDIS);
 			if (host->mode_reg) {
-				atmci_readl(host, MR);
+				atmci_readl(host, ATMCI_MR);
 				clk_disable(host->mck);
 			}
 			host->mode_reg = 0;
@@ -1058,9 +1058,9 @@ static void atmci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	struct atmel_mci	*host = slot->host;
 
 	if (enable)
-		atmci_writel(host, IER, slot->sdio_irq);
+		atmci_writel(host, ATMCI_IER, slot->sdio_irq);
 	else
-		atmci_writel(host, IDR, slot->sdio_irq);
+		atmci_writel(host, ATMCI_IDR, slot->sdio_irq);
 }
 
 static const struct mmc_host_ops atmci_ops = {
@@ -1087,9 +1087,9 @@ static void atmci_request_end(struct atmel_mci *host, struct mmc_request *mrq)
 	 * busy transferring data.
 	 */
 	if (host->need_clock_update) {
-		atmci_writel(host, MR, host->mode_reg);
+		atmci_writel(host, ATMCI_MR, host->mode_reg);
 		if (atmci_is_mci2())
-			atmci_writel(host, CFG, host->cfg_reg);
+			atmci_writel(host, ATMCI_CFG, host->cfg_reg);
 	}
 
 	host->cur_slot->mrq = NULL;
@@ -1118,10 +1118,10 @@ static void atmci_command_complete(struct atmel_mci *host,
 	u32		status = host->cmd_status;
 
 	/* Read the response from the card (up to 16 bytes) */
-	cmd->resp[0] = atmci_readl(host, RSPR);
-	cmd->resp[1] = atmci_readl(host, RSPR);
-	cmd->resp[2] = atmci_readl(host, RSPR);
-	cmd->resp[3] = atmci_readl(host, RSPR);
+	cmd->resp[0] = atmci_readl(host, ATMCI_RSPR);
+	cmd->resp[1] = atmci_readl(host, ATMCI_RSPR);
+	cmd->resp[2] = atmci_readl(host, ATMCI_RSPR);
+	cmd->resp[3] = atmci_readl(host, ATMCI_RSPR);
 
 	if (status & ATMCI_RTOE)
 		cmd->error = -ETIMEDOUT;
@@ -1139,7 +1139,7 @@ static void atmci_command_complete(struct atmel_mci *host,
 		if (cmd->data) {
 			atmci_stop_dma(host);
 			host->data = NULL;
-			atmci_writel(host, IDR, ATMCI_NOTBUSY
+			atmci_writel(host, ATMCI_IDR, ATMCI_NOTBUSY
 					| ATMCI_TXRDY | ATMCI_RXRDY
 					| ATMCI_DATA_ERROR_FLAGS);
 		}
@@ -1192,11 +1192,11 @@ static void atmci_detect_change(unsigned long data)
 				 * Reset controller to terminate any ongoing
 				 * commands or data transfers.
 				 */
-				atmci_writel(host, CR, ATMCI_CR_SWRST);
-				atmci_writel(host, CR, ATMCI_CR_MCIEN);
-				atmci_writel(host, MR, host->mode_reg);
+				atmci_writel(host, ATMCI_CR, ATMCI_CR_SWRST);
+				atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIEN);
+				atmci_writel(host, ATMCI_MR, host->mode_reg);
 				if (atmci_is_mci2())
-					atmci_writel(host, CFG, host->cfg_reg);
+					atmci_writel(host, ATMCI_CFG, host->cfg_reg);
 
 				host->data = NULL;
 				host->cmd = NULL;
@@ -1262,7 +1262,7 @@ static void atmci_tasklet_func(unsigned long priv)
 	dev_vdbg(&host->pdev->dev,
 		"tasklet: state %u pending/completed/mask %lx/%lx/%x\n",
 		state, host->pending_events, host->completed_events,
-		atmci_readl(host, IMR));
+		atmci_readl(host, ATMCI_IMR));
 
 	do {
 		prev_state = state;
@@ -1331,7 +1331,7 @@ static void atmci_tasklet_func(unsigned long priv)
 			} else {
 				data->bytes_xfered = data->blocks * data->blksz;
 				data->error = 0;
-				atmci_writel(host, IDR, ATMCI_DATA_ERROR_FLAGS);
+				atmci_writel(host, ATMCI_IDR, ATMCI_DATA_ERROR_FLAGS);
 			}
 
 			if (!data->stop) {
@@ -1381,7 +1381,7 @@ static void atmci_read_data_pio(struct atmel_mci *host)
 	unsigned int		nbytes = 0;
 
 	do {
-		value = atmci_readl(host, RDR);
+		value = atmci_readl(host, ATMCI_RDR);
 		if (likely(offset + 4 <= sg->length)) {
 			put_unaligned(value, (u32 *)(buf + offset));
 
@@ -1413,9 +1413,9 @@ static void atmci_read_data_pio(struct atmel_mci *host)
 			nbytes += offset;
 		}
 
-		status = atmci_readl(host, SR);
+		status = atmci_readl(host, ATMCI_SR);
 		if (status & ATMCI_DATA_ERROR_FLAGS) {
-			atmci_writel(host, IDR, (ATMCI_NOTBUSY | ATMCI_RXRDY
+			atmci_writel(host, ATMCI_IDR, (ATMCI_NOTBUSY | ATMCI_RXRDY
 						| ATMCI_DATA_ERROR_FLAGS));
 			host->data_status = status;
 			data->bytes_xfered += nbytes;
@@ -1432,8 +1432,8 @@ static void atmci_read_data_pio(struct atmel_mci *host)
 	return;
 
 done:
-	atmci_writel(host, IDR, ATMCI_RXRDY);
-	atmci_writel(host, IER, ATMCI_NOTBUSY);
+	atmci_writel(host, ATMCI_IDR, ATMCI_RXRDY);
+	atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
 	data->bytes_xfered += nbytes;
 	smp_wmb();
 	atmci_set_pending(host, EVENT_XFER_COMPLETE);
@@ -1452,7 +1452,7 @@ static void atmci_write_data_pio(struct atmel_mci *host)
 	do {
 		if (likely(offset + 4 <= sg->length)) {
 			value = get_unaligned((u32 *)(buf + offset));
-			atmci_writel(host, TDR, value);
+			atmci_writel(host, ATMCI_TDR, value);
 
 			offset += 4;
 			nbytes += 4;
@@ -1473,20 +1473,20 @@ static void atmci_write_data_pio(struct atmel_mci *host)
 
 			host->sg = sg = sg_next(sg);
 			if (!sg) {
-				atmci_writel(host, TDR, value);
+				atmci_writel(host, ATMCI_TDR, value);
 				goto done;
 			}
 
 			offset = 4 - remaining;
 			buf = sg_virt(sg);
 			memcpy((u8 *)&value + remaining, buf, offset);
-			atmci_writel(host, TDR, value);
+			atmci_writel(host, ATMCI_TDR, value);
 			nbytes += offset;
 		}
 
-		status = atmci_readl(host, SR);
+		status = atmci_readl(host, ATMCI_SR);
 		if (status & ATMCI_DATA_ERROR_FLAGS) {
-			atmci_writel(host, IDR, (ATMCI_NOTBUSY | ATMCI_TXRDY
+			atmci_writel(host, ATMCI_IDR, (ATMCI_NOTBUSY | ATMCI_TXRDY
 						| ATMCI_DATA_ERROR_FLAGS));
 			host->data_status = status;
 			data->bytes_xfered += nbytes;
@@ -1503,8 +1503,8 @@ static void atmci_write_data_pio(struct atmel_mci *host)
 	return;
 
 done:
-	atmci_writel(host, IDR, ATMCI_TXRDY);
-	atmci_writel(host, IER, ATMCI_NOTBUSY);
+	atmci_writel(host, ATMCI_IDR, ATMCI_TXRDY);
+	atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
 	data->bytes_xfered += nbytes;
 	smp_wmb();
 	atmci_set_pending(host, EVENT_XFER_COMPLETE);
@@ -1512,7 +1512,7 @@ done:
 
 static void atmci_cmd_interrupt(struct atmel_mci *host, u32 status)
 {
-	atmci_writel(host, IDR, ATMCI_CMDRDY);
+	atmci_writel(host, ATMCI_IDR, ATMCI_CMDRDY);
 
 	host->cmd_status = status;
 	smp_wmb();
@@ -1540,16 +1540,16 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 	unsigned int		pass_count = 0;
 
 	do {
-		status = atmci_readl(host, SR);
-		mask = atmci_readl(host, IMR);
+		status = atmci_readl(host, ATMCI_SR);
+		mask = atmci_readl(host, ATMCI_IMR);
 		pending = status & mask;
 		if (!pending)
 			break;
 
 		if (pending & ATMCI_DATA_ERROR_FLAGS) {
-			atmci_writel(host, IDR, ATMCI_DATA_ERROR_FLAGS
+			atmci_writel(host, ATMCI_IDR, ATMCI_DATA_ERROR_FLAGS
 					| ATMCI_RXRDY | ATMCI_TXRDY);
-			pending &= atmci_readl(host, IMR);
+			pending &= atmci_readl(host, ATMCI_IMR);
 
 			host->data_status = status;
 			smp_wmb();
@@ -1557,7 +1557,7 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 			tasklet_schedule(&host->tasklet);
 		}
 		if (pending & ATMCI_NOTBUSY) {
-			atmci_writel(host, IDR,
+			atmci_writel(host, ATMCI_IDR,
 					ATMCI_DATA_ERROR_FLAGS | ATMCI_NOTBUSY);
 			if (!host->data_status)
 				host->data_status = status;
@@ -1790,7 +1790,7 @@ static int __init atmci_probe(struct platform_device *pdev)
 		goto err_ioremap;
 
 	clk_enable(host->mck);
-	atmci_writel(host, CR, ATMCI_CR_SWRST);
+	atmci_writel(host, ATMCI_CR, ATMCI_CR_SWRST);
 	host->bus_hz = clk_get_rate(host->mck);
 	clk_disable(host->mck);
 
@@ -1861,9 +1861,9 @@ static int __exit atmci_remove(struct platform_device *pdev)
 	}
 
 	clk_enable(host->mck);
-	atmci_writel(host, IDR, ~0UL);
-	atmci_writel(host, CR, ATMCI_CR_MCIDIS);
-	atmci_readl(host, SR);
+	atmci_writel(host, ATMCI_IDR, ~0UL);
+	atmci_writel(host, ATMCI_CR, ATMCI_CR_MCIDIS);
+	atmci_readl(host, ATMCI_SR);
 	clk_disable(host->mck);
 
 #ifdef CONFIG_MMC_ATMELMCI_DMA
-- 
1.7.0.4

