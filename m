From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 2/4] Limit max_discard_sectors to UINT_MAX>>9
Date: Tue, 25 Mar 2014 16:48:24 -0700
Message-ID: <1395791307-23727-3-git-send-email-gwendal@chromium.org>
References: <1395791307-23727-1-git-send-email-gwendal@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f202.google.com ([209.85.214.202]:45134 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbaCYXtM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Mar 2014 19:49:12 -0400
Received: by mail-ob0-f202.google.com with SMTP id wo20so268626obc.5
        for <linux-mmc@vger.kernel.org>; Tue, 25 Mar 2014 16:49:11 -0700 (PDT)
In-Reply-To: <1395791307-23727-1-git-send-email-gwendal@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: axboe@kernel.dk, ulf.hansson@linaro.org
Cc: linux-mtd@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>

max_discard_sectors can not be larger than UINT_MAX>>9,
otherwise, there is a risk that discard requests would be merged
into a request larger than 4GB.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 block/blk-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 9b5b561..67bb0e7 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -64,7 +64,7 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	 * Ensure that max_discard_sectors is of the proper
 	 * granularity, so that requests stay aligned after a split.
 	 */
-	max_discard_sectors = min(q->limits.max_discard_sectors, UINT_MAX >> 9);
+	max_discard_sectors = q->limits.max_discard_sectors;
 	max_discard_sectors -= max_discard_sectors % granularity;
 	if (unlikely(!max_discard_sectors)) {
 		/* Avoid infinite loop below. Being cautious never hurts. */
-- 
1.9.1.423.g4596e3a

