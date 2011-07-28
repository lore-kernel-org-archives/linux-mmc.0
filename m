From: ludovic.desroches@atmel.com
Subject: [RFC PATCH 9/9] mmc: atmel-mci: fix a potential issue about pending PDC interrupts
Date: Thu, 28 Jul 2011 16:29:58 +0200
Message-ID: <1311863398-31579-10-git-send-email-ludovic.desroches@atmel.com>
References: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:11007 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371Ab1G1NYJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jul 2011 09:24:09 -0400
In-Reply-To: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: patrice.vilchez@atmel.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

This patch fixes a potential issue about PDC interrupts. For example we have
a ENDRX pending interrupt and a RXBUFF pending interrupt. We have received the
RXBUFF interrupt but the transfer is not finished (so we didn't have time to
give a new buffer to the PDC controller). Then we will compute ENDRX interrupt
and we will give a new buffer to the PDC controller, just after we will
compute the RXBUFF interrupt and give one or two new buffers to the PDC
controller but we are not sure that the first buffer given has been filled. So
in this situation we may "lost" one sg buffer. It's the same for transmission.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 963e320..7108f64 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1729,17 +1729,9 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 			tasklet_schedule(&host->tasklet);
 		}
 
-		if (pending & ATMCI_ENDTX) {
-			atmci_writel(host, ATMCI_IDR, ATMCI_ENDTX);
-			if (host->data_size) {
-				atmci_pdc_set_single_buf(host,
-						XFER_TRANSMIT, PDC_SECOND_BUF);
-				atmci_writel(host, ATMCI_IER, ATMCI_ENDTX);
-			}
-		}
-
 		if (pending & ATMCI_TXBUFE) {
 			atmci_writel(host, ATMCI_IDR, ATMCI_TXBUFE);
+			atmci_writel(host, ATMCI_IDR, ATMCI_ENDTX);
 			/*
 			 * We can receive this interruption before having configured
 			 * the second pdc buffer, so we need to reconfigure first and
@@ -1747,24 +1739,24 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 			 */
 			if (host->data_size) {
 				atmci_pdc_set_both_buf(host, XFER_TRANSMIT);
+				atmci_writel(host, ATMCI_IER, ATMCI_ENDTX);
 				atmci_writel(host, ATMCI_IER, ATMCI_TXBUFE);
 			} else {
 				atmci_pdc_complete(host);
 			}
-		}
-
-		if (pending & ATMCI_ENDRX) {
-			atmci_writel(host, ATMCI_IDR, ATMCI_ENDRX);
+		} else if (pending & ATMCI_ENDTX) {
+			atmci_writel(host, ATMCI_IDR, ATMCI_ENDTX);
 
 			if (host->data_size) {
 				atmci_pdc_set_single_buf(host,
-						XFER_RECEIVE, PDC_SECOND_BUF);
-				atmci_writel(host, ATMCI_IER, ATMCI_ENDRX);
+						XFER_TRANSMIT, PDC_SECOND_BUF);
+				atmci_writel(host, ATMCI_IER, ATMCI_ENDTX);
 			}
 		}
 
 		if (pending & ATMCI_RXBUFF) {
 			atmci_writel(host, ATMCI_IDR, ATMCI_RXBUFF);
+			atmci_writel(host, ATMCI_IDR, ATMCI_ENDRX);
 			/*
 			 * We can receive this interruption before having configured
 			 * the second pdc buffer, so we need to reconfigure first and
@@ -1772,12 +1764,22 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 			 */
 			if (host->data_size) {
 				atmci_pdc_set_both_buf(host, XFER_RECEIVE);
+				atmci_writel(host, ATMCI_IER, ATMCI_ENDRX);
 				atmci_writel(host, ATMCI_IER, ATMCI_RXBUFF);
 			} else {
 				atmci_pdc_complete(host);
 			}
+		} else if (pending & ATMCI_ENDRX) {
+			atmci_writel(host, ATMCI_IDR, ATMCI_ENDRX);
+
+			if (host->data_size) {
+				atmci_pdc_set_single_buf(host,
+						XFER_RECEIVE, PDC_SECOND_BUF);
+				atmci_writel(host, ATMCI_IER, ATMCI_ENDRX);
+			}
 		}
 
+
 		if (pending & ATMCI_NOTBUSY) {
 			atmci_writel(host, ATMCI_IDR,
 					ATMCI_DATA_ERROR_FLAGS | ATMCI_NOTBUSY);
-- 
1.7.0.4

