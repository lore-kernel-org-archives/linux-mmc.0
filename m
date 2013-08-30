From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 22/22] mmc: dw_mmc: fix the transfer termination in IDMAC mode
Date: Sat, 31 Aug 2013 00:14:38 +0900
Message-ID: <001901cea593$a4a2c7b0$ede85710$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38718 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756327Ab3H3POj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 11:14:39 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSC003RBNO9SJM0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 31 Aug 2013 00:14:38 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>

In IDMAC mode EVENT_XFER_COMPLETE is set when RI/TI of last descriptor
is done. So if errors are happened in the middle of data transfers,
'dw_mci_stop_dma' during error handing can be called and eventually
prevents this flag to be set.
This results in permanent wait for EVENT_XFER_COMPLETE in 'dw_mci_tasklet_func'.
Therefore, if dma running is stopped forcibly, EVENT_XFER_COMPLETE should be set.

Reported-by: Bing Zhao <bzhao@marvell.com>
Signed-off-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 5d9c7e5..10e39ba 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -345,10 +345,10 @@ static void dw_mci_stop_dma(struct dw_mci *host)
 	if (host->using_dma) {
 		host->dma_ops->stop(host);
 		host->dma_ops->cleanup(host);
-	} else {
-		/* Data transfer was stopped by the interrupt handler */
-		set_bit(EVENT_XFER_COMPLETE, &host->pending_events);
 	}
+
+	/* Data transfer was stopped by the interrupt handler */
+	set_bit(EVENT_XFER_COMPLETE, &host->pending_events);
 }
 
 static int dw_mci_get_dma_dir(struct mmc_data *data)
-- 
1.7.0.4


