From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH 4/4] mmc: pxamci: Fix race condition between pxamci_dma_irq()
 and pxamci_irq()
Date: Wed, 19 Apr 2017 01:18:00 +0200
Message-ID: <31e332fa-f152-1eff-39fb-91f332b84757@tul.cz>
References: <cover.1492492523.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:32976 "EHLO bubo.tul.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757500AbdDRXRd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Apr 2017 19:17:33 -0400
In-Reply-To: <cover.1492492523.git.petr.cvek@tul.cz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, robert.jarzmik@free.fr
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The data write requests may require an FIFO flush when the DMA transaction
ends. This is handled by a DMA callback pxamci_dma_irq(). After flushing
the FIFO the MCI controller generates the DATA_TRAN_DONE interrupt.

Problem is the DATA_TRAN_DONE interrupt will be generated when the write
data length is divisible by the FIFO size (no flush is required). And in
this case the DMA callback can be called long time after the
DATA_TRAN_DONE interrupt (as the DMA callback is realised by a tasklet,
it can even stack). When the DMA callback is finally called there can
already be a different type of the transaction (another data read or write
request).

The dmaengine_tx_status() will be called for a wrong DMA transaction and
in some case it returns DMA_IN_PROGRESS, which the code recognize as
an error and ends a running DMA and halts the MCI controller.

The problem presents itself under heavy (interrupt) load with a high MCI
traffic with this message:

	mmc0: DMA error on tx channel

The fix must obey these situations:
 - Any command will erase the FIFO
 - Data writes divisible by the FIFO size will (probably) automatically
   generate a DATA_TRAN_DONE interrupt
 - Data writes with a nonzero FIFO remainder must be flushed and then MCI
   generates a DATA_TRAN_DONE interrupt
 - Data reads do not require a flush but they will generate
   a DATA_TRAN_DONE interrupt

The fix changes the DATA_TRAN_DONE interrupt enable from read/write
requests to read requests. The DATA_TRAN_DONE interrupt for a write
request is enabled in the DMA callback, this assures  a DATA_TRAN_DONE
interrupt will be always called after a callback (with or without an FIFO
flush).

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 drivers/mmc/host/pxamci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 570735a10127..08713bb6c716 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -335,7 +335,9 @@ static int pxamci_cmd_done(struct pxamci_host *host, unsigned int stat)
 
 	pxamci_disable_irq(host, END_CMD_RES);
 	if (host->data && !cmd->error) {
-		pxamci_enable_irq(host, DATA_TRAN_DONE);
+		if (host->data->flags & MMC_DATA_READ)
+			pxamci_enable_irq(host, DATA_TRAN_DONE);
+
 		/*
 		 * workaround for erratum #91, if doing write
 		 * enable DMA late
@@ -585,6 +587,9 @@ static void pxamci_dma_irq(void *param)
 
 	if (likely(status == DMA_COMPLETE)) {
 		writel(BUF_PART_FULL, host->base + MMC_PRTBUF);
+
+		/* NOTICE pxamci_irq() is dependent on pxamci_dma_irq() */
+		pxamci_enable_irq(host, DATA_TRAN_DONE);
 	} else {
 		pr_err("%s: Invalid DMA status %i\n", mmc_hostname(host->mmc),
 			status);
-- 
2.11.0

