From: "Yuan, Juntao" <juntao.yuan@intel.com>
Subject: [PATCH] mmc: block: correct 4KB alignment check
Date: Fri, 13 May 2016 07:59:24 +0000
Message-ID: <588D8A7789B2934A9950BF189ED6F50A2007FF09@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3000 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689AbcEMH7n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 May 2016 03:59:43 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


In sectors alignment check, brq->data.blocks means sectors of the
previous mqrq since data.blocks for mqrq_cur hasn't been updated yet.
data.blocks will be updated later in mmc_blk_packed_hdr_wrq_prep or
mmc_blk_rw_rq_prep.

static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, ......
        ......
    struct mmc_blk_request *brq = &mq->mqrq_cur->brq;

Signed-off-by: Yuan Juntao <juntao.yuan@intel.com>
---
 drivers/mmc/card/block.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 3bdbe50..cc0189f 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1950,8 +1950,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
             * When 4KB native sector is enabled, only 8 blocks
             * multiple read or write is allowed
             */
-           if ((brq->data.blocks & 0x07) &&
-               (card->ext_csd.data_sector_size == 4096)) {
+           if (mmc_large_sector(card) &&
+               !IS_ALIGNED(blk_rq_sectors(rqc), 8)) {
                pr_err("%s: Transfer size is not 4KB sector size aligned\n",
                    req->rq_disk->disk_name);
                mq_rq = mq->mqrq_cur;
--
1.7.9.5

