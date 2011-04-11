From: Andrei Warkentin <andreiw@motorola.com>
Subject: [PATCH 2/2] MMC: Fix erase/trim for certain SanDisk cards.
Date: Mon, 11 Apr 2011 17:20:41 -0500
Message-ID: <1302560441-10565-3-git-send-email-andreiw@motorola.com>
References: <1302560441-10565-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:50821 "EHLO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755928Ab1DKVlo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 17:41:44 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3BLg4gV018864
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 17:42:05 -0400 (EDT)
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com [209.85.213.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3BLfP9o018621
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 17:42:04 -0400 (EDT)
Received: by mail-yw0-f42.google.com with SMTP id 1so4181113ywh.15
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2011 14:41:42 -0700 (PDT)
In-Reply-To: <1302560441-10565-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>

CMD38 argument is passed through EXT_CSD[113].

Change-Id: I47e9d5e2cf44d9274a65a3b1955026185cb8f2b8
Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/block.c |   40 +++++++++++++++++++++++++++++++++++++++-
 include/linux/mmc/card.h |    1 +
 2 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 823f295..9fba4a6 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -48,6 +48,13 @@ MODULE_ALIAS("mmc:block");
 #endif
 #define MODULE_PARAM_PREFIX "mmcblk."
 
+#define INAND_CMD38_ARG_EXT_CSD  113
+#define INAND_CMD38_ARG_ERASE    0x00
+#define INAND_CMD38_ARG_TRIM     0x01
+#define INAND_CMD38_ARG_SECERASE 0x80
+#define INAND_CMD38_ARG_SECTRIM1 0x81
+#define INAND_CMD38_ARG_SECTRIM2 0x88
+
 #define REL_WRITES_SUPPORTED(card) (mmc_card_mmc((card)) &&	\
     (((card)->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||	\
      ((card)->ext_csd.rel_sectors)))
@@ -288,6 +295,15 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 	else
 		arg = MMC_ERASE_ARG;
 
+	if (card->quirks & MMC_QUIRK_INAND_CMD38) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				 INAND_CMD38_ARG_EXT_CSD,
+				 arg == MMC_TRIM_ARG ?
+				 INAND_CMD38_ARG_TRIM :
+				 INAND_CMD38_ARG_ERASE);
+		if (err)
+			goto out;
+	}
 	err = mmc_erase(card, from, nr, arg);
 out:
 	spin_lock_irq(&md->lock);
@@ -322,9 +338,26 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 	else
 		arg = MMC_SECURE_ERASE_ARG;
 
+	if (card->quirks & MMC_QUIRK_INAND_CMD38) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				 INAND_CMD38_ARG_EXT_CSD,
+				 arg == MMC_SECURE_TRIM1_ARG ?
+				 INAND_CMD38_ARG_SECTRIM1 :
+				 INAND_CMD38_ARG_SECERASE);
+		if (err)
+			goto out;
+	}
 	err = mmc_erase(card, from, nr, arg);
-	if (!err && arg == MMC_SECURE_TRIM1_ARG)
+	if (!err && arg == MMC_SECURE_TRIM1_ARG) {
+		if (card->quirks & MMC_QUIRK_INAND_CMD38) {
+			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+					 INAND_CMD38_ARG_EXT_CSD,
+					 INAND_CMD38_ARG_SECTRIM2);
+			if (err)
+				goto out;
+		}
 		err = mmc_erase(card, from, nr, MMC_SECURE_TRIM2_ARG);
+	}
 out:
 	spin_lock_irq(&md->lock);
 	__blk_end_request(req, err, blk_rq_bytes(req));
@@ -757,6 +790,11 @@ mmc_blk_set_blksize(struct mmc_blk_data *md, struct mmc_card *card)
 
 static const struct mmc_fixup blk_fixups[] =
 {
+	MMC_FIXUP("SEM02G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
+	MMC_FIXUP("SEM04G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
+	MMC_FIXUP("SEM08G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
+	MMC_FIXUP("SEM16G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
+	MMC_FIXUP("SEM32G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
 	END_FIXUP
 };
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index c651317..28ce230 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -131,6 +131,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_CLK_GATING (1<<3)	/* clock gating the sdio bus will make card fail */
 #define MMC_QUIRK_NONSTD_FUNC_IF (1<<4)		/* SDIO card has nonstd function interfaces */
 #define MMC_QUIRK_DISABLE_CD	(1<<5)		/* disconnect CD/DAT[3] resistor */
+#define MMC_QUIRK_INAND_CMD38	(1<<6)		/* iNAND devices have broken CMD38 */
 
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
-- 
1.7.0.4

