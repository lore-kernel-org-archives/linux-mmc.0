From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v3] mmc: dw_mmc: Add support for pre_req and post_req
Date: Mon, 06 Feb 2012 16:55:07 +0900
Message-ID: <000201cce4a4$a5540c20$effc2460$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:54001 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab2BFHzJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Feb 2012 02:55:09 -0500
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LYY00K2ZOKYUZ80@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 06 Feb 2012 16:55:08 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0LYY00ID1ONWED21@mmp2.samsung.com>
 for linux-mmc@vger.kernel.org; Mon, 06 Feb 2012 16:55:08 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>

This patch implements pre_req and post_req in dw_mmc
to support asynchronous mmc request.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
Changes in v3:
	Rebase with latest mmc-next.
Changes in v2:
	Consider system DMA case as well as IDMAC.
NOTE:
	Performance gains the following.
	Sequential read and write improve 23% and 5% respectively.

 drivers/mmc/host/dw_mmc.c |  129 +++++++++++++++++++++++++++++++++++---------
 1 files changed, 102 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9188489..dee839e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -297,14 +297,24 @@ static void dw_mci_stop_dma(struct dw_mci *host)
 }
 
 #ifdef CONFIG_MMC_DW_IDMAC
+static int dw_mci_get_dma_dir(struct mmc_data *data)
+{
+	if (data->flags & MMC_DATA_WRITE)
+		return DMA_TO_DEVICE;
+	else
+		return DMA_FROM_DEVICE;
+}
+
 static void dw_mci_dma_cleanup(struct dw_mci *host)
 {
 	struct mmc_data *data = host->data;
 
 	if (data)
-		dma_unmap_sg(&host->dev, data->sg, data->sg_len,
-			     ((data->flags & MMC_DATA_WRITE)
-			      ? DMA_TO_DEVICE : DMA_FROM_DEVICE));
+		if (!data->host_cookie)
+			dma_unmap_sg(&host->dev,
+				     data->sg,
+				     data->sg_len,
+				     dw_mci_get_dma_dir(data));
 }
 
 static void dw_mci_idmac_stop_dma(struct dw_mci *host)
@@ -420,26 +430,15 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 	return 0;
 }
 
-static struct dw_mci_dma_ops dw_mci_idmac_ops = {
-	.init = dw_mci_idmac_init,
-	.start = dw_mci_idmac_start_dma,
-	.stop = dw_mci_idmac_stop_dma,
-	.complete = dw_mci_idmac_complete_dma,
-	.cleanup = dw_mci_dma_cleanup,
-};
-#endif /* CONFIG_MMC_DW_IDMAC */
-
-static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
+static int dw_mci_pre_dma_transfer(struct dw_mci *host,
+				   struct mmc_data *data,
+				   bool next)
 {
 	struct scatterlist *sg;
-	unsigned int i, direction, sg_len;
-	u32 temp;
-
-	host->using_dma = 0;
+	unsigned int i, sg_len;
 
-	/* If we don't have a channel, we can't do DMA */
-	if (!host->use_dma)
-		return -ENODEV;
+	if (!next && data->host_cookie)
+		return data->host_cookie;
 
 	/*
 	 * We don't do DMA on "complex" transfers, i.e. with
@@ -448,6 +447,7 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
 	 */
 	if (data->blocks * data->blksz < DW_MCI_DMA_THRESHOLD)
 		return -EINVAL;
+
 	if (data->blksz & 3)
 		return -EINVAL;
 
@@ -456,15 +456,88 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
 			return -EINVAL;
 	}
 
-	host->using_dma = 1;
+	sg_len = dma_map_sg(&host->dev,
+			    data->sg,
+			    data->sg_len,
+			    dw_mci_get_dma_dir(data));
+	if (sg_len == 0)
+		return -EINVAL;
 
-	if (data->flags & MMC_DATA_READ)
-		direction = DMA_FROM_DEVICE;
-	else
-		direction = DMA_TO_DEVICE;
+	if (next)
+		data->host_cookie = sg_len;
+
+	return sg_len;
+}
+
+static struct dw_mci_dma_ops dw_mci_idmac_ops = {
+	.init = dw_mci_idmac_init,
+	.start = dw_mci_idmac_start_dma,
+	.stop = dw_mci_idmac_stop_dma,
+	.complete = dw_mci_idmac_complete_dma,
+	.cleanup = dw_mci_dma_cleanup,
+};
+#else
+static int dw_mci_pre_dma_transfer(struct dw_mci *host,
+				   struct mmc_data *data,
+				   bool next)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_MMC_DW_IDMAC */
+
+static void dw_mci_pre_req(struct mmc_host *mmc,
+			   struct mmc_request *mrq,
+			   bool is_first_req)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct mmc_data *data = mrq->data;
+
+	if (!slot->host->use_dma || !data)
+		return;
+
+	if (data->host_cookie) {
+		data->host_cookie = 0;
+		return;
+	}
+
+	if (dw_mci_pre_dma_transfer(slot->host, mrq->data, 1) < 0)
+		data->host_cookie = 0;
+}
+
+static void dw_mci_post_req(struct mmc_host *mmc,
+			    struct mmc_request *mrq,
+			    int err)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct mmc_data *data = mrq->data;
+
+	if (!slot->host->use_dma || !data)
+		return;
+
+	if (data->host_cookie)
+		dma_unmap_sg(&slot->host->dev,
+			     data->sg,
+			     data->sg_len,
+			     dw_mci_get_dma_dir(data));
+	data->host_cookie = 0;
+}
+
+static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
+{
+	int sg_len;
+	u32 temp;
 
-	sg_len = dma_map_sg(&host->dev, data->sg, data->sg_len,
-			    direction);
+	host->using_dma = 0;
+
+	/* If we don't have a channel, we can't do DMA */
+	if (!host->use_dma)
+		return -ENODEV;
+
+	sg_len = dw_mci_pre_dma_transfer(host, data, 0);
+	if (sg_len < 0)
+		return sg_len;
+
+	host->using_dma = 1;
 
 	dev_vdbg(&host->dev,
 		 "sd sg_cpu: %#lx sg_dma: %#lx sg_len: %d\n",
@@ -795,6 +868,8 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
 
 static const struct mmc_host_ops dw_mci_ops = {
 	.request		= dw_mci_request,
+	.pre_req		= dw_mci_pre_req,
+	.post_req		= dw_mci_post_req,
 	.set_ios		= dw_mci_set_ios,
 	.get_ro			= dw_mci_get_ro,
 	.get_cd			= dw_mci_get_cd,
-- 
1.7.0.4


