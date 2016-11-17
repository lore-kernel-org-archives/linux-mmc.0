From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv3 6/9] mmc: dw_mmc: use the cookie's enum values for
 post/pre_req()
Date: Thu, 17 Nov 2016 16:40:38 +0900
Message-ID: <20161117074041.8641-7-jh80.chung@samsung.com>
References: <20161117074041.8641-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58231 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbcKQHlA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2016 02:41:00 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OGR01SAEZZO5X60@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 17 Nov 2016 16:40:43 +0900 (KST)
In-reply-to: <20161117074041.8641-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, adrian.hunter@intel.com, Jaehoon Chung <jh80.chung@samsung.com>

This patch removed the meaningless value. Instead, use the cookie's enum
values for executing correctly.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mmc/host/dw_mmc.c  | 39 +++++++++++++++++++--------------------
 include/linux/mmc/dw_mmc.h |  6 ++++++
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index f01b5ce..d2fae00 100644
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
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index f5af2bd..15db6f8 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -39,6 +39,12 @@ enum {
 	EVENT_DATA_ERROR,
 };
 
+enum dw_mci_cookie {
+	COOKIE_UNMAPPED,
+	COOKIE_PRE_MAPPED,	/* mapped by pre_req() of dwmmc */
+	COOKIE_MAPPED,		/* mapped by prepare_data() of dwmmc */
+};
+
 struct mmc_data;
 
 enum {
-- 
2.10.1

