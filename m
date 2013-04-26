From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/3] mmc: sdhci-acpi: fix initial runtime pm status
Date: Fri, 26 Apr 2013 11:27:21 +0300
Message-ID: <1366964843-20413-2-git-send-email-adrian.hunter@intel.com>
References: <1366964843-20413-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23525 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758896Ab3DZIXG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 26 Apr 2013 04:23:06 -0400
In-Reply-To: <1366964843-20413-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Initial runtime pm status is active.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 7bcf74b..1da5f29 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -202,6 +202,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 		goto err_free;
 
 	if (c->use_runtime_pm) {
+		pm_runtime_set_active(dev);
 		pm_suspend_ignore_children(dev, 1);
 		pm_runtime_set_autosuspend_delay(dev, 50);
 		pm_runtime_use_autosuspend(dev);
-- 
1.7.11.7

