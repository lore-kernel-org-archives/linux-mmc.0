From: Matthias Kraemer <matthiasmartinsson@gmail.com>
Subject: [PATCH] mmc: sdhci-pci: Use macros in pci_ids definition
Date: Thu,  4 May 2017 20:55:58 +0200
Message-ID: <1493924158-2577-2-git-send-email-matthiasmartinsson@gmail.com>
References: <1493924158-2577-1-git-send-email-matthiasmartinsson@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35099 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752210AbdEDS4Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 May 2017 14:56:24 -0400
Received: by mail-wr0-f194.google.com with SMTP id g12so2315055wrg.2
        for <linux-mmc@vger.kernel.org>; Thu, 04 May 2017 11:56:23 -0700 (PDT)
In-Reply-To: <1493924158-2577-1-git-send-email-matthiasmartinsson@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: Matthias Kraemer <matthiasmartinsson@gmail.com>

This patch applies the PCI_DEVICE_ macros to specify the pci_ids instead
of open-coding them within the sdhci-pci driver.

v2,v3:
Suggested-by Adrian Hunter <adrian.hunter@intel.com>
Instead of using the generic PCI_ marcos, introduce device specific macros
to be able to shorten the table entries even further.

v4:
Fix compile-time issue

Signed-off-by: Matthias Kraemer <matthiasmartinsson@gmail.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 619 +++++---------------------------------
 drivers/mmc/host/sdhci-pci.h      |  41 ++-
 2 files changed, 111 insertions(+), 549 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 86560d5..d2b6115 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -992,554 +992,77 @@ static const struct sdhci_pci_fixes sdhci_amd = {
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
+	{SDHCI_PCI_DEVICE(RICOH, RICOH_R5C822, ricoh)},
+	{SDHCI_PCI_DEVICE(RICOH, RICOH_0x843, ricoh_mmc)},
+	{SDHCI_PCI_DEVICE(RICOH, RICOH_0xe822, ricoh_mmc)},
+	{SDHCI_PCI_DEVICE(RICOH, RICOH_0xe823, ricoh_mmc)},
+	{SDHCI_PCI_DEVICE(ENE, ENE_CB712_SD, ene_712)},
+	{SDHCI_PCI_DEVICE(ENE, ENE_CB712_SD_2, ene_712)},
+	{SDHCI_PCI_DEVICE(ENE, ENE_CB714_SD, ene_714)},
+	{SDHCI_PCI_DEVICE(ENE, ENE_CB714_SD_2, ene_714)},
+	{SDHCI_PCI_DEVICE(MARVELL, MARVELL_88ALP01_SD, cafe)},
+	{SDHCI_PCI_DEVICE(JMICRON, JMICRON_JMB38X_SD, jmicron)},
+	{SDHCI_PCI_DEVICE(JMICRON, JMICRON_JMB38X_MMC, jmicron)},
+	{SDHCI_PCI_DEVICE(JMICRON, JMICRON_JMB388_SD, jmicron)},
+	{SDHCI_PCI_DEVICE(JMICRON, JMICRON_JMB388_ESD, jmicron)},
+	{SDHCI_PCI_DEVICE(SYSKONNECT, SYSKONNECT_0x8000, syskt)},
+	{SDHCI_PCI_DEVICE(VIA, VIA_0x95d0, via)},
+	{SDHCI_PCI_DEVICE(REALTEK, REALTEK_0x5250, rtsx)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_QRK_SD, intel_qrk)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_MRST_SD0, intel_mrst_hc0)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_MRST_SD1, intel_mrst_hc1_hc2)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_MRST_SD2, intel_mrst_hc1_hc2)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_MFD_SD, intel_mfd_sd)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_MFD_SDIO1, intel_mfd_sdio)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_MFD_SDIO2, intel_mfd_sdio)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_MFD_EMMC0, intel_mfd_emmc)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_MFD_EMMC1, intel_mfd_emmc)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_PCH_SDIO0, intel_pch_sdio)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_PCH_SDIO1, intel_pch_sdio)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_BYT_EMMC, intel_byt_emmc)},
+	{SDHCI_PCI_DEVICE_SUB(INTEL, INTEL_BYT_SDIO, NI, INTEL_SUB_0x7884,
+			      ni_byt_sdio)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_BYT_SDIO, intel_byt_sdio)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_BYT_SD, intel_byt_sd)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_BYT_EMMC2, intel_byt_emmc)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_BSW_EMMC, intel_byt_emmc)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_BSW_SDIO, intel_byt_sdio)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_BSW_SD, intel_byt_sd)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_CLV_SDIO0, intel_mfd_sd)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_CLV_SDIO1, intel_mfd_sdio)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_CLV_SDIO2, intel_mfd_sdio)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_CLV_EMMC0, intel_mfd_emmc)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_CLV_EMMC1, intel_mfd_emmc)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_MRFLD_MMC, intel_mrfld_mmc)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_SPT_EMMC, intel_byt_emmc)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_SPT_SDIO, intel_byt_sdio)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_SPT_SD, intel_byt_sd)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_DNV_EMMC, intel_byt_emmc)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_BXT_EMMC, intel_byt_emmc)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_BXT_SDIO, intel_byt_sdio)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_BXT_SD, intel_byt_sd)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_BXTM_EMMC, intel_byt_emmc)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_BXTM_SDIO, intel_byt_sdio)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_BXTM_SD, intel_byt_sd)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_APL_EMMC, intel_byt_emmc)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_APL_SDIO, intel_byt_sdio)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_APL_SD, intel_byt_sd)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_GLK_EMMC, intel_byt_emmc)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_GLK_SDIO, intel_byt_sdio)},
+	{SDHCI_PCI_DEVICE(INTEL, INTEL_GLK_SD, intel_byt_sd)},
+	{SDHCI_PCI_DEVICE(O2, O2_8120, o2)},
+	{SDHCI_PCI_DEVICE(O2, O2_8220, o2)},
+	{SDHCI_PCI_DEVICE(O2, O2_8221, o2)},
+	{SDHCI_PCI_DEVICE(O2, O2_8320, o2)},
+	{SDHCI_PCI_DEVICE(O2, O2_8321, o2)},
+	{SDHCI_PCI_DEVICE(O2, O2_FUJIN2, o2)},
+	{SDHCI_PCI_DEVICE(O2, O2_SDS0, o2)},
+	{SDHCI_PCI_DEVICE(O2, O2_SDS1, o2)},
+	{SDHCI_PCI_DEVICE(O2, O2_SEABIRD0, o2)},
+	{SDHCI_PCI_DEVICE(O2, O2_SEABIRD1, o2)},
+	{SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd)},
+	/* Generic SD host controller */
+	{PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
 	{ /* end: all zeroes */ },
 };
 
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 36f7434..b3485cc 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -2,7 +2,7 @@
 #define __SDHCI_PCI_H
 
 /*
- * PCI device IDs
+ * PCI device IDs, sub IDs
  */
 
 #define PCI_DEVICE_ID_INTEL_PCH_SDIO0	0x8809
