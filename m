From: Prabu Thangamuthu <Prabu.T@synopsys.com>
Subject: [PATCH 1/1] mmc: sdhci-pci-dwc-mshc: synopsys dwc mshc support
Date: Tue, 22 May 2018 06:42:39 +0000
Message-ID: <705D14B1C7978B40A723277C067CEDE2010A9B43CC@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Manjunath M Bettegowda <Manjunath.MB@synopsys.com>, "prabu.t@synopsys.com" <prabu.t@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

To enable Synopsys DWC MSHC controller on HPAS-DX platform connected using=
=0A=
PCIe interface. As Clock generation logic is implemented in MMCM module of=
=0A=
HAPS-DX platform, we have separate functions to control the MMCM to=0A=
generate required clocks with respect to speed mode. Also we have platform=
=0A=
specific set_power function to support different VDD of eMMC devices.=0A=
=0A=
Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>=0A=
---=0A=
 MAINTAINERS                           |   7 ++=0A=
 drivers/mmc/host/Makefile             |   3 +-=0A=
 drivers/mmc/host/sdhci-pci-core.c     |   1 +=0A=
 drivers/mmc/host/sdhci-pci-dwc-mshc.c | 146=0A=
++++++++++++++++++++++++++++++++++=0A=
 drivers/mmc/host/sdhci-pci-dwc-mshc.h |  37 +++++++++=0A=
 drivers/mmc/host/sdhci-pci.h          |   3 +=0A=
 6 files changed, 196 insertions(+), 1 deletion(-)=0A=
 create mode 100644 drivers/mmc/host/sdhci-pci-dwc-mshc.c=0A=
 create mode 100644 drivers/mmc/host/sdhci-pci-dwc-mshc.h=0A=
=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index 9051a9c..f1749c4 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -12643,6 +12643,13 @@ S:    Maintained=0A=
 F:    drivers/mmc/host/sdhci*=0A=
 F:    include/linux/mmc/sdhci*=0A=
 =0A=
+SYNOPSYS SDHCI COMPLIANT DWC MSHC DRIVER=0A=
+M:    Prabu Thangamuthu <prabu.t@synopsys.com>=0A=
+M:    Manjunath M B <manjumb@synopsys.com>=0A=
+L:    linux-mmc@vger.kernel.org=0A=
+S:    Maintained=0A=
+F:    drivers/mmc/host/sdhci-pci-dwc-mshc*=0A=
+=0A=
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) SAMSUNG DRIVER=0A=
 M:    Ben Dooks <ben-linux@fluff.org>=0A=
 M:    Jaehoon Chung <jh80.chung@samsung.com>=0A=
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile=0A=
index 6aead24..6c0d3fb 100644=0A=
--- a/drivers/mmc/host/Makefile=0A=
+++ b/drivers/mmc/host/Makefile=0A=
@@ -11,7 +11,8 @@ obj-$(CONFIG_MMC_MXC)        +=3D mxcmmc.o=0A=
 obj-$(CONFIG_MMC_MXS)        +=3D mxs-mmc.o=0A=
 obj-$(CONFIG_MMC_SDHCI)        +=3D sdhci.o=0A=
 obj-$(CONFIG_MMC_SDHCI_PCI)    +=3D sdhci-pci.o=0A=
-sdhci-pci-y            +=3D sdhci-pci-core.o sdhci-pci-o2micro.o=0A=
sdhci-pci-arasan.o=0A=
+sdhci-pci-y            +=3D sdhci-pci-core.o sdhci-pci-o2micro.o=0A=
sdhci-pci-arasan.o \=0A=
+                   sdhci-pci-dwc-mshc.o=0A=
 obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))    +=3D sdhci-pci-data.o=0A=
 obj-$(CONFIG_MMC_SDHCI_ACPI)    +=3D sdhci-acpi.o=0A=
 obj-$(CONFIG_MMC_SDHCI_PXAV3)    +=3D sdhci-pxav3.o=0A=
diff --git a/drivers/mmc/host/sdhci-pci-core.c=0A=
b/drivers/mmc/host/sdhci-pci-core.c=0A=
index 77dd352..96b6963 100644=0A=
--- a/drivers/mmc/host/sdhci-pci-core.c=0A=
+++ b/drivers/mmc/host/sdhci-pci-core.c=0A=
@@ -1511,6 +1511,7 @@ static int amd_probe(struct sdhci_pci_chip *chip)=0A=
     SDHCI_PCI_DEVICE(O2, SEABIRD0, o2),=0A=
     SDHCI_PCI_DEVICE(O2, SEABIRD1, o2),=0A=
     SDHCI_PCI_DEVICE(ARASAN, PHY_EMMC, arasan),=0A=
+    SDHCI_PCI_DEVICE(SYNOPSYS, DWC_MSHC,  snps),=0A=
     SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),=0A=
     /* Generic SD host controller */=0A=
     {PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},=0A=
