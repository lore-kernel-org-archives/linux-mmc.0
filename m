From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 3/3] sdhci: Add Moorestown devices
Date: Mon, 04 Oct 2010 15:07:24 +0100
Message-ID: <20101004140721.14608.79483.stgit@localhost.localdomain>
References: <20101004140454.14608.70665.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:46815 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756275Ab0JDPrh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Oct 2010 11:47:37 -0400
Received: from localhost.localdomain (earthlight.etchedpixels.co.uk [81.2.110.250])
	by lxorguk.ukuu.org.uk (8.14.4/8.14.1) with ESMTP id o94EPoru024147
	for <linux-mmc@vger.kernel.org>; Mon, 4 Oct 2010 15:25:55 +0100
In-Reply-To: <20101004140454.14608.70665.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

This adds the basic identifiers. Due to the various chip quirks it's not
enough to make MRST support very useful for earlier steppings but that can
follow.

(I'm currently trying to verify which steps actually matter outside Intel
 so I can avoid unneeded stuff going upstream)

[Extracted from original development]
Signed-off-by: JiebingLi <jiebing.li@intel.com>
[Folds in fixes]
Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/host/sdhci-pci.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)


diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index ec4b81d..789dbff 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -145,6 +145,31 @@ static const struct sdhci_pci_fixes sdhci_cafe = {
 			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
 };
 
+/*
+ * ADMA operation is disabled for Moorestown platform due to
+ * hardware bugs.
+ */
+static int mrst_hc1_probe(struct sdhci_pci_chip *chip)
+{
+	/*
+	 * slots number is fixed here for MRST as SDIO3 is never used and has
+	 * hardware bugs.
+	 */
+	chip->num_slots = 1;
+	return 0;
+}
+
+static const struct sdhci_pci_fixes sdhci_intel_mrst_hc0 = {
+	.quirks		= SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_NO_HISPD_BIT,
+	.host_ops	= &sdhci_intel_mrst_hc,
+};
+
+static const struct sdhci_pci_fixes sdhci_intel_mrst_hc1 = {
+	.quirks		= SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_NO_HISPD_BIT,
+	.host_ops	= &sdhci_intel_mrst_hc,
+	.probe		= mrst_hc1_probe,
+};
+
 static const struct sdhci_pci_fixes sdhci_intel_mfd_sd = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 };
@@ -504,6 +529,22 @@ static const struct pci_device_id pci_ids[] __devinitdata = {
 
 	{
 		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_MRST_SD0,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_mrst_hc0,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_MRST_SD1,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_mrst_hc1,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_MFD_SD,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,

