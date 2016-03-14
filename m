From: David Lechner <david@lechnology.com>
Subject: [PATCH v2 4/5] mmc: davinci: don't use dma platform resources
Date: Mon, 14 Mar 2016 17:54:40 -0500
Message-ID: <1457996081-21975-5-git-send-email-david@lechnology.com>
References: <56E6BF7E.7020401@ti.com>
 <1457996081-21975-1-git-send-email-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457996081-21975-1-git-send-email-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nsekhar@ti.com
Cc: khilman@kernel.org, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, David Lechner <david@lechnology.com>
List-Id: linux-mmc@vger.kernel.org

The davinci arch now has dma_slave_map tables for dma resources, so it is
no longer necessary to pass dma resources through the platform device.

Signed-off-by: David Lechner <david@lechnology.com>
---

v2 changes: Remove platform_get_resource completly instead of just ignoring it.


 drivers/mmc/host/davinci_mmc.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 8d10a92..dc96401 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -202,7 +202,6 @@ struct mmc_davinci_host {
 	u32 buffer_bytes_left;
 	u32 bytes_left;
 
-	u32 rxdma, txdma;
 	struct dma_chan *dma_tx;
 	struct dma_chan *dma_rx;
 	bool use_dma;
@@ -520,16 +519,14 @@ static int __init davinci_acquire_dma_channels(struct mmc_davinci_host *host)
 	dma_cap_set(DMA_SLAVE, mask);
 
 	host->dma_tx =
-		dma_request_slave_channel_compat(mask, edma_filter_fn,
-				&host->txdma, mmc_dev(host->mmc), "tx");
+		dma_request_slave_channel(mmc_dev(host->mmc), "tx");
 	if (!host->dma_tx) {
 		dev_err(mmc_dev(host->mmc), "Can't get dma_tx channel\n");
 		return -ENODEV;
 	}
 
 	host->dma_rx =
-		dma_request_slave_channel_compat(mask, edma_filter_fn,
-				&host->rxdma, mmc_dev(host->mmc), "rx");
+		dma_request_slave_channel(mmc_dev(host->mmc), "rx");
 	if (!host->dma_rx) {
 		dev_err(mmc_dev(host->mmc), "Can't get dma_rx channel\n");
 		r = -ENODEV;
@@ -1251,18 +1248,6 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	host = mmc_priv(mmc);
 	host->mmc = mmc;	/* Important */
 
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!r)
-		dev_warn(&pdev->dev, "RX DMA resource not specified\n");
-	else
-		host->rxdma = r->start;
-
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (!r)
-		dev_warn(&pdev->dev, "TX DMA resource not specified\n");
-	else
-		host->txdma = r->start;
-
 	host->mem_res = mem;
 	host->base = devm_ioremap(&pdev->dev, mem->start, mem_size);
 	if (!host->base)
-- 
1.9.1
