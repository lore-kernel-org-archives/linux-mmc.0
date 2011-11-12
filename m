From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: card: Use manufacturer ID symbols in card quirks.
Date: Fri, 11 Nov 2011 22:07:01 -0500
Message-ID: <1321067221-18639-1-git-send-email-cjb@laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58333 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971Ab1KLDHf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Nov 2011 22:07:35 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, "Andrei E. Warkentin" <andrey.warkentin@gmail.com>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

No functional change; adds macros for card manufacturer IDs.

Signed-off-by: Chris Ball <cjb@laptop.org>
Cc: Andrei E. Warkentin <andrey.warkentin@gmail.com>
Cc: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
---
 drivers/mmc/card/block.c |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1e0e27c..c80bb6d 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1584,13 +1584,22 @@ static int mmc_add_disk(struct mmc_blk_data *md)
 	return ret;
 }
 
+#define CID_MANFID_SANDISK	0x2
+#define CID_MANFID_TOSHIBA	0x11
+#define CID_MANFID_MICRON	0x13
+
 static const struct mmc_fixup blk_fixups[] =
 {
-	MMC_FIXUP("SEM02G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
-	MMC_FIXUP("SEM04G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
-	MMC_FIXUP("SEM08G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
-	MMC_FIXUP("SEM16G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
-	MMC_FIXUP("SEM32G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
+	MMC_FIXUP("SEM02G", CID_MANFID_SANDISK, 0x100, add_quirk,
+		  MMC_QUIRK_INAND_CMD38),
+	MMC_FIXUP("SEM04G", CID_MANFID_SANDISK, 0x100, add_quirk,
+		  MMC_QUIRK_INAND_CMD38),
+	MMC_FIXUP("SEM08G", CID_MANFID_SANDISK, 0x100, add_quirk,
+		  MMC_QUIRK_INAND_CMD38),
+	MMC_FIXUP("SEM16G", CID_MANFID_SANDISK, 0x100, add_quirk,
+		  MMC_QUIRK_INAND_CMD38),
+	MMC_FIXUP("SEM32G", CID_MANFID_SANDISK, 0x100, add_quirk,
+		  MMC_QUIRK_INAND_CMD38),
 
 	/*
 	 * Some MMC cards experience performance degradation with CMD23
@@ -1600,18 +1609,18 @@ static const struct mmc_fixup blk_fixups[] =
 	 *
 	 * N.B. This doesn't affect SD cards.
 	 */
-	MMC_FIXUP("MMC08G", 0x11, CID_OEMID_ANY, add_quirk_mmc,
+	MMC_FIXUP("MMC08G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_BLK_NO_CMD23),
-	MMC_FIXUP("MMC16G", 0x11, CID_OEMID_ANY, add_quirk_mmc,
+	MMC_FIXUP("MMC16G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_BLK_NO_CMD23),
-	MMC_FIXUP("MMC32G", 0x11, CID_OEMID_ANY, add_quirk_mmc,
+	MMC_FIXUP("MMC32G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_BLK_NO_CMD23),
 
 	/*
 	 * Some Micron MMC cards needs longer data read timeout than
 	 * indicated in CSD.
 	 */
-	MMC_FIXUP(CID_NAME_ANY, 0x13, 0x200, add_quirk_mmc,
+	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_MICRON, 0x200, add_quirk_mmc,
 		  MMC_QUIRK_LONG_READ_TIME),
 
 	END_FIXUP
-- 
1.7.5.4

