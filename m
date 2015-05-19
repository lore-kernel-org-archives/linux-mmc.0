From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH V3 6/8] mmc: lock: Prevent partition table read for locked cards.
Date: Tue, 19 May 2015 19:11:12 -0400
Message-ID: <1432077074-8422-7-git-send-email-alcooperx@gmail.com>
References: <1432077074-8422-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:24279 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbbESXMK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2015 19:12:10 -0400
In-Reply-To: <1432077074-8422-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, pgynther@google.com
Cc: Al Cooper <alcooperx@gmail.com>

Change the MMC block layer to avoid reading the partition table
when the card is locked because read commands will fail.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/card/block.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 60f7141..5650748 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2147,6 +2147,13 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
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
1.9.0.138.g2de3478

