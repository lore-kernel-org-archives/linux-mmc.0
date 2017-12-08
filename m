From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/2] mmc: sdhci-acpi: Add setup_host() callback
Date: Fri,  8 Dec 2017 15:04:58 +0200
Message-ID: <1512738299-5650-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:41282 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753470AbdLHNFX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 8 Dec 2017 08:05:23 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Carlo Caione <carlo@endlessm.com>

Add a ->setup_host() callback so that device-specific changes can be made
to the mmc host controller before it is added.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 1b1ce804d2d7..f7445cf8f7dd 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -76,6 +76,7 @@ struct sdhci_acpi_slot {
 	size_t		priv_size;
 	int (*probe_slot)(struct platform_device *, const char *, const char *);
 	int (*remove_slot)(struct platform_device *);
+	int (*setup_host)(struct platform_device *pdev);
 };
 
 struct sdhci_acpi_host {
@@ -688,10 +689,20 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = sdhci_add_host(host);
+	err = sdhci_setup_host(host);
 	if (err)
 		goto err_free;
 
+	if (c->slot && c->slot->setup_host) {
+		err = c->slot->setup_host(pdev);
+		if (err)
+			goto err_cleanup;
+	}
+
+	err = __sdhci_add_host(host);
+	if (err)
+		goto err_cleanup;
+
 	if (c->use_runtime_pm) {
 		pm_runtime_set_active(dev);
 		pm_suspend_ignore_children(dev, 1);
@@ -704,6 +715,8 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_cleanup:
+	sdhci_cleanup_host(c->host);
 err_free:
 	sdhci_free_host(c->host);
 	return err;
-- 
1.9.1

