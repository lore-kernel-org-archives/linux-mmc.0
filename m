From: "George G. Davis" <gdavis@mvista.com>
Subject: [RFC/PATCH] mmc: sdhci: Enable high speed support for MMC cards
Date: Thu, 18 Feb 2010 15:27:53 -0500
Message-ID: <1266524873-24274-1-git-send-email-gdavis@mvista.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:40940
	"EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753789Ab0BRU2E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Feb 2010 15:28:04 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: "George G. Davis" <gdavis@mvista.com>

Allow high speed mode for high speed capable ver 4.x MMC cards.

Comments and/or feedback appreciated.

Signed-off-by: George G. Davis <gdavis@mvista.com>
---
 drivers/mmc/host/sdhci.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6c05d80..a935316 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1161,7 +1161,8 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		ctrl &= ~SDHCI_CTRL_8BITBUS;
 	}
 
-	if (ios->timing == MMC_TIMING_SD_HS)
+	if (ios->timing == MMC_TIMING_SD_HS ||
+	    ios->timing == MMC_TIMING_MMC_HS)
 		ctrl |= SDHCI_CTRL_HISPD;
 	else
 		ctrl &= ~SDHCI_CTRL_HISPD;
@@ -1797,8 +1798,10 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->caps |= MMC_CAP_8_BIT_DATA;
 	}
 
-	if (caps & SDHCI_CAN_DO_HISPD)
+	if (caps & SDHCI_CAN_DO_HISPD) {
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
+		mmc->caps |= MMC_CAP_MMC_HIGHSPEED;
+	}
 
 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
-- 
1.6.3.3.311.g43dd

