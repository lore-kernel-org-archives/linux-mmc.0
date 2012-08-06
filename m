From: Loic Pallardy <loic.pallardy-ext@stericsson.com>
Subject: [PATCH v3 1/5] mmc: core: Expose access to RPMB partition
Date: Mon, 6 Aug 2012 17:12:27 +0200
Message-ID: <1344265951-22437-2-git-send-email-loic.pallardy-ext@stericsson.com>
References: <1344265951-22437-1-git-send-email-loic.pallardy-ext@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:59879 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932081Ab2HFPNY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Aug 2012 11:13:24 -0400
In-Reply-To: <1344265951-22437-1-git-send-email-loic.pallardy-ext@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Loic Pallardy <loic.pallardy-ext@stericsson.com>, Alex Macro <alex.macro@stericsson.com>, Loic Pallardy <loic.pallardy@stericsson.com>

Following JEDEC standard, if the mmc support RPMB partition,
a new interface is created and exposed via /dev/block.
Users will be able to access RPMB partition using standard
mmc IOCTL command.

Signed-off-by: Alex Macro <alex.macro@stericsson.com>
Signed-off-by: Loic Pallardy <loic.pallardy@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Johan Rudholm <johan.rudholm@stericsson.com>
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
---
 drivers/mmc/core/mmc.c   | 11 +++++++++++
 include/linux/mmc/card.h |  2 ++
 include/linux/mmc/mmc.h  |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 258b203..8a459cb 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -480,6 +480,17 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 
 		card->ext_csd.rel_param = ext_csd[EXT_CSD_WR_REL_PARAM];
 		card->ext_csd.rst_n_function = ext_csd[EXT_CSD_RST_N_FUNCTION];
+
+		/*
+		 * RPMB regions are defined in multiples of 128K.
+		 */
+		card->ext_csd.raw_rpmb_size_mult = ext_csd[EXT_CSD_RPMB_MULT];
+		if (ext_csd[EXT_CSD_RPMB_MULT]) {
+			mmc_part_add(card, ext_csd[EXT_CSD_RPMB_MULT] << 17,
+				EXT_CSD_PART_CONFIG_ACC_RPMB,
+				"rpmb", 0, false,
+				MMC_BLK_DATA_AREA_RPMB);
+		}
 	}
 
 	card->ext_csd.raw_erased_mem_count = ext_csd[EXT_CSD_ERASED_MEM_CONT];
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index d76513b..46a5502 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -81,6 +81,7 @@ struct mmc_ext_csd {
 	unsigned int		boot_ro_lock;		/* ro lock support */
 	bool			boot_ro_lockable;
 	u8			raw_partition_support;	/* 160 */
+	u8			raw_rpmb_size_mult;	/* 168 */
 	u8			raw_erased_mem_count;	/* 181 */
 	u8			raw_ext_csd_structure;	/* 194 */
 	u8			raw_card_type;		/* 196 */
@@ -200,6 +201,7 @@ struct mmc_part {
 #define MMC_BLK_DATA_AREA_MAIN	(1<<0)
 #define MMC_BLK_DATA_AREA_BOOT	(1<<1)
 #define MMC_BLK_DATA_AREA_GP	(1<<2)
+#define MMC_BLK_DATA_AREA_RPMB	(1<<3)
 };
 
 /*
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index d425cab..e73136a 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -282,6 +282,7 @@ struct _mmc_csd {
 #define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
 #define EXT_CSD_SANITIZE_START		165     /* W */
 #define EXT_CSD_WR_REL_PARAM		166	/* RO */
+#define EXT_CSD_RPMB_MULT		168	/* RO */
 #define EXT_CSD_BOOT_WP			173	/* R/W */
 #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
 #define EXT_CSD_PART_CONFIG		179	/* R/W */
@@ -333,6 +334,7 @@ struct _mmc_csd {
 
 #define EXT_CSD_PART_CONFIG_ACC_MASK	(0x7)
 #define EXT_CSD_PART_CONFIG_ACC_BOOT0	(0x1)
+#define EXT_CSD_PART_CONFIG_ACC_RPMB	(0x3)
 #define EXT_CSD_PART_CONFIG_ACC_GP0	(0x4)
 
 #define EXT_CSD_PART_SUPPORT_PART_EN	(0x1)
-- 
1.7.11.1

