From: <ludovic.desroches@atmel.com>
Subject: [PATCH 4/4] mmc: atmel-mci: add debug logs
Date: Wed, 16 May 2012 15:26:01 +0200
Message-ID: <1337174761-23988-5-git-send-email-ludovic.desroches@atmel.com>
References: <1337174761-23988-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:51063 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967470Ab2EPN0Z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 May 2012 09:26:25 -0400
In-Reply-To: <1337174761-23988-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 92c4145..a5856c6 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -630,6 +630,7 @@ static void atmci_send_command(struct atmel_mci *host,
 
 static void atmci_send_stop_cmd(struct atmel_mci *host, struct mmc_data *data)
 {
+	dev_dbg(&host->pdev->dev, "send stop command\n");
 	atmci_send_command(host, data->stop, host->stop_cmdr);
 	atmci_writel(host, ATMCI_IER, ATMCI_CMDRDY);
 }
@@ -738,6 +739,8 @@ static void atmci_pdc_complete(struct atmel_mci *host)
 	 * to send the stop command or waiting for NBUSY in this case.
 	 */
 	if (host->data) {
+		dev_dbg(&host->pdev->dev,
+		        "(%s) set pending xfer complete\n", __func__);
 		atmci_set_pending(host, EVENT_XFER_COMPLETE);
 		tasklet_schedule(&host->tasklet);
 	}
@@ -774,6 +777,8 @@ static void atmci_dma_complete(void *arg)
 	 * to send the stop command or waiting for NBUSY in this case.
 	 */
 	if (data) {
+		dev_dbg(&host->pdev->dev,
+		        "(%s) set pending xfer complete\n", __func__);
 		atmci_set_pending(host, EVENT_XFER_COMPLETE);
 		tasklet_schedule(&host->tasklet);
 
@@ -1002,6 +1007,8 @@ atmci_submit_data_dma(struct atmel_mci *host, struct mmc_data *data)
 
 static void atmci_stop_transfer(struct atmel_mci *host)
 {
+	dev_dbg(&host->pdev->dev,
+	        "(%s) set pending xfer complete\n", __func__);
 	atmci_set_pending(host, EVENT_XFER_COMPLETE);
 	atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
 }
@@ -1023,6 +1030,8 @@ static void atmci_stop_transfer_dma(struct atmel_mci *host)
 		atmci_dma_cleanup(host);
 	} else {
 		/* Data transfer was stopped by the interrupt handler */
+		dev_dbg(&host->pdev->dev,
+		        "(%s) set pending xfer complete\n", __func__);
 		atmci_set_pending(host, EVENT_XFER_COMPLETE);
 		atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
 	}
@@ -1050,6 +1059,8 @@ static void atmci_start_request(struct atmel_mci *host,
 	host->cmd_status = 0;
 	host->data_status = 0;
 
+	dev_dbg(&host->pdev->dev, "start request: cmd %u\n", mrq->cmd->opcode);
+
 	if (host->need_reset || host->caps.need_reset_after_xfer) {
 		iflags = atmci_readl(host, ATMCI_IMR);
 		iflags &= (ATMCI_SDIOIRQA | ATMCI_SDIOIRQB);
@@ -1130,6 +1141,7 @@ static void atmci_queue_request(struct atmel_mci *host,
 		host->state = STATE_SENDING_CMD;
 		atmci_start_request(host, slot);
 	} else {
+		dev_dbg(&host->pdev->dev, "queue request\n");
 		list_add_tail(&slot->queue_node, &host->queue);
 	}
 	spin_unlock_bh(&host->lock);
@@ -1142,6 +1154,7 @@ static void atmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	struct mmc_data		*data;
 
 	WARN_ON(slot->mrq);
+	dev_dbg(&host->pdev->dev, "MRQ: cmd %u\n", mrq->cmd->opcode);
 
 	/*
 	 * We may "know" the card is gone even though there's still an
@@ -1531,6 +1544,7 @@ static void atmci_tasklet_func(unsigned long priv)
 
 	do {
 		prev_state = state;
+		dev_dbg(&host->pdev->dev, "FSM: state=%d\n", state);
 
 		switch (state) {
 		case STATE_IDLE:
@@ -1543,14 +1557,18 @@ static void atmci_tasklet_func(unsigned long priv)
 			 * END_REQUEST by default, WAITING_NOTBUSY if it's a
 			 * command needing it or DATA_XFER if there is data.
 			 */
+			dev_dbg(&host->pdev->dev, "FSM: cmd ready?\n");
 			if (!atmci_test_and_clear_pending(host,
 						EVENT_CMD_RDY))
 				break;
 
+			dev_dbg(&host->pdev->dev, "set completed cmd ready\n");
 			host->cmd = NULL;
 			atmci_set_completed(host, EVENT_CMD_RDY);
 			atmci_command_complete(host, mrq->cmd);
 			if (mrq->data) {
+				dev_dbg(&host->pdev->dev,
+				        "command with data transfer");
 				/*
 				 * If there is a command error don't start
 				 * data transfer.
@@ -1565,6 +1583,8 @@ static void atmci_tasklet_func(unsigned long priv)
 				} else
 					state = STATE_DATA_XFER;
 			} else if ((!mrq->data) && (mrq->cmd->flags & MMC_RSP_BUSY)) {
+				dev_dbg(&host->pdev->dev,
+				        "command response need waiting notbusy");
 				atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
 				state = STATE_WAITING_NOTBUSY;
 			} else
@@ -1575,6 +1595,7 @@ static void atmci_tasklet_func(unsigned long priv)
 		case STATE_DATA_XFER:
 			if (atmci_test_and_clear_pending(host,
 						EVENT_DATA_ERROR)) {
+				dev_dbg(&host->pdev->dev, "set completed data error\n");
 				atmci_set_completed(host, EVENT_DATA_ERROR);
 				state = STATE_END_REQUEST;
 				break;
@@ -1587,10 +1608,14 @@ static void atmci_tasklet_func(unsigned long priv)
 			 * to the next step which is WAITING_NOTBUSY in write
 			 * case and directly SENDING_STOP in read case.
 			 */
+			dev_dbg(&host->pdev->dev, "FSM: xfer complete?\n");
 			if (!atmci_test_and_clear_pending(host,
 						EVENT_XFER_COMPLETE))
 				break;
 
+			dev_dbg(&host->pdev->dev,
+			        "(%s) set completed xfer complete\n",
+				__func__);
 			atmci_set_completed(host, EVENT_XFER_COMPLETE);
 
 			if (host->data->flags & MMC_DATA_WRITE) {
@@ -1615,10 +1640,12 @@ static void atmci_tasklet_func(unsigned long priv)
 			 * included) or a write operation. In the latest case,
 			 * we need to send a stop command.
 			 */
+			dev_dbg(&host->pdev->dev, "FSM: not busy?\n");
 			if (!atmci_test_and_clear_pending(host,
 						EVENT_NOTBUSY))
 				break;
 
+			dev_dbg(&host->pdev->dev, "set completed not busy\n");
 			atmci_set_completed(host, EVENT_NOTBUSY);
 
 			if (host->data) {
@@ -1650,10 +1677,12 @@ static void atmci_tasklet_func(unsigned long priv)
 			 * in order to go to the end request state instead of
 			 * sending stop again.
 			 */
+			dev_dbg(&host->pdev->dev, "FSM: cmd ready?\n");
 			if (!atmci_test_and_clear_pending(host,
 						EVENT_CMD_RDY))
 				break;
 
+			dev_dbg(&host->pdev->dev, "FSM: cmd ready\n");
 			host->cmd = NULL;
 			host->data = NULL;
 			data->bytes_xfered = data->blocks * data->blksz;
@@ -1859,18 +1888,21 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 			break;
 
 		if (pending & ATMCI_DATA_ERROR_FLAGS) {
+			dev_dbg(&host->pdev->dev, "IRQ: data error\n");
 			atmci_writel(host, ATMCI_IDR, ATMCI_DATA_ERROR_FLAGS
 					| ATMCI_RXRDY | ATMCI_TXRDY
 					| ATMCI_ENDRX | ATMCI_ENDTX
 					| ATMCI_RXBUFF | ATMCI_TXBUFE);
 
 			host->data_status = status;
+			dev_dbg(&host->pdev->dev, "set pending data error\n");
 			smp_wmb();
 			atmci_set_pending(host, EVENT_DATA_ERROR);
 			tasklet_schedule(&host->tasklet);
 		}
 
 		if (pending & ATMCI_TXBUFE) {
+			dev_dbg(&host->pdev->dev, "IRQ: tx buffer empty\n");
 			atmci_writel(host, ATMCI_IDR, ATMCI_TXBUFE);
 			atmci_writel(host, ATMCI_IDR, ATMCI_ENDTX);
 			/*
@@ -1886,6 +1918,7 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 				atmci_pdc_complete(host);
 			}
 		} else if (pending & ATMCI_ENDTX) {
+			dev_dbg(&host->pdev->dev, "IRQ: end of tx buffer\n");
 			atmci_writel(host, ATMCI_IDR, ATMCI_ENDTX);
 
 			if (host->data_size) {
@@ -1896,6 +1929,7 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 		}
 
 		if (pending & ATMCI_RXBUFF) {
+			dev_dbg(&host->pdev->dev, "IRQ: rx buffer full\n");
 			atmci_writel(host, ATMCI_IDR, ATMCI_RXBUFF);
 			atmci_writel(host, ATMCI_IDR, ATMCI_ENDRX);
 			/*
@@ -1911,6 +1945,7 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 				atmci_pdc_complete(host);
 			}
 		} else if (pending & ATMCI_ENDRX) {
+			dev_dbg(&host->pdev->dev, "IRQ: end of rx buffer\n");
 			atmci_writel(host, ATMCI_IDR, ATMCI_ENDRX);
 
 			if (host->data_size) {
@@ -1927,15 +1962,19 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 		 * The appropriate workaround is to use the BLKE signal.
 		 */
 		if (pending & ATMCI_BLKE) {
+			dev_dbg(&host->pdev->dev, "IRQ: blke\n");
 			atmci_writel(host, ATMCI_IDR, ATMCI_BLKE);
 			smp_wmb();
+			dev_dbg(&host->pdev->dev, "set pending notbusy\n");
 			atmci_set_pending(host, EVENT_NOTBUSY);
 			tasklet_schedule(&host->tasklet);
 		}
 
 		if (pending & ATMCI_NOTBUSY) {
+			dev_dbg(&host->pdev->dev, "IRQ: not_busy\n");
 			atmci_writel(host, ATMCI_IDR, ATMCI_NOTBUSY);
 			smp_wmb();
+			dev_dbg(&host->pdev->dev, "set pending notbusy\n");
 			atmci_set_pending(host, EVENT_NOTBUSY);
 			tasklet_schedule(&host->tasklet);
 		}
@@ -1946,9 +1985,11 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 			atmci_write_data_pio(host);
 
 		if (pending & ATMCI_CMDRDY) {
+			dev_dbg(&host->pdev->dev, "IRQ: cmd ready\n");
 			atmci_writel(host, ATMCI_IDR, ATMCI_CMDRDY);
 			host->cmd_status = status;
 			smp_wmb();
+			dev_dbg(&host->pdev->dev, "set pending cmd rdy\n");
 			atmci_set_pending(host, EVENT_CMD_RDY);
 			tasklet_schedule(&host->tasklet);
 		}
-- 
1.7.5.4

