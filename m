From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1] drivers/mmc/host/dw_mmc.c: use ARRAY_SIZE instead of sizeof/sizeof[0]
Date: Sat,  7 Jun 2014 14:09:02 +0200
Message-ID: <1402142942-27459-1-git-send-email-fabf@skynet.be>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailrelay008.isp.belgacom.be ([195.238.6.174]:59339 "EHLO
	mailrelay008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752563AbaFGMJO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 7 Jun 2014 08:09:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org

Use kernel.h definition.

Cc: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
This is untested.

 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1ac227c..e725b47 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -584,7 +584,7 @@ static void dw_mci_adjust_fifoth(struct dw_mci *host, struct mmc_data *data)
 	u32 fifo_width = 1 << host->data_shift;
 	u32 blksz_depth = blksz / fifo_width, fifoth_val;
 	u32 msize = 0, rx_wmark = 1, tx_wmark, tx_wmark_invers;
-	int idx = (sizeof(mszs) / sizeof(mszs[0])) - 1;
+	int idx = ARRAY_SIZE(mszs) - 1;
 
 	tx_wmark = (host->fifo_depth) / 2;
 	tx_wmark_invers = host->fifo_depth - tx_wmark;
-- 
1.9.1

