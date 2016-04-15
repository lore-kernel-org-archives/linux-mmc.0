From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/1] mmc: sdhci-acpi: Reduce Baytrail eMMC/SD/SDIO hangs
Date: Fri, 15 Apr 2016 14:06:57 +0300
Message-ID: <1460718417-20920-2-git-send-email-adrian.hunter@intel.com>
References: <1460718417-20920-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:31269 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180AbcDOLLA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 15 Apr 2016 07:11:00 -0400
In-Reply-To: <1460718417-20920-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Baytrail eMMC/SD/SDIO host controllers have been known to
hang.  A change to a hardware setting has been found to
reduce the occurrence of such hangs.  This patch ensures
the correct setting.

This patch applies cleanly to v4.4+.  It could go to
earlier kernels also, so I will send backports to the
stable list in due course.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v4.4+
---
 drivers/mmc/host/Kconfig      |  1 +
 drivers/mmc/host/sdhci-acpi.c | 81 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 04feea8354cb..e657af0e95fa 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -97,6 +97,7 @@ config MMC_RICOH_MMC
 config MMC_SDHCI_ACPI
 	tristate "SDHCI support for ACPI enumerated SDHCI controllers"
 	depends on MMC_SDHCI && ACPI
+	select IOSF_MBI if X86
 	help
 	  This selects support for ACPI enumerated SDHCI controllers,
 	  identified by ACPI Compatibility ID PNP0D40 or specific
diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 6106354c6c17..b2d70ba6caa7 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -41,6 +41,11 @@
 #include <linux/mmc/pm.h>
 #include <linux/mmc/slot-gpio.h>
 
+#ifdef CONFIG_X86
+#include <asm/cpu_device_id.h>
+#include <asm/iosf_mbi.h>
+#endif
+
 #include "sdhci.h"
 
 enum {
@@ -116,6 +121,75 @@ static const struct sdhci_acpi_chip sdhci_acpi_chip_int = {
 	.ops = &sdhci_acpi_ops_int,
 };
 
+#ifdef CONFIG_X86
+
+static bool sdhci_acpi_byt(void)
+{
+	static const struct x86_cpu_id byt[] = {
+		{ X86_VENDOR_INTEL, 6, 0x37 },
+		{}
+	};
+
+	return x86_match_cpu(byt);
+}
+
+#define BYT_IOSF_SCCEP			0x63
+#define BYT_IOSF_OCP_NETCTRL0		0x1078
+#define BYT_IOSF_OCP_TIMEOUT_BASE	GENMASK(10, 8)
+
+static void sdhci_acpi_byt_setting(struct device *dev)
+{
+	u32 val = 0;
+
+	if (!sdhci_acpi_byt())
+		return;
+
+	if (iosf_mbi_read(BYT_IOSF_SCCEP, MBI_CR_READ, BYT_IOSF_OCP_NETCTRL0,
+			  &val)) {
+		dev_err(dev, "%s read error\n", __func__);
+		return;
+	}
+
+	if (!(val & BYT_IOSF_OCP_TIMEOUT_BASE))
+		return;
+
+	val &= ~BYT_IOSF_OCP_TIMEOUT_BASE;
+
+	if (iosf_mbi_write(BYT_IOSF_SCCEP, MBI_CR_WRITE, BYT_IOSF_OCP_NETCTRL0,
+			   val)) {
+		dev_err(dev, "%s write error\n", __func__);
+		return;
+	}
+
+	dev_dbg(dev, "%s completed\n", __func__);
+}
+
+static bool sdhci_acpi_byt_defer(struct device *dev)
+{
+	if (!sdhci_acpi_byt())
+		return false;
+
+	if (!iosf_mbi_available())
+		return true;
+
+	sdhci_acpi_byt_setting(dev);
+
+	return false;
+}
+
+#else
+
+static inline void sdhci_acpi_byt_setting(struct device *dev)
+{
+}
+
+static inline bool sdhci_acpi_byt_defer(struct device *dev)
+{
+	return false;
+}
+
+#endif
+
 static int bxt_get_cd(struct mmc_host *mmc)
 {
 	int gpio_cd = mmc_gpio_get_cd(mmc);
@@ -319,6 +393,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	if (acpi_bus_get_status(device) || !device->status.present)
 		return -ENODEV;
 
+	if (sdhci_acpi_byt_defer(dev))
+		return -EPROBE_DEFER;
+
 	hid = acpi_device_hid(device);
 	uid = device->pnp.unique_id;
 
@@ -444,6 +521,8 @@ static int sdhci_acpi_resume(struct device *dev)
 {
 	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
 
+	sdhci_acpi_byt_setting(&c->pdev->dev);
+
 	return sdhci_resume_host(c->host);
 }
 
@@ -467,6 +546,8 @@ static int sdhci_acpi_runtime_resume(struct device *dev)
 {
 	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
 
+	sdhci_acpi_byt_setting(&c->pdev->dev);
+
 	return sdhci_runtime_resume_host(c->host);
 }
 
-- 
1.9.1

