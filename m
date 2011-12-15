From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH V2] mmc: core: Add host capability check for power class
Date: Thu, 15 Dec 2011 09:28:37 +0530
Message-ID: <1323921517-31241-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37883 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889Ab1LODyt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Dec 2011 22:54:49 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, linux-samsung-soc@vger.kernel.org, subhashj@codeaurora.org, Girish K S <girish.shivananjappa@linaro.org>, Chris Ball <cjb@laptop.org>

This patch adds a check whether the host supports maximum current value
obtained from the device's extended csd register for a selected interface
voltage and frequency.

cc: Chris Ball <cjb@laptop.org>
Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
Changes in v2:
	deleted a unnecessary if else condition identified by subhash J
Changes in v1:
       reduced the number of comparisons as per Hein's suggestion

 drivers/mmc/core/mmc.c   |   19 +++++++++++++++++++
 include/linux/mmc/card.h |    4 ++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 006e932..b9ef777 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -688,6 +688,25 @@ static int mmc_select_powerclass(struct mmc_card *card,
 		pwrclass_val = (pwrclass_val & EXT_CSD_PWR_CL_4BIT_MASK) >>
 				EXT_CSD_PWR_CL_4BIT_SHIFT;
 
+	if (pwrclass_val >= MMC_MAX_CURRENT_800)
+		pwrclass_val = MMC_MAX_CURRENT_800;
+	else if (pwrclass_val >= MMC_MAX_CURRENT_600)
+		pwrclass_val = MMC_MAX_CURRENT_600;
+	else if (pwrclass_val >= MMC_MAX_CURRENT_400)
+		pwrclass_val = MMC_MAX_CURRENT_400;
+	else
+		pwrclass_val = MMC_MAX_CURRENT_200;
+
+	if ((pwrclass_val == MMC_MAX_CURRENT_800) &&
+	    !(card->host->caps & MMC_CAP_MAX_CURRENT_800))
+		pwrclass_val = MMC_MAX_CURRENT_600;
+	if ((pwrclass_val == MMC_MAX_CURRENT_600) &&
+	    !(card->host->caps & MMC_CAP_MAX_CURRENT_600))
+		pwrclass_val = MMC_MAX_CURRENT_400;
+	if ((pwrclass_val == MMC_MAX_CURRENT_400) &&
+	    !(card->host->caps & MMC_CAP_MAX_CURRENT_400))
+		pwrclass_val = MMC_MAX_CURRENT_200;
+
 	/* If the power class is different from the default value */
 	if (pwrclass_val > 0) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 9478a6b..c5e031a 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -195,6 +195,10 @@ struct mmc_part {
 #define MMC_BLK_DATA_AREA_GP	(1<<2)
 };
 
+#define MMC_MAX_CURRENT_200	(0)
+#define MMC_MAX_CURRENT_400	(7)
+#define MMC_MAX_CURRENT_600	(11)
+#define MMC_MAX_CURRENT_800	(13)
 /*
  * MMC device
  */
-- 
1.7.1

