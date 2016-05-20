From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/3] mmc: sdhci-acpi: Remove MMC_CAP_BUS_WIDTH_TEST for Intel controllers
Date: Fri, 20 May 2016 10:33:48 +0300
Message-ID: <1463729628-3517-4-git-send-email-adrian.hunter@intel.com>
References: <1463729628-3517-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45641 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753772AbcETHhu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 May 2016 03:37:50 -0400
In-Reply-To: <1463729628-3517-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

The CMD19/CMD14 bus width test has been found to be unreliable in
some cases.  It is not essential, so simply remove it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/mmc/host/sdhci-acpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index b2d70ba6caa7..3f923644eaa4 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -274,7 +274,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
 	.chip    = &sdhci_acpi_chip_int,
 	.caps    = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
 		   MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR |
-		   MMC_CAP_BUS_WIDTH_TEST | MMC_CAP_WAIT_WHILE_BUSY,
+		   MMC_CAP_WAIT_WHILE_BUSY,
 	.caps2   = MMC_CAP2_HC_ERASE_SZ,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
 	.quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
@@ -289,7 +289,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
 		   SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2 = SDHCI_QUIRK2_HOST_OFF_CARD_ON,
 	.caps    = MMC_CAP_NONREMOVABLE | MMC_CAP_POWER_OFF_CARD |
-		   MMC_CAP_BUS_WIDTH_TEST | MMC_CAP_WAIT_WHILE_BUSY,
+		   MMC_CAP_WAIT_WHILE_BUSY,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
 	.pm_caps = MMC_PM_KEEP_POWER,
 	.probe_slot	= sdhci_acpi_sdio_probe_slot,
@@ -301,7 +301,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sd = {
 	.quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2 = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
 		   SDHCI_QUIRK2_STOP_WITH_TC,
-	.caps    = MMC_CAP_BUS_WIDTH_TEST | MMC_CAP_WAIT_WHILE_BUSY,
+	.caps    = MMC_CAP_WAIT_WHILE_BUSY,
 	.probe_slot	= sdhci_acpi_sd_probe_slot,
 };
 
-- 
1.9.1

