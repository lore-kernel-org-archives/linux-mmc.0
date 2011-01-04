From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 1/4] mmc: mmc_card_keep_power cleanups
Date: Tue,  4 Jan 2011 23:10:13 +0200
Message-ID: <1294175416-12358-1-git-send-email-ohad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59865 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994Ab1ADVKo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 16:10:44 -0500
Received: by eye27 with SMTP id 27so6488007eye.19
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jan 2011 13:10:43 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

mmc_card_is_powered_resumed is a mouthful; instead, simply use
mmc_card_keep_power, which also better reflects the meaning of
the predicate.

Employ mmc_card_keep_power() where possible.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/core/core.c  |    4 ++--
 drivers/mmc/core/sdio.c  |   10 +++++-----
 include/linux/mmc/host.h |    2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 286e6ce..de8a3d3 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1723,7 +1723,7 @@ int mmc_suspend_host(struct mmc_host *host)
 	}
 	mmc_bus_put(host);
 
-	if (!err && !(host->pm_flags & MMC_PM_KEEP_POWER))
+	if (!err && !mmc_card_keep_power(host))
 		mmc_power_off(host);
 
 	return err;
@@ -1741,7 +1741,7 @@ int mmc_resume_host(struct mmc_host *host)
 
 	mmc_bus_get(host);
 	if (host->bus_ops && !host->bus_dead) {
-		if (!(host->pm_flags & MMC_PM_KEEP_POWER)) {
+		if (!mmc_card_keep_power(host)) {
 			mmc_power_up(host);
 			mmc_select_voltage(host, host->ocr);
 			/*
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 5c4a54d..97a6182 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -616,7 +616,7 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 		}
 	}
 
-	if (!err && host->pm_flags & MMC_PM_KEEP_POWER) {
+	if (!err && mmc_card_keep_power(host)) {
 		mmc_claim_host(host);
 		sdio_disable_wide(host->card);
 		mmc_release_host(host);
@@ -636,10 +636,10 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	mmc_claim_host(host);
 
 	/* No need to reinitialize powered-resumed nonremovable cards */
-	if (mmc_card_is_removable(host) || !mmc_card_is_powered_resumed(host))
+	if (mmc_card_is_removable(host) || !mmc_card_keep_power(host))
 		err = mmc_sdio_init_card(host, host->ocr, host->card,
-				 (host->pm_flags & MMC_PM_KEEP_POWER));
-	else if (mmc_card_is_powered_resumed(host)) {
+					mmc_card_keep_power(host));
+	else if (mmc_card_keep_power(host)) {
 		/* We may have switched to 1-bit mode during suspend */
 		err = sdio_enable_4bit_bus(host->card);
 		if (err > 0) {
@@ -682,7 +682,7 @@ static int mmc_sdio_power_restore(struct mmc_host *host)
 
 	mmc_claim_host(host);
 	ret = mmc_sdio_init_card(host, host->ocr, host->card,
-			(host->pm_flags & MMC_PM_KEEP_POWER));
+				mmc_card_keep_power(host));
 	if (!ret && host->sdio_irqs)
 		mmc_signal_sdio_irq(host);
 	mmc_release_host(host);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index bcb793e..cccb5cf 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -321,7 +321,7 @@ static inline int mmc_card_is_removable(struct mmc_host *host)
 	return !(host->caps & MMC_CAP_NONREMOVABLE) && mmc_assume_removable;
 }
 
-static inline int mmc_card_is_powered_resumed(struct mmc_host *host)
+static inline int mmc_card_keep_power(struct mmc_host *host)
 {
 	return host->pm_flags & MMC_PM_KEEP_POWER;
 }
-- 
1.7.1

