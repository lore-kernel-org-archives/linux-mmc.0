From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 07/15] mmc: core: Hold re-tuning while bkops ongoing
Date: Thu, 29 Jan 2015 11:00:22 +0200
Message-ID: <1422522030-17793-8-git-send-email-adrian.hunter@intel.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47441 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759191AbbA2JDo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 29 Jan 2015 04:03:44 -0500
In-Reply-To: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Hold re-tuning during bkops to prevent
it from conflicting with the busy state.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 91838ea..392a150 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -311,6 +311,10 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 	} else {
 		timeout = 0;
 		use_busy_signal = false;
+		/* Hold re-tuning for ongoing bkops */
+		err = mmc_retune_and_hold(card->host);
+		if (err)
+			goto out;
 	}
 
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
@@ -319,6 +323,9 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 	if (err) {
 		pr_warn("%s: Error %d starting bkops\n",
 			mmc_hostname(card->host), err);
+		/* bkops not ongoing, so release re-tuning */
+		if (!use_busy_signal)
+			mmc_retune_release(card->host);
 		goto out;
 	}
 
@@ -753,6 +760,7 @@ int mmc_stop_bkops(struct mmc_card *card)
 	 */
 	if (!err || (err == -EINVAL)) {
 		mmc_card_clr_doing_bkops(card);
+		mmc_retune_release(card->host);
 		err = 0;
 	}
 
-- 
1.9.1

