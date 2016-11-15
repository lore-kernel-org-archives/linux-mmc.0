From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv2 07/10] mmc: dw_mmc: use the cookie's enum values for
 post/pre_req()
Date: Tue, 15 Nov 2016 19:12:29 +0900
Message-ID: <20161115101232.3854-8-jh80.chung@samsung.com>
References: <20161115101232.3854-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:60899 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941613AbcKOKMs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2016 05:12:48 -0500
In-reply-to: <20161115101232.3854-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de, shawn.lin@rock-chips.com, robh+dt@kernel.org, Jaehoon Chung <jh80.chung@samsung.com>

This patch removed the meaningless value. Instead, use the cookie's enum
values for executing correctly.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mmc/host/dw_mmc.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 12e1107..e912de6 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -414,12 +414,13 @@ static void dw_mci_dma_cleanup(struct dw_mci *host)
 {
 	struct mmc_data *data = host->data;
 
-	if (data)
-		if (!data->host_cookie)
-			dma_unmap_sg(host->dev,
-				     data->sg,
-				     data->sg_len,
-				     dw_mci_get_dma_dir(data));
+	if (data && data->host_cookie == COOKIE_MAPPED) {
+		dma_unmap_sg(host->dev,
+			     data->sg,
+			     data->sg_len,
+			     dw_mci_get_dma_dir(data));
+		data->host_cookie = COOKIE_UNMAPPED;
+	}
 }
 
 static void dw_mci_idmac_reset(struct dw_mci *host)
@@ -850,13 +851,13 @@ static const struct dw_mci_dma_ops dw_mci_edmac_ops = {
 
 static int dw_mci_pre_dma_transfer(struct dw_mci *host,
 				   struct mmc_data *data,
-				   bool next)
+				   int cookie)
 {
 	struct scatterlist *sg;
 	unsigned int i, sg_len;
 
-	if (!next && data->host_cookie)
-		return data->host_cookie;
+	if (data->host_cookie == COOKIE_PRE_MAPPED)
+		return data->sg_len;
 
 	/*
 	 * We don't do DMA on "complex" transfers, i.e. with
@@ -881,8 +882,7 @@ static int dw_mci_pre_dma_transfer(struct dw_mci *host,
 	if (sg_len == 0)
 		return -EINVAL;
 
-	if (next)
-		data->host_cookie = sg_len;
+	data->host_cookie = cookie;
 
 	return sg_len;
 }
@@ -897,13 +897,12 @@ static void dw_mci_pre_req(struct mmc_host *mmc,
 	if (!slot->host->use_dma || !data)
 		return;
 
-	if (data->host_cookie) {
-		data->host_cookie = 0;
-		return;
-	}
+	/* This data might be unmapped at this time */
+	data->host_cookie = COOKIE_UNMAPPED;
 
-	if (dw_mci_pre_dma_transfer(slot->host, mrq->data, 1) < 0)
-		data->host_cookie = 0;
+	if (dw_mci_pre_dma_transfer(slot->host, mrq->data,
+				COOKIE_PRE_MAPPED) < 0)
+		data->host_cookie = COOKIE_UNMAPPED;
 }
 
 static void dw_mci_post_req(struct mmc_host *mmc,
@@ -916,12 +915,12 @@ static void dw_mci_post_req(struct mmc_host *mmc,
 	if (!slot->host->use_dma || !data)
 		return;
 
-	if (data->host_cookie)
+	if (data->host_cookie != COOKIE_UNMAPPED)
 		dma_unmap_sg(slot->host->dev,
 			     data->sg,
 			     data->sg_len,
 			     dw_mci_get_dma_dir(data));
-	data->host_cookie = 0;
+	data->host_cookie = COOKIE_UNMAPPED;
 }
 
 static void dw_mci_adjust_fifoth(struct dw_mci *host, struct mmc_data *data)
@@ -1027,7 +1026,7 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
 	if (!host->use_dma)
 		return -ENODEV;
 
-	sg_len = dw_mci_pre_dma_transfer(host, data, 0);
+	sg_len = dw_mci_pre_dma_transfer(host, data, COOKIE_MAPPED);
 	if (sg_len < 0) {
 		host->dma_ops->stop(host);
 		return sg_len;
-- 
2.10.1

