From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 12/12] mmc: sdhci-pci: Enable HS400 for some Intel host controllers
Date: Thu,  5 Feb 2015 15:13:49 +0200
Message-ID: <1423142029-22521-13-git-send-email-adrian.hunter@intel.com>
References: <1423142029-22521-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7345 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752989AbbBENSL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Feb 2015 08:18:11 -0500
In-Reply-To: <1423142029-22521-1-git-send-email-adrian.hunter@intel.com>
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
index 580f5df..1409fe1 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -378,6 +378,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
 	.probe_slot	= byt_emmc_probe_slot,
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2	= SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			  SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 |
 			  SDHCI_QUIRK2_STOP_WITH_TC,
 };
 
-- 
1.9.1

