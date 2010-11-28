From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 2/3] mmc: sdio: don't reinitialize nonremovable powered-resumed cards
Date: Sun, 28 Nov 2010 07:21:29 +0200
Message-ID: <1290921690-6133-3-git-send-email-ohad@wizery.com>
References: <1290921690-6133-1-git-send-email-ohad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57371 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab0K1FTq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Nov 2010 00:19:46 -0500
Received: by mail-fx0-f46.google.com with SMTP id 15so1617040fxm.19
        for <linux-mmc@vger.kernel.org>; Sat, 27 Nov 2010 21:19:45 -0800 (PST)
In-Reply-To: <1290921690-6133-1-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

Upon system resume, SDIO core must reinitialize cards that were
powered off during suspend.

If the card had its power kept during suspend (and thus it
is 'powered-resumed'), SDIO core performs only a limited reinitializing,
mainly needed to make sure that the card wasn't removed/replaced.

If a __nonremovable__ card is powered-resumed, we can safely skip the
reinitializing phase.

Note: 9b966aa removed the bus width reconfiguration since
mmc_sdio_init_card already does it. It is brought back now in case
mmc_sdio_init_card is skipped.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---

I have not switched all existing code to mmc_card_is_powered_resumed(),
I can do that as a subsequent clean up patch.

 drivers/mmc/core/sdio.c  |   16 ++++++++++++++--
 include/linux/mmc/host.h |    5 +++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index efef5f9..b424fbe 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -627,15 +627,27 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 
 static int mmc_sdio_resume(struct mmc_host *host)
 {
-	int i, err;
+	int i, err = 0;
 
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
 	/* Basic card reinitialization. */
 	mmc_claim_host(host);
-	err = mmc_sdio_init_card(host, host->ocr, host->card,
+
+	/* No need to reinitialize powered-resumed nonremovable cards */
+	if (mmc_card_is_removable(host) || !mmc_card_is_powered_resumed(host))
+		err = mmc_sdio_init_card(host, host->ocr, host->card,
 				 (host->pm_flags & MMC_PM_KEEP_POWER));
+	else if (mmc_card_is_powered_resumed(host)) {
+		/* We may have switched to 1-bit mode during suspend */
+		err = sdio_enable_4bit_bus(host->card);
+		if (err > 0) {
+			mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
+			err = 0;
+		}
+	}
+
 	if (!err && host->sdio_irqs)
 		mmc_signal_sdio_irq(host);
 	mmc_release_host(host);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 381c77f..30b6fb9 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -317,5 +317,10 @@ static inline int mmc_card_is_removable(struct mmc_host *host)
 	return !(host->caps & MMC_CAP_NONREMOVABLE) && mmc_assume_removable;
 }
 
+static inline int mmc_card_is_powered_resumed(struct mmc_host *host)
+{
+	return host->pm_flags & MMC_PM_KEEP_POWER;
+}
+
 #endif
 
-- 
1.7.0.4

