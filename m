From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/4] mmc: sdhci-acpi: Tidy Intel slot probe functions into one
Date: Thu, 19 Oct 2017 13:41:44 +0300
Message-ID: <1508409706-27026-3-git-send-email-adrian.hunter@intel.com>
References: <1508409706-27026-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21701 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751897AbdJSKsk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Oct 2017 06:48:40 -0400
In-Reply-To: <1508409706-27026-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Tidy Intel slot probe functions into one. A single function can be used
because the logic uses hid / uid as necessary to identify devices anyway.
This gets rid of some pointless comments and checks for variables that
cannot possibly be NULL, as well as giving the function a name that
identifies it as specific to Intel controllers.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 48 ++++++-------------------------------------
 1 file changed, 6 insertions(+), 42 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index e4b7fac5efb2..640be5b618fc 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -269,53 +269,17 @@ static int bxt_get_cd(struct mmc_host *mmc)
 	return ret;
 }
 
-static int sdhci_acpi_emmc_probe_slot(struct platform_device *pdev,
-				      const char *hid, const char *uid)
+static int intel_probe_slot(struct platform_device *pdev, const char *hid,
+			    const char *uid)
 {
 	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
-	struct sdhci_host *host;
-
-	if (!c || !c->host)
-		return 0;
-
-	host = c->host;
-
-	/* Platform specific code during emmc probe slot goes here */
+	struct sdhci_host *host = c->host;
 
 	if (hid && uid && !strcmp(hid, "80860F14") && !strcmp(uid, "1") &&
 	    sdhci_readl(host, SDHCI_CAPABILITIES) == 0x446cc8b2 &&
 	    sdhci_readl(host, SDHCI_CAPABILITIES_1) == 0x00000807)
 		host->timeout_clk = 1000; /* 1000 kHz i.e. 1 MHz */
 
-	return 0;
-}
-
-static int sdhci_acpi_sdio_probe_slot(struct platform_device *pdev,
-				      const char *hid, const char *uid)
-{
-	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
-
-	if (!c || !c->host)
-		return 0;
-
-	/* Platform specific code during sdio probe slot goes here */
-
-	return 0;
-}
-
-static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
-				    const char *hid, const char *uid)
-{
-	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
-	struct sdhci_host *host;
-
-	if (!c || !c->host || !c->slot)
-		return 0;
-
-	host = c->host;
-
-	/* Platform specific code during sd probe slot goes here */
-
 	if (hid && !strcmp(hid, "80865ACA"))
 		host->mmc_host_ops.get_cd = bxt_get_cd;
 
@@ -332,7 +296,7 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 		   SDHCI_QUIRK2_STOP_WITH_TC |
 		   SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400,
-	.probe_slot	= sdhci_acpi_emmc_probe_slot,
+	.probe_slot	= intel_probe_slot,
 };
 
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
@@ -343,7 +307,7 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
 		   MMC_CAP_WAIT_WHILE_BUSY,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
 	.pm_caps = MMC_PM_KEEP_POWER,
-	.probe_slot	= sdhci_acpi_sdio_probe_slot,
+	.probe_slot	= intel_probe_slot,
 };
 
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sd = {
@@ -353,7 +317,7 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
 	.quirks2 = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
 		   SDHCI_QUIRK2_STOP_WITH_TC,
 	.caps    = MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_AGGRESSIVE_PM,
-	.probe_slot	= sdhci_acpi_sd_probe_slot,
+	.probe_slot	= intel_probe_slot,
 };
 
 static const struct sdhci_acpi_slot sdhci_acpi_slot_qcom_sd_3v = {
-- 
1.9.1

