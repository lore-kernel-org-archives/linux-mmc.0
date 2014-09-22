From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 07/13] mmc: sdhci-acpi: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel host controllers
Date: Mon, 22 Sep 2014 13:17:38 +0300
Message-ID: <1411381064-1703-8-git-send-email-adrian.hunter@intel.com>
References: <1411381064-1703-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52707 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753558AbaIVKTa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Sep 2014 06:19:30 -0400
In-Reply-To: <1411381064-1703-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Add quirk SDHCI_QUIRK2_STOP_WITH_TC for Intel host controllers.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 3483c08..1bc92c6 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -175,7 +175,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
 		   MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR,
 	.caps2   = MMC_CAP2_HC_ERASE_SZ,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN | SDHCI_QUIRK2_STOP_WITH_TC,
 	.probe_slot	= sdhci_acpi_emmc_probe_slot,
 };
 
@@ -191,7 +191,8 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sd = {
 	.flags   = SDHCI_ACPI_SD_CD | SDHCI_ACPI_SD_CD_OVERRIDE_LEVEL |
 		   SDHCI_ACPI_RUNTIME_PM,
-	.quirks2 = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON,
+	.quirks2 = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
+		   SDHCI_QUIRK2_STOP_WITH_TC,
 	.probe_slot	= sdhci_acpi_sd_probe_slot,
 };
 
-- 
1.8.3.2

