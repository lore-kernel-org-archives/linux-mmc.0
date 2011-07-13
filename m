From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: block: fixed NULL pointer dereference
Date: Wed, 13 Jul 2011 17:02:16 +0900
Message-ID: <4E1D5108.8040309@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:61453 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964961Ab1GMIB6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2011 04:01:58 -0400
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LO9003KDIAQ7NE0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 13 Jul 2011 17:01:57 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LO9009NTIB8YU@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 13 Jul 2011 17:01:56 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Per Forlin <per.forlin@linaro.org>, Philip Rakity <prakity@marvell.com>

Hi.

I send to mailing for [RFC] Kernel NULL pointer dereference.
This patch is fixed it.

In similar case, when discard request, check condition and
performed mmc_blk_issue_rw_rq(mq, NULL) for ongoing async transfer.

But When flush request, entered the mmc_blk_issue_flush() then return.
(then didn't complete ongoing aync transfer).

I think that need to complete for ongoing aync transfer before flush request.

I tested with this patch, it's working fine.
(SDHCI controller, eMMC4.41)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/card/block.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 38d0149..1ff5486 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1200,6 +1200,9 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		else
 			ret = mmc_blk_issue_discard_rq(mq, req);
 	} else if (req && req->cmd_flags & REQ_FLUSH) {
+		/* complete ongoing async transfer before issuing flush */
+		if (card->host->areq)
+			mmc_blk_issue_rw_rq(mq, NULL);
 		ret = mmc_blk_issue_flush(mq, req);
 	} else {
 		ret = mmc_blk_issue_rw_rq(mq, req);
