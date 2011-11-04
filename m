From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH] mmc: core: Fix setting power notify state variable for non eMMC
Date: Fri,  4 Nov 2011 16:22:47 +0530
Message-ID: <1320403967-2940-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45857 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938Ab1KDKxE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2011 06:53:04 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>

This patch skips the setting of the power notify state variable
for non eMMC 4.5 devices. Also fixes the problem of omap_hsmmc
noisy/broken for suspend resume reported by kevin Hilman.

cc: Chris Ball <cjb@laptop.org>
Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 drivers/mmc/core/mmc.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3627044..4db73a9 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -882,10 +882,14 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 				 card->ext_csd.generic_cmd6_time);
 		if (err && err != -EBADMSG)
 			goto free_card;
-	}
 
-	if (!err)
-		card->poweroff_notify_state = MMC_POWERED_ON;
+		/*
+		 * The err can be -EBADMSG or 0,
+		 * so check for success and update the flag
+		 */
+		if (!err)
+			card->poweroff_notify_state = MMC_POWERED_ON;
+	}
 
 	/*
 	 * Activate high speed (if supported)
-- 
1.7.4.1

