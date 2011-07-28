From: Kyungmin Park <kmpark@infradead.org>
Subject: [PATCH] mmc: new discard feature support at mmc v4.5
Date: Thu, 28 Jul 2011 14:17:13 +0900
Message-ID: <20110728051713.GA17683@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:44052 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047Ab1G1FRW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jul 2011 01:17:22 -0400
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LP10083O2OE50O0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 28 Jul 2011 14:17:20 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LP100FOM2OW43@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 28 Jul 2011 14:17:20 +0900 (KST)
Content-disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: jh80.chung@samsung.com

From: Kyungmin Park <kyungmin.park@samsung.com>

At mmc v4.5, it supports the DISCARD feature (CMD38).
It's different from trim and there's no check bit. 
currently it's only supported at v4.5.

In trim mode, the controller can perform the actual erase at a convenient time.
however, In discard, The controller can perform partial or full the actual erase at a convenient time.

So in mmc v4.5, it's better to use the discard instead of trim.

it's based on the previous patch, "mmc: Detect mmc v4.5"

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1ff5486..9649997 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -701,7 +701,9 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 	from = blk_rq_pos(req);
 	nr = blk_rq_sectors(req);
 
-	if (mmc_can_trim(card))
+	if (mmc_can_discard(card))
+		arg = MMC_DISCARD_ARG;
+	else if (mmc_can_trim(card))
 		arg = MMC_TRIM_ARG;
 	else
 		arg = MMC_ERASE_ARG;
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 89bdeae..8fb80d8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1587,10 +1587,24 @@ int mmc_can_trim(struct mmc_card *card)
 {
 	if (card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN)
 		return 1;
+	if (mmc_can_discard(card))
+		return 1;
 	return 0;
 }
 EXPORT_SYMBOL(mmc_can_trim);
 
+int mmc_can_discard(struct mmc_card *card)
+{
+	/*
+	 * As there's no way to detect the discard support bit at v4.5
+	 * use the s/w feature support filed.
+	 */
+	if (card->ext_csd.feature_support & MMC_DISCARD_FEATURE)
+		return 1;
+	return 0;
+}
+EXPORT_SYMBOL(mmc_can_discard);
+
 int mmc_can_secure_erase_trim(struct mmc_card *card)
 {
 	if (card->ext_csd.sec_feature_support & EXT_CSD_SEC_ER_EN)
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index aa7d1d7..2a356b7 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -405,6 +405,10 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	if (card->ext_csd.rev >= 5)
 		card->ext_csd.rel_param = ext_csd[EXT_CSD_WR_REL_PARAM];
 
+	/* eMMC v4.5 or later */
+	if (card->ext_csd.rev >= 6)
+		card->ext_csd.feature_support |= MMC_DISCARD_FEATURE;
+
 	if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
 		card->erased_byte = 0xFF;
 	else
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index b460fc2..d5d8c0d 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -77,6 +77,9 @@ struct mmc_ext_csd {
 	u8			raw_sec_feature_support;/* 231 */
 	u8			raw_trim_mult;		/* 232 */
 	u8			raw_sectors[4];		/* 212 - 4 bytes */
+
+#define MMC_DISCARD_FEATURE	BIT(0)			/* CMD38 feature */
+	unsigned int		feature_support;
 };
 
 struct sd_scr {
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index b8b1b7a..6118f10 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -146,6 +146,7 @@ extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
 #define MMC_ERASE_ARG		0x00000000
 #define MMC_SECURE_ERASE_ARG	0x80000000
 #define MMC_TRIM_ARG		0x00000001
+#define MMC_DISCARD_ARG		0x00000003
 #define MMC_SECURE_TRIM1_ARG	0x80000001
 #define MMC_SECURE_TRIM2_ARG	0x80008000
 
@@ -156,6 +157,7 @@ extern int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 		     unsigned int arg);
 extern int mmc_can_erase(struct mmc_card *card);
 extern int mmc_can_trim(struct mmc_card *card);
+extern int mmc_can_discard(struct mmc_card *card);
 extern int mmc_can_secure_erase_trim(struct mmc_card *card);
 extern int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
 				   unsigned int nr);
