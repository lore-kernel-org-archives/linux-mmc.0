From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/2] mmc: sdhci-acpi: Add more ACPI HIDs for Intel controllers
Date: Wed, 21 Oct 2015 11:15:46 +0300
Message-ID: <1445415346-12929-2-git-send-email-adrian.hunter@intel.com>
References: <1445415346-12929-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:26896 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753759AbbJUISt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Oct 2015 04:18:49 -0400
In-Reply-To: <1445415346-12929-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Add ACPI HIDs for Intel host controllers including one
supporting HS400.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 78aa16aed07b..f6047fc94062 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -207,7 +207,9 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
 	.caps2   = MMC_CAP2_HC_ERASE_SZ,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
 	.quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN | SDHCI_QUIRK2_STOP_WITH_TC,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_STOP_WITH_TC |
+		   SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400,
 	.probe_slot	= sdhci_acpi_emmc_probe_slot,
 };
 
@@ -239,6 +241,9 @@ struct sdhci_acpi_uid_slot {
 };
 
 static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
+	{ "80865ACA", NULL, &sdhci_acpi_slot_int_sd },
+	{ "80865ACC", NULL, &sdhci_acpi_slot_int_emmc },
+	{ "80865AD0", NULL, &sdhci_acpi_slot_int_sdio },
 	{ "80860F14" , "1" , &sdhci_acpi_slot_int_emmc },
 	{ "80860F14" , "3" , &sdhci_acpi_slot_int_sd   },
 	{ "80860F16" , NULL, &sdhci_acpi_slot_int_sd   },
@@ -253,6 +258,9 @@ static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
 };
 
 static const struct acpi_device_id sdhci_acpi_ids[] = {
+	{ "80865ACA" },
+	{ "80865ACC" },
+	{ "80865AD0" },
 	{ "80860F14" },
 	{ "80860F16" },
 	{ "INT33BB"  },
-- 
1.9.1

