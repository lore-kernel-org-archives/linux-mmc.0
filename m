From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] mmc: dw_mmc: Fix switch from DMA to PIO
Date: Tue, 10 Apr 2012 09:53:32 +0900
Message-ID: <000601cd16b4$5a409a40$0ec1cec0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:34419 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395Ab2DJAxf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Apr 2012 20:53:35 -0400
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0M28003K9NQJYVC0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 10 Apr 2012 09:53:33 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0M280008WNT85L30@mmp1.samsung.com>
 for linux-mmc@vger.kernel.org; Tue, 10 Apr 2012 09:53:32 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>

When dw_mci_pre_dma_transfer returns failure in some reasons,
dw_mci_submit_data will prepare to switch the PIO mode from DMA.
After switching to PIO mode, DMA(IDMAC in particular) is still
enabled. This makes the corruption in handling interrupt and
the driver lock-up.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index bf3c9b4..f3b0fcd 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -526,8 +526,10 @@ static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
 		return -ENODEV;
 
 	sg_len = dw_mci_pre_dma_transfer(host, data, 0);
-	if (sg_len < 0)
+	if (sg_len < 0) {
+		host->dma_ops->stop(host);
 		return sg_len;
+	}
 
 	host->using_dma = 1;
 
-- 
1.7.0.4


