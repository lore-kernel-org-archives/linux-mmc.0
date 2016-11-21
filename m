From: Zach Brown <zach.brown@ni.com>
Subject: [PATCH 1/2] mmc: sdhci-pci: Add PCI ID for Intel byt sdio host controller sub-vended by NI
Date: Mon, 21 Nov 2016 17:04:05 -0600
Message-ID: <1479769446-8490-2-git-send-email-zach.brown@ni.com>
References: <1479769446-8490-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:57389 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754790AbcKUXEJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 21 Nov 2016 18:04:09 -0500
In-Reply-To: <1479769446-8490-1-git-send-email-zach.brown@ni.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, zach.brown@ni.com

Add PCI ID for Intel byt sdio host controller sub-vended by NI.

The controller has different behavior because of the board layout NI
puts it on.

Signed-off-by: Zach Brown <zach.brown@ni.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 1d9e00a..9741505 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -375,6 +375,13 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
+static int ni_byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
+{
+	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE |
+				 MMC_CAP_WAIT_WHILE_BUSY;
+	return 0;
+}
+
 static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 {
 	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE |
@@ -447,6 +454,15 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
 	.ops		= &sdhci_intel_byt_ops,
 };
 
+static const struct sdhci_pci_fixes sdhci_ni_byt_sdio = {
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks2	= SDHCI_QUIRK2_HOST_OFF_CARD_ON |
+			  SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.allow_runtime_pm = true,
+	.probe_slot	= ni_byt_sdio_probe_slot,
+	.ops		= &sdhci_intel_byt_ops,
+};
+
 static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2	= SDHCI_QUIRK2_HOST_OFF_CARD_ON |
@@ -1079,6 +1095,14 @@ static const struct pci_device_id pci_ids[] = {
 	{
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_BYT_SDIO,
+		.subvendor	= PCI_VENDOR_ID_NI,
+		.subdevice	= 0x7884,
+		.driver_data	= (kernel_ulong_t)&sdhci_ni_byt_sdio,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_BYT_SDIO,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sdio,
-- 
2.7.4