@@ -38,6 +38,45 @@
 #define PCI_DEVICE_ID_INTEL_GLK_EMMC	0x31cc
 #define PCI_DEVICE_ID_INTEL_GLK_SDIO	0x31d0
 
+#define PCI_DEVICE_ID_RICOH_0x843	0x843
+#define PCI_DEVICE_ID_RICOH_0xe822	0xe822
+#define PCI_DEVICE_ID_RICOH_0xe823	0xe823
+#define PCI_DEVICE_ID_SYSKONNECT_0x8000	0x8000
+#define PCI_DEVICE_ID_VIA_0x95d0	0x95d0
+#define PCI_DEVICE_ID_REALTEK_0x5250	0x5250
+
+#define PCI_DEVICE_ID_INTEL_SUB_0x7884	0x7884
+
+/*
+ * PCI device class and mask
+ */
+
+#define SYSTEM_SDHCI			(PCI_CLASS_SYSTEM_SDHCI << 8)
+#define PCI_CLASS_MASK			0xFFFF00
+
+/*
+ * Macros for PCI device-description
+ */
+
+#define _PCI_VEND(vend) PCI_VENDOR_ID_##vend
+#define _PCI_DEV(dev) PCI_DEVICE_ID_##dev
+
+#define SDHCI_PCI_DEVICE(vend, dev, cfg) \
+	.vendor = _PCI_VEND(vend), .device = _PCI_DEV(dev), \
+	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, \
+	.driver_data = (kernel_ulong_t)&(sdhci_##cfg)
+
+#define SDHCI_PCI_DEVICE_SUB(vend, dev, subvend, subdev, cfg) \
+	.vendor = _PCI_VEND(vend), .device = _PCI_DEV(dev), \
+	.subvendor = _PCI_VEND(subvend), .subdevice = _PCI_DEV(subdev), \
+	.driver_data = (kernel_ulong_t)&(sdhci_##cfg)
+
+#define SDHCI_PCI_DEVICE_CLASS(vend, cl, cl_msk, cfg) \
+	.vendor = _PCI_VEND(vend), .device = PCI_ANY_ID, \
+	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, \
+	.class = (cl), .class_mask = (cl_msk), \
+	.driver_data = (kernel_ulong_t)&(sdhci_##cfg)
+
 /*
  * PCI registers
  */
-- 
2.7.4

