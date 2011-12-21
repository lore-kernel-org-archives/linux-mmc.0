From: Saugata Das <saugata.das@stericsson.com>
Subject: [PATCH] MMC-4.5 Data Tag Support
Date: Wed, 21 Dec 2011 13:09:17 +0530
Message-ID: <1324453157-30081-1-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:48678 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751071Ab1LUHj0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Dec 2011 02:39:26 -0500
Received: from zeta.dmz-us.st.com (ns4.st.com [167.4.16.71])
	by beta.dmz-us.st.com (STMicroelectronics) with ESMTP id B6B8E68
	for <linux-mmc@vger.kernel.org>; Wed, 21 Dec 2011 07:39:18 +0000 (GMT)
Received: from relay2.stm.gmessaging.net (unknown [10.230.100.18])
	by zeta.dmz-us.st.com (STMicroelectronics) with ESMTP id 4049476
	for <linux-mmc@vger.kernel.org>; Wed, 21 Dec 2011 07:06:10 +0000 (GMT)
Received: from exdcvycastm022.EQ1STM.local (alteon-source-exch [10.230.100.61])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "exdcvycastm022", Issuer "exdcvycastm022" (not verified))
	by relay2.stm.gmessaging.net (Postfix) with ESMTPS id 1A09AA8065
	for <linux-mmc@vger.kernel.org>; Wed, 21 Dec 2011 08:39:19 +0100 (CET)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

From: Saugata Das <saugata.das@linaro.org>

MMC-4.5 data tag feature will be used to store the file system meta-data in the
tagged region of eMMC. This will improve the write and subsequent read transfer
time for the meta data.

Signed-off-by: Saugata Das <saugata.das@linaro.org>
---
 drivers/mmc/card/block.c |   17 +++++++++++++++--
 drivers/mmc/core/mmc.c   |   14 ++++++++++++++
 include/linux/mmc/card.h |    2 ++
 include/linux/mmc/mmc.h  |    3 +++
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index a1cb21f..af3b6c3 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -995,6 +995,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	struct mmc_blk_request *brq = &mqrq->brq;
 	struct request *req = mqrq->req;
 	struct mmc_blk_data *md = mq->data;
+	bool do_data_tag;
 
 	/*
 	 * Reliable writes are used to implement Forced Unit Access and
@@ -1071,6 +1072,16 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 		mmc_apply_rel_rw(brq, card, req);
 
 	/*
+	 * Data tag is used only during writing meta data to speed
+	 * up write and any subsequent read of this meta data
+	 */
+	do_data_tag = (card->ext_csd.data_tag_unit_size) &&
+		(req->cmd_flags & REQ_META) &&
+		(rq_data_dir(req) == WRITE) &&
+		((brq->data.blocks * brq->data.blksz) >=
+		card->ext_csd.data_tag_unit_size) ;
+
+	/*
 	 * Pre-defined multi-block transfers are preferable to
 	 * open ended-ones (and necessary for reliable writes).
 	 * However, it is not sufficient to just send CMD23,
@@ -1091,10 +1102,12 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 
 	if ((md->flags & MMC_BLK_CMD23) &&
 	    mmc_op_multi(brq->cmd.opcode) &&
-	    (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_NO_CMD23))) {
+	    (do_rel_wr || !(card->quirks & MMC_QUIRK_BLK_NO_CMD23) ||
+		do_data_tag)) {
 		brq->sbc.opcode = MMC_SET_BLOCK_COUNT;
 		brq->sbc.arg = brq->data.blocks |
-			(do_rel_wr ? (1 << 31) : 0);
+			(do_rel_wr ? (1 << 31) : 0) |
+			(do_data_tag ? (1 << 29) : 0);
 		brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
 		brq->mrq.sbc = &brq->sbc;
 	}
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index dbf421a..244049b 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -488,6 +488,20 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 			ext_csd[EXT_CSD_CACHE_SIZE + 1] << 8 |
 			ext_csd[EXT_CSD_CACHE_SIZE + 2] << 16 |
 			ext_csd[EXT_CSD_CACHE_SIZE + 3] << 24;
+
+		if (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] == 1)
+			card->ext_csd.data_sector_size = 4096;
+		else
+			card->ext_csd.data_sector_size = 512;
+
+		if ((ext_csd[EXT_CSD_DATA_TAG_SUPPORT] & 1) &&
+			(ext_csd[EXT_CSD_TAG_UNIT_SIZE] <= 8)) {
+			card->ext_csd.data_tag_unit_size =
+			((unsigned int) 1 << ext_csd[EXT_CSD_TAG_UNIT_SIZE]) *
+			(card->ext_csd.data_sector_size);
+		} else {
+			card->ext_csd.data_tag_unit_size = 0;
+		}
 	}
 
 out:
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 415f2db..a55668d 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -71,6 +71,8 @@ struct mmc_ext_csd {
 	bool			hpi_en;			/* HPI enablebit */
 	bool			hpi;			/* HPI support bit */
 	unsigned int		hpi_cmd;		/* cmd used as HPI */
+	unsigned int		data_sector_size;	/* 512Bytes or 4KB */
+	unsigned int		data_tag_unit_size;	/* DATA TAG UNIT size */
 	u8			raw_partition_support;	/* 160 */
 	u8			raw_erased_mem_count;	/* 181 */
 	u8			raw_ext_csd_structure;	/* 194 */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 0e71356..e076f7f 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -273,6 +273,7 @@ struct _mmc_csd {
 #define EXT_CSD_FLUSH_CACHE		32      /* W */
 #define EXT_CSD_CACHE_CTRL		33      /* R/W */
 #define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */
+#define EXT_CSD_DATA_SECTOR_SIZE	61	/* R */
 #define EXT_CSD_GP_SIZE_MULT		143	/* R/W */
 #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
 #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
@@ -313,6 +314,8 @@ struct _mmc_csd {
 #define EXT_CSD_POWER_OFF_LONG_TIME	247	/* RO */
 #define EXT_CSD_GENERIC_CMD6_TIME	248	/* RO */
 #define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
+#define EXT_CSD_TAG_UNIT_SIZE		498	/* RO */
+#define EXT_CSD_DATA_TAG_SUPPORT	499	/* RO */
 #define EXT_CSD_HPI_FEATURES		503	/* RO */
 
 /*
-- 
1.7.4.3

