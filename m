From: Haijun Zhang <haijun.zhang@freescale.com>
Subject: [PATCH] mmc:block Add Fixup of BROKEN CMD23 for SANDISK card
Date: Sun, 7 Apr 2013 15:36:32 +0800
Message-ID: <1365320192-27620-1-git-send-email-haijun.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0189.outbound.messaging.microsoft.com ([213.199.154.189]:9431
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932916Ab3DGIMI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Apr 2013 04:12:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Haijun Zhang <haijun.zhang@freescale.com>, Haijun Zhang <Haijun.Zhang@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>

Some sandisk card can't support CMD23, cmd timeout will generate.
SO add FIX-UP for two type of these Sandisk cards.
"SDMB-32" and "SDM032"

Error log:
mmcblk0: timed out sending SET_BLOCK_COUNT command, card status 0x400900
mmcblk0: timed out sending SET_BLOCK_COUNT command, card status 0x400900
mmcblk0: timed out sending SET_BLOCK_COUNT command, card status 0x400900
end_request: I/O error, dev mmcblk0, sector 0
Buffer I/O error on device mmcblk0, logical block 0
mmcblk0: timed out sending SET_BLOCK_COUNT command, card status 0x400900

Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
CC: Anton Vorontsov <cbouatmailru@gmail.com>
---
 drivers/mmc/card/block.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index e12a03c..fb378e0 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2264,6 +2264,10 @@ static const struct mmc_fixup blk_fixups[] =
 	 *
 	 * N.B. This doesn't affect SD cards.
 	 */
+	MMC_FIXUP("SDMB-32", CID_MANFID_SANDISK, CID_OEMID_ANY, add_quirk_mmc,
+		MMC_QUIRK_BLK_NO_CMD23),
+	MMC_FIXUP("SDM032", CID_MANFID_SANDISK, CID_OEMID_ANY, add_quirk_mmc,
+		MMC_QUIRK_BLK_NO_CMD23),
 	MMC_FIXUP("MMC08G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_BLK_NO_CMD23),
 	MMC_FIXUP("MMC16G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
-- 
1.7.0.4


