From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 1/3] mmc: host: omap_hsmmc: remove *use_dma* member
Date: Wed, 18 May 2016 14:15:13 +0530
Message-ID: <1463561115-31798-2-git-send-email-kishon@ti.com>
References: <1463561115-31798-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463561115-31798-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, afenkart@gmail.com, ulf.hansson@linaro.org, linux@armlinux.org.uk, tony@atomide.com
Cc: rogerq@ti.com, peter.ujfalusi@ti.com, bcousson@baylibre.com, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

omap_hsmmc doesn't support polled I/O. So remove *use_dma*
which is always set to '1'.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f9ac3bb..cc916d5 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -198,7 +198,7 @@ struct omap_hsmmc_host {
 	u32			capa;
 	int			irq;
 	int			wake_irq;
-	int			use_dma, dma_ch;
+	int			dma_ch;
 	struct dma_chan		*tx_chan;
 	struct dma_chan		*rx_chan;
 	int			response_busy;
@@ -582,8 +582,8 @@ static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
 	u32 irq_mask = INT_EN_MASK;
 	unsigned long flags;
 
-	if (host->use_dma)
-		irq_mask &= ~(BRR_EN | BWR_EN);
+	/* BRR and BWR need not be enabled for DMA */
+	irq_mask &= ~(BRR_EN | BWR_EN);
 
 	/* Disable timeout for erases */
 	if (cmd->opcode == MMC_ERASE)
@@ -928,8 +928,7 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host, struct mmc_command *cmd,
 			cmdreg &= ~(DDIR);
 	}
 
-	if (host->use_dma)
-		cmdreg |= DMAE;
+	cmdreg |= DMAE;
 
 	host->req_in_progress = 1;
 
@@ -964,7 +963,7 @@ static void omap_hsmmc_request_done(struct omap_hsmmc_host *host, struct mmc_req
 
 	omap_hsmmc_disable_irq(host);
 	/* Do not complete the request if DMA is still in progress */
-	if (mrq->data && host->use_dma && dma_ch != -1)
+	if (mrq->data && dma_ch != -1)
 		return;
 	host->mrq = NULL;
 	mmc_request_done(host->mmc, mrq);
@@ -1053,7 +1052,7 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
 	host->dma_ch = -1;
 	spin_unlock_irqrestore(&host->irq_lock, flags);
 
-	if (host->use_dma && dma_ch != -1) {
+	if (dma_ch != -1) {
 		struct dma_chan *chan = omap_hsmmc_get_dma_chan(host, host->data);
 
 		dmaengine_terminate_all(chan);
@@ -1548,12 +1547,10 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
 		return 0;
 	}
 
-	if (host->use_dma) {
-		ret = omap_hsmmc_setup_dma_transfer(host, req);
-		if (ret != 0) {
-			dev_err(mmc_dev(host->mmc), "MMC start dma failure\n");
-			return ret;
-		}
+	ret = omap_hsmmc_setup_dma_transfer(host, req);
+	if (ret != 0) {
+		dev_err(mmc_dev(host->mmc), "MMC start dma failure\n");
+		return ret;
 	}
 	return 0;
 }
@@ -1564,7 +1561,7 @@ static void omap_hsmmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
 
-	if (host->use_dma && data->host_cookie) {
+	if (data->host_cookie) {
 		struct dma_chan *c = omap_hsmmc_get_dma_chan(host, data);
 
 		dma_unmap_sg(c->device->dev, data->sg, data->sg_len,
@@ -1583,13 +1580,11 @@ static void omap_hsmmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
 		return ;
 	}
 
-	if (host->use_dma) {
-		struct dma_chan *c = omap_hsmmc_get_dma_chan(host, mrq->data);
+	struct dma_chan *c = omap_hsmmc_get_dma_chan(host, mrq->data);
 
-		if (omap_hsmmc_pre_dma_transfer(host, mrq->data,
-						&host->next_data, c))
-			mrq->data->host_cookie = 0;
-	}
+	if (omap_hsmmc_pre_dma_transfer(host, mrq->data,
+					&host->next_data, c))
+		mrq->data->host_cookie = 0;
 }
 
 /*
@@ -2052,7 +2047,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->mmc	= mmc;
 	host->pdata	= pdata;
 	host->dev	= &pdev->dev;
-	host->use_dma	= 1;
 	host->dma_ch	= -1;
 	host->irq	= irq;
 	host->mapbase	= res->start + pdata->reg_offset;
-- 
1.7.9.5
