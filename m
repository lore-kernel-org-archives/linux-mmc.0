From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/2] mmc: sdhci-acpi: Sync quirks with sdhci_intel_byt_* from sdhci-pci-core.c
Date: Wed, 15 Mar 2017 17:31:44 +0100
Message-ID: <20170315163145.15475-1-hdegoede@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752569AbdCOQcJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Mar 2017 12:32:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org

The sdhci_intel_byt_* and the non _qcom_ sdhci_acpi_slot_ entries in
sdhci-acpi.c are for the same mmc host in either pci or acpi mapped
mode, so the flags should be the same.

The syncing removes the SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk from
sdhci_acpi_slot_int_sdio, this quirk is a nop as this slot also has
MMC_CAP_NONREMOVABLE, and adds SDHCI_QUIRK2_PRESET_VALUE_BROKEN to
sdhci_acpi_slot_int_sdio and sdhci_acpi_slot_int_sd. Note that
sdhci_acpi_slot_int_mmc already has the SDHCI_QUIRK2_PRESET_VALUE_BROKEN
quirk, which is another indication that the others need it too.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/host/sdhci-acpi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 9dcb704..237f318 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -286,9 +286,9 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
 };
 
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
-	.quirks  = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
-		   SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
-	.quirks2 = SDHCI_QUIRK2_HOST_OFF_CARD_ON,
+	.quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks2 = SDHCI_QUIRK2_HOST_OFF_CARD_ON |
+		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.caps    = MMC_CAP_NONREMOVABLE | MMC_CAP_POWER_OFF_CARD |
 		   MMC_CAP_WAIT_WHILE_BUSY,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
@@ -301,6 +301,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sd = {
 		   SDHCI_ACPI_RUNTIME_PM,
 	.quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2 = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
+		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 		   SDHCI_QUIRK2_STOP_WITH_TC,
 	.caps    = MMC_CAP_WAIT_WHILE_BUSY,
 	.probe_slot	= sdhci_acpi_sd_probe_slot,
-- 
2.9.3

