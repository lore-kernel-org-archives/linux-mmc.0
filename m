From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC RESEND PATCH 1/2]  mmc: sdio: Factor out retry init card helper function
Date: Wed, 14 Dec 2016 12:17:17 +0800
Message-ID: <1481689038-128781-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:35109 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754722AbcLNESE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2016 23:18:04 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Add new helper function, mmc_sdio_retry_init_card, to be
reused when trying to retry the init sequence.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/sdio.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index ecbc529..47f824b 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -541,6 +541,18 @@ static int mmc_sdio_init_uhs_card(struct mmc_card *card)
 	return err;
 }
 
+static void mmc_sdio_retry_init_card(struct mmc_host *host,
+				     struct mmc_card *card,
+				     int *retries)
+{
+	sdio_reset(host);
+	mmc_go_idle(host);
+	mmc_send_if_cond(host, host->ocr_avail);
+	mmc_remove_card(card);
+	(*retries)--;
+
+}
+
 /*
  * Handle the detection and initialisation of a card.
  *
@@ -630,11 +642,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
 					ocr_card);
 		if (err == -EAGAIN) {
-			sdio_reset(host);
-			mmc_go_idle(host);
-			mmc_send_if_cond(host, host->ocr_avail);
-			mmc_remove_card(card);
-			retries--;
+			mmc_sdio_retry_init_card(host, card, &retries);
 			goto try_again;
 		} else if (err) {
 			ocr &= ~R4_18V_PRESENT;
-- 
1.9.1


