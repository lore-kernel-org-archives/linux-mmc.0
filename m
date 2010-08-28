From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH 2/2] sdhci: disable MMC_CAP_NEEDS_POLL in nonremovable case
Date: Sat, 28 Aug 2010 14:53:56 +0100
Message-ID: <7e892c443f11d51a30029ddfeef27af09a9a970d.1283003070.git.matt@console-pimps.org>
References: <4d1a88f196fa7e7eaf4c4a4af13d91ec81fb084e.1283003070.git.matt@console-pimps.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:39288 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751429Ab0H1Nx5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 28 Aug 2010 09:53:57 -0400
In-Reply-To: <4d1a88f196fa7e7eaf4c4a4af13d91ec81fb084e.1283003070.git.matt@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Dooks <ben-linux@fluff.org>, Ben Hutchings <ben@decadent.org.uk>, Yunpeng Gao <yunpeng.gao@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>

From: Jaehoon Chung <jh80.chung@samsung.com>

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
index f6be963..3111859 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1827,8 +1827,9 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
-	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
-		mmc->caps |= MMC_CAP_NEEDS_POLL;
+	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
+		!mmc_card_is_removable(mmc))
+			mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	mmc->ocr_avail = 0;
 	if (caps & SDHCI_CAN_VDD_330)
-- 
1.7.1

