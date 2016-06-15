From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH RFC 01/10] mmc: core: Add support to read command queue parameters
Date: Wed, 15 Jun 2016 18:31:05 +0530
Message-ID: <1465995674-15816-2-git-send-email-riteshh@codeaurora.org>
References: <1465995674-15816-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43596 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932718AbcFONCM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2016 09:02:12 -0400
In-Reply-To: <1465995674-15816-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: adrian.hunter@intel.com, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, jh80.chung@samsung.com, dongas86@gmail.com, asutoshd@codeaurora.org, zhangfei.gao@gmail.com, sthumma@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Subhash Jadavani <subhashj@codeaurora.org>

From: Asutosh Das <asutoshd@codeaurora.org>

eMMC cards with EXT_CSD version >= 7, optionally support command
queuing feature as defined by JEDEC eMMC5.1. Add support for probing
command queue feature for such type of cards.

Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
[subhashj@codeaurora.org: fixed trivial merge conflicts]
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
---
 drivers/mmc/core/mmc.c   | 18 ++++++++++++++++++
 include/linux/mmc/card.h |  2 ++
 include/linux/mmc/mmc.h  |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4dbe3df..ff560e9 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -578,6 +578,24 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		card->ext_csd.data_sector_size = 512;
 	}
 
+	if (card->ext_csd.rev >= 7) {
+		card->ext_csd.cmdq_support = ext_csd[EXT_CSD_CMDQ_SUPPORT];
+		if (card->ext_csd.cmdq_support) {
+			/*
+			 * Queue Depth = N + 1,
+			 * see JEDEC JESD84-B51 section 7.4.19
+			 */
+			card->ext_csd.cmdq_depth =
+				ext_csd[EXT_CSD_CMDQ_DEPTH] + 1;
+			pr_info("%s: CMDQ supported: depth: %d\n",
+				mmc_hostname(card->host),
+				card->ext_csd.cmdq_depth);
+		}
+	} else {
+		card->ext_csd.cmdq_support = 0;
+		card->ext_csd.cmdq_depth = 0;
+	}
+
 	/* eMMC v5 or later */
 	if (card->ext_csd.rev >= 7) {
 		memcpy(card->ext_csd.fwrev, &ext_csd[EXT_CSD_FIRMWARE_VERSION],
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index eb0151b..f74db84 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -118,6 +118,8 @@ struct mmc_ext_csd {
 	u8			raw_pwr_cl_ddr_200_360;	/* 253 */
 	u8			raw_bkops_status;	/* 246 */
 	u8			raw_sectors[4];		/* 212 - 4 bytes */
+	u8			cmdq_depth;		/* 307 */
+	u8			cmdq_support;		/* 308 */
 
 	unsigned int            feature_support;
 #define MMC_DISCARD_FEATURE	BIT(0)                  /* CMD38 feature */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 15f2c4a..1c0ae75 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -330,6 +330,9 @@ struct _mmc_csd {
 #define EXT_CSD_CACHE_SIZE		249	/* RO, 4 bytes */
 #define EXT_CSD_PWR_CL_DDR_200_360	253	/* RO */
 #define EXT_CSD_FIRMWARE_VERSION	254	/* RO, 8 bytes */
+#define EXT_CSD_CMDQ_DEPTH		307	/* RO */
+#define EXT_CSD_CMDQ_SUPPORT		308	/* RO */
+ #define EXT_CSD_TAG_UNIT_SIZE		498	/* RO */
 #define EXT_CSD_SUPPORTED_MODE		493	/* RO */
 #define EXT_CSD_TAG_UNIT_SIZE		498	/* RO */
 #define EXT_CSD_DATA_TAG_SUPPORT	499	/* RO */
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

