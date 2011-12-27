From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V4 7/7] mmc: sdhci-pci: enable runtime PM for Medfield SDIO
Date: Tue, 27 Dec 2011 15:48:47 +0200
Message-ID: <1324993727-7508-8-git-send-email-adrian.hunter@intel.com>
References: <1324993727-7508-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49580 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753958Ab1L0NtH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 27 Dec 2011 08:49:07 -0500
In-Reply-To: <1324993727-7508-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Runtime PM for SDIO is no longer enabled by default
(see 5c7f0e083d2d98ba14ddd10e88f001a0ead4cae4) so
it must now be enabled per platform, in this case
Medfield uses it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 83a152e..7165e6a 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -248,6 +248,12 @@ static int mfd_emmc_probe_slot(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
+static int mfd_sdio_probe_slot(struct sdhci_pci_slot *slot)
+{
+	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD;
+	return 0;
+}
+
 static const struct sdhci_pci_fixes sdhci_intel_mrst_hc0 = {
 	.quirks		= SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_NO_HISPD_BIT,
 	.probe_slot	= mrst_hc_probe_slot,
@@ -266,6 +272,7 @@ static const struct sdhci_pci_fixes sdhci_intel_mfd_sd = {
 static const struct sdhci_pci_fixes sdhci_intel_mfd_sdio = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.allow_runtime_pm = true,
+	.probe_slot	= mfd_sdio_probe_slot,
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_mfd_emmc = {
-- 
1.7.6.4

