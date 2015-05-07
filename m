From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V7 06/14] mmc: core: Hold re-tuning while bkops ongoing
Date: Thu,  7 May 2015 13:10:17 +0300
Message-ID: <1430993425-2777-7-git-send-email-adrian.hunter@intel.com>
References: <1430993425-2777-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29829 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbbEGKMy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 7 May 2015 06:12:54 -0400
In-Reply-To: <1430993425-2777-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Hold re-tuning during bkops to prevent
it from conflicting with the busy state.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ff1e384..adb6408 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -318,12 +318,15 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 		use_busy_signal = false;
 	}
 
+	mmc_retune_hold(card->host);
+
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			EXT_CSD_BKOPS_START, 1, timeout,
 			use_busy_signal, true, false);
 	if (err) {
 		pr_warn("%s: Error %d starting bkops\n",
 			mmc_hostname(card->host), err);
+		mmc_retune_release(card->host);
 		goto out;
 	}
 
@@ -334,6 +337,8 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 	 */
 	if (!use_busy_signal)
 		mmc_card_set_doing_bkops(card);
+	else
+		mmc_retune_release(card->host);
 out:
 	mmc_release_host(card->host);
 }
@@ -749,6 +754,7 @@ int mmc_stop_bkops(struct mmc_card *card)
 	 */
 	if (!err || (err == -EINVAL)) {
 		mmc_card_clr_doing_bkops(card);
+		mmc_retune_release(card->host);
 		err = 0;
 	}
 
-- 
1.9.1

