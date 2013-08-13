From: "Al Cooper" <alcooperx@gmail.com>
Subject: [PATCH 6/7] mmc: lock: Prevent partition table read for locked
 cards.
Date: Tue, 13 Aug 2013 11:21:29 -0400
Message-ID: <1376407290-21477-7-git-send-email-alcooperx@gmail.com>
References: <1376407290-21477-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms1.broadcom.com ([216.31.210.17]:2907 "EHLO mms1.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757986Ab3HMPWT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 13 Aug 2013 11:22:19 -0400
In-Reply-To: <1376407290-21477-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Al Cooper <acooper@broadcom.com>

From: Al Cooper <acooper@broadcom.com>

Change the MMC block layer to avoid reading the partition table
when the card is locked because read commands will fail.

refs #SWLINUX-2545

Signed-off-by: Al Cooper <acooper@broadcom.com>
---
 drivers/mmc/card/block.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index cd0b7f4..8eb254f 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2047,6 +2047,13 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 		md->disk->flags |= GENHD_FL_NO_PART_SCAN;
 
 	/*
+	 * If the card is locked, reads will fail so prevent partition
+	 * table scan
+	 */
+	if (mmc_card_locked(card))
+		md->disk->flags |= GENHD_FL_NO_PART_SCAN;
+
+	/*
 	 * As discussed on lkml, GENHD_FL_REMOVABLE should:
 	 *
 	 * - be set for removable media with permanent block devices
-- 
1.8.1.3


