From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 4/5] mmc: omap_hsmmc: add cmd23 support
Date: Tue, 21 Jan 2014 19:54:41 +0530
Message-ID: <1390314282-20520-5-git-send-email-balajitk@ti.com>
References: <1390314282-20520-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45805 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670AbaAUOZD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Jan 2014 09:25:03 -0500
In-Reply-To: <1390314282-20520-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

Add set block count command support for close ended
multiblock read/write.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b02fd30..bad246e 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -193,6 +193,8 @@ struct omap_hsmmc_host {
 	struct	omap_mmc_platform_data	*pdata;
 };
 
+static void omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host);
+
 static int omap_hsmmc_card_detect(struct device *dev, int slot)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
@@ -865,11 +867,10 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host *host, struct mmc_data *data)
 	else
 		data->bytes_xfered = 0;
 
-	if (!data->stop) {
+	if (data->stop && (data->error || !host->mrq->sbc))
+		omap_hsmmc_start_command(host, data->stop, NULL);
+	else
 		omap_hsmmc_request_done(host, data->mrq);
-		return;
-	}
-	omap_hsmmc_start_command(host, data->stop, NULL);
 }
 
 /*
@@ -880,6 +881,14 @@ omap_hsmmc_cmd_done(struct omap_hsmmc_host *host, struct mmc_command *cmd)
 {
 	host->cmd = NULL;
 
+	if (host->mrq->sbc && (host->cmd == host->mrq->sbc) &&
+	    !host->mrq->sbc->error) {
+		omap_hsmmc_start_dma_transfer(host);
+		omap_hsmmc_start_command(host, host->mrq->cmd,
+						host->mrq->data);
+		return;
+	}
+
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		if (cmd->flags & MMC_RSP_136) {
 			/* response type 2 */
@@ -1482,6 +1491,10 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 		mmc_request_done(mmc, req);
 		return;
 	}
+	if (req->sbc) {
+		omap_hsmmc_start_command(host, req->sbc, NULL);
+		return;
+	}
 
 	omap_hsmmc_start_dma_transfer(host);
 	omap_hsmmc_start_command(host, req->cmd, req->data);
-- 
1.7.5.4

