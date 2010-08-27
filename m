From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] sdhci: disable MMC_CAP_NEEDS_POLL in nonremovable case
Date: Fri, 27 Aug 2010 15:34:54 +0900
Message-ID: <4C775C8E.7040903@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:17001 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab0H0Ge4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Aug 2010 02:34:56 -0400
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L7S00B2DSY6N9A0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 27 Aug 2010 15:34:54 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L7S00BTYSY6PS@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 27 Aug 2010 15:34:54 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, matt@console-pimps.org, Marek Szyprowski <m.szyprowski@samsung.com>

If controller use SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk, 
controller need always polling detect

In this case, always generated interrupt.Because controller checked card status.
I think that is not efficiently.

But if card is nonremovable, we need not always polling.
So i added the check-point which is nonremovable or not

 Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

---
 drivers/mmc/host/sdhci.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 401527d..4bc5d3c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1826,8 +1826,9 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
 
-	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
-		mmc->caps |= MMC_CAP_NEEDS_POLL;
+	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
+		!(host->mmc->caps & MMC_CAP_NONREMOVABLE))
+			mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	mmc->ocr_avail = 0;
 	if (caps & SDHCI_CAN_VDD_330)
-- 
1.6.0.4
