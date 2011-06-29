From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/2] mmc: sdhci-pci: add 8-bit bus width support for mrst hc0
Date: Wed, 29 Jun 2011 14:23:46 +0300
Message-ID: <1309346627-32630-2-git-send-email-adrian.hunter@intel.com>
References: <1309346627-32630-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64578 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755046Ab1F2LYB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2011 07:24:01 -0400
In-Reply-To: <1309346627-32630-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@marvell.com>, Major Lee <major_lee@wistron.com>, Alan Cox <alan@linux.intel.com>, Dirk Brandewie <dirk.brandewie@gmail.com>

From: Major Lee <major_lee@wistron.com>

And hook platform_8bit_width to support 8-bit bus width.

Signed-off-by: Major Lee <major_lee@wistron.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 drivers/mmc/host/sdhci-pci.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 936bbca..e1ae855 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -143,6 +143,12 @@ static const struct sdhci_pci_fixes sdhci_cafe = {
 			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
 };
 
+static int mrst_hc_probe_slot(struct sdhci_pci_slot *slot)
+{
+	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+	return 0;
+}
+
 /*
  * ADMA operation is disabled for Moorestown platform due to
  * hardware bugs.
@@ -159,6 +165,7 @@ static int mrst_hc_probe(struct sdhci_pci_chip *chip)
 
 static const struct sdhci_pci_fixes sdhci_intel_mrst_hc0 = {
 	.quirks		= SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_NO_HISPD_BIT,
+	.probe_slot	= mrst_hc_probe_slot,
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_mrst_hc1_hc2 = {
@@ -789,8 +796,34 @@ static int sdhci_pci_enable_dma(struct sdhci_host *host)
 	return 0;
 }
 
+static int sdhci_pci_8bit_width(struct sdhci_host *host, int width)
+{
+	u8 ctrl;
+
+	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+
+	switch (width) {
+	case MMC_BUS_WIDTH_8:
+		ctrl |= SDHCI_CTRL_8BITBUS;
+		ctrl &= ~SDHCI_CTRL_4BITBUS;
+		break;
+	case MMC_BUS_WIDTH_4:
+		ctrl |= SDHCI_CTRL_4BITBUS;
+		ctrl &= ~SDHCI_CTRL_8BITBUS;
+		break;
+	default:
+		ctrl &= ~(SDHCI_CTRL_8BITBUS | SDHCI_CTRL_4BITBUS);
+		break;
+	}
+
+	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+
+	return 0;
+}
+
 static struct sdhci_ops sdhci_pci_ops = {
 	.enable_dma	= sdhci_pci_enable_dma,
+	.platform_8bit_width	= sdhci_pci_8bit_width,
 };
 
 /*****************************************************************************\
-- 
1.7.4.4

