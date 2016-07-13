From: Taras Kondratiuk <takondra@cisco.com>
Subject: [PATCH] mmc: block: fix packed command header endianness
Date: Wed, 13 Jul 2016 22:05:38 +0000
Message-ID: <1468447538-17973-1-git-send-email-takondra@cisco.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:10722 "EHLO
	rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbcGMWPb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2016 18:15:31 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, xe-linux-external@cisco.com

The code that fills packed command header assumes that CPU runs in
little-endian mode. Hence the header is malformed in big-endian mode
and causes MMC data transfer errors:

[  563.200828] mmcblk0: error -110 transferring data, sector 2048, nr 8, cmd response 0x900, card status 0xc40
[  563.219647] mmcblk0: packed cmd failed, nr 2, sectors 16, failure index: -1

Convert header data to LE.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
The patch is based on v4.7-rc7.
Tested on v4.4 kernel, but this code was not changed since then.

 drivers/mmc/card/block.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index e62fde3ac431..3832234d9aef 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1786,8 +1786,8 @@ static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *mqrq,
 
 	packed_cmd_hdr = packed->cmd_hdr;
 	memset(packed_cmd_hdr, 0, sizeof(packed->cmd_hdr));
-	packed_cmd_hdr[0] = (packed->nr_entries << 16) |
-		(PACKED_CMD_WR << 8) | PACKED_CMD_VER;
+	packed_cmd_hdr[0] = cpu_to_le32((packed->nr_entries << 16) |
+		(PACKED_CMD_WR << 8) | PACKED_CMD_VER);
 	hdr_blocks = mmc_large_sector(card) ? 8 : 1;
 
 	/*
@@ -1801,14 +1801,14 @@ static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *mqrq,
 			((brq->data.blocks * brq->data.blksz) >=
 			 card->ext_csd.data_tag_unit_size);
 		/* Argument of CMD23 */
-		packed_cmd_hdr[(i * 2)] =
+		packed_cmd_hdr[(i * 2)] = cpu_to_le32(
 			(do_rel_wr ? MMC_CMD23_ARG_REL_WR : 0) |
 			(do_data_tag ? MMC_CMD23_ARG_TAG_REQ : 0) |
-			blk_rq_sectors(prq);
+			blk_rq_sectors(prq));
 		/* Argument of CMD18 or CMD25 */
-		packed_cmd_hdr[((i * 2)) + 1] =
+		packed_cmd_hdr[((i * 2)) + 1] = cpu_to_le32(
 			mmc_card_blockaddr(card) ?
-			blk_rq_pos(prq) : blk_rq_pos(prq) << 9;
+			blk_rq_pos(prq) : blk_rq_pos(prq) << 9);
 		packed->blocks += blk_rq_sectors(prq);
 		i++;
 	}
-- 
2.5.0

