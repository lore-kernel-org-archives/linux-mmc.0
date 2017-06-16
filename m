From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 13/16] mmc: host: omap_hsmmc: Remove *use_dma* member
Date: Fri, 16 Jun 2017 18:15:41 +0530
Message-ID: <20170616124544.15046-14-kishon@ti.com>
References: <20170616124544.15046-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170616124544.15046-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com
Cc: Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

omap_hsmmc doesn't support polled I/O. So remove *use_dma*
which is always set to '1'.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 0887da4f1ff6..f47bade0d6fe 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -238,7 +238,7 @@ struct omap_hsmmc_host {
 	u32			capa;
 	int			irq;
 	int			wake_irq;
-	int			use_dma, dma_ch;
+	int			dma_ch;
 	struct dma_chan		*tx_chan;
 	struct dma_chan		*rx_chan;
 	int			response_busy;
@@ -647,8 +647,8 @@ static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
 		 */
 		irq_mask &= ~(DCRC_EN | DEB_EN);
 
-	if (host->use_dma)
-		irq_mask &= ~(BRR_EN | BWR_EN);
+	/* BRR and BWR need not be enabled for DMA */
+	irq_mask &= ~(BRR_EN | BWR_EN);
 
 	/* Disable timeout for erases or when using software timeout */
 	if (cmd && (cmd->opcode == MMC_ERASE || host->data_timeout))
@@ -1001,8 +1001,7 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host, struct mmc_command *cmd,
 	    (cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200))
 		cmdreg |= DP_SELECT | DDIR;
 
-	if (host->use_dma)
-		cmdreg |= DMAE;
+	cmdreg |= DMAE;
 
 	host->req_in_progress = 1;
 	host->last_cmd = cmd->opcode;
@@ -1029,7 +1028,7 @@ static void omap_hsmmc_request_done(struct omap_hsmmc_host *host, struct mmc_req
 
 	omap_hsmmc_disable_irq(host);
 	/* Do not complete the request if DMA is still in progress */
-	if (mrq->data && host->use_dma && dma_ch != -1)
+	if (mrq->data && dma_ch != -1)
 		return;
 	host->mrq = NULL;
 	mmc_request_done(host->mmc, mrq);
@@ -1116,7 +1115,7 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
 	host->dma_ch = -1;
 	spin_unlock_irqrestore(&host->irq_lock, flags);
 
-	if (host->use_dma && dma_ch != -1) {
+	if (dma_ch != -1) {
 		struct dma_chan *chan = omap_hsmmc_get_dma_chan(host, host->data);
 
 		dmaengine_terminate_all(chan);
@@ -1634,12 +1633,10 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
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
@@ -1650,7 +1647,7 @@ static void omap_hsmmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
 
-	if (host->use_dma && data->host_cookie) {
+	if (data->host_cookie) {
 		struct dma_chan *c = omap_hsmmc_get_dma_chan(host, data);
 
 		dma_unmap_sg(c->device->dev, data->sg, data->sg_len,
@@ -1662,19 +1659,18 @@ static void omap_hsmmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 static void omap_hsmmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
+	struct dma_chan *c = NULL;
 
 	if (mrq->data->host_cookie) {
 		mrq->data->host_cookie = 0;
 		return ;
 	}
 
-	if (host->use_dma) {
-		struct dma_chan *c = omap_hsmmc_get_dma_chan(host, mrq->data);
+	c = omap_hsmmc_get_dma_chan(host, mrq->data);
 
-		if (omap_hsmmc_pre_dma_transfer(host, mrq->data,
-						&host->next_data, c))
-			mrq->data->host_cookie = 0;
-	}
+	if (omap_hsmmc_pre_dma_transfer(host, mrq->data,
+					&host->next_data, c))
+		mrq->data->host_cookie = 0;
 }
 
 /*
@@ -2563,7 +2559,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->mmc	= mmc;
 	host->pdata	= pdata;
 	host->dev	= &pdev->dev;
-	host->use_dma	= 1;
 	host->dma_ch	= -1;
 	host->irq	= irq;
 	host->mapbase	= res->start + pdata->reg_offset;
-- 
2.11.0
