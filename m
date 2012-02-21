From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: core: fix wrong bit operation for SD card's au_size
Date: Tue, 21 Feb 2012 13:31:31 +0900
Message-ID: <4F431E23.8050006@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:30157 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab2BUEbd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Feb 2012 23:31:33 -0500
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZQ00I1P788XS60@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 21 Feb 2012 13:31:32 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LZQ002UR78K9550@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 21 Feb 2012 13:31:32 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, hyeonsu.kim@samsung.com

In SD spec, AU_SIZE and the value can be selected from 16KB.
But this code should be selected from 32KB.
I think right that shift (au + 3) instead of (au + 4).

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
CC: Hyeonsu Kim <hyeonsu.kim@samsung.com>
---
 drivers/mmc/core/sd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 5017f93..85c7b39 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -245,7 +245,7 @@ static int mmc_read_ssr(struct mmc_card *card)
 	 */
 	au = UNSTUFF_BITS(ssr, 428 - 384, 4);
 	if (au > 0 || au <= 9) {
-		card->ssr.au = 1 << (au + 4);
+		card->ssr.au = 1 << (au + 3);
 		es = UNSTUFF_BITS(ssr, 408 - 384, 16);
 		et = UNSTUFF_BITS(ssr, 402 - 384, 6);
 		eo = UNSTUFF_BITS(ssr, 400 - 384, 2);
-- 
1.7.4.1
