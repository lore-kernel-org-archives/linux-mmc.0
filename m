From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [PATCH] mmc: block: add fixup of broken CMD23 for Sandisk card
Date: Fri, 10 Jul 2015 11:44:03 +0800
Message-ID: <1436499843-16527-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0124.outbound.protection.outlook.com ([65.55.169.124]:32052
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751229AbbGJDsr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jul 2015 23:48:47 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Some Sandisk cards(such as "SDMB-32" and "SDM032" cards)
can't support CMD23, and would generate CMD timeout. So add
FIX-UP for these two types Sandisk cards.

Error log:
mmcblk0: timed out sending SET_BLOCK_COUNT command, card status 0x400900
mmcblk0: timed out sending SET_BLOCK_COUNT command, card status 0x400900
mmcblk0: timed out sending SET_BLOCK_COUNT command, card status 0x400900
end_request: I/O error, dev mmcblk0, sector 0
Buffer I/O error on device mmcblk0, logical block 0
mmcblk0: timed out sending SET_BLOCK_COUNT command, card status 0x400900

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/card/block.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c9c3d20..d06b9ab 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2406,6 +2406,10 @@ static const struct mmc_fixup blk_fixups[] =
 	 *
 	 * N.B. This doesn't affect SD cards.
 	 */
+	MMC_FIXUP("SDMB-32", CID_MANFID_SANDISK, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BLK_NO_CMD23),
+	MMC_FIXUP("SDM032", CID_MANFID_SANDISK, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BLK_NO_CMD23),
 	MMC_FIXUP("MMC08G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_BLK_NO_CMD23),
 	MMC_FIXUP("MMC16G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
-- 
2.1.0.27.g96db324

