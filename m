From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: mmc: dw_mmc: miscaculated the fifo-depth with wrong bit operation
Date: Mon, 09 Jan 2012 10:06:44 +0900
Message-ID: <4F0A3DA4.8010909@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:27689 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005Ab2AIBGs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Jan 2012 20:06:48 -0500
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LXI00ILJB38ACD0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 09 Jan 2012 10:06:46 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LXI00J7PB38Z700@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 09 Jan 2012 10:06:45 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

In FIFOTH register, can find "bit[27:16] = FIFO_DEPTH - 1".
Finally, FIFO_DEPTH = bit[27:16] + 1.

Now, Used the 0x7ff. but 0xfff is right.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 94e22382..0e34279 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1949,7 +1949,7 @@ static int dw_mci_probe(struct platform_device *pdev)
 		 * should put it in the platform data.
 		 */
 		fifo_size = mci_readl(host, FIFOTH);
-		fifo_size = 1 + ((fifo_size >> 16) & 0x7ff);
+		fifo_size = 1 + ((fifo_size >> 16) & 0xfff);
 	} else {
 		fifo_size = host->pdata->fifo_depth;
 	}
