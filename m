From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/4] mmc: sdhci-pci: Add SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC to BYT
Date: Mon,  1 Dec 2014 15:51:16 +0200
Message-ID: <1417441879-28058-2-git-send-email-adrian.hunter@intel.com>
References: <1417441879-28058-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:35203 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753585AbaLANw6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 1 Dec 2014 08:52:58 -0500
In-Reply-To: <1417441879-28058-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC actually causes
standard-compliant behaviour by causing the flagging
of the last DMA transfer descriptor as the end
instead of there being an additional nop descriptor
which is flagged as the end.  Consequently, it is
better to have the quirk.  Add it for BYT.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index c1ecd20..632e9d9 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -294,11 +294,13 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
 	.allow_runtime_pm = true,
 	.probe_slot	= byt_emmc_probe_slot,
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2	= SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 			  SDHCI_QUIRK2_STOP_WITH_TC,
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2	= SDHCI_QUIRK2_HOST_OFF_CARD_ON |
 			SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.allow_runtime_pm = true,
@@ -306,6 +308,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2	= SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
 			  SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 			  SDHCI_QUIRK2_STOP_WITH_TC,
-- 
1.9.1

