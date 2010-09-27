From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH V2 2/2] mmc: sdhci: disable MMC_CAP_NEEDS_POLL in nonremovable case
Date: Mon, 27 Sep 2010 09:42:20 +0100
Message-ID: <1285576940-27587-3-git-send-email-matt@console-pimps.org>
References: <1285576940-27587-1-git-send-email-matt@console-pimps.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:44854 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758914Ab0I0ImX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2010 04:42:23 -0400
In-Reply-To: <1285576940-27587-1-git-send-email-matt@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Yunpeng Gao <yunpeng.gao@intel.com>, zhangfei gao <zhangfei.gao@gmail.com>, Chris Ball <cjb@laptop.org>

From: Jaehoon Chung <jh80.chung@samsung.com>

When a controller requires SDHCI_QUIRK_BROKEN_CARD_DETECTION, we poll
for card insertion/removal, and that creates interrupts.  There's no
need to be doing this if we have a non-removable card.

This patch requires cards to be removable before we're willing to set
MMC_CAP_NEEDS_POLL.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Matt Fleming <matt@console-pimps.org>
[cjb: modified changelog and code indentation]
Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5928b0a..d851315 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1847,7 +1847,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
-	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
+	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
+	    mmc_card_is_removable(mmc))
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	mmc->ocr_avail = 0;
-- 
1.7.2.1

