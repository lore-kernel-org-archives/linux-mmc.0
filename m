From: Uri Yanai <uri.yanai@sandisk.com>
Subject: [PATCH v2 1/2] mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS support
Date: Sun, 22 Jan 2017 11:15:34 +0200
Message-ID: <1485076535-20572-2-git-send-email-uri.yanai@sandisk.com>
References: <1485076535-20572-1-git-send-email-uri.yanai@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-co1nam03on0045.outbound.protection.outlook.com ([104.47.40.45]:50954
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750735AbdAVJxv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 22 Jan 2017 04:53:51 -0500
In-Reply-To: <1485076535-20572-1-git-send-email-uri.yanai@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, alex.lemberg@sandisk.com, Uri Yanai <uri.yanai@sandisk.com>

Read from the device EXT_CSD and set to the card->ext_csd structure

Changes in v2:
- inverse the logic for printing the debug message.
  only print when bits are set.

Signed-off-by: Uri Yanai <uri.yanai@sandisk.com>
Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
---
 drivers/mmc/core/mmc.c   | 10 ++++++++--
 include/linux/mmc/card.h |  1 +
 include/linux/mmc/mmc.h  |  1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c0e2507..f70f6a1 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -530,8 +530,14 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 						EXT_CSD_MANUAL_BKOPS_MASK);
 			card->ext_csd.raw_bkops_status =
 				ext_csd[EXT_CSD_BKOPS_STATUS];
-			if (!card->ext_csd.man_bkops_en)
-				pr_debug("%s: MAN_BKOPS_EN bit is not set\n",
+			if (card->ext_csd.man_bkops_en)
+				pr_debug("%s: MAN_BKOPS_EN bit is set\n",
+					mmc_hostname(card->host));
+			card->ext_csd.auto_bkops_en =
+					(ext_csd[EXT_CSD_BKOPS_EN] &
+						EXT_CSD_AUTO_BKOPS_MASK);
+			if (card->ext_csd.auto_bkops_en)
+				pr_debug("%s: AUTO_BKOPS_EN bit is set\n",
 					mmc_hostname(card->host));
 		}
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 00449e5..e3f1031 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -84,6 +84,7 @@ struct mmc_ext_csd {
 	unsigned int		hpi_cmd;		/* cmd used as HPI */
 	bool			bkops;		/* background support bit */
 	bool			man_bkops_en;	/* manual bkops enable bit */
+	bool			auto_bkops_en;	/* auto bkops enable bit */
 	unsigned int            data_sector_size;       /* 512 bytes or 4KB */
 	unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
 	unsigned int		boot_ro_lock;		/* ro lock support */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index a074082..126b8d5 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -449,6 +449,7 @@ struct _mmc_csd {
  * BKOPS modes
  */
 #define EXT_CSD_MANUAL_BKOPS_MASK	0x01
+#define EXT_CSD_AUTO_BKOPS_MASK		0x02
 
 /*
  * Command Queue
-- 
1.9.1

