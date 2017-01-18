From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V4] mmc: sdhci-acpi: support deferred probe
Date: Wed, 18 Jan 2017 17:46:18 +0800
Message-ID: <1484732778-14108-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:15146 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752253AbdARJq2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Jan 2017 04:46:28 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: adrian.hunter@intel.com, cja@gmx.net, darcari@redhat.com, ulf.hansson@linaro.org

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
index 160f695..5440323 100644
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

