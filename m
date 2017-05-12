From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mmc: queue: delete mmc_req_is_special()
Date: Fri, 12 May 2017 11:41:20 +0200
Message-ID: <20170512094120.8726-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36566 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbdELJlb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 12 May 2017 05:41:31 -0400
Received: by mail-wm0-f49.google.com with SMTP id u65so15185763wmu.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 May 2017 02:41:31 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>

commit cdf8a6fb48882651049e468e6b16956fb83db86c
"mmc: block: Introduce queue semantics"
deleted the last user of mmc_req_is_special() and it was
a horrible hack to classify requests as "special" or
"not special" to begin with, so delete the helper.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/queue.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 7015df6681c3..e0936742c802 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -12,14 +12,6 @@ static inline struct mmc_queue_req *req_to_mq_rq(struct request *rq)
 	return blk_mq_rq_to_pdu(rq);
 }
 
-static inline bool mmc_req_is_special(struct request *req)
-{
-	return req &&
-		(req_op(req) == REQ_OP_FLUSH ||
-		 req_op(req) == REQ_OP_DISCARD ||
-		 req_op(req) == REQ_OP_SECURE_ERASE);
-}
-
 struct task_struct;
 struct mmc_blk_data;
 struct mmc_blk_ioc_data;
-- 
2.9.3

