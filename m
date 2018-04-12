From: Prabu Thangamuthu <Prabu.T@synopsys.com>
Subject: [RESEND PATCH v4.9, 1/1] mmc: sdhci-dwc-mshc-pci: synopsys dwc mshc
 support
Date: Thu, 12 Apr 2018 15:47:10 +0000
Message-ID: <705D14B1C7978B40A723277C067CEDE2010A99DD80@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "prabu.t@synopsys.com" <prabu.t@synopsys.com>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

This patch is intended for linux-4.9.y branch.

Synopsys DWC MSHC IP is complaint to SD Standard Host Controller Interface
specification. This patch is to enable DWC MSHC controller on HPAS-DX
platform connected using PCIe interface.

As clock generation logic is implemented in MMCM block of HAPS-DX platform,
we need separate functions to control the MMCM module to generate required
clocks with respect to mode of operations. Also we have the platform
specific set_power function to support different VDD of eMMC devices.

Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>
---
 MAINTAINERS                           |   7 ++
 drivers/mmc/host/Makefile             |   3 +-
 drivers/mmc/host/sdhci-dwc-mshc-pci.c | 139
++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-dwc-mshc-pci.h |  44 +++++++++++
 drivers/mmc/host/sdhci-pci-core.c     |  25 ++++++
 5 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/host/sdhci-dwc-mshc-pci.c
 create mode 100644 drivers/mmc/host/sdhci-dwc-mshc-pci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 63cefa6..869b92b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10808,6 +10808,13 @@ S:    Maintained
 F:    drivers/mmc/host/sdhci*
 F:    include/linux/mmc/sdhci*
 
+SYNOPSYS SDHCI COMPLIANT DWC MSHC DRIVER
+M:    Prabu Thangamuthu <prabu.t@synopsys.com>
+M:    Manjunath M B <manjumb@synopsys.com>
+L:    linux-mmc@vger.kernel.org
+S:    Maintained
+F:    drivers/mmc/host/sdhci-dwc*
+
 SECURE COMPUTING
 M:    Kees Cook <keescook@chromium.org>
 R:    Andy Lutomirski <luto@amacapital.net>
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index e2bdaaf4..e83355f 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -9,7 +9,8 @@ obj-$(CONFIG_MMC_MXC)        += mxcmmc.o
 obj-$(CONFIG_MMC_MXS)        += mxs-mmc.o
 obj-$(CONFIG_MMC_SDHCI)        += sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)    += sdhci-pci.o
-sdhci-pci-y            += sdhci-pci-core.o sdhci-pci-o2micro.o
+sdhci-pci-y            += sdhci-pci-core.o sdhci-pci-o2micro.o \
+                   sdhci-dwc-mshc-pci.o
 obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))    += sdhci-pci-data.o
 obj-$(CONFIG_MMC_SDHCI_ACPI)    += sdhci-acpi.o
 obj-$(CONFIG_MMC_SDHCI_PXAV3)    += sdhci-pxav3.o
