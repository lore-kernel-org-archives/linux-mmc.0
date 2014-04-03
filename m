From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: sdhci-acpi: Intel SDIO has broken card detect
Date: Thu,  3 Apr 2014 14:58:39 +0300
Message-ID: <1396526319-614-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1214 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837AbaDCL7V (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 3 Apr 2014 07:59:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Intel SDIO has broken card detect so add a quirk
to reflect that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 0d372f0..ebb3f39 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -122,6 +122,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
 };
 
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
+	.quirks  = SDHCI_QUIRK_BROKEN_CARD_DETECTION,
 	.quirks2 = SDHCI_QUIRK2_HOST_OFF_CARD_ON,
 	.caps    = MMC_CAP_NONREMOVABLE | MMC_CAP_POWER_OFF_CARD,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
-- 
1.8.3.2

