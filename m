From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] sdhci-acpi: fix copy'n'paste typos in the comments
Date: Mon, 12 Jan 2015 19:37:25 +0200
Message-ID: <1421084245-16656-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27258 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbbALRh0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 Jan 2015 12:37:26 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Just fix the comments, no functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index dffd2c2..b11a3cb 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -158,7 +158,7 @@ static int sdhci_acpi_emmc_probe_slot(struct platform_device *pdev,
 
 	host = c->host;
 
-	/* Platform specific code during emmc proble slot goes here */
+	/* Platform specific code during emmc probe slot goes here */
 
 	if (hid && uid && !strcmp(hid, "80860F14") && !strcmp(uid, "1") &&
 	    sdhci_readl(host, SDHCI_CAPABILITIES) == 0x446cc8b2 &&
@@ -179,7 +179,7 @@ static int sdhci_acpi_sdio_probe_slot(struct platform_device *pdev,
 
 	host = c->host;
 
-	/* Platform specific code during emmc proble slot goes here */
+	/* Platform specific code during sdio probe slot goes here */
 
 	return 0;
 }
@@ -195,7 +195,7 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
 
 	host = c->host;
 
-	/* Platform specific code during emmc proble slot goes here */
+	/* Platform specific code during sd probe slot goes here */
 
 	return 0;
 }
-- 
2.1.4

