From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 11/11] mmc: sdhci-pci: Enable HS400 for some Intel host controllers
Date: Fri,  6 Feb 2015 14:13:01 +0200
Message-ID: <1423224781-27076-12-git-send-email-adrian.hunter@intel.com>
References: <1423224781-27076-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3058 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756606AbbBFMPN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 6 Feb 2015 07:15:13 -0500
In-Reply-To: <1423224781-27076-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>

Enable detection of HS400 support via capability bit-63
for some Intel host controllers.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index d778a81..5a5b5e9 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -370,6 +370,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
 	.probe_slot	= byt_emmc_probe_slot,
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2	= SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			  SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 |
 			  SDHCI_QUIRK2_STOP_WITH_TC,
 };
 
-- 
1.9.1

