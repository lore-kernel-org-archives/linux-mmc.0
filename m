From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/7] mmc: sdhci-acpi: Add a HID and UID for a SD Card host controller
Date: Wed, 24 Sep 2014 10:27:29 +0300
Message-ID: <1411543653-3728-4-git-send-email-adrian.hunter@intel.com>
References: <1411543653-3728-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49230 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157AbaIXHiK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 24 Sep 2014 03:38:10 -0400
In-Reply-To: <1411543653-3728-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Add a HID (INT33BB) and UID (3) for a SD Card host controller.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 1bc92c6..c38f089 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -207,6 +207,7 @@ static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
 	{ "80860F14" , "3" , &sdhci_acpi_slot_int_sd   },
 	{ "80860F16" , NULL, &sdhci_acpi_slot_int_sd   },
 	{ "INT33BB"  , "2" , &sdhci_acpi_slot_int_sdio },
+	{ "INT33BB"  , "3" , &sdhci_acpi_slot_int_sd },
 	{ "INT33C6"  , NULL, &sdhci_acpi_slot_int_sdio },
 	{ "INT3436"  , NULL, &sdhci_acpi_slot_int_sdio },
 	{ "PNP0D40"  },
-- 
1.8.3.2

