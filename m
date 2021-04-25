Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9228C433B4
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Apr 2021 06:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0406614A7
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Apr 2021 06:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhDYGD1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Apr 2021 02:03:27 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:62204 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhDYGDY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Apr 2021 02:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619330586; x=1650866586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9WZaPw4KZpeJYrx3M3ibtk48XrQW5uCu4oKARqVad1o=;
  b=YFarjGWijJNoSGKrMgT0OkVuV8u7vXv2QSyGcvppZskp+Yb3PX+31vra
   Nf2o8Q0uHZaqp/VfLhugHm4rk4XCFqBb81WRHKnsUXNXNpFixb5Z40gZZ
   1LSC4LzTIpcSORuqzocUhdmB99ew++UYtVR7NKOlq6u5I8HSjhJiVl3t8
   AlIgKjm0wiUVmQ5xsA1ElzrccruRXumvSEoMS57G+BT/c23chXdjQMcyr
   aXW/vYZLUbbMil/iabRg86T16RKp6r7DRHS3pG3XhJV129G8Qgg8gnA9o
   0tCC9cYgKcRnDZWX0lXCxeUXoKWR8ouSReNt7bBz7qYO8p97GGPIeTldb
   A==;
IronPort-SDR: 89pUJPYsR897XhkLZIP5HPsVdKk29UYRlROoTot86BqsBN/hS+TguEomaeloQn7xG/KTxORXqO
 VBYko1evLAu3IHAVhOcora1KL3eicweuV0F6rhVkjDZbQKctoX5VX9/o8I4M2CQZfm+kFlnxLU
 AHV0FKlT0/K0uXs2P+WpvvOBb3BMTQARkhBtWmrl0oqJ9Zzb/XZGwsQn1C8OVioZ6l+yPXeKi4
 D+zehevWQoG94PhilhQzd8Ic9BwGmaeXmsSbCtX/fUad58V28Lbb5aGnwVOFbVRalUsJY/bMLB
 20U=
X-IronPort-AV: E=Sophos;i="5.82,249,1613404800"; 
   d="scan'208";a="270095762"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2021 14:03:04 +0800
IronPort-SDR: g89OwnKxFTncVIOLCxMWNrWAu5wp5ZrUpXKa5InwMi47sW3LFxWQQLV43zq/r7APkpxIjyWZEF
 gg9fbzPn7Zv+3uYcyMgLmk0fLjxgzFnqPminiaAIQGL5A0CZvKYV94B/ApyBmmhLtUVxHtcGfY
 Kq+7nTJM7/BseK99pJy0Rb+GY2BrPaCHcl3wlCe/L4vdjo7PXE0M+jrihKuWV1AXtCzcsi265w
 mx8O1mPgnNTvxHhfT9Fd5gSTHM68AZdKewE8ZSdigANR3v9zOPdsvQpPC62nzLcKvbVsz4miPm
 +QUAE8EDhFGoqy95IdATfWuX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 22:41:41 -0700
IronPort-SDR: A9jd4nrS8nBJER5L82C+PQ49VSgZcKrE0H26/kM1YCO1TdCzfpOeWlLafcJUAiD4biByKwXUXn
 /lkAXwetcPLYemlPbCNe/scDJFNS2Q8agncKoagzydd10N3otfpN/GWRhtaDJrtk+KdHvn3STO
 9eY+ZczmSTXx7BXqAPr19QA4sW0WBQG9oWWx/qx7YhzJ3nqCS15sHGK4lSFb7NKE9OUW+xiRqM
 biE6RWCRxsgQQyxG0r7a7UrrfwuyTE4gXEimdqXynAS6596I00noyYfuYJkLWhdIQj0b8i5bqj
 HWI=
WDCIronportException: Internal
Received: from bxygm33.sdcorp.global.sandisk.com ([10.0.231.247])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Apr 2021 23:02:42 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Brendan Peter <bpeter@lytx.com>
Subject: [PATCH v5 2/2] mmc: block: Issue flush only if allowed
Date:   Sun, 25 Apr 2021 09:02:07 +0300
Message-Id: <20210425060207.2591-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210425060207.2591-1-avri.altman@wdc.com>
References: <20210425060207.2591-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The cache may be flushed to the nonvolatile storage by writing to
FLUSH_CACHE byte (EXT_CSD byte [32]). When in command queueing mode, the
cache may be flushed by issuing a CMDQ_TASK_ DEV_MGMT (CMD48) with a
FLUSH_CACHE op-code.  Either way, verify that The cache function is
turned ON before doing so.

fixes: 1e8e55b67030 (mmc: block: Add CQE support)

Reported-by: Brendan Peter <bpeter@lytx.com>
Tested-by: Brendan Peter <bpeter@lytx.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 6cd5d03bcc64..e3062bbf110e 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2198,6 +2198,11 @@ static int mmc_blk_wait_for_idle(struct mmc_queue *mq, struct mmc_host *host)
 	return mmc_blk_rw_wait(mq, NULL);
 }
 
+static bool mmc_blk_cache_disabled(struct mmc_host *host)
+{
+	return !mmc_cache_enabled(host);
+}
+
 enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->blkdata;
@@ -2237,6 +2242,10 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
 	case MMC_ISSUE_ASYNC:
 		switch (req_op(req)) {
 		case REQ_OP_FLUSH:
+			if (mmc_blk_cache_disabled(host)) {
+				blk_mq_end_request(req, BLK_STS_OK);
+				return MMC_REQ_FINISHED;
+			}
 			ret = mmc_blk_cqe_issue_flush(mq, req);
 			break;
 		case REQ_OP_READ:
-- 
2.25.1

