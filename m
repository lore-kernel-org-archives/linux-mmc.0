Return-Path: <SRS0=5cIg=4H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31107C34052
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 08:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1400624670
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 08:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgBSIb4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:31:56 -0500
Received: from inva020.nxp.com ([92.121.34.13]:50190 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgBSIbz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Feb 2020 03:31:55 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 458F81A00C9;
        Wed, 19 Feb 2020 09:31:54 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CDA4B1A0578;
        Wed, 19 Feb 2020 09:31:50 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 312C64030D;
        Wed, 19 Feb 2020 16:31:44 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, linus.walleij@linaro.org
Subject: [PATCH v4 14/14] mmc: queue: create dev->dma_parms before call dma_set_max_seg_size()
Date:   Wed, 19 Feb 2020 16:25:57 +0800
Message-Id: <1582100757-20683-9-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com>
References: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

To make dma_set_max_seg_size() work, need to create dev->dma_parms.

Find this issue on i.MX8QM mek board, this platform config the
max_segment_size to 65535, but this dma_set_max_seg_size do not
actuall work, find sometimes the segment size is 65536, exceed
the hardware max segment limitation, trigger ADMA error.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/core/queue.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 9edc08685e86..91094e56f7c9 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -359,6 +359,7 @@ static const struct blk_mq_ops mmc_mq_ops = {
 static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
+	struct device *dev = mmc_dev(host);
 	unsigned block_size = 512;
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, mq->queue);
@@ -366,13 +367,12 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 	if (mmc_can_erase(card))
 		mmc_queue_setup_discard(mq->queue, card);
 
-	if (!mmc_dev(host)->dma_mask || !*mmc_dev(host)->dma_mask)
+	if (!dev->dma_mask || !*dev->dma_mask)
 		blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);
 	blk_queue_max_hw_sectors(mq->queue,
 		min(host->max_blk_count, host->max_req_size / 512));
 	if (host->can_dma_map_merge)
-		WARN(!blk_queue_can_use_dma_map_merging(mq->queue,
-							mmc_dev(host)),
+		WARN(!blk_queue_can_use_dma_map_merging(mq->queue, dev),
 		     "merging was advertised but not possible");
 	blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));
 
@@ -389,7 +389,10 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 		blk_queue_max_segment_size(mq->queue,
 			round_down(host->max_seg_size, block_size));
 
-	dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->queue));
+	if (!dev->dma_parms)
+		dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms),
+						GFP_KERNEL);
+	dma_set_max_seg_size(dev, queue_max_segment_size(mq->queue));
 
 	INIT_WORK(&mq->recovery_work, mmc_mq_recovery_handler);
 	INIT_WORK(&mq->complete_work, mmc_blk_mq_complete_work);
-- 
2.17.1

