From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/2] mmc: sdhci-pci: set Medfield SDIO as non-removable
Date: Mon, 30 Jan 2012 14:27:18 +0200
Message-ID: <1327926439-23603-2-git-send-email-adrian.hunter@intel.com>
References: <1327926439-23603-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31965 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752363Ab2A3M10 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 30 Jan 2012 07:27:26 -0500
In-Reply-To: <1327926439-23603-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Set Medfield SDIO as non-removable to avoid un-necessary
card detect activity.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 7165e6a..6ebdc40 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -250,7 +250,7 @@ static int mfd_emmc_probe_slot(struct sdhci_pci_slot *slot)
 
 static int mfd_sdio_probe_slot(struct sdhci_pci_slot *slot)
 {
-	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD;
+	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE;
 	return 0;
 }
 
-- 
1.7.6.4

