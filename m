From: hyeonsu.kim@samsung.com
Subject: [PATCH] mmc: core: fix au_size according to sd spec3.0
Date: Fri, 17 Feb 2012 19:14:41 +0900
Message-ID: <1329473681-5071-1-git-send-email-hyeonsu.kim@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:37912 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab2BQKOv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2012 05:14:51 -0500
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZJ00F2W8GIAQ20@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 17 Feb 2012 19:14:43 +0900 (KST)
Received: from localhost.localdomain ([165.213.219.99])
 by mmp2.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0LZJ006WF8GJOK10@mmp2.samsung.com>
 for linux-mmc@vger.kernel.org; Fri, 17 Feb 2012 19:14:43 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: kyungmin.park@samsung.com, jh80.chung@samsung.com, Hyeonsu Kim <hyeonsu.kim@samsung.com>

From: Hyeonsu Kim <hyeonsu.kim@samsung.com>

This "if phrase" is illogical.
and SD Spec 3.0 supports au_size from 0 to 0xF.

Signed-off-by: Hyeonsu Kim <hyeonsu.kim@samsung.com>
---
 drivers/mmc/core/sd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index c63ad03..cf8bf0e 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -244,7 +244,7 @@ static int mmc_read_ssr(struct mmc_card *card)
 	 * bitfield positions accordingly.
 	 */
 	au = UNSTUFF_BITS(ssr, 428 - 384, 4);
-	if (au > 0 || au <= 9) {
+	if (au >= 0 && au < 16) {
 		card->ssr.au = 1 << (au + 4);
 		es = UNSTUFF_BITS(ssr, 408 - 384, 16);
 		et = UNSTUFF_BITS(ssr, 402 - 384, 6);
-- 
1.7.5.4