diff --git a/drivers/mmc/host/sdhci-dwc-mshc-pci.c
b/drivers/mmc/host/sdhci-dwc-mshc-pci.c
new file mode 100644
index 0000000..4721cc7
--- /dev/null
+++ b/drivers/mmc/host/sdhci-dwc-mshc-pci.c
@@ -0,0 +1,139 @@
+/*
+ * SDHCI driver for Synopsys DWC_MSHC controller
+ *
+ * Copyright (C) 2017-2018 Synopsys, Inc. (www.synopsys.com)
+ *
+ * Authors:
+ *    Prabu Thangamuthu <prabut@synopsys.com>
+ *    Manjunath M B <manjumb@synopsys.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#include "sdhci.h"
+#include "sdhci-pci.h"
+#include "sdhci-dwc-mshc-pci.h"
+
+#define DRIVER_NAME "sdhci_snps"
+
+/* Default emmc vdd is set to 1.8V */
+static unsigned int emmc_vdd = SDHC_EMMC_VDD_180V;
+module_param(emmc_vdd, int, 0444);
+
+void sdhci_snps_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+    u16 clk = 0;
+    u32 reg = 0;
+    u32 vendor_ptr = 0;
+
+    vendor_ptr = sdhci_readw(host, SDHCI_VENDOR_PTR_R);
+
+    /* Disable Software managed rx tuning */
+    reg = sdhci_readl(host, (SDHC_AT_CTRL_R + vendor_ptr));
+    reg &= ~SDHC_SW_TUNE_EN;
+    sdhci_writel(host, reg, (SDHC_AT_CTRL_R + vendor_ptr));
+
+    if (clock <= 52000000) {
+        sdhci_set_clock(host, clock);
+    } else {
+        /* Assert reset to MMCM */
+        reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
+        reg |= SDHC_CCLK_MMCM_RST;
+        sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
+
+        /* Configure MMCM*/
+        sdhci_writel(host, DIV_REG_100_MHZ, SDHC_MMCM_DIV_REG);
+        sdhci_writel(host, CLKFBOUT_100_MHZ,
+                SDHC_MMCM_CLKFBOUT);
+
+        /* De-assert reset to MMCM*/
+        reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
+        reg &= ~SDHC_CCLK_MMCM_RST;
+        sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
+
+        /* Enable clock */
+        clk = SDHCI_PROG_CLOCK_MODE | SDHCI_CLOCK_INT_EN |
+            SDHCI_CLOCK_CARD_EN;
+        sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+    }
+}
+EXPORT_SYMBOL_GPL(sdhci_snps_set_clock);
+
+void sdhci_snps_set_power(struct sdhci_host *host, unsigned char mode,
+             unsigned short vdd)
+{
+    u8 pwr = 0;
+    u16 ctrl;
+
+    if (mode != MMC_POWER_OFF) {
+        switch (1 << vdd) {
+        case MMC_VDD_165_195:
+            pwr = SDHCI_POWER_180;
+            break;
+        case MMC_VDD_29_30:
+        case MMC_VDD_30_31:
+            pwr = SDHCI_POWER_300;
+            break;
+        case MMC_VDD_32_33:
+        case MMC_VDD_33_34:
+            pwr = SDHCI_POWER_330;
+            break;
+        default:
+            WARN(1, "%s: Invalid vdd %#x\n",
+                 mmc_hostname(host->mmc), vdd);
+            break;
+        }
+    }
+
+    if (host->pwr == pwr)
+        return;
+
+    host->pwr = pwr;
+
+    if (pwr == 0) {
+        sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+    } else {
+        sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+
+        /*
+         * Enable it for eMMC phy cfg1 test with 1.8V mode
+         */
+        if (emmc_vdd == SDHC_EMMC_VDD_180V) {
+            pwr = SDHCI_POWER_180;
+            sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+
+            ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+            /*
+             * Enable 1.8V Signal Enable in the Host Control2
+             * register
+             */
+            ctrl |= SDHCI_CTRL_VDD_180;
+            sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+        }
+        pwr |= SDHCI_POWER_ON;
+
+        sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+    }
+}
+EXPORT_SYMBOL_GPL(sdhci_snps_set_power);
+
+int sdhci_snps_pci_probe_slot(struct sdhci_pci_slot *slot)
+{
+    struct sdhci_host *host = slot->host;
+
+    host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+    host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+
+    return 0;
+}
+EXPORT_SYMBOL_GPL(sdhci_snps_pci_probe_slot);
+
+MODULE_PARM_DESC(emmc_vdd, "VDD to configure eMMC device supply voltage");
+
diff --git a/drivers/mmc/host/sdhci-dwc-mshc-pci.h
b/drivers/mmc/host/sdhci-dwc-mshc-pci.h
new file mode 100644
index 0000000..97f5529
--- /dev/null
+++ b/drivers/mmc/host/sdhci-dwc-mshc-pci.h
@@ -0,0 +1,44 @@
+/*
+ * SDHCI driver for Synopsys DWC_MSHC controller
+ *
+ * Copyright (C) 2017-2018 Synopsys, Inc. (www.synopsys.com)
+ *
+ * Authors:
+ *    Prabu Thangamuthu <prabut@synopsys.com>
+ *    Manjunath M B <manjumb@synopsys.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __SDHCI_DWC_MSHC_PCI_H__
+#define __SDHCI_DWC_MSHC_PCI_H__
+
+#define SDHCI_VENDOR_PTR_R               0xE8
+
+/* Module Parameters */
+#define SDHC_EMMC_VDD_330V               33
+#define SDHC_EMMC_VDD_180V               18
+
+/* Synopsys Vendor Specific Registers */
+#define SDHC_GPIO_OUT                          0x34
+#define SDHC_AT_CTRL_R                   0x40
+
+#define SDHC_SW_TUNE_EN                   0x00000010
+
+/* MMCM DRP */
+#define SDHC_MMCM_DIV_REG               0x1020
+#define DIV_REG_100_MHZ                   0x1145
+
+#define SDHC_MMCM_CLKFBOUT               0x1024
+#define CLKFBOUT_100_MHZ               0x0000
+
+#define SDHC_CCLK_MMCM_RST               0x00000001
+
+int sdhci_snps_pci_probe_slot(struct sdhci_pci_slot *slot);
+void sdhci_snps_set_clock(struct sdhci_host *host, unsigned int clock);
+void sdhci_snps_set_power(struct sdhci_host *host, unsigned char mode,
+             unsigned short vdd);
+
+#endif
diff --git a/drivers/mmc/host/sdhci-pci-core.c
b/drivers/mmc/host/sdhci-pci-core.c
index b0b9ceb..f16ae5b 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -31,6 +31,7 @@
 #include "sdhci.h"
 #include "sdhci-pci.h"
 #include "sdhci-pci-o2micro.h"
