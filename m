From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] dw_mmc: add support for pre_req and post_req
Date: Thu, 07 Apr 2011 17:04:52 +0900
Message-ID: <4D9D7024.2030404@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:15021 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755414Ab1DGIG2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2011 04:06:28 -0400
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LJ900DE3VUPUH80@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 07 Apr 2011 17:06:25 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LJ900GBHVUQEA@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 07 Apr 2011 17:06:26 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@linaro.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>

This patch is based on Per Forlin's patches.
([PATCH v2 00/12]mmc: use nonblock mmc requests to minimize latency)
After applied Per Forlin's patches, this patch must be apply.
In dw_mmc.c, support for pre/post_reqeust().

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c  |   84 ++++++++++++++++++++++++++++++++++++++++----
 include/linux/mmc/dw_mmc.h |    7 ++++
 2 files changed, 84 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 87e1f57..67eeb85 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -417,6 +417,42 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 	return 0;
 }
 
+static unsigned int dw_mci_pre_dma_transfer(struct dw_mci *host,
+			struct mmc_data *data, struct dw_mci_next *next)
+{
+	unsigned int sg_len;
+
+	BUG_ON(next && data->host_cookie);
+	BUG_ON(!next && data->host_cookie &&
+			data->host_cookie != host->next_data.cookie);
+
+	if (!next && data->host_cookie &&
+			data->host_cookie != host->next_data.cookie) {
+		data->host_cookie = 0;
+	}
+
+	if (next ||
+		(!next && data->host_cookie != host->next_data.cookie)) {
+		sg_len = dma_map_sg(&host->pdev->dev, data->sg,
+				data->sg_len, ((data->flags & MMC_DATA_WRITE)
+			      ? DMA_TO_DEVICE : DMA_FROM_DEVICE));
+	} else {
+		sg_len = host->next_data.sg_len;
+		host->next_data.sg_len = 0;
+	}
+
+	if (sg_len == 0)
+		return -EINVAL;
+
+	if (next) {
+		next->sg_len = sg_len;
+		data->host_cookie = ++next->cookie < 0 ? 1 : next->cookie;
+	} else
+		data->sg_len = sg_len;
+
+	return sg_len;
+}
+
 static struct dw_mci_dma_ops dw_mci_idmac_ops = {
 	.init = dw_mci_idmac_init,
 	.start = dw_mci_idmac_start_dma,
@@ -451,13 +487,9 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
 			return -EINVAL;
 	}
 
-	if (data->flags & MMC_DATA_READ)
-		direction = DMA_FROM_DEVICE;
-	else
-		direction = DMA_TO_DEVICE;
-
-	sg_len = dma_map_sg(&host->pdev->dev, data->sg, data->sg_len,
-			    direction);
+	sg_len = dw_mci_pre_dma_transfer(host, data, NULL);
+	if (sg_len < 0)
+		return sg_len;
 
 	dev_vdbg(&host->pdev->dev,
 		 "sd sg_cpu: %#lx sg_dma: %#lx sg_len: %d\n",
@@ -643,6 +675,42 @@ static void dw_mci_queue_request(struct dw_mci *host, struct dw_mci_slot *slot,
 	spin_unlock_bh(&host->lock);
 }
 
+static void dw_mci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
+		int err)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct mmc_data *data = mrq->data;
+
+	if (!data)
+		return;
+
+	if (slot->host->use_dma) {
+		dma_unmap_sg(&slot->host->pdev->dev, data->sg, data->sg_len,
+			     ((data->flags & MMC_DATA_WRITE)
+			      ? DMA_TO_DEVICE : DMA_FROM_DEVICE));
+
+		data->host_cookie = 0;
+	}
+}
+
+static void dw_mci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq,
+		bool is_first_req)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct mmc_data *data = mrq->data;
+
+	if (!data)
+		return;
+
+	BUG_ON(mrq->data->host_cookie);
+
+	if (slot->host->use_dma) {
+		if (dw_mci_pre_dma_transfer(slot->host, mrq->data,
+					&slot->host->next_data))
+			mrq->data->host_cookie = 0;
+	}
+}
+
 static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
@@ -748,6 +816,8 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 
 static const struct mmc_host_ops dw_mci_ops = {
 	.request	= dw_mci_request,
+	.pre_req	= dw_mci_pre_request,
+	.post_req	= dw_mci_post_request,
 	.set_ios	= dw_mci_set_ios,
 	.get_ro		= dw_mci_get_ro,
 	.get_cd		= dw_mci_get_cd,
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index c0207a7..dca82ee 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -35,6 +35,11 @@ enum {
 
 struct mmc_data;
 
+struct dw_mci_next {
+	unsigned int	sg_len;
+	s32		cookie;
+};
+
 /**
  * struct dw_mci - MMC controller state shared between all slots
  * @lock: Spinlock protecting the queue and associated data.
@@ -154,6 +159,8 @@ struct dw_mci {
 	u32			quirks;
 
 	struct regulator	*vmmc;	/* Power regulator */
+
+	struct dw_mci_next	next_data;
 };
 
 /* DMA ops for Internal/External DMAC interface */
