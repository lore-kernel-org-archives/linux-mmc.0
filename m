From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] dw-mmc: prevent the Null pointer dereference for dma_ops
Date: Wed, 18 Apr 2012 15:42:31 +0900
Message-ID: <4F8E6257.5010603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:19727 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab2DRGmt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 02:42:49 -0400
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M2N009XJXATHBB0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 18 Apr 2012 15:42:47 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M2N000NUXBBM260@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 18 Apr 2012 15:42:47 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

Now, dma_ops is assumed that use the IDMAC.
But if dma_ops is assigned the pdata->dma_ops,
We didn't ensure that callback function is defined.

If anything of callback didn't define, then should be run the PIO mode.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index f3b0fcd..bab9ead 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1881,7 +1881,8 @@ static void dw_mci_init_dma(struct dw_mci *host)
 	if (!host->dma_ops)
 		goto no_dma;
 
-	if (host->dma_ops->init) {
+	if (host->dma_ops->init && host->dma_ops->start &&
+			host->dma_ops->stop && host->dma_ops->cleanup) {
 		if (host->dma_ops->init(host)) {
 			dev_err(&host->dev, "%s: Unable to initialize "
 				"DMA Controller.\n", __func__);
-- 
1.7.4.1
