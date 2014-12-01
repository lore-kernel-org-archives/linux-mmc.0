From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/4] mmc: sdhci-acpi: Add SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
Date: Mon,  1 Dec 2014 15:51:17 +0200
Message-ID: <1417441879-28058-3-git-send-email-adrian.hunter@intel.com>
References: <1417441879-28058-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:35203 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753675AbaLANxB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 1 Dec 2014 08:53:01 -0500
In-Reply-To: <1417441879-28058-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC actually causes
standard-compliant behaviour by causing the flagging
of the last DMA transfer descriptor as the end
instead of there being an additional nop descriptor
which is flagged as the end.  Consequently, it is
better to have the quirk.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 3109763..de67ae6 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -206,12 +206,14 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
 		   MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR,
 	.caps2   = MMC_CAP2_HC_ERASE_SZ,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
+	.quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN | SDHCI_QUIRK2_STOP_WITH_TC,
 	.probe_slot	= sdhci_acpi_emmc_probe_slot,
 };
 
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
-	.quirks  = SDHCI_QUIRK_BROKEN_CARD_DETECTION,
+	.quirks  = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
+		   SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2 = SDHCI_QUIRK2_HOST_OFF_CARD_ON,
 	.caps    = MMC_CAP_NONREMOVABLE | MMC_CAP_POWER_OFF_CARD,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
@@ -222,6 +224,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sd = {
 	.flags   = SDHCI_ACPI_SD_CD | SDHCI_ACPI_SD_CD_OVERRIDE_LEVEL |
 		   SDHCI_ACPI_RUNTIME_PM,
+	.quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2 = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
 		   SDHCI_QUIRK2_STOP_WITH_TC,
 	.probe_slot	= sdhci_acpi_sd_probe_slot,
-- 
1.9.1

