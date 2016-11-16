From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 7/9] mmc: core: Allow CMD13 polling when switch to HS200 mode
Date: Wed, 16 Nov 2016 11:51:19 +0100
Message-ID: <1479293481-20186-8-git-send-email-ulf.hansson@linaro.org>
References: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38487 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938542AbcKPKvq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2016 05:51:46 -0500
Received: by mail-wm0-f54.google.com with SMTP id f82so64237590wmf.1
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2016 02:51:45 -0800 (PST)
In-Reply-To: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

In cases when the mmc host doesn't support HW busy detection, polling for
busy by using CMD13 is beneficial. The reasons have already been explained
in earlier change logs.

To allow polling with CMD13, let's provide MMC_TIMING_MMC_HS200 as the
timing parameter to __mmc_switch(), which makes sure the mmc host and the
mmc card operates at the same bus timing during the polling.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3268fcd..0b26383 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1351,7 +1351,7 @@ static void mmc_select_driver_type(struct mmc_card *card)
 static int mmc_select_hs200(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
-	unsigned int old_timing, old_signal_voltage;
+	unsigned int old_signal_voltage;
 	int err = -EINVAL;
 	u8 val;
 
@@ -1378,22 +1378,11 @@ static int mmc_select_hs200(struct mmc_card *card)
 		      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				   EXT_CSD_HS_TIMING, val,
-				   card->ext_csd.generic_cmd6_time, 0,
-				   true, false, true);
-		if (err)
-			goto err;
-		old_timing = host->ios.timing;
-		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
-
-		err = mmc_switch_status(card);
-		/*
-		 * mmc_select_timing() assumes timing has not changed if
-		 * it is a switch error.
-		 */
-		if (err == -EBADMSG)
-			mmc_set_timing(host, old_timing);
+				   card->ext_csd.generic_cmd6_time,
+				   MMC_TIMING_MMC_HS200,
+				   true, true, true);
 	}
-err:
+
 	if (err) {
 		/* fall back to the old signal voltage, if fails report error */
 		if (__mmc_set_signal_voltage(host, old_signal_voltage))
-- 
1.9.1

