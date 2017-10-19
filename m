From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/4] mmc: sdhci-acpi: Use helper function acpi_device_uid()
Date: Thu, 19 Oct 2017 13:41:43 +0300
Message-ID: <1508409706-27026-2-git-send-email-adrian.hunter@intel.com>
References: <1508409706-27026-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21701 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751897AbdJSKsj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Oct 2017 06:48:39 -0400
In-Reply-To: <1508409706-27026-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Make use of acpi_device_uid() instead of open coding.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 08ae0ff13513..e4b7fac5efb2 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -443,7 +443,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	hid = acpi_device_hid(device);
-	uid = device->pnp.unique_id;
+	uid = acpi_device_uid(device);
 
 	/* Power on the SDHCI controller and its children */
 	acpi_device_fix_up_power(device);
-- 
1.9.1

