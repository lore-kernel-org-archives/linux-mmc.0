From: yongd <yongd@marvell.com>
Subject: [PATCH] mmc: remove MMC_CAP_NEEDS_POLL setting in sdhci_add_host
Date: Tue, 25 Sep 2012 14:34:07 +0800
Message-ID: <1348554847-14190-1-git-send-email-yongd@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:37493 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750884Ab2IYGuz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 02:50:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linux-mmc@vger.kernel.org, Daniel Drake <dsd@laptop.org>, Zhangfei Gao <zhangfei.gao@marvell.com>, yongd <yongd@marvell.com>

From: yongd <yongd@marvell.com>

In the current code logic, sdhci_add_host() will enable the polling
method (set MMC_CAP_NEEDS_POLL) for a removable card (MMC_CAP_
NONREMOVABLE is not set) whose host's internal card detection method
is disabled for some reason (SDHCI_QUIRK_BROKEN_CARD_DETECTION is set).

However, this is improper since we can have some other card detection
methods besides host internal card detection and the polling method.
For example, we might use an external GPIO pin's interrupt to detect
a removable SD card, so we shall set SDHCI_QUIRK_BROKEN_CARD_DETECTION
since we don't use the internal card detection, and not set MMC_CAP_
NONREMOVABLE since the SD card is physically removable. As a result,
with the current code, the polling method will also be enabled.
Apparently, this is redundant and not what we want.

And the better one to decide whether we use polling or not should be
the host driver itself. Actually, some host driver has already been
like this. Eg, in drivers/mmc/host/Au1xmmc.c, polling will be enabled
only after the board-specific card detection can't be set up successfully.

Change-Id: I27774488a7b9191d7bc39699fd7d62ee21bbf157
Signed-off-by: yongd <yongd@marvell.com>
---
 drivers/mmc/host/sdhci.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0e15c79..900d5f4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2840,10 +2840,6 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps[0] & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
-	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
-	    !(host->mmc->caps & MMC_CAP_NONREMOVABLE))
-		mmc->caps |= MMC_CAP_NEEDS_POLL;
-
 	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
 	host->vqmmc = regulator_get(mmc_dev(mmc), "vqmmc");
 	if (IS_ERR(host->vqmmc)) {
-- 
1.7.9.5