+#include "sdhci-dwc-mshc-pci.h"
 
 static int sdhci_pci_enable_dma(struct sdhci_host *host);
 static void sdhci_pci_set_bus_width(struct sdhci_host *host, int width);
@@ -79,6 +80,23 @@ static int ricoh_mmc_resume(struct sdhci_pci_chip *chip)
     return 0;
 }
 
+/* Synopsys DWC MSHC Controller based on SDHCI-PCI */
+static const struct sdhci_ops sdhci_snps_ops = {
+    .set_clock    = sdhci_snps_set_clock,
+    .set_power    = sdhci_snps_set_power,
+    .enable_dma    = sdhci_pci_enable_dma,
+    .set_bus_width    = sdhci_pci_set_bus_width,
+    .reset        = sdhci_reset,
+    .set_uhs_signaling = sdhci_set_uhs_signaling,
+    .hw_reset        = sdhci_pci_hw_reset,
+    .select_drive_strength    = sdhci_pci_select_drive_strength,
+};
+
+static const struct sdhci_pci_fixes sdhci_snps = {
+    .probe_slot    = sdhci_snps_pci_probe_slot,
+    .ops        = &sdhci_snps_ops,
+};
+
 static const struct sdhci_pci_fixes sdhci_ricoh = {
     .probe        = ricoh_probe,
     .quirks        = SDHCI_QUIRK_32BIT_DMA_ADDR |
@@ -857,6 +875,13 @@ static int amd_probe(struct sdhci_pci_chip *chip)
 
 static const struct pci_device_id pci_ids[] = {
     {
+        .vendor        = 0x16c3,    /* Synopsys Vendor ID */
+        .device        = 0xc202,    /* IPK HAPS_Dx */
+        .subvendor    = PCI_ANY_ID,
+        .subdevice    = PCI_ANY_ID,
+        .driver_data    = (kernel_ulong_t)&sdhci_snps,
+    },
+    {
         .vendor        = PCI_VENDOR_ID_RICOH,
         .device        = PCI_DEVICE_ID_RICOH_R5C822,
         .subvendor    = PCI_ANY_ID,
-- 
1.9.1
