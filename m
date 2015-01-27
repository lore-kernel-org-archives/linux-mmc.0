From: Alexey Skidanov <alexey.skidanov@sandisk.com>
Subject: [PATCH] mmc: Manual BKOPs enablement bug fix
Date: Tue, 27 Jan 2015 16:01:20 +0200
Message-ID: <1422367281-17546-1-git-send-email-alexey.skidanov@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0054.outbound.protection.outlook.com ([65.55.169.54]:5686
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752423AbbA0QfO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 27 Jan 2015 11:35:14 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: alex.lemberg@sandisk.com, Alexey Skidanov <alexey.skidanov@sandisk.com>

This patch is coming to fix compatibility issue of BKOPS_EN  field of EXT_CSD.
In eMMC-5.1, BKOPS_EN was changed, and now it has two operational bits:
Bit 0 - MANUAL_EN
Bit 1 - AUTO_EN
In previous eMMC revisions, only Bit 0 was supported.

Signed-off-by: Alexey Skidanov <alexey.skidanov@sandisk.com>
---
 drivers/mmc/core/core.c  |    2 +-
 drivers/mmc/core/mmc.c   |    6 ++++--
 include/linux/mmc/card.h |    5 ++++-
 include/linux/mmc/mmc.h  |    6 ++++++
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1be7055..0dc64e6 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -275,7 +275,7 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 
 	BUG_ON(!card);
 
-	if (!card->ext_csd.bkops_en || mmc_card_doing_bkops(card))
+	if (!card->ext_csd.man_bkops_en || mmc_card_doing_bkops(card))
 		return;
 
 	err = mmc_read_bkops_status(card);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 1fc48a2..c35bf6e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -483,10 +483,12 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		/* check whether the eMMC card supports BKOPS */
 		if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1) {
 			card->ext_csd.bkops = 1;
-			card->ext_csd.bkops_en = ext_csd[EXT_CSD_BKOPS_EN];
+			card->ext_csd.man_bkops_en =
+					(ext_csd[EXT_CSD_BKOPS_EN] &
+						EXT_CSD_MANUAL_BKOPS_MASK);
 			card->ext_csd.raw_bkops_status =
 				ext_csd[EXT_CSD_BKOPS_STATUS];
-			if (!card->ext_csd.bkops_en)
+			if (!card->ext_csd.man_bkops_en)
 				pr_info("%s: BKOPS_EN bit is not set\n",
 					mmc_hostname(card->host));
 		}
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 4d69c00..15772d0 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -83,7 +83,10 @@ struct mmc_ext_csd {
 	bool			hpi;			/* HPI support bit */
 	unsigned int		hpi_cmd;		/* cmd used as HPI */
 	bool			bkops;		/* background support bit */
-	bool			bkops_en;	/* background enable bit */
+	bool			man_bkops_en;	/* manual background
+						enable bit */
+	bool			auto_bkops_en;	/* automatic background
+						enable bit */
 	unsigned int            data_sector_size;       /* 512 bytes or 4KB */
 	unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
 	unsigned int		boot_ro_lock;		/* ro lock support */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index fb97b5c..d39db3e 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -428,6 +428,12 @@ struct _mmc_csd {
 #define EXT_CSD_BKOPS_LEVEL_2		0x2
 
 /*
+ * BKOPS modes
+ */
+#define EXT_CSD_MANUAL_BKOPS_MASK	0x01
+#define EXT_CSD_AUTOMATIC_BKOPS_MASK	0x02
+
+/*
  * MMC_SWITCH access modes
  */
 
-- 
1.7.9.5

