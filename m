From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/5] mmc: sdhci-acpi: Set MMC_CAP_AGGRESSIVE_PM for Broxton controllers
Date: Tue, 12 Apr 2016 14:25:06 +0300
Message-ID: <1460460309-13619-3-git-send-email-adrian.hunter@intel.com>
References: <1460460309-13619-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:39057 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932652AbcDLL3I (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Apr 2016 07:29:08 -0400
In-Reply-To: <1460460309-13619-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Set MMC_CAP_AGGRESSIVE_PM for Broxton host controllers.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 1ed8ea6ff155..6106354c6c17 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -188,8 +188,10 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
 
 	/* Platform specific code during sd probe slot goes here */
 
-	if (hid && !strcmp(hid, "80865ACA"))
+	if (hid && !strcmp(hid, "80865ACA")) {
 		host->mmc_host_ops.get_cd = bxt_get_cd;
+		host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
+	}
 
 	return 0;
 }
-- 
1.9.1

