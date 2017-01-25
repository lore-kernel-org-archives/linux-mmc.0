From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/6] mmc: core: Remove redundant code in mmc_set_signal_voltage()
Date: Wed, 25 Jan 2017 16:12:18 +0100
Message-ID: <1485357143-23280-2-git-send-email-ulf.hansson@linaro.org>
References: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34239 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbdAYPMd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jan 2017 10:12:33 -0500
Received: by mail-lf0-f47.google.com with SMTP id v186so130536002lfa.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jan 2017 07:12:32 -0800 (PST)
In-Reply-To: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Stefan Wahren <stefan.wahren@i2se.com>, Fabio Estevam <festevam@gmail.com>, Jan Glauber <jan.glauber@caviumnetworks.com>

The mmc_set_signal_voltage() function is used for SD/SDIO when switching to
1.8V for UHS mode. Therefore let's remove the redundant code dealing with
MMC_SIGNAL_VOLTAGE_330.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8c45825..bb819d4 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1654,13 +1654,6 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, u32 ocr)
 	u32 clock;
 
 	/*
-	 * Send CMD11 only if the request is to switch the card to
-	 * 1.8V signalling.
-	 */
-	if (signal_voltage == MMC_SIGNAL_VOLTAGE_330)
-		return __mmc_set_signal_voltage(host, signal_voltage);
-
-	/*
 	 * If we cannot switch voltages, return failure so the caller
 	 * can continue without UHS mode
 	 */
-- 
1.9.1

