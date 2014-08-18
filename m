From: Yunpeng Gao <yunpeng.gao@intel.com>
Subject: [PATCH] mmc: sdhci-pci: disable preset register for Baytrail and Merrifield
Date: Mon, 18 Aug 2014 15:32:09 +0800
Message-ID: <1408347129-733-1-git-send-email-yunpeng.gao@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24198 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbaHRHaY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Aug 2014 03:30:24 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Yunpeng Gao <yunpeng.gao@intel.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>

Due to HW issue, SDHCI host controller on Intel
Baytrail/Merrifield platforms can not use preset
register. So, disable preset registers for them by quirks.

Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/host/sdhci-pci.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 52c42fc..98187ae 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -277,18 +277,21 @@ static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 }
 
 static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
+	.quirks2	= SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.allow_runtime_pm = true,
 	.probe_slot	= byt_emmc_probe_slot,
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
-	.quirks2	= SDHCI_QUIRK2_HOST_OFF_CARD_ON,
+	.quirks2	= SDHCI_QUIRK2_HOST_OFF_CARD_ON |
+			SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.allow_runtime_pm = true,
 	.probe_slot	= byt_sdio_probe_slot,
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
-	.quirks2	= SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON,
+	.quirks2	= SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
+			SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.allow_runtime_pm = true,
 	.own_cd_for_runtime_pm = true,
 };
@@ -312,7 +315,8 @@ static int intel_mrfl_mmc_probe_slot(struct sdhci_pci_slot *slot)
 
 static const struct sdhci_pci_fixes sdhci_intel_mrfl_mmc = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
-	.quirks2	= SDHCI_QUIRK2_BROKEN_HS200,
+	.quirks2	= SDHCI_QUIRK2_BROKEN_HS200 |
+			SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.probe_slot	= intel_mrfl_mmc_probe_slot,
 };
 
-- 
1.7.9.5

