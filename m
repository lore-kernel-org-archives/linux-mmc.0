From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 39/39] mmc: sdhci-pci: Add CQHCI support for Intel GLK
Date: Fri, 10 Feb 2017 14:55:52 +0200
Message-ID: <1486731352-8018-40-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:56293 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751584AbdBJNLw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 08:11:52 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Add CQHCI initialization and implement CQHCI operations for Intel GLK.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/Kconfig          |   1 +
 drivers/mmc/host/sdhci-pci-core.c | 151 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index fceba81b8f37..d964681579b4 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -72,6 +72,7 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
 config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
 	depends on MMC_SDHCI && PCI
+	select MMC_CQHCI
 	help
 	  This selects the PCI Secure Digital Host Controller Interface.
 	  Most controllers found today are PCI devices.
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 5c98a7bb8ed6..f6d47cfc8ba5 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -29,6 +29,8 @@
 #include <linux/mmc/sdhci-pci-data.h>
 #include <linux/acpi.h>
 
+#include "cqhci.h"
+
 #include "sdhci.h"
 #include "sdhci-pci.h"
 #include "sdhci-pci-o2micro.h"
@@ -115,6 +117,28 @@ int sdhci_pci_resume_host(struct sdhci_pci_chip *chip)
 
 	return 0;
 }
+
+static int sdhci_cqhci_suspend(struct sdhci_pci_chip *chip)
+{
+	int ret;
+
+	ret = cqhci_suspend(chip->slots[0]->host->mmc);
+	if (ret)
+		return ret;
+
+	return sdhci_pci_suspend_host(chip);
+}
+
+static int sdhci_cqhci_resume(struct sdhci_pci_chip *chip)
+{
+	int ret;
+
+	ret = sdhci_pci_resume_host(chip);
+	if (ret)
+		return ret;
+
+	return cqhci_resume(chip->slots[0]->host->mmc);
+}
 #endif
 
 #ifdef CONFIG_PM
@@ -158,8 +182,54 @@ static int sdhci_pci_runtime_resume_host(struct sdhci_pci_chip *chip)
 
 	return 0;
 }
+
+static int sdhci_cqhci_runtime_suspend(struct sdhci_pci_chip *chip)
+{
+	int ret;
+
+	ret = cqhci_suspend(chip->slots[0]->host->mmc);
+	if (ret)
+		return ret;
+
+	return sdhci_pci_runtime_suspend_host(chip);
+}
+
+static int sdhci_cqhci_runtime_resume(struct sdhci_pci_chip *chip)
+{
+	int ret;
+
+	ret = sdhci_pci_runtime_resume_host(chip);
+	if (ret)
+		return ret;
+
+	return cqhci_resume(chip->slots[0]->host->mmc);
+}
 #endif
 
+static u32 sdhci_cqhci_irq(struct sdhci_host *host, u32 intmask)
+{
+	int cmd_error = 0;
+	int data_error = 0;
+
+	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
+		return intmask;
+
+	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
+
+	return 0;
+}
+
+static void sdhci_pci_dumpregs(struct mmc_host *mmc)
+{
+	sdhci_dumpregs(mmc_priv(mmc));
+}
+
+static const struct cqhci_host_ops sdhci_cqhci_ops = {
+	.enable		= sdhci_cqe_enable,
+	.disable	= sdhci_cqe_disable,
+	.dumpregs	= sdhci_pci_dumpregs,
+};
+
 /*****************************************************************************\
  *                                                                           *
  * Hardware specific quirk handling                                          *
@@ -521,6 +591,18 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 	.select_drive_strength	= sdhci_pci_select_drive_strength,
 };
 
+static const struct sdhci_ops sdhci_intel_glk_ops = {
+	.set_clock		= sdhci_set_clock,
+	.set_power		= sdhci_intel_set_power,
+	.enable_dma		= sdhci_pci_enable_dma,
+	.set_bus_width		= sdhci_pci_set_bus_width,
+	.reset			= sdhci_reset,
+	.set_uhs_signaling	= sdhci_set_uhs_signaling,
+	.hw_reset		= sdhci_pci_hw_reset,
+	.select_drive_strength	= sdhci_pci_select_drive_strength,
+	.irq			= sdhci_cqhci_irq,
+};
+
 static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 {
 	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
@@ -538,6 +620,54 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
+static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
+{
+	int ret = byt_emmc_probe_slot(slot);
+
+	slot->host->mmc->caps2 |= MMC_CAP2_CQE;
+
+	return ret;
+}
+
+static int glk_emmc_add_host(struct sdhci_pci_slot *slot)
+{
+	struct device *dev = &slot->chip->pdev->dev;
+	struct sdhci_host *host = slot->host;
+	struct cqhci_host *cq_host;
+	bool dma64;
+	int ret;
+
+	ret = sdhci_setup_host(host);
+	if (ret)
+		return ret;
+
+	cq_host = devm_kzalloc(dev, sizeof(*cq_host), GFP_KERNEL);
+	if (!cq_host) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	cq_host->mmio = host->ioaddr + 0x200;
+	cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
+	cq_host->quirks |= CQHCI_QUIRK_SHORT_TXFR_DESC_SZ;
+	cq_host->ops = &sdhci_cqhci_ops;
+
+	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
+	ret = cqhci_init(cq_host, host->mmc, dma64);
+	if (ret)
+		goto cleanup;
+
+	ret = __sdhci_add_host(host);
+	if (ret)
+		goto cleanup;
+
+	return 0;
+
+cleanup:
+	sdhci_cleanup_host(host);
+	return ret;
+}
+
 #ifdef CONFIG_ACPI
 static int ni_set_max_freq(struct sdhci_pci_slot *slot)
 {
@@ -609,6 +739,25 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 	.ops		= &sdhci_intel_byt_ops,
 };
 
+static const struct sdhci_pci_fixes sdhci_intel_glk_emmc = {
+	.allow_runtime_pm	= true,
+	.probe_slot		= glk_emmc_probe_slot,
+	.add_host		= glk_emmc_add_host,
+#ifdef CONFIG_PM_SLEEP
+	.suspend		= sdhci_cqhci_suspend,
+	.resume			= sdhci_cqhci_resume,
+#endif
+#ifdef CONFIG_PM
+	.runtime_suspend	= sdhci_cqhci_runtime_suspend,
+	.runtime_resume		= sdhci_cqhci_runtime_resume,
+#endif
+	.quirks			= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks2		= SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+				  SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 |
+				  SDHCI_QUIRK2_STOP_WITH_TC,
+	.ops			= &sdhci_intel_glk_ops,
+};
+
 static const struct sdhci_pci_fixes sdhci_ni_byt_sdio = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2	= SDHCI_QUIRK2_HOST_OFF_CARD_ON |
@@ -1560,7 +1709,7 @@ static int amd_probe(struct sdhci_pci_chip *chip)
 		.device		= PCI_DEVICE_ID_INTEL_GLK_EMMC,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_emmc,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_glk_emmc,
 	},
 
 	{
-- 
1.9.1

