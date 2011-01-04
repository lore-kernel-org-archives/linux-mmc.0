From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 2/4] mmc: do not switch to 1-bit mode if not required
Date: Tue,  4 Jan 2011 23:10:14 +0200
Message-ID: <1294175416-12358-2-git-send-email-ohad@wizery.com>
References: <1294175416-12358-1-git-send-email-ohad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59865 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482Ab1ADVKq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 16:10:46 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so6488007eye.19
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jan 2011 13:10:45 -0800 (PST)
In-Reply-To: <1294175416-12358-1-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

6b5eda36 followed SDIO spec part E1 section 8, which states that
in case SDIO interrupts are being used to wake up a suspended host,
then it is required to switch to 1-bit mode before stopping the clock.

Before switching to 1-bit mode (or back to 4-bit mode on resume),
make sure that SDIO interrupts are really being used to wake the host.

This is helpful for devices which have an external irq line (e.g.
wl1271), and do not use SDIO interrupts to wake up the host.

In this case, switching to 1-bit mode (and back to 4-bit mode on resume)
is not necessary.

Reported-by: Eliad Peller <eliad@wizery.com>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/core/sdio.c  |    4 ++--
 include/linux/mmc/host.h |    4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 97a6182..78be7d9 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -616,7 +616,7 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 		}
 	}
 
-	if (!err && mmc_card_keep_power(host)) {
+	if (!err && mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
 		mmc_claim_host(host);
 		sdio_disable_wide(host->card);
 		mmc_release_host(host);
@@ -639,7 +639,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	if (mmc_card_is_removable(host) || !mmc_card_keep_power(host))
 		err = mmc_sdio_init_card(host, host->ocr, host->card,
 					mmc_card_keep_power(host));
-	else if (mmc_card_keep_power(host)) {
+	else if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
 		/* We may have switched to 1-bit mode during suspend */
 		err = sdio_enable_4bit_bus(host->card);
 		if (err > 0) {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index cccb5cf..4f705eb 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -326,5 +326,9 @@ static inline int mmc_card_keep_power(struct mmc_host *host)
 	return host->pm_flags & MMC_PM_KEEP_POWER;
 }
 
+static inline int mmc_card_wake_sdio_irq(struct mmc_host *host)
+{
+	return host->pm_flags & MMC_PM_WAKE_SDIO_IRQ;
+}
 #endif
 
-- 
1.7.1

