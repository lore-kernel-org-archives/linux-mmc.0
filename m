From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/3] mmc: sdhci-acpi: Fix Braswell eMMC timeout clock frequency
Date: Mon,  6 Oct 2014 15:23:07 +0300
Message-ID: <1412598187-5263-4-git-send-email-adrian.hunter@intel.com>
References: <1412598187-5263-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:60429 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160AbaJFMY6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 Oct 2014 08:24:58 -0400
In-Reply-To: <1412598187-5263-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Braswell eMMC host controller specifies an incorrect
timeout clock frequncy in the capabilities registers.
The correct value is 1 MHz.  A similar fix was done
for sdhci-pci, however in the sdhci-acpi case the
HID/UID is not unique so the capabilities register
values are matched also.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 7548261..9cccc0e 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -137,6 +137,11 @@ static int sdhci_acpi_emmc_probe_slot(struct platform_device *pdev,
 
 	/* Platform specific code during emmc proble slot goes here */
 
+	if (hid && uid && !strcmp(hid, "80860F14") && !strcmp(uid, "1") &&
+	    sdhci_readl(host, SDHCI_CAPABILITIES) == 0x446cc8b2 &&
+	    sdhci_readl(host, SDHCI_CAPABILITIES_1) == 0x00000807)
+		host->timeout_clk = 1000; /* 1000 kHz i.e. 1 MHz */
+
 	return 0;
 }
 
-- 
1.9.1

