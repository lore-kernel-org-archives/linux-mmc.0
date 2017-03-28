From: Azhar Shaikh <azhar.shaikh@intel.com>
Subject: [PATCH 1/2] mmc: sdhci-acpi: Set MMC_CAP_AGGRESSIVE_PM for BYT-related Intel controllers
Date: Tue, 28 Mar 2017 11:08:29 -0700
Message-ID: <1490724510-105153-1-git-send-email-azhar.shaikh@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34436 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753066AbdC1SIc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 28 Mar 2017 14:08:32 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org, azhar.shaikh@intel.com

Set MMC_CAP_AGGRESSIVE_PM for BYT-related Intel SD card
controllers.

Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 9dcb704..a15d237 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -263,10 +263,8 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
 
 	/* Platform specific code during sd probe slot goes here */
 
-	if (hid && !strcmp(hid, "80865ACA")) {
+	if (hid && !strcmp(hid, "80865ACA"))
 		host->mmc_host_ops.get_cd = bxt_get_cd;
-		host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
-	}
 
 	return 0;
 }
@@ -302,7 +300,7 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
 	.quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2 = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
 		   SDHCI_QUIRK2_STOP_WITH_TC,
-	.caps    = MMC_CAP_WAIT_WHILE_BUSY,
+	.caps    = MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_AGGRESSIVE_PM,
 	.probe_slot	= sdhci_acpi_sd_probe_slot,
 };
 
-- 
1.9.1

