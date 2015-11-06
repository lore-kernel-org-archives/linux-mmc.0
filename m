From: "Luca Porzio (lporzio)" <lporzio@micron.com>
Subject: [RFC PATCH v2] mmc: remove bondage between REQ_META and reliable
 write
Date: Fri, 6 Nov 2015 15:12:26 +0000
Message-ID: <02bfbc87a60a46a9a5bc68b96c71ad03@BOWEX36-D.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout.micron.com ([137.201.242.129]:40028 "EHLO
	mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbbKFPMi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Nov 2015 10:12:38 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Ulf Hansson (ulf.hansson@linaro.org)" <ulf.hansson@linaro.org>
Cc: "Bruce Ford (bford)" <bford@micron.com>, Alex Lemberg <alex.lemberg@sandisk.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "anton@tuxera.com" <anton@tuxera.com>

mmc: remove bondage between REQ_META and reliable write

Anytime a write operation is performed with Reliable Write flag enabled, 
the eMMC device is enforced to bypass the cache and do a write to the 
underling NVM device by Jedec specification; this causes a performance 
penalty since write operations cannot be optimized by the device cache.

In our tests, we replayed a typical mobile daily trace pattern and 
found ~9% overall time reduction in trace replay by using this patch.
Also the write ops within 4KB~64KB chunk size range get a 40~60% 
performance improvement by using the patch (as this range of write 
chunks are the one affected by REQ_META).

This patch has been discussed in the Mobile & Embedded Linux Storage 
Forum and it is the results of feedbacks from many people.
We also checked with fsdevl and f2fs mailing list developers that this change 
in the usage of REQ_META is not affecting FS behavior and we got 
positive feedbacks on applying this patch.
Reporting here the feedbacks:
- http://comments.gmane.org/gmane.linux.file-systems/97219
- http://thread.gmane.org/gmane.linux.file-systems.f2fs/3178/focus=3183

Signed-off-by: Bruce Ford <bford@micron.com>
Signed-off-by: Luca Porzio <lporzio@micron.com>
---
 drivers/mmc/card/block.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 4409d79..cba6d5e 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -62,8 +62,7 @@ MODULE_ALIAS("mmc:block");
 #define MMC_SANITIZE_REQ_TIMEOUT 240000
 #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
 
-#define mmc_req_rel_wr(req)	(((req->cmd_flags & REQ_FUA) || \
-				  (req->cmd_flags & REQ_META)) && \
+#define mmc_req_rel_wr(req)	((req->cmd_flags & REQ_FUA) && \
 				  (rq_data_dir(req) == WRITE))
 #define PACKED_CMD_VER	0x01
 #define PACKED_CMD_WR	0x02
@@ -1353,13 +1352,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 
 	/*
 	 * Reliable writes are used to implement Forced Unit Access and
-	 * REQ_META accesses, and are supported only on MMCs.
-	 *
-	 * XXX: this really needs a good explanation of why REQ_META
-	 * is treated special.
+	 * are supported only on MMCs.
 	 */
-	bool do_rel_wr = ((req->cmd_flags & REQ_FUA) ||
-			  (req->cmd_flags & REQ_META)) &&
+	bool do_rel_wr = (req->cmd_flags & REQ_FUA) &&
 		(rq_data_dir(req) == WRITE) &&
 		(md->flags & MMC_BLK_REL_WR);
 
-- 
2.1.1

