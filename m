From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V2 2/9] mmc: core: Move mmc bkops functions from core.c to mmc_ops.c
Date: Fri,  9 Jun 2017 14:15:01 +0200
Message-ID: <1497010501-17302-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35205 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbdFIMPH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2017 08:15:07 -0400
Received: by mail-lf0-f50.google.com with SMTP id p189so29055003lfe.2
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jun 2017 05:15:06 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

The mmc_start_bkops(), mmc_stop_bkops() and mmc_read_bkops_status()
functions are all specific to eMMCs. To make this clear, let's move them
from from core.c to mmc_ops.c and take the opportunity to make
mmc_read_bkops_status() static.

While moving them, get rid of MMC_BKOPS_MAX_TIMEOUT (4 min) and use the
common default timeout MMC_OPS_TIMEOUT_MS (10 min) instead, as there is no
need to have specific default timeout for bkops.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Convert mmc_read_bkops_status() to static.

---
 drivers/mmc/core/core.c    | 118 ---------------------------------------------
 drivers/mmc/core/mmc_ops.c | 113 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc_ops.h |   1 -
 3 files changed, 113 insertions(+), 119 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d48be0b..d7c934c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -53,12 +53,6 @@
 /* If the device is not responding */
 #define MMC_CORE_TIMEOUT_MS	(10 * 60 * 1000) /* 10 minute timeout */
 
-/*
- * Background operations can take a long time, depending on the housekeeping
- * operations the card has to perform.
- */
-#define MMC_BKOPS_MAX_TIMEOUT	(4 * 60 * 1000) /* max time to wait in ms */
-
 /* The max erase timeout, used when host->max_busy_timeout isn't specified */
 #define MMC_ERASE_TIMEOUT_MS	(60 * 1000) /* 60 s */
 
@@ -362,73 +356,6 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	return 0;
 }
 
