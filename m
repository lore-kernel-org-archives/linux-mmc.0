From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V4 07/15] mmc: core: Hold re-tuning while bkops ongoing
Date: Fri, 27 Mar 2015 22:57:35 +0200
Message-ID: <1427489863-9050-8-git-send-email-adrian.hunter@intel.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24700 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345AbbC0VAB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Mar 2015 17:00:01 -0400
In-Reply-To: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
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
index d4e3248..f8ae793 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -316,6 +316,8 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 	} else {
 		timeout = 0;
 		use_busy_signal = false;
+		/* Hold re-tuning for ongoing bkops */
+		mmc_retune_hold(card->host);
 	}
 
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
@@ -324,6 +326,9 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 	if (err) {
 		pr_warn("%s: Error %d starting bkops\n",
 			mmc_hostname(card->host), err);
+		/* bkops not ongoing, so release re-tuning */
+		if (!use_busy_signal)
+			mmc_retune_release(card->host);
 		goto out;
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

