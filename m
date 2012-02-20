From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] mmc: dw_mmc: Fix disableing DMA in Non-IDMAC
Date: Mon, 20 Feb 2012 11:01:43 +0900
Message-ID: <001e01ccef73$97aee200$c70ca600$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:31318 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab2BTCBn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Feb 2012 21:01:43 -0500
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZO00B2G5MR9UH0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 20 Feb 2012 11:01:41 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0LZO00JU25MT5B00@mmp2.samsung.com>
 for linux-mmc@vger.kernel.org; Mon, 20 Feb 2012 11:01:41 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'linux-mmc' <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, 'James Hogan' <james@albanarts.com>, 'Will Newton' <will.newton@imgtec.com>

dw_mci_pre_dma_transfer() is valid only if internal DMA. In case of
using other DMA it returns -ENOSYS. It prevents the DMA operations.
This patch makes dw_mci_pre_dma_transfer() effective in all DMA case.

Reported-by: James Hogan <james@albanarts.com>
Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   25 +++++++++----------------
 1 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 692c3ba..bf3c9b4 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -429,6 +429,15 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 	return 0;
 }
 
+static struct dw_mci_dma_ops dw_mci_idmac_ops = {
+	.init = dw_mci_idmac_init,
+	.start = dw_mci_idmac_start_dma,
+	.stop = dw_mci_idmac_stop_dma,
+	.complete = dw_mci_idmac_complete_dma,
+	.cleanup = dw_mci_dma_cleanup,
+};
+#endif /* CONFIG_MMC_DW_IDMAC */
+
 static int dw_mci_pre_dma_transfer(struct dw_mci *host,
 				   struct mmc_data *data,
 				   bool next)
@@ -468,22 +477,6 @@ static int dw_mci_pre_dma_transfer(struct dw_mci *host,
 	return sg_len;
 }
 
-static struct dw_mci_dma_ops dw_mci_idmac_ops = {
-	.init = dw_mci_idmac_init,
-	.start = dw_mci_idmac_start_dma,
-	.stop = dw_mci_idmac_stop_dma,
-	.complete = dw_mci_idmac_complete_dma,
-	.cleanup = dw_mci_dma_cleanup,
-};
-#else
-static int dw_mci_pre_dma_transfer(struct dw_mci *host,
-				   struct mmc_data *data,
-				   bool next)
-{
-	return -ENOSYS;
-}
-#endif /* CONFIG_MMC_DW_IDMAC */
-
 static void dw_mci_pre_req(struct mmc_host *mmc,
 			   struct mmc_request *mrq,
 			   bool is_first_req)
-- 
1.7.0.4


