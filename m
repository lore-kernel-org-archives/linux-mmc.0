From: Matthias Kraemer <matthiasmartinsson@gmail.com>
Subject: [PATCH] mmc: sdhci-pci: Use macros in pci_ids definition
Date: Wed, 12 Apr 2017 22:37:17 +0200
Message-ID: <1492029437-19455-2-git-send-email-matthiasmartinsson@gmail.com>
References: <1492029437-19455-1-git-send-email-matthiasmartinsson@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34534 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754805AbdDLUho (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Apr 2017 16:37:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id x75so8849074wma.1
        for <linux-mmc@vger.kernel.org>; Wed, 12 Apr 2017 13:37:43 -0700 (PDT)
In-Reply-To: <1492029437-19455-1-git-send-email-matthiasmartinsson@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Matthias Kraemer <matthiasmartinsson@gmail.com>

This patch applies the PCI_DEVICE_ macros to specify the pci_ids instead
of open-coding them within the sdhci-pci driver.

v2:
Suggested-by Adrian Hunter <adrian.hunter@intel.com>
Instead of using the generic PCI_ marcos, introduce device specific macros
to be able to shorten the table entries even further.

Signed-off-by: Matthias Kraemer <matthiasmartinsson@gmail.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 673 +++++++-------------------------------
 drivers/mmc/host/sdhci-pci.h      |  14 +
 2 files changed, 139 insertions(+), 548 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 86560d5..b5292b0 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -992,554 +992,131 @@ static const struct sdhci_pci_fixes sdhci_amd = {
 };
 
 static const struct pci_device_id pci_ids[] = {
-	{
-		.vendor		= PCI_VENDOR_ID_RICOH,
-		.device		= PCI_DEVICE_ID_RICOH_R5C822,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_ricoh,
-	},
-
-	{
-		.vendor         = PCI_VENDOR_ID_RICOH,
-		.device         = 0x843,
-		.subvendor      = PCI_ANY_ID,
-		.subdevice      = PCI_ANY_ID,
-		.driver_data    = (kernel_ulong_t)&sdhci_ricoh_mmc,
-	},
-
-	{
-		.vendor         = PCI_VENDOR_ID_RICOH,
-		.device         = 0xe822,
-		.subvendor      = PCI_ANY_ID,
-		.subdevice      = PCI_ANY_ID,
-		.driver_data    = (kernel_ulong_t)&sdhci_ricoh_mmc,
-	},
-
-	{
-		.vendor         = PCI_VENDOR_ID_RICOH,
-		.device         = 0xe823,
-		.subvendor      = PCI_ANY_ID,
-		.subdevice      = PCI_ANY_ID,
-		.driver_data    = (kernel_ulong_t)&sdhci_ricoh_mmc,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_ENE,
-		.device		= PCI_DEVICE_ID_ENE_CB712_SD,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_ene_712,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_ENE,
-		.device		= PCI_DEVICE_ID_ENE_CB712_SD_2,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_ene_712,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_ENE,
-		.device		= PCI_DEVICE_ID_ENE_CB714_SD,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_ene_714,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_ENE,
-		.device		= PCI_DEVICE_ID_ENE_CB714_SD_2,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_ene_714,
-	},
-
-	{
-		.vendor         = PCI_VENDOR_ID_MARVELL,
-		.device         = PCI_DEVICE_ID_MARVELL_88ALP01_SD,
-		.subvendor      = PCI_ANY_ID,
-		.subdevice      = PCI_ANY_ID,
-		.driver_data    = (kernel_ulong_t)&sdhci_cafe,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_JMICRON,
-		.device		= PCI_DEVICE_ID_JMICRON_JMB38X_SD,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_jmicron,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_JMICRON,
-		.device		= PCI_DEVICE_ID_JMICRON_JMB38X_MMC,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_jmicron,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_JMICRON,
-		.device		= PCI_DEVICE_ID_JMICRON_JMB388_SD,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_jmicron,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_JMICRON,
-		.device		= PCI_DEVICE_ID_JMICRON_JMB388_ESD,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_jmicron,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_SYSKONNECT,
-		.device		= 0x8000,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_syskt,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device		= 0x95d0,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_via,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_REALTEK,
-		.device		= 0x5250,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_rtsx,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_QRK_SD,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_qrk,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_MRST_SD0,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_mrst_hc0,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_MRST_SD1,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_mrst_hc1_hc2,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_MRST_SD2,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_mrst_hc1_hc2,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_MFD_SD,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_sd,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_MFD_SDIO1,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_sdio,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_MFD_SDIO2,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_sdio,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_MFD_EMMC0,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_emmc,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_MFD_EMMC1,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_emmc,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_PCH_SDIO0,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_pch_sdio,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_PCH_SDIO1,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_pch_sdio,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_BYT_EMMC,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_emmc,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_BYT_SDIO,
-		.subvendor	= PCI_VENDOR_ID_NI,
-		.subdevice	= 0x7884,
-		.driver_data	= (kernel_ulong_t)&sdhci_ni_byt_sdio,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_BYT_SDIO,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sdio,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_BYT_SD,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sd,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_BYT_EMMC2,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_emmc,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_BSW_EMMC,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_emmc,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_BSW_SDIO,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sdio,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_BSW_SD,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sd,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_CLV_SDIO0,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_sd,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_CLV_SDIO1,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_sdio,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_CLV_SDIO2,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_sdio,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_CLV_EMMC0,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_emmc,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_CLV_EMMC1,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_emmc,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_MRFLD_MMC,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_mrfld_mmc,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_SPT_EMMC,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_emmc,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_SPT_SDIO,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sdio,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_SPT_SD,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sd,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_DNV_EMMC,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_emmc,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_BXT_EMMC,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_emmc,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_BXT_SDIO,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sdio,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_BXT_SD,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sd,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_BXTM_EMMC,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_emmc,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_BXTM_SDIO,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sdio,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_BXTM_SD,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sd,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_APL_EMMC,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_emmc,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_APL_SDIO,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sdio,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_APL_SD,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sd,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_GLK_EMMC,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_emmc,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_GLK_SDIO,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sdio,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_GLK_SD,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sd,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_O2,
-		.device		= PCI_DEVICE_ID_O2_8120,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_o2,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_O2,
-		.device		= PCI_DEVICE_ID_O2_8220,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_o2,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_O2,
-		.device		= PCI_DEVICE_ID_O2_8221,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_o2,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_O2,
-		.device		= PCI_DEVICE_ID_O2_8320,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_o2,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_O2,
-		.device		= PCI_DEVICE_ID_O2_8321,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_o2,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_O2,
-		.device		= PCI_DEVICE_ID_O2_FUJIN2,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_o2,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_O2,
-		.device		= PCI_DEVICE_ID_O2_SDS0,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_o2,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_O2,
-		.device		= PCI_DEVICE_ID_O2_SDS1,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_o2,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_O2,
-		.device		= PCI_DEVICE_ID_O2_SEABIRD0,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_o2,
-	},
-
-	{
-		.vendor		= PCI_VENDOR_ID_O2,
-		.device		= PCI_DEVICE_ID_O2_SEABIRD1,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_o2,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_AMD,
-		.device		= PCI_ANY_ID,
-		.class		= PCI_CLASS_SYSTEM_SDHCI << 8,
-		.class_mask	= 0xFFFF00,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_amd,
-	},
-	{	/* Generic SD host controller */
-		PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8), 0xFFFF00)
-	},
-
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_R5C822,
+			  sdhci_ricoh)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_RICOH, 0x843, sdhci_ricoh_mmc)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_RICOH, 0xe822, sdhci_ricoh_mmc)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_RICOH, 0xe823, sdhci_ricoh_mmc)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_ENE, PCI_DEVICE_ID_ENE_CB712_SD,
+			  sdhci_ene_712)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_ENE, PCI_DEVICE_ID_ENE_CB712_SD_2,
+			  sdhci_ene_712)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_ENE, PCI_DEVICE_ID_ENE_CB714_SD,
+			  sdhci_ene_714)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_ENE, PCI_DEVICE_ID_ENE_CB714_SD_2,
+			  sdhci_ene_714)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_MARVELL,
+			  PCI_DEVICE_ID_MARVELL_88ALP01_SD, sdhci_cafe)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_JMICRON,
+			  PCI_DEVICE_ID_JMICRON_JMB38X_SD, sdhci_jmicron)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_JMICRON,
+			  PCI_DEVICE_ID_JMICRON_JMB38X_MMC, sdhci_jmicron)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_JMICRON,
+			  PCI_DEVICE_ID_JMICRON_JMB388_SD, sdhci_jmicron)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_JMICRON,
+			  PCI_DEVICE_ID_JMICRON_JMB388_ESD, sdhci_jmicron)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, 0x8000, sdhci_syskt)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_VIA, 0x95d0, sdhci_via)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x5250, sdhci_rtsx)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_QRK_SD,
+			  sdhci_intel_qrk)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MRST_SD0,
+			  sdhci_intel_mrst_hc0)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MRST_SD1,
+			  sdhci_intel_mrst_hc1_hc2)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MRST_SD2,
+			  sdhci_intel_mrst_hc1_hc2)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MFD_SD,
+			  sdhci_intel_mfd_sd)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MFD_SDIO1,
+			  sdhci_intel_mfd_sdio)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MFD_SDIO2,
+			  sdhci_intel_mfd_sdio)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MFD_EMMC0,
+			  sdhci_intel_mfd_emmc)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MFD_EMMC1,
+			  sdhci_intel_mfd_emmc)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PCH_SDIO0,
+			  sdhci_intel_pch_sdio)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PCH_SDIO1,
+			  sdhci_intel_pch_sdio)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BYT_EMMC,
+			  sdhci_intel_byt_emmc)},
+	{SDHCI_PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BYT_SDIO,
+			      PCI_VENDOR_ID_NI, 0x7884, sdhci_ni_byt_sdio)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BYT_SDIO,
+			  sdhci_intel_byt_sdio)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BYT_SD,
+			  sdhci_intel_byt_sd)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BYT_EMMC2,
+			  sdhci_intel_byt_emmc)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BSW_EMMC,
+			  sdhci_intel_byt_emmc)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BSW_SDIO,
+			  sdhci_intel_byt_sdio)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BSW_SD,
+			  sdhci_intel_byt_sd)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CLV_SDIO0,
+			  sdhci_intel_mfd_sd)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CLV_SDIO1,
+			  sdhci_intel_mfd_sdio)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CLV_SDIO2,
+			  sdhci_intel_mfd_sdio)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CLV_EMMC0,
+			  sdhci_intel_mfd_emmc)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CLV_EMMC1,
+			  sdhci_intel_mfd_emmc)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MRFLD_MMC,
+			  sdhci_intel_mrfld_mmc)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SPT_EMMC,
+			  sdhci_intel_byt_emmc)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SPT_SDIO,
+			  sdhci_intel_byt_sdio)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SPT_SD,
+			  sdhci_intel_byt_sd)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_DNV_EMMC,
+			  sdhci_intel_byt_emmc)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BXT_EMMC,
+			  sdhci_intel_byt_emmc)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BXT_SDIO,
+			  sdhci_intel_byt_sdio)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BXT_SD,
+			  sdhci_intel_byt_sd)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BXTM_EMMC,
+			  sdhci_intel_byt_emmc)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BXTM_SDIO,
+			  sdhci_intel_byt_sdio)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BXTM_SD,
+			  sdhci_intel_byt_sd)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_APL_EMMC,
+			  sdhci_intel_byt_emmc)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_APL_SDIO,
+			  sdhci_intel_byt_sdio)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_APL_SD,
+			  sdhci_intel_byt_sd)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_GLK_EMMC,
+			  sdhci_intel_byt_emmc)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_GLK_SDIO,
+			  sdhci_intel_byt_sdio)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_GLK_SD,
+			  sdhci_intel_byt_sd)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_8120, sdhci_o2)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_8220, sdhci_o2)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_8221, sdhci_o2)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_8320, sdhci_o2)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_8321, sdhci_o2)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_FUJIN2, sdhci_o2)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_SDS0, sdhci_o2)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_SDS1, sdhci_o2)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_SEABIRD0,
+			  sdhci_o2)},
+	{SDHCI_PCI_DEVICE(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_SEABIRD1,
+			  sdhci_o2)},
+	{SDHCI_PCI_DEVICE_CLASS(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
+				PCI_CLASS_SYSTEM_SDHCI << 8, 0xFFFF00,
+				sdhci_amd)},
+	/* Generic SD host controller */
+	{PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8), 0xFFFF00)},
 	{ /* end: all zeroes */ },
 };
 
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 36f7434..57a62b5 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -52,6 +52,20 @@
 
 #define MAX_SLOTS			8
 
+#define SDHCI_PCI_DEVICE(vend, dev, cfg) \
+	.vendor = (vend), .device = (dev), \
+	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, \
+	.driver_data = (kernel_ulong_t)&(cfg)
+
+#define SDHCI_PCI_DEVICE_SUB(vend, dev, subvend, subdev, cfg) \
+	.vendor = (vend), .device = (dev), \
+	.subvendor = (subvend), .subdevice = (subdev), \
+	.driver_data = (kernel_ulong_t)&(cfg)
+
+#define SDHCI_PCI_DEVICE_CLASS(vend, dev, cl, cl_msk, cfg) \
+	SDHCI_PCI_DEVICE(vend, dev, cfg), \
+	.class = (cl), .class_mask = (cl_msk)
+
 struct sdhci_pci_chip;
 struct sdhci_pci_slot;
 
-- 
2.7.4

