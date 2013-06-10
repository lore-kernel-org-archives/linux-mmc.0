From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 08/12] mmc: core: Handle both poweroff notification types for eMMC
Date: Mon, 10 Jun 2013 17:03:43 +0200
Message-ID: <1370876627-13439-9-git-send-email-ulf.hansson@stericsson.com>
References: <1370876627-13439-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog122.obsmtp.com ([207.126.144.153]:49642 "EHLO
	eu1sys200aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753729Ab3FJPEW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2013 11:04:22 -0400
In-Reply-To: <1370876627-13439-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

Depending on the context of the operation while powering down the card,
either POWER_OFF_NOTIFY_SHORT or POWER_OFF_NOTIFY_LONG will be used. In
suspend context a short timeout is preferred while a long timeout would
be acceptable in a shutdown/hibernation context.

We add a new parameter to the mmc_suspend function so we can provide an
indication of what notification type to use.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 86ca103..dcf0169 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1464,12 +1464,11 @@ static void mmc_detect(struct mmc_host *host)
 	}
 }
 
-/*
- * Suspend callback from host.
- */
-static int mmc_suspend(struct mmc_host *host)
+static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 {
 	int err = 0;
+	unsigned int notify_type = is_suspend ? EXT_CSD_POWER_OFF_SHORT :
+					EXT_CSD_POWER_OFF_LONG;
 
 	BUG_ON(!host);
 	BUG_ON(!host->card);
@@ -1487,7 +1486,7 @@ static int mmc_suspend(struct mmc_host *host)
 		goto out;
 
 	if (mmc_can_poweroff_notify(host->card))
-		err = mmc_poweroff_notify(host->card, EXT_CSD_POWER_OFF_SHORT);
+		err = mmc_poweroff_notify(host->card, notify_type);
 	else if (mmc_can_sleep(host->card))
 		err = mmc_sleep(host);
 	else if (!mmc_host_is_spi(host))
@@ -1502,6 +1501,14 @@ out:
 }
 
 /*
+ * Suspend callback from host.
+ */
+static int mmc_suspend(struct mmc_host *host)
+{
+	return _mmc_suspend(host, true);
+}
+
+/*
  * Resume callback from host.
  *
  * This function tries to determine if the same card is still present
-- 
1.7.10

