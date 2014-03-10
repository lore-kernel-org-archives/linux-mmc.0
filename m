From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 5/6] mmc: sdhci-acpi: Add device id 80860F16
Date: Mon, 10 Mar 2014 15:02:43 +0200
Message-ID: <1394456564-13783-6-git-send-email-adrian.hunter@intel.com>
References: <1394456564-13783-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46138 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753247AbaCJNEK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Mar 2014 09:04:10 -0400
In-Reply-To: <1394456564-13783-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Add ACPI HID 80860F16 as a host controller for
a SD card.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 98c7420..0d372f0 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -143,6 +143,7 @@ struct sdhci_acpi_uid_slot {
 static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
 	{ "80860F14" , "1" , &sdhci_acpi_slot_int_emmc },
 	{ "80860F14" , "3" , &sdhci_acpi_slot_int_sd   },
+	{ "80860F16" , NULL, &sdhci_acpi_slot_int_sd   },
 	{ "INT33BB"  , "2" , &sdhci_acpi_slot_int_sdio },
 	{ "INT33C6"  , NULL, &sdhci_acpi_slot_int_sdio },
 	{ "INT3436"  , NULL, &sdhci_acpi_slot_int_sdio },
@@ -152,6 +153,7 @@ static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
 
 static const struct acpi_device_id sdhci_acpi_ids[] = {
 	{ "80860F14" },
+	{ "80860F16" },
 	{ "INT33BB"  },
 	{ "INT33C6"  },
 	{ "INT3436"  },
-- 
1.8.3.2

