From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 2/2] mmc: do not switch to 1-bit mode if not required
Date: Tue,  5 Apr 2011 17:43:21 +0300
Message-ID: <1302014601-8089-2-git-send-email-ohad@wizery.com>
References: <1302014601-8089-1-git-send-email-ohad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48769 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558Ab1DEOoN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 10:44:13 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so361705bwz.19
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2011 07:44:12 -0700 (PDT)
In-Reply-To: <1302014601-8089-1-git-send-email-ohad@wizery.com>
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
index 0f7d436..4221670 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -625,7 +625,7 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 		}
 	}
 
-	if (!err && mmc_card_keep_power(host)) {
+	if (!err && mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
 		mmc_claim_host(host);
 		sdio_disable_wide(host->card);
 		mmc_release_host(host);
@@ -648,7 +648,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
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

