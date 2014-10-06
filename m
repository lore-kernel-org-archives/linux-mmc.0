From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/3] mmc: sdhci-acpi: Pass HID and UID to probe_slot
Date: Mon,  6 Oct 2014 15:23:06 +0300
Message-ID: <1412598187-5263-3-git-send-email-adrian.hunter@intel.com>
References: <1412598187-5263-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:60429 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795AbaJFMY5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 Oct 2014 08:24:57 -0400
In-Reply-To: <1412598187-5263-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Pass HID and UID to probe_slot so extra setup
can be done for specific ids.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 839f26c..7548261 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -67,7 +67,7 @@ struct sdhci_acpi_slot {
 	unsigned int	caps2;
 	mmc_pm_flag_t	pm_caps;
 	unsigned int	flags;
-	int (*probe_slot)(struct platform_device *);
+	int (*probe_slot)(struct platform_device *, const char *, const char *);
 	int (*remove_slot)(struct platform_device *);
 };
 
@@ -124,7 +124,8 @@ static const struct sdhci_acpi_chip sdhci_acpi_chip_int = {
 	.ops = &sdhci_acpi_ops_int,
 };
 
-static int sdhci_acpi_emmc_probe_slot(struct platform_device *pdev)
+static int sdhci_acpi_emmc_probe_slot(struct platform_device *pdev,
+				      const char *hid, const char *uid)
 {
 	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
 	struct sdhci_host *host;
@@ -139,7 +140,8 @@ static int sdhci_acpi_emmc_probe_slot(struct platform_device *pdev)
 	return 0;
 }
 
-static int sdhci_acpi_sdio_probe_slot(struct platform_device *pdev)
+static int sdhci_acpi_sdio_probe_slot(struct platform_device *pdev,
+				      const char *hid, const char *uid)
 {
 	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
 	struct sdhci_host *host;
@@ -154,7 +156,8 @@ static int sdhci_acpi_sdio_probe_slot(struct platform_device *pdev)
 	return 0;
 }
 
-static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev)
+static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
+				    const char *hid, const char *uid)
 {
 	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
 	struct sdhci_host *host;
@@ -314,7 +317,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 
 	if (c->slot) {
 		if (c->slot->probe_slot) {
-			err = c->slot->probe_slot(pdev);
+			err = c->slot->probe_slot(pdev, hid, uid);
 			if (err)
 				goto err_free;
 		}
-- 
1.9.1

