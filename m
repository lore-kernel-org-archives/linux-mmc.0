From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: Restore parts of the polling policy when switch to HS/HS DDR
Date: Fri, 13 Jan 2017 12:05:03 +0100
Message-ID: <1484305503-30723-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33163 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbdAMLFf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2017 06:05:35 -0500
Received: by mail-lf0-f45.google.com with SMTP id k86so34379843lfi.0
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2017 03:05:35 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>, Clemens Gruber <clemens.gruber@pqgruber.com>, Gary Bisson <gary.bisson@boundarydevices.com>, Dong Aisheng <dongas86@gmail.com>, Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>, Haibo Chen <haibo.chen@nxp.com>

Regressions for not being able to detect an eMMC HS DDR mode card has been
reported for the sdhci-esdhc-imx driver, but potentially other sdhci
variants may suffer from the similar problem.

The commit e173f8911f09 ("mmc: core: Update CMD13 polling policy when
switch to HS DDR mode"), is causing the problem. It seems that change moved
one step to far, regarding changing the host's timing before polling for a
busy card.

To fix this, let's move back to the behaviour when the host's timing is
updated after the polling, but before the switch status is fetched and
validated.

In cases when polling with CMD13, we keep validating the switch status at
each attempt. However, to align with the other card busy detections
mechanism, let's fetch and validate the switch status also after the host's
timing is updated.

Reported-by: Clemens Gruber <clemens.gruber@pqgruber.com>
Reported-by: Gary Bisson <gary.bisson@boundarydevices.com>
Fixes: e173f8911f09 ("mmc: core: Update CMD13 polling policy when switch..")
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index db2969f..fe80f26 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -506,9 +506,6 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 		}
 	} while (busy);
 
-	if (host->ops->card_busy && send_status)
-		return mmc_switch_status(card);
-
 	return 0;
 }
 
@@ -577,24 +574,26 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	if (!use_busy_signal)
 		goto out;
 
-	/* Switch to new timing before poll and check switch status. */
-	if (timing)
-		mmc_set_timing(host, timing);
-
 	/*If SPI or used HW busy detection above, then we don't need to poll. */
 	if (((host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp) ||
-		mmc_host_is_spi(host)) {
-		if (send_status)
-			err = mmc_switch_status(card);
+		mmc_host_is_spi(host))
 		goto out_tim;
-	}
 
 	/* Let's try to poll to find out when the command is completed. */
 	err = mmc_poll_for_busy(card, timeout_ms, send_status, retry_crc_err);
+	if (err)
+		goto out;
 
 out_tim:
-	if (err && timing)
-		mmc_set_timing(host, old_timing);
+	/* Switch to new timing before check switch status. */
+	if (timing)
+		mmc_set_timing(host, timing);
+
+	if (send_status) {
+		err = mmc_switch_status(card);
+		if (err && timing)
+			mmc_set_timing(host, old_timing);
+	}
 out:
 	mmc_retune_release(host);
 
-- 
1.9.1

