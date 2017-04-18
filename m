From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH 2/4] mmc: pxamci: Enhance error checking
Date: Wed, 19 Apr 2017 01:17:21 +0200
Message-ID: <a8769ce8-2732-1f23-eaca-33591951ee78@tul.cz>
References: <cover.1492492523.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:32942 "EHLO bubo.tul.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757976AbdDRXQy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Apr 2017 19:16:54 -0400
In-Reply-To: <cover.1492492523.git.petr.cvek@tul.cz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, robert.jarzmik@free.fr
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The pxamci_dma_irq() and pxamci_data_done() should print errors if they
obtains invalid parameters. Make the pxamci_dma_irq() call with
the MMC_DATA_READ flag a fault as the DMA callback is used only for write.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 drivers/mmc/host/pxamci.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 80bc8065b50f..48c26d848e9f 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -354,13 +354,22 @@ static int pxamci_data_done(struct pxamci_host *host, unsigned int stat)
 	struct mmc_data *data = host->data;
 	struct dma_chan *chan;
 
-	if (!data)
+	if (!data) {
+		pr_err("%s: Missing data structure\n",
+			mmc_hostname(host->mmc));
 		return 0;
+	}
 
 	if (data->flags & MMC_DATA_READ)
 		chan = host->dma_chan_rx;
-	else
+	else if (data->flags & MMC_DATA_WRITE)
 		chan = host->dma_chan_tx;
+	else {
+		pr_err("%s: Unknown data direction, flags=%08x\n",
+			mmc_hostname(host->mmc), data->flags);
+		return 0;
+	}
+
 	dma_unmap_sg(chan->device->dev,
 		     data->sg, data->sg_len, host->dma_dir);
 
@@ -558,21 +567,27 @@ static void pxamci_dma_irq(void *param)
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	if (!host->data)
+	if (!host->data) {
+		pr_err("%s: Missing data structure\n",
+			mmc_hostname(host->mmc));
 		goto out_unlock;
+	}
 
-	if (host->data->flags & MMC_DATA_READ)
-		chan = host->dma_chan_rx;
-	else
-		chan = host->dma_chan_tx;
+	if (!(host->data->flags & MMC_DATA_WRITE)) {
+		pr_err("%s: DMA callback is only for tx channel, flags=%x\n",
+			mmc_hostname(host->mmc), host->data->flags);
+		goto out_unlock;
+	}
+
+	chan = host->dma_chan_tx;
 
 	status = dmaengine_tx_status(chan, host->dma_cookie, &state);
 
 	if (likely(status == DMA_COMPLETE)) {
 		writel(BUF_PART_FULL, host->base + MMC_PRTBUF);
 	} else {
-		pr_err("%s: DMA error on %s channel\n", mmc_hostname(host->mmc),
-			host->data->flags & MMC_DATA_READ ? "rx" : "tx");
+		pr_err("%s: Invalid DMA status %i\n", mmc_hostname(host->mmc),
+			status);
 		host->data->error = -EIO;
 		pxamci_data_done(host, 0);
 	}
-- 
2.11.0

