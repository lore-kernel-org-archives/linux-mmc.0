From: =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>
Subject: [PATCH] mmc: don't use CMD23 with very old MMC cards
Date: Tue, 30 Aug 2016 14:17:30 +0200
Message-ID: <1472559450-19840-1-git-send-email-dg@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.emlix.com ([88.198.252.230]:58157 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932773AbcH3M2Q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 30 Aug 2016 08:28:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>

CMD23 aka SET_BLOCK_COUNT was introduced with MMC v3.1.
Older versions of the specification allowed to terminate
multi-block transfers only with CMD12.

The patch fixes the following problem:

  mmc0: new MMC card at address 0001
  mmcblk0: mmc0:0001 SDMB-16 15.3 MiB
  mmcblk0: timed out sending SET_BLOCK_COUNT command, card status 0x400900
  ...
  blk_update_request: I/O error, dev mmcblk0, sector 0
  Buffer I/O error on dev mmcblk0, logical block 0, async page read
   mmcblk0: unable to read partition table

Signed-off-by: Daniel Glöckner <dg@emlix.com>
---
 drivers/mmc/card/block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 2206d44..0fec40d 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2303,7 +2303,8 @@ again:
 	set_capacity(md->disk, size);
 
 	if (mmc_host_cmd23(card->host)) {
-		if (mmc_card_mmc(card) ||
+		if ((mmc_card_mmc(card) &&
+		     card->csd.mmca_vsn >= CSD_SPEC_VER_3)||
 		    (mmc_card_sd(card) &&
 		     card->scr.cmds & SD_SCR_CMD23_SUPPORT))
 			md->flags |= MMC_BLK_CMD23;
-- 
2.1.2

