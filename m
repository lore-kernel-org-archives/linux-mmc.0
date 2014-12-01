From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 4/4] mmc: sdhci-acpi: Add two host capabilities for Intel
Date: Mon,  1 Dec 2014 15:51:19 +0200
Message-ID: <1417441879-28058-5-git-send-email-adrian.hunter@intel.com>
References: <1417441879-28058-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:35203 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753721AbaLANxG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 1 Dec 2014 08:53:06 -0500
In-Reply-To: <1417441879-28058-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Intel host controllers are capable of doing the bus
width test and of waiting while busy, so add the
capability flags.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index de67ae6..daba49a 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -203,7 +203,8 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
 	.chip    = &sdhci_acpi_chip_int,
 	.caps    = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
-		   MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR,
+		   MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR |
+		   MMC_CAP_BUS_WIDTH_TEST | MMC_CAP_WAIT_WHILE_BUSY,
 	.caps2   = MMC_CAP2_HC_ERASE_SZ,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
 	.quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
@@ -215,7 +216,8 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
 	.quirks  = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
 		   SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2 = SDHCI_QUIRK2_HOST_OFF_CARD_ON,
-	.caps    = MMC_CAP_NONREMOVABLE | MMC_CAP_POWER_OFF_CARD,
+	.caps    = MMC_CAP_NONREMOVABLE | MMC_CAP_POWER_OFF_CARD |
+		   MMC_CAP_BUS_WIDTH_TEST | MMC_CAP_WAIT_WHILE_BUSY,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
 	.pm_caps = MMC_PM_KEEP_POWER,
 	.probe_slot	= sdhci_acpi_sdio_probe_slot,
@@ -227,6 +229,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sd = {
 	.quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2 = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
 		   SDHCI_QUIRK2_STOP_WITH_TC,
+	.caps    = MMC_CAP_BUS_WIDTH_TEST | MMC_CAP_WAIT_WHILE_BUSY,
 	.probe_slot	= sdhci_acpi_sd_probe_slot,
 };
 
-- 
1.9.1

