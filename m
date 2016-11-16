From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 9/9] mmc: core: Allow CMD13 polling when switch to HS400ES mode
Date: Wed, 16 Nov 2016 11:51:21 +0100
Message-ID: <1479293481-20186-10-git-send-email-ulf.hansson@linaro.org>
References: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37032 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934463AbcKPKvt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2016 05:51:49 -0500
Received: by mail-wm0-f48.google.com with SMTP id t79so63898401wmt.0
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2016 02:51:48 -0800 (PST)
In-Reply-To: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

In cases when the mmc host doesn't support HW busy detection, polling for
busy by using CMD13 is beneficial. The reasons have already been explained
in earlier change logs.

Moreover, when polling with CMD13 during bus timing changes, we should
retry instead of fail when we get CRC errors.

Switching to HS400ES includes several steps, where each step changes the
bus speed timing. Let's improve the behaviour during these sequences, by
allowing CMD13 polling for each of the step. Let's also make sure the CMD13
polling becomes retried, while receiving a CRC error.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 24b9e72..b6f0035 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1227,31 +1227,24 @@ static int mmc_select_hs400es(struct mmc_card *card)
 		goto out_err;
 
 	/* Switch card to HS mode */
-	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
-			   card->ext_csd.generic_cmd6_time, 0,
-			   true, false, true);
+	err = mmc_select_hs(card);
 	if (err) {
 		pr_err("%s: switch to hs for hs400es failed, err:%d\n",
 			mmc_hostname(host), err);
 		goto out_err;
 	}
 
-	mmc_set_timing(host, MMC_TIMING_MMC_HS);
-	err = mmc_switch_status(card);
-	if (err)
-		goto out_err;
-
 	mmc_set_clock(host, card->ext_csd.hs_max_dtr);
 
-	/* Switch card to DDR with strobe bit */
+	/* Switch card to HS DDR with strobe bit */
 	val = EXT_CSD_DDR_BUS_WIDTH_8 | EXT_CSD_BUS_WIDTH_STROBE;
-	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			 EXT_CSD_BUS_WIDTH,
-			 val,
-			 card->ext_csd.generic_cmd6_time);
+	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			   EXT_CSD_BUS_WIDTH, val,
+			   card->ext_csd.generic_cmd6_time,
+			   MMC_TIMING_MMC_DDR52,
+			   true, true, true);
 	if (err) {
-		pr_err("%s: switch to bus width for hs400es failed, err:%d\n",
+		pr_err("%s: switch to hs ddr for hs400es failed, err:%d\n",
 			mmc_hostname(host), err);
 		goto out_err;
 	}
@@ -1261,26 +1254,20 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
-			   card->ext_csd.generic_cmd6_time, 0,
-			   true, false, true);
+			   card->ext_csd.generic_cmd6_time,
+			   MMC_TIMING_MMC_HS400,
+			   true, true, true);
 	if (err) {
 		pr_err("%s: switch to hs400es failed, err:%d\n",
 			mmc_hostname(host), err);
 		goto out_err;
 	}
 
-	/* Set host controller to HS400 timing and frequency */
-	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
-
 	/* Controller enable enhanced strobe function */
 	host->ios.enhanced_strobe = true;
 	if (host->ops->hs400_enhanced_strobe)
 		host->ops->hs400_enhanced_strobe(host, &host->ios);
 
-	err = mmc_switch_status(card);
-	if (err)
-		goto out_err;
-
 	return 0;
 
 out_err:
-- 
1.9.1

