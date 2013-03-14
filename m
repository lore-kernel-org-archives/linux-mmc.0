From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] mmc: block: fix the host's claim-release in special request
Date: Thu, 14 Mar 2013 15:17:13 +0900
Message-ID: <001101ce207b$91e60440$b5b20cc0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:57007 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab3CNGRQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Mar 2013 02:17:16 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJN0088K04BAQ20@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 14 Mar 2013 15:17:14 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Johan Rudholm' <jrudholm@gmail.com>, 'Konstantin Dorfman' <kdorfman@codeaurora.org>

For normal request mmc_blk_issue_rq is called twice with asynchronous
transfer(cur and prev). Host's claim and release can be done in each
mmc_blk_issue_rq. However, Special request is currently excluded in
asynchronous transfer. After special request is finished, if there is
no new request, mmc_release_host won't be called in mmc_blk_issue_rq.
The problem is founded during mmc_suspend.

[<c0541124>] (__schedule+0x0/0x78c) from [<c05419e8>] (schedule+0x38/0x78)
[<c05419b0>] (schedule+0x0/0x78) from [<c03a843c>] (__mmc_claim_host+0xac/0x1b4)
[<c03a8390>] (__mmc_claim_host+0x0/0x1b4) from [<c03ac98c>] (mmc_suspend+0x28/0x9c)
[<c03ac964>] (mmc_suspend+0x0/0x9c) from [<c03aad24>] (mmc_suspend_host+0xb4/0x194)
...

Reported-by: Johan Rudholm <jrudholm@gmail.com>
Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/card/block.c |   10 ++++++++--
 drivers/mmc/card/queue.c |    3 ---
 drivers/mmc/card/queue.h |    2 ++
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 5bab73b..71c5ce7 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1932,8 +1932,14 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	}
 
 out:
-	if (!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST))
-		/* release host only when there are no more requests */
+	if (!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST) ||
+	    req && (req->cmd_flags & MMC_REQ_SPECIAL_MASK))
+		/*
+		 * Release host when there are no more requests
+		 * and after special request(discard, flush) is done.
+		 * In case sepecial request, there is no reentry to
+		 * the 'mmc_blk_issue_rq' with 'mqrq_prev->req'.
+		 */
 		mmc_release_host(card->host);
 	return ret;
 }
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index fa4e44e..9447a0e 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -22,9 +22,6 @@
 
 #define MMC_QUEUE_BOUNCESZ	65536
 
-
-#define MMC_REQ_SPECIAL_MASK	(REQ_DISCARD | REQ_FLUSH)
-
 /*
  * Prepare a MMC request. This just filters out odd stuff.
  */
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 031bf63..5752d50 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -1,6 +1,8 @@
 #ifndef MMC_QUEUE_H
 #define MMC_QUEUE_H
 
+#define MMC_REQ_SPECIAL_MASK	(REQ_DISCARD | REQ_FLUSH)
+
 struct request;
 struct task_struct;
 
-- 
1.7.0.4


