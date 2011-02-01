From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] mmc: ensure linux does start in eMMC private boot partition
Date: Mon, 31 Jan 2011 22:27:47 -0800
Message-ID: <717F8DCD-CC5B-46F8-A4C4-C772414D7F8C@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:45766 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750859Ab1BAGaI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 1 Feb 2011 01:30:08 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>, Bruce Clemens <BPCLEMEN@marvell.com>


uboot sometimes leaves eMMC pointing to the private boot
partition.  Ensure we always start looking at the user partition

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Bruce Clemens <bpclemens@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>
---
 drivers/mmc/core/mmc.c   |   11 +++++++++++
 include/linux/mmc/card.h |    1 +
 include/linux/mmc/mmc.h  |    2 ++
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 9303a57..d074a62 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -286,6 +286,8 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 			mmc_hostname(card->host));
 	}
 
+	card->ext_csd.bootconfig = ext_csd[EXT_CSD_BOOT_CONFIG];
+
 	if (card->ext_csd.rev >= 3) {
 		u8 sa_shift = ext_csd[EXT_CSD_S_A_TIMEOUT];
 
@@ -492,6 +494,15 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	/*
+	 * ensure eMMC user default PARTITION is enabled
+	 */
+	if (card->ext_csd.bootconfig & 0x7) {
+		card->ext_csd.bootconfig &= ~0x7;
+		mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			EXT_CSD_BOOT_CONFIG, card->ext_csd.bootconfig);
+	}
+
+	/*
 	 * Activate high speed (if supported)
 	 */
 	if ((card->ext_csd.hs_max_dtr != 0) &&
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 8ce0827..8a73b24 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -45,6 +45,7 @@ struct mmc_ext_csd {
 	u8			rev;
 	u8			erase_group_def;
 	u8			sec_feature_support;
+	u8			bootconfig;
 	unsigned int		sa_timeout;		/* Units: 100ns */
 	unsigned int		hs_max_dtr;
 	unsigned int		sectors;
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 612301f..bef80b1 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -198,6 +198,7 @@ struct _mmc_csd {
 	u8  tmp_write_protect;
 	u8  file_format;
 	u8  ecc;
+	u8  bootconfig;
 };
 
 /*
@@ -254,6 +255,7 @@ struct _mmc_csd {
  */
 
 #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
+#define EXT_CSD_BOOT_CONFIG		179	/* R/W */
 #define EXT_CSD_ERASED_MEM_CONT		181	/* RO */
 #define EXT_CSD_BUS_WIDTH		183	/* R/W */
 #define EXT_CSD_HS_TIMING		185	/* R/W */
-- 
1.7.0.4


