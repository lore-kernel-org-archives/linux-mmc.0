From: Uri Yanai <uri.yanai@sandisk.com>
Subject: [v3 2/3] mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS support
Date: Tue, 7 Feb 2017 18:00:01 +0200
Message-ID: <1486483202-5515-3-git-send-email-uri.yanai@sandisk.com>
References: <1486483202-5515-1-git-send-email-uri.yanai@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:17551 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755195AbdBGQDb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2017 11:03:31 -0500
In-Reply-To: <1486483202-5515-1-git-send-email-uri.yanai@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Alex.Lemberg@sandisk.com, Uri Yanai <uri.yanai@sandisk.com>, Alex Lemberg <alex.lemberg@sandisk.com>

Adding dedicated flag for AUTO_BKOPS in card->ext_csd structure.
Read AUTO_BKOPS bit value from the device EXT_CSD and set to the
card->ext_csd structure.
In mmc_decode_ext_csd() add a print message in case the AUTO_BKOPS
is enabled

Signed-off-by: Uri Yanai <uri.yanai@sandisk.com>
Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
---

Changes in v3:
- move the code inversing manual bkops to a separate patch

Changes in v2:
- inverse the logic for printing the debug message.
  only print when bits are set.

---
 drivers/mmc/core/mmc.c   | 6 ++++++
 include/linux/mmc/card.h | 1 +
 include/linux/mmc/mmc.h  | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 9d1c149..f70f6a1 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -533,6 +533,12 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 			if (card->ext_csd.man_bkops_en)
 				pr_debug("%s: MAN_BKOPS_EN bit is set\n",
 					mmc_hostname(card->host));
+			card->ext_csd.auto_bkops_en =
+					(ext_csd[EXT_CSD_BKOPS_EN] &
+						EXT_CSD_AUTO_BKOPS_MASK);
+			if (card->ext_csd.auto_bkops_en)
+				pr_debug("%s: AUTO_BKOPS_EN bit is set\n",
+					mmc_hostname(card->host));
 		}
 
 		/* check whether the eMMC card supports HPI */
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

