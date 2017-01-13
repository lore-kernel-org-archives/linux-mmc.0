From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3] mmc: sdhci-acpi: support deferred probe
Date: Fri, 13 Jan 2017 19:03:35 +0800
Message-ID: <1484305415.2221.45.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57654 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751529AbdAMLDl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 13 Jan 2017 06:03:41 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: cja@gmx.net, darcari@redhat.com, ulf.hansson@linaro.org, adrain <adrian.hunter@intel.com>

>From c889f737322b797b743c63eda241d0283696d3f5 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Wed, 7 Dec 2016 13:13:31 +0800
Subject: [PATCH v3] mmc: sdhci-acpi: support deferred probe

With commit 67bf5156edc4 ("gpio / ACPI: fix returned error from
acpi_dev_gpio_irq_get()"), mmc_gpiod_request_cd() returns -EPROBE_DEFER if
GPIO is not ready when sdhci-acpi driver is probed, and sdhci-acpi driver
should be probed again later in this case.

This fixes an order issue when both GPIO and sdhci-acpi drivers are built
as modules.

CC: stable@vger.kernel.org # v4.9
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=177101
Tested-by: Jonas Aaberg <cja@gmx.net>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 160f695cc09c..5440323894ee 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -466,7 +466,10 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	if (sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD)) {
 		bool v = sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD_OVERRIDE_LEVEL);
 
-		if (mmc_gpiod_request_cd(host->mmc, NULL, 0, v, 0, NULL)) {
+		err = mmc_gpiod_request_cd(host->mmc, NULL, 0, v, 0, NULL);
+		if (err) {
+			if (err == -EPROBE_DEFER)
+				goto err_free;
 			dev_warn(dev, "failed to setup card detect gpio\n");
 			c->use_runtime_pm = false;
 		}
-- 
2.7.4

