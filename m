From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 10/15] mmc: core: Add support for HS400 re-tuning
Date: Thu, 29 Jan 2015 11:00:25 +0200
Message-ID: <1422522030-17793-11-git-send-email-adrian.hunter@intel.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:43633 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758539AbbA2JCv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 29 Jan 2015 04:02:51 -0500
In-Reply-To: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

HS400 re-tuning must be done in HS200 mode. Add
the ability to switch from HS400 mode to HS200
mode before re-tuning and switch back to HS400
after re-tuning.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.h |  2 ++
 drivers/mmc/core/host.c | 17 ++++++++++
 drivers/mmc/core/mmc.c  | 86 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)

diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index cfba3c0..e6f2de7 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -88,6 +88,8 @@ void mmc_remove_card_debugfs(struct mmc_card *card);
 void mmc_init_context_info(struct mmc_host *host);
 
 int mmc_execute_tuning(struct mmc_card *card);
+int mmc_hs200_to_hs400(struct mmc_card *card);
+int mmc_hs400_to_hs200(struct mmc_card *card);
 
 #endif
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 221d46d..20354a5 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -322,6 +322,7 @@ void mmc_retune_timer_stop(struct mmc_host *host)
 
 int mmc_retune(struct mmc_host *host)
 {
+	bool return_to_hs400 = false;
 	int err;
 
 	if (!host->need_retune || host->doing_retune || host->hold_retune ||
@@ -332,8 +333,24 @@ int mmc_retune(struct mmc_host *host)
 
 	host->doing_retune = 1;
 
+	if (host->ios.timing == MMC_TIMING_MMC_HS400) {
+		err = mmc_hs400_to_hs200(host->card);
+		if (err)
+			goto out;
+
+		return_to_hs400 = true;
+
+		if (host->ops->prepare_hs400_tuning)
+			host->ops->prepare_hs400_tuning(host, &host->ios);
+	}
+
 	err = mmc_execute_tuning(host->card);
+	if (err)
+		goto out;
 
+	if (return_to_hs400)
+		err = mmc_hs200_to_hs400(host->card);
+out:
 	host->doing_retune = 0;
 
 	return err;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index d4156e9..e35701a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1081,6 +1081,92 @@ static int mmc_select_hs400(struct mmc_card *card)
 	return 0;
 }
 
+int mmc_hs200_to_hs400(struct mmc_card *card)
+{
+	return mmc_select_hs400(card);
+}
+
+/* Caller must hold re-tuning */
+static int mmc_switch_status(struct mmc_card *card)
+{
+	u32 status;
+	int err;
+
+	err = mmc_send_status(card, &status);
+	if (err)
+		return err;
+
+	return mmc_switch_status_error(card->host, status);
+}
+
+int mmc_hs400_to_hs200(struct mmc_card *card)
+{
+	struct mmc_host *host = card->host;
+	bool send_status = true;
+	unsigned int max_dtr;
+	int err;
+
+	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
+		send_status = false;
+
+	/* Reduce frequency to HS */
+	max_dtr = card->ext_csd.hs_max_dtr;
+	mmc_set_clock(host, max_dtr);
+
+	/* Switch HS400 to HS DDR */
+	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
+			   EXT_CSD_TIMING_HS, card->ext_csd.generic_cmd6_time,
+			   true, send_status, true);
+	if (err)
+		goto out_err;
+
+	mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
+
+	if (!send_status) {
+		err = mmc_switch_status(card);
+		if (err)
+			goto out_err;
+	}
+
+	/* Switch HS DDR to HS */
+	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BUS_WIDTH,
+			   EXT_CSD_BUS_WIDTH_8, card->ext_csd.generic_cmd6_time,
+			   true, send_status, true);
+	if (err)
+		goto out_err;
+
+	mmc_set_timing(host, MMC_TIMING_MMC_HS);
+
+	if (!send_status) {
+		err = mmc_switch_status(card);
+		if (err)
+			goto out_err;
+	}
+
+	/* Switch HS to HS200 */
+	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
+			   EXT_CSD_TIMING_HS200,
+			   card->ext_csd.generic_cmd6_time, true, send_status,
+			   true);
+	if (err)
+		goto out_err;
+
+	mmc_set_timing(host, MMC_TIMING_MMC_HS200);
+
+	if (!send_status) {
+		err = mmc_switch_status(card);
+		if (err)
+			goto out_err;
+	}
+
+	return 0;
+
+out_err:
+	pr_err("%s: %s failed, error %d\n", mmc_hostname(card->host),
+	       __func__, err);
+	return err;
+}
+
 /*
  * For device supporting HS200 mode, the following sequence
  * should be done before executing the tuning process.
-- 
1.9.1

