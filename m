From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH V3 6/7] mmc: lock: Prevent block device from coming up for locked cards.
Date: Wed, 5 Mar 2014 18:44:51 -0500
Message-ID: <1394063092-9048-7-git-send-email-alcooperx@gmail.com>
References: <1394063092-9048-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:4980 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757296AbaCEXxB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Mar 2014 18:53:01 -0500
In-Reply-To: <1394063092-9048-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Al Cooper <alcooperx@gmail.com>

A locked card will return an error for all reads/writes to the
block device, so prevent the block layer from coming up until
the card is unlocked.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/card/block.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 7b5424f..a4b909d 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2377,6 +2377,16 @@ static int mmc_blk_probe(struct mmc_card *card)
 	struct mmc_blk_data *md, *part_md;
 	char cap_str[10];
 
+
+	/* if the card is locked, don't bring up the block layer because
+	 * all reads and writes will fail.
+	 */
+	if (mmc_card_locked(card)) {
+		pr_debug("%s: %s - Probe aborted because card is locked\n",
+			 mmc_hostname(card->host), __func__);
+		return -ENODEV;
+	}
+
 	/*
 	 * Check that the card supports the command class(es) we need.
 	 */
-- 
1.8.1.3

