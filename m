From: Tomas Winkler <tomas.winkler@intel.com>
Subject: [mmc] mmc: core: mmc_blk_rw_cmd_err - remove unused variable
Date: Thu,  9 Mar 2017 16:58:21 +0200
Message-ID: <20170309145821.8849-1-tomas.winkler@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30088 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754704AbdCIO7g (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 9 Mar 2017 09:59:36 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>

Fix compilation warning:

drivers/mmc/core/block.c:1563:24: warning: variable ‘mq_rq’ set but not
used [-Wunused-but-set-variable]  struct mmc_queue_req *mq_rq;

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/mmc/core/block.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 1621fa08e206..87f8091f936c 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1560,11 +1560,8 @@ static bool mmc_blk_rw_cmd_err(struct mmc_blk_data *md, struct mmc_card *card,
 			       struct mmc_blk_request *brq, struct request *req,
 			       bool old_req_pending)
 {
-	struct mmc_queue_req *mq_rq;
 	bool req_pending;
 
-	mq_rq = container_of(brq, struct mmc_queue_req, brq);
-
 	/*
 	 * If this is an SD card and we're writing, we can first
 	 * mark the known good sectors as ok.
-- 
2.9.3

