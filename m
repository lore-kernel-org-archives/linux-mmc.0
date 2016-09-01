From: alex lemberg <alex.lemberg@sandisk.com>
Subject: [PATCH 2/3] mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS support
Date: Thu, 1 Sep 2016 17:24:49 +0300
Message-ID: <1472739890-3384-3-git-send-email-alex.lemberg@sandisk.com>
References: <1472739890-3384-1-git-send-email-alex.lemberg@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam01on0052.outbound.protection.outlook.com ([104.47.34.52]:5504
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932583AbcIAOnx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Sep 2016 10:43:53 -0400
In-Reply-To: <1472739890-3384-1-git-send-email-alex.lemberg@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: avi.shchislowski@sandisk.com, alex lemberg <alex.lemberg@sandisk.com>

Signed-off-by: alex lemberg <alex.lemberg@sandisk.com>
---
 drivers/mmc/core/mmc.c   | 6 ++++++
 include/linux/mmc/card.h | 1 +
 include/linux/mmc/mmc.h  | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f2d185c..e2e987f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -531,6 +531,12 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 			if (!card->ext_csd.man_bkops_en)
 				pr_debug("%s: MAN_BKOPS_EN bit is not set\n",
 					mmc_hostname(card->host));
+			card->ext_csd.auto_bkops_en =
+					(ext_csd[EXT_CSD_BKOPS_EN] &
+						EXT_CSD_AUTO_BKOPS_MASK);
+			if (!card->ext_csd.auto_bkops_en)
+				pr_debug("%s: AUTO_BKOPS_EN bit is not set\n",
+					mmc_hostname(card->host));
 		}
 
 		/* check whether the eMMC card supports HPI */
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 73fad83..aaedb68 100644
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
index c376209..0fe3908 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -436,6 +436,7 @@ struct _mmc_csd {
  * BKOPS modes
  */
 #define EXT_CSD_MANUAL_BKOPS_MASK	0x01
+#define EXT_CSD_AUTO_BKOPS_MASK	0x02
 
 /*
  * MMC_SWITCH access modes
-- 
1.9.1

