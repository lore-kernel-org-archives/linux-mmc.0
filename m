From: Andrei Warkentin <andreiw@motorola.com>
Subject: [PatchRebased] MMC: Fix erase/trim for certain SanDisk cards.
Date: Tue, 12 Apr 2011 15:06:53 -0500
Message-ID: <1302638813-32155-1-git-send-email-andreiw@motorola.com>
References: <BANLkTi=N75ATcXHqbjDMpCMJ1bGnJggqog@mail.gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:35874 "EHLO
	exprod5og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739Ab1DLT16 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2011 15:27:58 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3CJQ8EN020048
	for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2011 15:26:08 -0400 (EDT)
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com [209.85.160.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3CJPRCZ019697
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2011 15:26:08 -0400 (EDT)
Received: by mail-gy0-f170.google.com with SMTP id 11so4745695gyb.15
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2011 12:27:56 -0700 (PDT)
In-Reply-To: <BANLkTi=N75ATcXHqbjDMpCMJ1bGnJggqog@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>

CMD38 argument is passed through EXT_CSD[113].

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/block.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mmc/card.h |    1 +
 2 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1bf1c5d..863f810 100644
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
@@ -356,6 +363,16 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 	else
 		arg = MMC_ERASE_ARG;
 
+	if (card->quirks & MMC_QUIRK_INAND_CMD38) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				 INAND_CMD38_ARG_EXT_CSD,
+				 arg == MMC_TRIM_ARG ?
+				 INAND_CMD38_ARG_TRIM :
+				 INAND_CMD38_ARG_ERASE,
+				 0);
+		if (err)
+			goto out;
+	}
 	err = mmc_erase(card, from, nr, arg);
 out:
 	spin_lock_irq(&md->lock);
@@ -386,9 +403,28 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 	else
 		arg = MMC_SECURE_ERASE_ARG;
 
+	if (card->quirks & MMC_QUIRK_INAND_CMD38) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				 INAND_CMD38_ARG_EXT_CSD,
+				 arg == MMC_SECURE_TRIM1_ARG ?
+				 INAND_CMD38_ARG_SECTRIM1 :
+				 INAND_CMD38_ARG_SECERASE,
+				 0);
+		if (err)
+			goto out;
+	}
 	err = mmc_erase(card, from, nr, arg);
-	if (!err && arg == MMC_SECURE_TRIM1_ARG)
+	if (!err && arg == MMC_SECURE_TRIM1_ARG) {
+		if (card->quirks & MMC_QUIRK_INAND_CMD38) {
+			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+					 INAND_CMD38_ARG_EXT_CSD,
+					 INAND_CMD38_ARG_SECTRIM2,
+					 0);
+			if (err)
+				goto out;
+		}
 		err = mmc_erase(card, from, nr, MMC_SECURE_TRIM2_ARG);
+	}
 out:
 	spin_lock_irq(&md->lock);
 	__blk_end_request(req, err, blk_rq_bytes(req));
@@ -941,6 +977,11 @@ static int mmc_add_disk(struct mmc_blk_data *md)
 
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
index 8ac96f7..0a2be01 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -133,6 +133,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_CLK_GATING (1<<3)	/* clock gating the sdio bus will make card fail */
 #define MMC_QUIRK_NONSTD_FUNC_IF (1<<4)		/* SDIO card has nonstd function interfaces */
 #define MMC_QUIRK_DISABLE_CD	(1<<5)		/* disconnect CD/DAT[3] resistor */
+#define MMC_QUIRK_INAND_CMD38	(1<<6)		/* iNAND devices have broken CMD38 */
 
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
-- 
1.7.0.4

