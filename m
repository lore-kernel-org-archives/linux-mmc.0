From: Sheetal Tigadoli <sheetal.tigadoli@gmail.com>
Subject: [PATCH 4/5] drivers: mmc: card: Fixed ERROR that open brace should be on the previous line
Date: Mon,  2 Feb 2015 01:37:01 +0530
Message-ID: <1422821222-24079-5-git-send-email-sheetal.tigadoli@gmail.com>
References: <1422821222-24079-1-git-send-email-sheetal.tigadoli@gmail.com>
 <1422821222-24079-2-git-send-email-sheetal.tigadoli@gmail.com>
 <1422821222-24079-3-git-send-email-sheetal.tigadoli@gmail.com>
 <1422821222-24079-4-git-send-email-sheetal.tigadoli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422821222-24079-4-git-send-email-sheetal.tigadoli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: chris@printf.net
Cc: joe@perches.com, linux-mmc@vger.kernel.org, ben@decadent.org.uk, kuninori.morimoto.gx@renesas.com, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, Sheetal Tigadoli <sheetal.tigadoli@gmail.com>
List-Id: linux-mmc@vger.kernel.org

 The Patch fixes the below coding style error found using checkpatch.pl script

        drivers/mmc/card/block.c:2362: ERROR: that open brace { should be on the previous line

Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@gmail.com>
---
 drivers/mmc/card/block.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 2394d0b..fe47297 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2358,8 +2358,7 @@ force_ro_fail:
 #define CID_MANFID_MICRON	0x13
 #define CID_MANFID_SAMSUNG	0x15
 
-static const struct mmc_fixup blk_fixups[] =
-{
+static const struct mmc_fixup blk_fixups[] = {
 	MMC_FIXUP("SEM02G", CID_MANFID_SANDISK, 0x100, add_quirk,
 		  MMC_QUIRK_INAND_CMD38),
 	MMC_FIXUP("SEM04G", CID_MANFID_SANDISK, 0x100, add_quirk,
-- 
1.7.9.5
