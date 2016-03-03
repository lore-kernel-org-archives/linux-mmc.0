From: Philip Elcan <pelcan@codeaurora.org>
Subject: [PATCH] mmc: sdhci-acpi: add QCOM controllers
Date: Thu,  3 Mar 2016 11:38:46 -0500
Message-ID: <1457023128-23720-1-git-send-email-pelcan@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51380 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbcCCQjG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Mar 2016 11:39:06 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Michele Curti <michele.curti@gmail.com>, Philip Elcan <pelcan@codeaurora.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Timur Tabi <timur@codeaurora.org>, linux-arm-msm@vger.kernel.org

This adds the HIDs for Qualcomm Technologies Inc SDHC
controllers:
QCOM8051: non-removable device that does not support 1.8v
QCOM8052: non-removable device that does support 1.8v

Signed-off-by: Philip Elcan <pelcan@codeaurora.org>
---
 drivers/mmc/host/sdhci-acpi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index a5cda92..041e739 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -264,6 +264,17 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sd = {
 	.probe_slot	= sdhci_acpi_sd_probe_slot,
 };
 
+static const struct sdhci_acpi_slot sdhci_acpi_slot_qcom_sd_3v = {
+	.quirks  = SDHCI_QUIRK_BROKEN_CARD_DETECTION,
+	.quirks2 = SDHCI_QUIRK2_NO_1_8_V,
+	.caps    = MMC_CAP_NONREMOVABLE,
+};
+
+static const struct sdhci_acpi_slot sdhci_acpi_slot_qcom_sd = {
+	.quirks  = SDHCI_QUIRK_BROKEN_CARD_DETECTION,
+	.caps    = MMC_CAP_NONREMOVABLE,
+};
+
 struct sdhci_acpi_uid_slot {
 	const char *hid;
 	const char *uid;
@@ -284,6 +295,8 @@ static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
 	{ "INT344D"  , NULL, &sdhci_acpi_slot_int_sdio },
 	{ "PNP0FFF"  , "3" , &sdhci_acpi_slot_int_sd   },
 	{ "PNP0D40"  },
+	{ "QCOM8051", NULL, &sdhci_acpi_slot_qcom_sd_3v },
+	{ "QCOM8052", NULL, &sdhci_acpi_slot_qcom_sd },
 	{ },
 };
 
@@ -298,6 +311,8 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
 	{ "INT3436"  },
 	{ "INT344D"  },
 	{ "PNP0D40"  },
+	{ "QCOM8051" },
+	{ "QCOM8052" },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

