From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 2/3] mmc: core: cycle power the card in voltage switch rather than mmc_sd_get_cid
Date: Fri, 14 Dec 2012 18:53:57 +0800
Message-ID: <1355482438-16836-3-git-send-email-kliu5@marvell.com>
References: <1355482438-16836-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:42985 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754138Ab2LNKvV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 05:51:21 -0500
In-Reply-To: <1355482438-16836-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, johan.rudholm@stericsson.com
Cc: per.forlin@stericsson.com, ulf.hansson@linaro.org, fredrik.soderstedt@stericsson.com, dsd@laptop.org, leafy.myeh@allwinnertech.com, subhashj@codeaurora.org, prakity@nvidia.com, zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com, Kevin Liu <kliu5@marvell.com>

Cycle power the card is a MUST step when voltage switch sequence failed.
So move this operation to function mmc_set_signal_voltage.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/core/sd.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index c1a700d..53ba4d9 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -757,7 +757,6 @@ try_again:
 	if (max_current > 150)
 		ocr |= SD_OCR_XPC;
 
-try_again:
 	err = mmc_send_app_op_cond(host, ocr, rocr);
 	if (err)
 		return err;
@@ -769,16 +768,11 @@ try_again:
 	if (!mmc_host_is_spi(host) && rocr &&
 	   ((*rocr & 0x41000000) == 0x41000000)) {
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180, true);
-		if (err == -EAGAIN) {
-			/* Power cycle card */
-			pr_debug("%s: Signal voltage switch failed, "
-					"power cycling card (retries = %d)\n",
-					mmc_hostname(host), retries);
-			mmc_power_cycle(host);
-			retries--;
-			goto try_again;
-		} else if (err) {
-			retries = 0;
+		if (err) {
+			if (err == -EAGAIN)
+				retries--;
+			else
+				retries = 0;
 			goto try_again;
 		}
 	}
-- 
1.7.0.4

