From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: block: Fix tag condition with packed writes
Date: Fri, 10 Jun 2016 16:22:16 +0300
Message-ID: <575ABF08.4010102@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38385 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932734AbcFJN0W (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 10 Jun 2016 09:26:22 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Apparently a cut-and-paste error, 'do_data_tag' is using 'brq' for data
size even though 'brq' has not been set up. Instead use blk_rq_sectors().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Hi

I don't know if anyone is actually using packed writes, but this is
something I noticed.

Regards
Adrian


 drivers/mmc/card/block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index b954516739be..aa5cfaf1fdf0 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1834,8 +1834,7 @@ static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *mqrq,
 		do_data_tag = (card->ext_csd.data_tag_unit_size) &&
 			(prq->cmd_flags & REQ_META) &&
 			(rq_data_dir(prq) == WRITE) &&
-			((brq->data.blocks * brq->data.blksz) >=
-			 card->ext_csd.data_tag_unit_size);
+			blk_rq_bytes(prq) >= card->ext_csd.data_tag_unit_size;
 		/* Argument of CMD23 */
 		packed_cmd_hdr[(i * 2)] =
 			(do_rel_wr ? MMC_CMD23_ARG_REL_WR : 0) |
-- 
1.9.1

