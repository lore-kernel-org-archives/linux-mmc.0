From: Yunpeng Gao <yunpeng.gao@intel.com>
Subject: [PATCH] mmc: sdhci: enable runtime pm for Intel Merrifield platform
Date: Mon, 18 Aug 2014 15:05:52 +0800
Message-ID: <1408345552-24029-1-git-send-email-yunpeng.gao@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:7443 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561AbaHRHEG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Aug 2014 03:04:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Yunpeng Gao <yunpeng.gao@intel.com>

Enable runtime pm support on Intel Merrifield platform.

Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
---
 drivers/mmc/host/sdhci-pci.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 52c42fc..1b50a4a 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -313,6 +313,7 @@ static int intel_mrfl_mmc_probe_slot(struct sdhci_pci_slot *slot)
 static const struct sdhci_pci_fixes sdhci_intel_mrfl_mmc = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2	= SDHCI_QUIRK2_BROKEN_HS200,
+	.allow_runtime_pm = true,
 	.probe_slot	= intel_mrfl_mmc_probe_slot,
 };
 
-- 
1.7.9.5

