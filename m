From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH mmc/next v3 2/4] mmc: tmio, renesas-sdhi: add dataend to DMA ops
Date: Wed, 21 Jun 2017 16:00:28 +0200
Message-ID: <1498053630-7780-3-git-send-email-horms+renesas@verge.net.au>
References: <1498053630-7780-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1498053630-7780-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Add dataend to DMA ops to allow DMAC implementation dependent
handling of DMA data end.

Also implement the operation for SDHI.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v3
* s/complete/dataend/

v2
* Implement operation for SDHI to avoid regression
---
 drivers/mmc/host/renesas_sdhi_sys_dmac.c |  6 ++++++
 drivers/mmc/host/tmio_mmc.h              |  1 +
 drivers/mmc/host/tmio_mmc_core.c         | 10 ++++++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 642a0dcc8c5c..a125378417bf 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -126,6 +126,11 @@ static void renesas_sdhi_sys_dmac_abort_dma(struct tmio_mmc_host *host)
 	renesas_sdhi_sys_dmac_enable_dma(host, true);
 }
 
+static void renesas_sdhi_sys_dmac_dataend_dma(struct tmio_mmc_host *host)
+{
+	complete(&host->dma_dataend);
+}
+
 static void renesas_sdhi_sys_dmac_dma_callback(void *arg)
 {
 	struct tmio_mmc_host *host = arg;
@@ -451,6 +456,7 @@ static const struct tmio_mmc_dma_ops renesas_sdhi_sys_dmac_dma_ops = {
 	.request = renesas_sdhi_sys_dmac_request_dma,
 	.release = renesas_sdhi_sys_dmac_release_dma,
 	.abort = renesas_sdhi_sys_dmac_abort_dma,
+	.dataend = renesas_sdhi_sys_dmac_dataend_dma,
 };
 
 static int renesas_sdhi_sys_dmac_probe(struct platform_device *pdev)
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 6ad6704175dc..f2d747b036c7 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -122,6 +122,7 @@ struct tmio_mmc_dma_ops {
 			struct tmio_mmc_data *pdata);
 	void (*release)(struct tmio_mmc_host *host);
 	void (*abort)(struct tmio_mmc_host *host);
+	void (*dataend)(struct tmio_mmc_host *host);
 };
 
 struct tmio_mmc_host {
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 95c93c227c65..77e7b56a9099 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -87,6 +87,12 @@ static inline void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
 		host->dma_ops->abort(host);
 }
 
+static inline void tmio_mmc_dataend_dma(struct tmio_mmc_host *host)
+{
+	if (host->dma_ops)
+		host->dma_ops->dataend(host);
+}
+
 void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i)
 {
 	host->sdcard_irq_mask &= ~(i & TMIO_MASK_IRQ);
@@ -606,11 +612,11 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
 
 		if (done) {
 			tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_DATAEND);
-			complete(&host->dma_dataend);
+			tmio_mmc_dataend_dma(host);
 		}
 	} else if (host->chan_rx && (data->flags & MMC_DATA_READ) && !host->force_pio) {
 		tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_DATAEND);
-		complete(&host->dma_dataend);
+		tmio_mmc_dataend_dma(host);
 	} else {
 		tmio_mmc_do_data_irq(host);
 		tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_READOP | TMIO_MASK_WRITEOP);
-- 
2.1.4
