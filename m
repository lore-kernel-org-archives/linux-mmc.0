From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 3/5] mmc: omap_hsmmc: split dma setup
Date: Tue, 21 Jan 2014 19:54:40 +0530
Message-ID: <1390314282-20520-4-git-send-email-balajitk@ti.com>
References: <1390314282-20520-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47566 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754481AbaAUOY7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Jan 2014 09:24:59 -0500
In-Reply-To: <1390314282-20520-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

split start dma function into setup and start dma
to keep track of host_cookie when cmd23 support is enabled
along with async request.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d3774b8..b02fd30 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1263,7 +1263,7 @@ static int omap_hsmmc_pre_dma_transfer(struct omap_hsmmc_host *host,
 /*
  * Routine to configure and start DMA for the MMC card
  */
-static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
+static int omap_hsmmc_setup_dma_transfer(struct omap_hsmmc_host *host,
 					struct mmc_request *req)
 {
 	struct dma_slave_config cfg;
@@ -1322,8 +1322,6 @@ static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
 
 	host->dma_ch = 1;
 
-	dma_async_issue_pending(chan);
-
 	return 0;
 }
 
@@ -1364,6 +1362,21 @@ static void set_data_timeout(struct omap_hsmmc_host *host,
 	OMAP_HSMMC_WRITE(host->base, SYSCTL, reg);
 }
 
+static void omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host)
+{
+	struct mmc_request *req = host->mrq;
+	struct dma_chan *chan;
+
+	if (!req->data)
+		return;
+	OMAP_HSMMC_WRITE(host->base, BLK, (req->data->blksz)
+				| (req->data->blocks << 16));
+	set_data_timeout(host, req->data->timeout_ns,
+				req->data->timeout_clks);
+	chan = omap_hsmmc_get_dma_chan(host, req->data);
+	dma_async_issue_pending(chan);
+}
+
 /*
  * Configure block length for MMC/SD cards and initiate the transfer.
  */
@@ -1384,12 +1397,8 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
 		return 0;
 	}
 
-	OMAP_HSMMC_WRITE(host->base, BLK, (req->data->blksz)
-					| (req->data->blocks << 16));
-	set_data_timeout(host, req->data->timeout_ns, req->data->timeout_clks);
-
 	if (host->use_dma) {
-		ret = omap_hsmmc_start_dma_transfer(host, req);
+		ret = omap_hsmmc_setup_dma_transfer(host, req);
 		if (ret != 0) {
 			dev_err(mmc_dev(host->mmc), "MMC start dma failure\n");
 			return ret;
@@ -1474,6 +1483,7 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 		return;
 	}
 
+	omap_hsmmc_start_dma_transfer(host);
 	omap_hsmmc_start_command(host, req->cmd, req->data);
 }
 
-- 
1.7.5.4

