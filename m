From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 7/9] mmc: core: Allow CMD13 polling when switch to HS200
 mode
Date: Thu, 17 Nov 2016 12:23:33 +0200
Message-ID: <e003f72a-6084-eb1a-6b44-c6a11d93b3ae@intel.com>
References: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
 <1479293481-20186-8-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:13141 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbcKQK2f (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 17 Nov 2016 05:28:35 -0500
In-Reply-To: <1479293481-20186-8-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

On 16/11/16 12:51, Ulf Hansson wrote:
> In cases when the mmc host doesn't support HW busy detection, polling for
> busy by using CMD13 is beneficial. The reasons have already been explained
> in earlier change logs.
> 
> To allow polling with CMD13, let's provide MMC_TIMING_MMC_HS200 as the
> timing parameter to __mmc_switch(), which makes sure the mmc host and the
> mmc card operates at the same bus timing during the polling.

I have reports of cases where CMD13 always gives CRC errors after switch
to HS200.  Currently we are assuming the low frequency should mean that
won't happen, but it does in some cases.  That is not entirely surprising
since HS200 needs tuning at the final operating frequency.

What I would like to do for hosts that support busy waiting or DAT0 polling
(i.e. MMC_CAP_WAIT_WHILE_BUSY or host->ops->card_busy), is to ignore CRC
errors from the CMD13 that checks the switch status.  The main reason for
doing that is that we really expect the switch to succeed and, given HS200
tuning requirement, the CRC error is not a reliable means of determining
that it hasn't.

With the existing code I would just change the err check:


diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3268fcd3378d..c8862c58b60b 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1387,6 +1387,13 @@ static int mmc_select_hs200(struct mmc_card *card)
 
 		err = mmc_switch_status(card);
 		/*
+		 * For HS200, CRC errors are not a reliable way to know the
+		 * switch failed. If there really is a problem, we would expect
+		 * tuning will fail and the result ends up the same.
+		 */
+		if (err == -EILSEQ)
+			err = 0;
+		/*
 		 * mmc_select_timing() assumes timing has not changed if
 		 * it is a switch error.
 		 */


Then to support polling:


diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c8862c58b60b..66d8d57ae2fb 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1352,6 +1352,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
 	unsigned int old_timing, old_signal_voltage;
+	bool send_status;
 	int err = -EINVAL;
 	u8 val;
 
@@ -1373,18 +1374,20 @@ static int mmc_select_hs200(struct mmc_card *card)
 	 * switch to HS200 mode if bus width is set successfully.
 	 */
 	err = mmc_select_bus_width(card);
-	if (err > 0) {
-		val = EXT_CSD_TIMING_HS200 |
-		      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
-		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				   EXT_CSD_HS_TIMING, val,
-				   card->ext_csd.generic_cmd6_time, 0,
-				   true, false, true);
-		if (err)
-			goto err;
-		old_timing = host->ios.timing;
-		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
+	if (err <= 0)
+		goto err;
+
+	send_status = !(host->caps & MMC_CAP_WAIT_WHILE_BUSY) &&
+		      !host->ops->card_busy;
+	old_timing = host->ios.timing;
+
+	val = EXT_CSD_TIMING_HS200 |
+	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
+	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING, val,
+			   card->ext_csd.generic_cmd6_time,
+			   MMC_TIMING_MMC_HS200, true, send_status, true);
 
+	if (!err && !send_status) {
 		err = mmc_switch_status(card);
 		/*
 		 * For HS200, CRC errors are not a reliable way to know the



Thoughts?

