From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] mmc: sdhci-acpi: add new ACPI ID
Date: Tue, 12 Nov 2013 12:01:33 +0200
Message-ID: <1384250493-11232-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:22169 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752488Ab3KLKBg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Nov 2013 05:01:36 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

Newer Intel PCHs with LPSS have the same SDHCI controller than Haswell but
ACPI ID is different. Add this ID to the driver list.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index cdd4ce0d7c90..d94fa1467c79 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -144,6 +144,7 @@ static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
 	{ "80860F14" , "3" , &sdhci_acpi_slot_int_sd   },
 	{ "INT33BB"  , "2" , &sdhci_acpi_slot_int_sdio },
 	{ "INT33C6"  , NULL, &sdhci_acpi_slot_int_sdio },
+	{ "INT3436"  , NULL, &sdhci_acpi_slot_int_sdio },
 	{ "PNP0D40"  },
 	{ },
 };
@@ -152,6 +153,7 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
 	{ "80860F14" },
 	{ "INT33BB"  },
 	{ "INT33C6"  },
+	{ "INT3436"  },
 	{ "PNP0D40"  },
 	{ },
 };
-- 
1.8.4.2

