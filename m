From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH] mmc: core: Add host capability check for power class
Date: Wed, 14 Dec 2011 11:49:33 +0530
Message-ID: <1323843573-25394-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, linux-samsung-soc@vger.kernel.org, subhashj@codeaurora.org, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds a check whether the host supports maximum current value
obtained from the device's extended csd register for a selected interface
voltage and frequency.

Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 drivers/mmc/core/mmc.c   |   27 +++++++++++++++++++++++++++
 include/linux/mmc/card.h |    4 ++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 006e932..30d1cbc 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -688,6 +688,33 @@ static int mmc_select_powerclass(struct mmc_card *card,
 		pwrclass_val = (pwrclass_val & EXT_CSD_PWR_CL_4BIT_MASK) >>
 				EXT_CSD_PWR_CL_4BIT_SHIFT;
 
+	if (card->host->caps & MMC_CAP_MAX_CURRENT_800) {
+		if (pwrclass_val >= MMC_MAX_CURRENT_800)
+			pwrclass_val = MMC_MAX_CURRENT_800;
+		else if (pwrclass_val >= MMC_MAX_CURRENT_600)
+			pwrclass_val = MMC_MAX_CURRENT_600;
+		else if (pwrclass_val >= MMC_MAX_CURRENT_400)
+			pwrclass_val = MMC_MAX_CURRENT_400;
+		else if (pwrclass_val >= MMC_MAX_CURRENT_200)
+			pwrclass_val = MMC_MAX_CURRENT_200;
+	} else if (card->host->caps & MMC_CAP_MAX_CURRENT_600) {
+		if (pwrclass_val >= MMC_MAX_CURRENT_600)
+			pwrclass_val = MMC_MAX_CURRENT_600;
+		else if (pwrclass_val >= MMC_MAX_CURRENT_400)
+			pwrclass_val = MMC_MAX_CURRENT_400;
+		else if (pwrclass_val >= MMC_MAX_CURRENT_200)
+			pwrclass_val = MMC_MAX_CURRENT_200;
+	} else if (card->host->caps & MMC_CAP_MAX_CURRENT_400) {
+		if (pwrclass_val >= MMC_MAX_CURRENT_400)
+			pwrclass_val = MMC_MAX_CURRENT_400;
+		else if (pwrclass_val >= MMC_MAX_CURRENT_200)
+			pwrclass_val = MMC_MAX_CURRENT_200;
+	} else if (card->host->caps & MMC_CAP_MAX_CURRENT_200) {
+		if (pwrclass_val >= MMC_MAX_CURRENT_200)
+			pwrclass_val = MMC_MAX_CURRENT_200;
+	} else
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
