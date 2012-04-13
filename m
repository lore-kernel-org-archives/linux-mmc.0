From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 3/4] mmc: queue: remove redundant memsets
Date: Fri, 13 Apr 2012 17:54:13 +0530
Message-ID: <1334319854-5989-4-git-send-email-svenkatr@ti.com>
References: <1334319854-5989-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44999 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755126Ab2DMMY6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 13 Apr 2012 08:24:58 -0400
In-Reply-To: <1334319854-5989-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Venkatraman S <svenkatr@ti.com>

Not needed to memset, as they are pointers and are assigned
to proper values in the next line anyway.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/card/queue.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 49af43c..e360a97 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -175,8 +175,6 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	if (!mq->queue)
 		return -ENOMEM;
 
-	memset(&mq->mqrq_cur, 0, sizeof(mq->mqrq_cur));
-	memset(&mq->mqrq_prev, 0, sizeof(mq->mqrq_prev));
 	mq->mqrq_cur = mqrq_cur;
 	mq->mqrq_prev = mqrq_prev;
 	mq->queue->queuedata = mq;
-- 
1.7.10.rc2

