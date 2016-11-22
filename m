From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 6/7] mmc: core: Allow CMD13 polling when switching to HS mode for mmc
Date: Tue, 22 Nov 2016 21:56:12 +0100
Message-ID: <1479848173-20881-7-git-send-email-ulf.hansson@linaro.org>
References: <1479848173-20881-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38364 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756829AbcKVU4y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2016 15:56:54 -0500
Received: by mail-wm0-f48.google.com with SMTP id f82so46548484wmf.1
        for <linux-mmc@vger.kernel.org>; Tue, 22 Nov 2016 12:56:31 -0800 (PST)
In-Reply-To: <1479848173-20881-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

In cases when the mmc host doesn't support HW busy detection, polling for a
card being busy by using CMD13 is beneficial. That is because, instead of
waiting a fixed amount of time, 500ms or the generic CMD6 time from
EXT_CSD, we find out a lot sooner when the card stops signaling busy. This
leads to a significant decreased total initialization time for the mmc
card.

However, to allow polling with CMD13 during a bus timing change operation,
such as switching to HS mode, we first need to update the mmc host's bus
timing before starting to poll. Deal with that, simply by providing
MMC_TIMING_MMC_HS as the timing parameter to __mmc_switch() from
mmc_select_hs().

By telling __mmc_switch() to allow polling with CMD13, also makes it
validate the CMD6 status, thus we can remove the corresponding checks.

When switching to HS400ES, the mmc_select_hs() function is called in one of
the intermediate steps. To still prevent CMD13 polling for HS400ES, let's
call the __mmc_switch() function in this path as it enables us to keep
using the existing method.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index cb1cf4e..15dd51c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1012,13 +1012,8 @@ static int mmc_select_hs(struct mmc_card *card)
 
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
-			   card->ext_csd.generic_cmd6_time, 0,
-			   true, false, true);
-	if (!err) {
-		mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
-		err = mmc_switch_status(card);
-	}
-
+			   card->ext_csd.generic_cmd6_time, MMC_TIMING_MMC_HS,
+			   true, true, true);
 	if (err)
 		pr_warn("%s: switch to high-speed failed, err:%d\n",
 			mmc_hostname(card->host), err);
@@ -1268,16 +1263,23 @@ static int mmc_select_hs400es(struct mmc_card *card)
 		goto out_err;
 
 	/* Switch card to HS mode */
-	err = mmc_select_hs(card);
-	if (err)
+	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
+			   card->ext_csd.generic_cmd6_time, 0,
+			   true, false, true);
+	if (err) {
+		pr_err("%s: switch to hs for hs400es failed, err:%d\n",
+			mmc_hostname(host), err);
 		goto out_err;
+	}
 
-	mmc_set_clock(host, card->ext_csd.hs_max_dtr);
-
+	mmc_set_timing(host, MMC_TIMING_MMC_HS);
 	err = mmc_switch_status(card);
 	if (err)
 		goto out_err;
 
+	mmc_set_clock(host, card->ext_csd.hs_max_dtr);
+
 	/* Switch card to DDR with strobe bit */
 	val = EXT_CSD_DDR_BUS_WIDTH_8 | EXT_CSD_BUS_WIDTH_STROBE;
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-- 
1.9.1

