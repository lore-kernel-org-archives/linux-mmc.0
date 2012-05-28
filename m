From: philipspatches@gmail.com
Subject: [PATCH 2/3] mmc: sdhci only set 200ma support for 1.8v if 200ma is available
Date: Sun, 27 May 2012 18:36:33 -0700
Message-ID: <1338168993-2087-1-git-send-email-prakity@marvell.com>
References: <prakity@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36271 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546Ab2E1Bgi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 27 May 2012 21:36:38 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so3998039pbb.19
        for <linux-mmc@vger.kernel.org>; Sun, 27 May 2012 18:36:38 -0700 (PDT)
In-Reply-To: <prakity@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Philip Rakity <prakity@marvell.com>

From: Philip Rakity <prakity@marvell.com>

max_current_caps can return 0 if not available from the sd controller.
if no regulator is present or the regulator specifies a current
less then 200ma we will set the 200ma caps bit by default.

do not do this.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Reviewed-by: Aaron Lu <aaron_lu@amd.com>
---
 drivers/mmc/core/sd.c    |   23 ++++++++++++-----------
 drivers/mmc/host/sdhci.c |    2 +-
 include/linux/mmc/card.h |    1 +
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index c272c68..c6fc3e8 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -553,13 +553,13 @@ static int sd_set_bus_speed_mode(struct mmc_card *card, u8 *status)
 
 static int sd_set_current_limit(struct mmc_card *card, u8 *status)
 {
-	int current_limit = 0;
+	int current_limit = SD_SET_CURRENT_NO_CHANGE;
 	int err;
 
 	/*
 	 * Current limit switch is only defined for SDR50, SDR104, and DDR50
-	 * bus speed modes. For other bus speed modes, we set the default
-	 * current limit of 200mA.
+	 * bus speed modes. For other bus speed modes, we do not change the
+	 * current limit.
 	 */
 	if ((card->sd_bus_speed == UHS_SDR50_BUS_SPEED) ||
 	    (card->sd_bus_speed == UHS_SDR104_BUS_SPEED) ||
@@ -595,17 +595,18 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
 			if (card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_200)
 				current_limit = SD_SET_CURRENT_LIMIT_200;
 		}
-	} else
-		current_limit = SD_SET_CURRENT_LIMIT_200;
+	}
 
-	err = mmc_sd_switch(card, 1, 3, current_limit, status);
-	if (err)
-		return err;
+	if (current_limit != SD_SET_CURRENT_NO_CHANGE) {
+		err = mmc_sd_switch(card, 1, 3, current_limit, status);
+		if (err)
+			return err;
 
-	if (((status[15] >> 4) & 0x0F) != current_limit)
-		pr_warning("%s: Problem setting current limit!\n",
-			mmc_hostname(card->host));
+		if (((status[15] >> 4) & 0x0F) != current_limit)
+			pr_warning("%s: Problem setting current limit!\n",
+				mmc_hostname(card->host));
 
+	}
 	return 0;
 }
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 22347d4..8d8dff0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2914,7 +2914,7 @@ int sdhci_add_host(struct sdhci_host *host)
 			mmc->caps |= MMC_CAP_MAX_CURRENT_600;
 		else if (max_current_180 >= 400)
 			mmc->caps |= MMC_CAP_MAX_CURRENT_400;
-		else
+		else if (max_current_180 >= 200)
 			mmc->caps |= MMC_CAP_MAX_CURRENT_200;
 	}
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 629b823..a999771 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -145,6 +145,7 @@ struct sd_switch_caps {
 #define SD_SET_CURRENT_LIMIT_400	1
 #define SD_SET_CURRENT_LIMIT_600	2
 #define SD_SET_CURRENT_LIMIT_800	3
+#define SD_SET_CURRENT_NO_CHANGE	(-1)
 
 #define SD_MAX_CURRENT_200	(1 << SD_SET_CURRENT_LIMIT_200)
 #define SD_MAX_CURRENT_400	(1 << SD_SET_CURRENT_LIMIT_400)
-- 
1.7.0.4

