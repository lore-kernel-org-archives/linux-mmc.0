From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] mmc: dw_mmc: NULL dereference in error message
Date: Thu, 22 Oct 2015 22:53:46 +0300
Message-ID: <20151022195346.GD24439@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:43838 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758046AbbJVTx6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Oct 2015 15:53:58 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org

The "host->dms->ch" pointer is NULL here so we can't use it to print the
error message.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 6e600e8..f877b2c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -752,9 +752,7 @@ static int dw_mci_edmac_init(struct dw_mci *host)
 
 	host->dms->ch = dma_request_slave_channel(host->dev, "rx-tx");
 	if (!host->dms->ch) {
-		dev_err(host->dev,
-			"Failed to get external DMA channel %d\n",
-			host->dms->ch->chan_id);
+		dev_err(host->dev, "Failed to get external DMA channel.\n");
 		kfree(host->dms);
 		host->dms = NULL;
 		return -ENXIO;
