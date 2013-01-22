From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 2/2] mmc: block: don't start new request when the card is
 removed
Date: Tue, 22 Jan 2013 19:48:07 +0900
Message-ID: <001e01cdf88d$f666ecb0$e334c610$%jun@samsung.com>
References: <004801cdad17$498d9140$dca8b3c0$%jun@samsung.com>
 <201210191010.48776.heiko@sntech.de> <87liepq8qo.fsf@octavius.laptop.org>
 <201210292337.35620.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:10276 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab3AVKsX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jan 2013 05:48:23 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MH000G2UWO3JLQ0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 Jan 2013 19:48:22 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MH0005F1WO7AR10@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 Jan 2013 19:48:07 +0900 (KST)
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Sujit Reddy Thumma' <sthumma@codeaurora.org>, 'Adrian Hunter' <adrian.hunter@intel.com>

Current request can be started newly while handling the error.
But if the card is removed, it's unnecessary to restart a request.
This makes the extra error handling.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/card/block.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index f79b468..1170afe 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1456,8 +1456,14 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
 
  start_new_req:
 	if (rqc) {
-		mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
-		mmc_start_req(card->host, &mq->mqrq_cur->mmc_active, NULL);
+		if (mmc_card_removed(card)) {
+			rqc->cmd_flags |= REQ_QUIET;
+			blk_end_request_all(rqc, -EIO);
+		} else {
+			mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
+			mmc_start_req(card->host,
+				      &mq->mqrq_cur->mmc_active, NULL);
+		}
 	}
 
 	return 0;
-- 
1.7.0.4


