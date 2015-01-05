From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/2] mmc: sdhci-acpi: Add ACPI HID INT344D
Date: Mon,  5 Jan 2015 14:47:57 +0200
Message-ID: <1420462078-28868-2-git-send-email-adrian.hunter@intel.com>
References: <1420462078-28868-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:11016 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbbAEMto (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 5 Jan 2015 07:49:44 -0500
In-Reply-To: <1420462078-28868-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Add ACPI HID INT344D for an Intel SDIO host controller.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index e3e56d3..970314e 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -247,6 +247,7 @@ static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
 	{ "INT33BB"  , "3" , &sdhci_acpi_slot_int_sd },
 	{ "INT33C6"  , NULL, &sdhci_acpi_slot_int_sdio },
 	{ "INT3436"  , NULL, &sdhci_acpi_slot_int_sdio },
+	{ "INT344D"  , NULL, &sdhci_acpi_slot_int_sdio },
 	{ "PNP0D40"  },
 	{ },
 };
@@ -257,6 +258,7 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
 	{ "INT33BB"  },
 	{ "INT33C6"  },
 	{ "INT3436"  },
+	{ "INT344D"  },
 	{ "PNP0D40"  },
 	{ },
 };
-- 
1.9.1

