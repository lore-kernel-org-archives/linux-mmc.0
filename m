From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH] mmc: core: production year for eMMC 4.41 and later
Date: Fri, 14 Jun 2013 14:25:44 +0200
Message-ID: <1371212744-31596-1-git-send-email-romain.izard.pro@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:59902 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569Ab3FNM0F (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Jun 2013 08:26:05 -0400
Received: by mail-wg0-f41.google.com with SMTP id y10so1126337wgg.2
        for <linux-mmc@vger.kernel.org>; Fri, 14 Jun 2013 05:26:03 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Romain Izard <romain.izard.pro@gmail.com>

The field containing the production date in the CID register only uses
4 bits to encode the year, starting from 1997 in the original standard.
In 2013, the production year field contains 0, and the kernel reports a
1997 production date.

The eMMC 4.51 specification adds a new interpretation rule. For all
devices implementing the 4.41 specification or later, the production
year field will be interpreted as a value between 2010 and 2025, with
0 corresponding to 2013.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/mmc/core/mmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3a69b94..3914523 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -482,6 +482,10 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	}
 
 	if (card->ext_csd.rev >= 5) {
+		/* Adjust production date as per JEDEC JESD84-B451 */
+		if (card->cid.year < 2010)
+			card->cid.year += 16;
+
 		/* check whether the eMMC card supports BKOPS */
 		if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1) {
 			card->ext_csd.bkops = 1;
-- 
1.8.1.2