-/**
- *	mmc_start_bkops - start BKOPS for supported cards
- *	@card: MMC card to start BKOPS
- *	@form_exception: A flag to indicate if this function was
- *			 called due to an exception raised by the card
- *
- *	Start background operations whenever requested.
- *	When the urgent BKOPS bit is set in a R1 command response
- *	then background operations should be started immediately.
-*/
-void mmc_start_bkops(struct mmc_card *card, bool from_exception)
-{
-	int err;
-	int timeout;
-	bool use_busy_signal;
-
-	if (!card->ext_csd.man_bkops_en || mmc_card_doing_bkops(card))
-		return;
-
-	err = mmc_read_bkops_status(card);
-	if (err) {
-		pr_err("%s: Failed to read bkops status: %d\n",
-		       mmc_hostname(card->host), err);
-		return;
-	}
-
-	if (!card->ext_csd.raw_bkops_status)
-		return;
-
-	if (card->ext_csd.raw_bkops_status < EXT_CSD_BKOPS_LEVEL_2 &&
-	    from_exception)
-		return;
-
-	mmc_claim_host(card->host);
-	if (card->ext_csd.raw_bkops_status >= EXT_CSD_BKOPS_LEVEL_2) {
-		timeout = MMC_BKOPS_MAX_TIMEOUT;
-		use_busy_signal = true;
-	} else {
-		timeout = 0;
-		use_busy_signal = false;
-	}
-
-	mmc_retune_hold(card->host);
-
-	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-			EXT_CSD_BKOPS_START, 1, timeout, 0,
-			use_busy_signal, true, false);
-	if (err) {
-		pr_warn("%s: Error %d starting bkops\n",
-			mmc_hostname(card->host), err);
-		mmc_retune_release(card->host);
-		goto out;
-	}
-
-	/*
-	 * For urgent bkops status (LEVEL_2 and more)
-	 * bkops executed synchronously, otherwise
-	 * the operation is in progress
-	 */
-	if (!use_busy_signal)
-		mmc_card_set_doing_bkops(card);
-	else
-		mmc_retune_release(card->host);
-out:
-	mmc_release_host(card->host);
-}
-
 /*
  * mmc_wait_data_done() - done callback for data request
  * @mrq: done data request
@@ -841,51 +768,6 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd, int retries
 EXPORT_SYMBOL(mmc_wait_for_cmd);
 
 /**
- *	mmc_stop_bkops - stop ongoing BKOPS
- *	@card: MMC card to check BKOPS
- *
- *	Send HPI command to stop ongoing background operations to
- *	allow rapid servicing of foreground operations, e.g. read/
- *	writes. Wait until the card comes out of the programming state
- *	to avoid errors in servicing read/write requests.
- */
-int mmc_stop_bkops(struct mmc_card *card)
-{
-	int err = 0;
-
-	err = mmc_interrupt_hpi(card);
-
-	/*
-	 * If err is EINVAL, we can't issue an HPI.
-	 * It should complete the BKOPS.
-	 */
-	if (!err || (err == -EINVAL)) {
-		mmc_card_clr_doing_bkops(card);
-		mmc_retune_release(card->host);
-		err = 0;
-	}
-
-	return err;
-}
-
-int mmc_read_bkops_status(struct mmc_card *card)
-{
-	int err;
-	u8 *ext_csd;
-
-	mmc_claim_host(card->host);
-	err = mmc_get_ext_csd(card, &ext_csd);
-	mmc_release_host(card->host);
-	if (err)
-		return err;
-
-	card->ext_csd.raw_bkops_status = ext_csd[EXT_CSD_BKOPS_STATUS];
-	card->ext_csd.raw_exception_status = ext_csd[EXT_CSD_EXP_EVENTS_STATUS];
-	kfree(ext_csd);
-	return 0;
-}
-
-/**
  *	mmc_set_data_timeout - set the timeout for a data command
  *	@data: data phase for command
  *	@card: the MMC card associated with the data transfer
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index ae1fc48..a631f74 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -19,6 +19,7 @@
 #include <linux/mmc/mmc.h>
 
 #include "core.h"
+#include "card.h"
 #include "host.h"
 #include "mmc_ops.h"
 
@@ -845,6 +846,118 @@ int mmc_can_ext_csd(struct mmc_card *card)
 	return (card && card->csd.mmca_vsn > CSD_SPEC_VER_3);
 }
 
+/**
+ *	mmc_stop_bkops - stop ongoing BKOPS
+ *	@card: MMC card to check BKOPS
+ *
+ *	Send HPI command to stop ongoing background operations to
+ *	allow rapid servicing of foreground operations, e.g. read/
+ *	writes. Wait until the card comes out of the programming state
+ *	to avoid errors in servicing read/write requests.
+ */
+int mmc_stop_bkops(struct mmc_card *card)
+{
+	int err = 0;
+
+	err = mmc_interrupt_hpi(card);
+
+	/*
+	 * If err is EINVAL, we can't issue an HPI.
+	 * It should complete the BKOPS.
+	 */
+	if (!err || (err == -EINVAL)) {
+		mmc_card_clr_doing_bkops(card);
+		mmc_retune_release(card->host);
+		err = 0;
+	}
+
+	return err;
+}
+
+static int mmc_read_bkops_status(struct mmc_card *card)
+{
+	int err;
+	u8 *ext_csd;
+
+	mmc_claim_host(card->host);
+	err = mmc_get_ext_csd(card, &ext_csd);
+	mmc_release_host(card->host);
+	if (err)
+		return err;
+
+	card->ext_csd.raw_bkops_status = ext_csd[EXT_CSD_BKOPS_STATUS];
+	card->ext_csd.raw_exception_status = ext_csd[EXT_CSD_EXP_EVENTS_STATUS];
+	kfree(ext_csd);
+	return 0;
+}
+
+/**
+ *	mmc_start_bkops - start BKOPS for supported cards
+ *	@card: MMC card to start BKOPS
+ *	@form_exception: A flag to indicate if this function was
+ *			 called due to an exception raised by the card
+ *
+ *	Start background operations whenever requested.
+ *	When the urgent BKOPS bit is set in a R1 command response
+ *	then background operations should be started immediately.
+*/
+void mmc_start_bkops(struct mmc_card *card, bool from_exception)
+{
+	int err;
+	int timeout;
+	bool use_busy_signal;
+
+	if (!card->ext_csd.man_bkops_en || mmc_card_doing_bkops(card))
+		return;
+
+	err = mmc_read_bkops_status(card);
+	if (err) {
+		pr_err("%s: Failed to read bkops status: %d\n",
+		       mmc_hostname(card->host), err);
+		return;
+	}
+
+	if (!card->ext_csd.raw_bkops_status)
+		return;
+
+	if (card->ext_csd.raw_bkops_status < EXT_CSD_BKOPS_LEVEL_2 &&
+	    from_exception)
+		return;
+
+	mmc_claim_host(card->host);
+	if (card->ext_csd.raw_bkops_status >= EXT_CSD_BKOPS_LEVEL_2) {
+		timeout = MMC_OPS_TIMEOUT_MS;
+		use_busy_signal = true;
+	} else {
+		timeout = 0;
+		use_busy_signal = false;
+	}
+
+	mmc_retune_hold(card->host);
+
+	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+			EXT_CSD_BKOPS_START, 1, timeout, 0,
+			use_busy_signal, true, false);
+	if (err) {
+		pr_warn("%s: Error %d starting bkops\n",
+			mmc_hostname(card->host), err);
+		mmc_retune_release(card->host);
+		goto out;
+	}
+
+	/*
+	 * For urgent bkops status (LEVEL_2 and more)
+	 * bkops executed synchronously, otherwise
+	 * the operation is in progress
+	 */
+	if (!use_busy_signal)
+		mmc_card_set_doing_bkops(card);
+	else
+		mmc_retune_release(card->host);
+out:
+	mmc_release_host(card->host);
+}
+
 static int mmc_cmdq_switch(struct mmc_card *card, bool enable)
 {
 	u8 val = enable ? EXT_CSD_CMDQ_MODE_ENABLED : 0;
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index b8d0552..2e97271 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -43,7 +43,6 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms);
 int mmc_stop_bkops(struct mmc_card *card);
-int mmc_read_bkops_status(struct mmc_card *card);
 void mmc_start_bkops(struct mmc_card *card, bool from_exception);
 int mmc_can_reset(struct mmc_card *card);
 int mmc_flush_cache(struct mmc_card *card);
-- 
2.7.4

