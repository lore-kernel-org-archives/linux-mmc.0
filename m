From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 4/7] mmc: sdhci-pci: Set SDHCI_QUIRK2_STOP_WITH_TC for Intel BYT host controllers
Date: Wed, 24 Sep 2014 10:27:30 +0300
Message-ID: <1411543653-3728-5-git-send-email-adrian.hunter@intel.com>
References: <1411543653-3728-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49230 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520AbaIXHiL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 24 Sep 2014 03:38:11 -0400
In-Reply-To: <1411543653-3728-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Add quirk SDHCI_QUIRK2_STOP_WITH_TC for Intel BYT host controllers.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 580073b..31181d8 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -283,7 +283,8 @@ static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
 	.allow_runtime_pm = true,
 	.probe_slot	= byt_emmc_probe_slot,
-	.quirks2	= SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2	= SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			  SDHCI_QUIRK2_STOP_WITH_TC,
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
@@ -295,7 +296,8 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
 
 static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
 	.quirks2	= SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
-			SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+			  SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			  SDHCI_QUIRK2_STOP_WITH_TC,
 	.allow_runtime_pm = true,
 	.own_cd_for_runtime_pm = true,
 };
-- 
1.8.3.2

