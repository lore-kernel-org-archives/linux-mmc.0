From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC 3/5] mmc: tmio: add complete to DMA ops
Date: Thu,  8 Jun 2017 15:13:13 +0200
Message-ID: <1496927595-19521-4-git-send-email-horms+renesas@verge.net.au>
References: <1496927595-19521-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1496927595-19521-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Add complete to DMA ops to allow DMAC implementation dependent
handling of DMA completion.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/tmio_mmc.h      |  1 +
 drivers/mmc/host/tmio_mmc_core.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 9c94b6eb9b49..82725f9de359 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -121,6 +121,7 @@ struct tmio_mmc_dma_ops {
 			struct tmio_mmc_data *pdata);
 	void (*release)(struct tmio_mmc_host *host);
 	void (*abort)(struct tmio_mmc_host *host);
+	void (*complete)(struct tmio_mmc_host *host);
 };
 
 struct tmio_mmc_host {
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 0e76e099dc7f..26fe9bb64849 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -86,6 +86,12 @@ static inline void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
 		host->dma_ops->abort(host);
 }
 
+static inline void tmio_mmc_complete_dma(struct tmio_mmc_host *host)
+{
+	if (host->dma_ops)
+		host->dma_ops->complete(host);
+}
+
 void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i)
 {
 	host->sdcard_irq_mask &= ~(i & TMIO_MASK_IRQ);
@@ -604,11 +610,11 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
 
 		if (done) {
 			tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_DATAEND);
-			complete(&host->dma_dataend);
+			tmio_mmc_complete_dma(host);
 		}
 	} else if (host->chan_rx && (data->flags & MMC_DATA_READ) && !host->force_pio) {
 		tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_DATAEND);
-		complete(&host->dma_dataend);
+		tmio_mmc_complete_dma(host);
 	} else {
 		tmio_mmc_do_data_irq(host);
 		tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_READOP | TMIO_MASK_WRITEOP);
-- 
2.1.4
