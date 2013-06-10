From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 10/12] mmc: core: Enable power_off_notify for eMMC shutdown sequence
Date: Mon, 10 Jun 2013 17:03:45 +0200
Message-ID: <1370876627-13439-11-git-send-email-ulf.hansson@stericsson.com>
References: <1370876627-13439-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:58865 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753767Ab3FJPEZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2013 11:04:25 -0400
In-Reply-To: <1370876627-13439-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

In suspend mode it is important to save power. If the host is able to
cut buth vcc and vccq, the MMC_CAP2_POWEROFF_NOTIFY shall be set. It
will mean the card will be completely powered down at suspend and the
power off notification cmd will be sent prior power down.

It seems common not being able to cut both vcc and vccq for a host. In
this situation we issue the sleep cmd in favor of the power off
notification cmd, to save more power.

While maintainng the above policy, we also want to make use of the
power off notification in the shutdown sequence, even in the case were
the host has not set MMC_CAP2_POWEROFF_NOTIFY, since we know vcc and
vccq will regardless be cut.

We accomplish this by always enabling the power off notification byte
in the EXT_CSD and issue the power off notification when either
MMC_CAP2_POWEROFF_NOTIFY is set or we are executing a shutdown.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3aafb2e..a96dcaa 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1041,11 +1041,9 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	/*
-	 * If the host supports the power_off_notify capability then
-	 * set the notification byte in the ext_csd register of device
+	 * Enable power_off_notification byte in the ext_csd register
 	 */
-	if ((host->caps2 & MMC_CAP2_POWEROFF_NOTIFY) &&
-	    (card->ext_csd.rev >= 6)) {
+	if (card->ext_csd.rev >= 6) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_POWER_OFF_NOTIFICATION,
 				 EXT_CSD_POWER_ON,
@@ -1485,7 +1483,8 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	if (err)
 		goto out;
 
-	if (mmc_can_poweroff_notify(host->card))
+	if (mmc_can_poweroff_notify(host->card) &&
+		((host->caps2 & MMC_CAP2_POWEROFF_NOTIFY) || !is_suspend))
 		err = mmc_poweroff_notify(host->card, notify_type);
 	else if (mmc_can_sleep(host->card))
 		err = mmc_sleep(host);
-- 
1.7.10

