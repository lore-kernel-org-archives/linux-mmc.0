From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: sdhci-acpi: remove unused struct sdhci_host variable
Date: Fri, 21 Jul 2017 09:19:50 +0800
Message-ID: <1500599990-170932-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:48791 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964950AbdGUBUa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Jul 2017 21:20:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

It was never used and introduce a warning

drivers/mmc/host/sdhci-acpi.c: In function 'sdhci_acpi_sdio_probe_slot':
drivers/mmc/host/sdhci-acpi.c:297:21: warning: variable 'host' set but
not used [-Wunused-but-set-variable]

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-acpi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index ac678e9..2b1df88 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -294,13 +294,10 @@ static int sdhci_acpi_sdio_probe_slot(struct platform_device *pdev,
 				      const char *hid, const char *uid)
 {
 	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
-	struct sdhci_host *host;
 
 	if (!c || !c->host)
 		return 0;
 
-	host = c->host;
-
 	/* Platform specific code during sdio probe slot goes here */
 
 	return 0;
-- 
1.9.1