diff --git a/drivers/mmc/host/sdhci-pci-dwc-mshc.c=0A=
b/drivers/mmc/host/sdhci-pci-dwc-mshc.c=0A=
new file mode 100644=0A=
index 0000000..bca3db4=0A=
--- /dev/null=0A=
+++ b/drivers/mmc/host/sdhci-pci-dwc-mshc.c=0A=
@@ -0,0 +1,146 @@=0A=
+// SPDX-License-Identifier: GPL-2.0=0A=
+/*=0A=
+ * SDHCI driver for Synopsys DWC_MSHC controller=0A=
+ *=0A=
+ * Copyright (C) 2018 Synopsys, Inc. (www.synopsys.com)=0A=
+ *=0A=
+ * Authors:=0A=
+ *    Prabu Thangamuthu <prabu.t@synopsys.com>=0A=
+ *    Manjunath M B <manjumb@synopsys.com>=0A=
+ *=0A=
+ */=0A=
+=0A=
+#include <linux/pci.h>=0A=
+#include <linux/delay.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/moduleparam.h>=0A=
+=0A=
+#include "sdhci.h"=0A=
+#include "sdhci-pci.h"=0A=
+#include "sdhci-pci-dwc-mshc.h"=0A=
+=0A=
+/* Default emmc vdd is set to 3.3V */=0A=
+static unsigned int emmc_vdd =3D SDHC_EMMC_VDD_330V;=0A=
+module_param(emmc_vdd, int, 0444);=0A=
+=0A=
+static void sdhci_snps_set_clock(struct sdhci_host *host, unsigned int=0A=
clock)=0A=
+{=0A=
+    u16 clk =3D 0;=0A=
+    u32 reg =3D 0;=0A=
+    u32 vendor_ptr =3D 0;=0A=
+=0A=
+    vendor_ptr =3D sdhci_readw(host, SDHCI_VENDOR_PTR_R);=0A=
+=0A=
+    /* Disable Software managed rx tuning */=0A=
+    reg =3D sdhci_readl(host, (SDHC_AT_CTRL_R + vendor_ptr));=0A=
+    reg &=3D ~SDHC_SW_TUNE_EN;=0A=
+    sdhci_writel(host, reg, (SDHC_AT_CTRL_R + vendor_ptr));=0A=
+=0A=
+    if (clock <=3D 52000000) {=0A=
+        sdhci_set_clock(host, clock);=0A=
+    } else {=0A=
+        /* Assert reset to MMCM */=0A=
+        reg =3D sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));=0A=
+        reg |=3D SDHC_CCLK_MMCM_RST;=0A=
+        sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));=0A=
+=0A=
+        /* Configure MMCM*/=0A=
+        sdhci_writel(host, DIV_REG_100_MHZ, SDHC_MMCM_DIV_REG);=0A=
+        sdhci_writel(host, CLKFBOUT_100_MHZ,=0A=
+                SDHC_MMCM_CLKFBOUT);=0A=
+=0A=
+        /* De-assert reset to MMCM*/=0A=
+        reg =3D sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));=0A=
+        reg &=3D ~SDHC_CCLK_MMCM_RST;=0A=
+        sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));=0A=
+=0A=
+        /* Enable clock */=0A=
+        clk =3D SDHCI_PROG_CLOCK_MODE | SDHCI_CLOCK_INT_EN |=0A=
+            SDHCI_CLOCK_CARD_EN;=0A=
+        sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void sdhci_snps_set_power(struct sdhci_host *host, unsigned char=0A=
mode,=0A=
+             unsigned short vdd)=0A=
+{=0A=
+    u8 pwr =3D 0;=0A=
+    u16 ctrl;=0A=
+=0A=
+    if (mode !=3D MMC_POWER_OFF) {=0A=
+        switch (1 << vdd) {=0A=
+        case MMC_VDD_165_195:=0A=
+            pwr =3D SDHCI_POWER_180;=0A=
+            break;=0A=
+        case MMC_VDD_29_30:=0A=
+        case MMC_VDD_30_31:=0A=
+            pwr =3D SDHCI_POWER_300;=0A=
+            break;=0A=
+        case MMC_VDD_32_33:=0A=
+        case MMC_VDD_33_34:=0A=
+            pwr =3D SDHCI_POWER_330;=0A=
+            break;=0A=
+        default:=0A=
+            WARN(1, "%s: Invalid vdd %#x\n",=0A=
+                 mmc_hostname(host->mmc), vdd);=0A=
+            break;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    if (host->pwr =3D=3D pwr)=0A=
+        return;=0A=
+=0A=
+    host->pwr =3D pwr;=0A=
+=0A=
+    if (pwr =3D=3D 0) {=0A=
+        sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);=0A=
+    } else {=0A=
+        sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);=0A=
+=0A=
+        /*=0A=
+         * Enable it for eMMC phy cfg1 test with 1.8V mode=0A=
+         */=0A=
+        if (emmc_vdd =3D=3D SDHC_EMMC_VDD_180V) {=0A=
+            pwr =3D SDHCI_POWER_180;=0A=
+            sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);=0A=
+=0A=
+            ctrl =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);=0A=
+            /*=0A=
+             * Enable 1.8V Signal Enable in the Host Control2=0A=
+             * register=0A=
+             */=0A=
+            ctrl |=3D SDHCI_CTRL_VDD_180;=0A=
+            sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);=0A=
+        }=0A=
+        pwr |=3D SDHCI_POWER_ON;=0A=
+=0A=
+        sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);=0A=
+    }=0A=
+}=0A=
+=0A=
+static int sdhci_snps_pci_probe_slot(struct sdhci_pci_slot *slot)=0A=
+{=0A=
+    struct sdhci_host *host =3D slot->host;=0A=
+=0A=
+    host->caps =3D sdhci_readl(host, SDHCI_CAPABILITIES);=0A=
+    host->caps1 =3D sdhci_readl(host, SDHCI_CAPABILITIES_1);=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+/* Synopsys DWC MSHC Controller based on SDHCI-PCI */=0A=
+static const struct sdhci_ops sdhci_snps_ops =3D {=0A=
+    .set_clock    =3D sdhci_snps_set_clock,=0A=
+    .set_power    =3D sdhci_snps_set_power,=0A=
+    .enable_dma    =3D sdhci_pci_enable_dma,=0A=
+    .set_bus_width    =3D sdhci_set_bus_width,=0A=
+    .reset        =3D sdhci_reset,=0A=
+    .set_uhs_signaling =3D sdhci_set_uhs_signaling,=0A=
+};=0A=
+=0A=
+const struct sdhci_pci_fixes sdhci_snps =3D {=0A=
+    .probe_slot    =3D sdhci_snps_pci_probe_slot,=0A=
+    .ops        =3D &sdhci_snps_ops,=0A=
+};=0A=
+=0A=
+MODULE_PARM_DESC(emmc_vdd, "VDD to configure eMMC device supply voltage");=
=0A=
diff --git a/drivers/mmc/host/sdhci-pci-dwc-mshc.h=0A=
b/drivers/mmc/host/sdhci-pci-dwc-mshc.h=0A=
new file mode 100644=0A=
index 0000000..352bbfd=0A=
--- /dev/null=0A=
+++ b/drivers/mmc/host/sdhci-pci-dwc-mshc.h=0A=
@@ -0,0 +1,37 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SDHCI driver for Synopsys DWC_MSHC controller=0A=
+ *=0A=
+ * Copyright (C) 2018 Synopsys, Inc. (www.synopsys.com)=0A=
+ *=0A=
+ * Authors:=0A=
+ *    Prabu Thangamuthu <prabu.t@synopsys.com>=0A=
+ *    Manjunath M B <manjumb@synopsys.com>=0A=
+ *=0A=
+ */=0A=
+=0A=
+#ifndef __SDHCI_PCI_DWC_MSHC_H__=0A=
+#define __SDHCI_PCI_DWC_MSHC_H__=0A=
+=0A=
+#define SDHCI_VENDOR_PTR_R               0xE8=0A=
+=0A=
+/* Module Parameters */=0A=
+#define SDHC_EMMC_VDD_330V               33=0A=
+#define SDHC_EMMC_VDD_180V               18=0A=
+=0A=
+/* Synopsys Vendor Specific Registers */=0A=
+#define SDHC_GPIO_OUT                          0x34=0A=
+#define SDHC_AT_CTRL_R                   0x40=0A=
+=0A=
+#define SDHC_SW_TUNE_EN                   0x00000010=0A=
+=0A=
+/* MMCM DRP */=0A=
+#define SDHC_MMCM_DIV_REG               0x1020=0A=
+#define DIV_REG_100_MHZ                   0x1145=0A=
+=0A=
+#define SDHC_MMCM_CLKFBOUT               0x1024=0A=
+#define CLKFBOUT_100_MHZ               0x0000=0A=
+=0A=
+#define SDHC_CCLK_MMCM_RST               0x00000001=0A=
+=0A=
+#endif=0A=
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h=0A=
index db9cb54..c91dcec 100644=0A=
--- a/drivers/mmc/host/sdhci-pci.h=0A=
+++ b/drivers/mmc/host/sdhci-pci.h=0A=
@@ -59,6 +59,7 @@=0A=
 #define PCI_VENDOR_ID_ARASAN        0x16e6=0A=
 #define PCI_DEVICE_ID_ARASAN_PHY_EMMC    0x0670=0A=
 =0A=
+#define PCI_DEVICE_ID_SYNOPSYS_DWC_MSHC 0xC202=0A=
 /*=0A=
  * PCI device class and mask=0A=
  */=0A=
@@ -183,4 +184,6 @@ static inline void *sdhci_pci_priv(struct=0A=
sdhci_pci_slot *slot)=0A=
 =0A=
 extern const struct sdhci_pci_fixes sdhci_arasan;=0A=
 =0A=
+extern const struct sdhci_pci_fixes sdhci_snps;=0A=
+=0A=
 #endif /* __SDHCI_PCI_H */=0A=
-- =0A=
1.9.1=0A=
=0A=
=0A=
