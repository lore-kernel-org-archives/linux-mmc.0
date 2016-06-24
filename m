From: Prabu Thangamuthu <Prabu.T@synopsys.com>
Subject: [PATCH v5] mmc: sdhci-pci: add Support of Synopsys DWC_MSHC IP
Date: Fri, 24 Jun 2016 14:41:20 +0000
Message-ID: <705D14B1C7978B40A723277C067CEDE2010A4D633F@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:48206 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbcFXOla convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jun 2016 10:41:30 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "davem@davemloft.net" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jiri Slaby <jslaby@suse.cz>, Guenter Roeck <linux@roeck-us.net>, Eric Anholt <eric@anholt.net>, Ludovic Desroches <ludovic.desroches@atmel.com>, Al Cooper <alcooperx@gmail.com>, Ben Hutchings <ben@decadent.org.uk>, Stefan Wahren <stefan.wahren@i2se.com>, Andrei Pistirica <andrei.pistirica@microchip.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "prabu.t@synopsys.com" <prabu.t@synopsys.com>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>

Patch to add Standard SD Host Controller Interface compliant
Synopsys sdhci-dwc controller driver.

Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>
---
Change log v5:
	-Updated review comments.

Change log v4:
	-Updated review comments to optimize the code.

Change log v3:
	-Removed unused code.
	-Updated review comments.

 MAINTAINERS                       |   7 ++
 drivers/mmc/host/Makefile         |   3 +-
 drivers/mmc/host/sdhci-pci-core.c |  14 +++
 drivers/mmc/host/sdhci-pci-dwc.c  | 238 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci-dwc.h  |  55 +++++++++
 5 files changed, 316 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/host/sdhci-pci-dwc.c
 create mode 100644 drivers/mmc/host/sdhci-pci-dwc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index eff1037..e5c36e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10162,6 +10162,13 @@ S:	Maintained
 F:	include/linux/mmc/dw_mmc.h
 F:	drivers/mmc/host/dw_mmc*
 
+SYNOPSYS SDHCI COMPLIANT DWC MSHC DRIVER
+M:	Prabu Thangamuthu <prabu.t@synopsys.com>
+M:	Manjunath M B <manjumb@synopsys.com>
+L:	linux-mmc@vger.kernel.org
+S:	Maintained
+F:	drivers/mmc/host/sdhci-pci-dwc*
+
 SYSTEM TRACE MODULE CLASS
 M:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
 S:	Maintained
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index e2bdaaf..c5331b8 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -9,7 +9,8 @@ obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
-sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o
+sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o \
+				   sdhci-pci-dwc.o
 obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))	+= sdhci-pci-data.o
 obj-$(CONFIG_MMC_SDHCI_ACPI)	+= sdhci-acpi.o
 obj-$(CONFIG_MMC_SDHCI_PXAV3)	+= sdhci-pxav3.o
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 5b03a7e..fc39ce5 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -31,6 +31,7 @@
 #include "sdhci.h"
 #include "sdhci-pci.h"
 #include "sdhci-pci-o2micro.h"
+#include "sdhci-pci-dwc.h"
 
 /*****************************************************************************\
  *                                                                           *
@@ -70,6 +71,11 @@ static int ricoh_mmc_resume(struct sdhci_pci_chip *chip)
 	msleep(500);
 	return 0;
 }
+/* Synopsys SDHCI compliant Controller */
+static const struct sdhci_pci_fixes sdhci_snps = {
+	.probe_slot	= sdhci_pci_probe_slot_snps,
+	.quirks2	= SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+};
 
 static const struct sdhci_pci_fixes sdhci_ricoh = {
 	.probe		= ricoh_probe,
@@ -791,6 +797,14 @@ static const struct sdhci_pci_fixes sdhci_amd = {
 
 static const struct pci_device_id pci_ids[] = {
 	{
+		.vendor		= PCI_VENDOR_ID_SYNOPSYS,
+		.device		= 0xc201, /* Device ID of sdhci-dwc on Haps51 */
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_snps,
+	},
+
+	{
 		.vendor		= PCI_VENDOR_ID_RICOH,
 		.device		= PCI_DEVICE_ID_RICOH_R5C822,
 		.subvendor	= PCI_ANY_ID,
diff --git a/drivers/mmc/host/sdhci-pci-dwc.c b/drivers/mmc/host/sdhci-pci-dwc.c
new file mode 100644
index 0000000..374fb8a
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pci-dwc.c
@@ -0,0 +1,238 @@
+/*
+ * Copyright (C) 2016 Synopsys, Inc.
+ *
+ * Authors:
+ *	Manjunath M B		<manjumb@synopsys.com>
+ *	Prabu Thangamuthu	<prabu.t@synopsys.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#include "sdhci.h"
+#include "sdhci-pci.h"
+#include "sdhci-pci-dwc.h"
+
+/* Hardware specific clock handling */
+static void snps_reset_dcm(struct sdhci_host *host, u32 mask, u8 reset)
+{
+	u16 vendor_ptr;
+	u32 reg;
+
+	vendor_ptr = sdhci_readw(host, SDHCI_UHS2_VENDOR);
+
+	reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
+
+	if (reset == 1)
+		reg |= mask;
+	else
+		reg &= ~mask;
+
+	sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
+}
+
+static void sdhci_set_clock_snps(struct sdhci_host *host, u32 clock)
+{
+	u8 div;
+	u8 mul;
+	u8 timeout;
+	u16 clk;
+	u16 vendor_ptr;
+	u16 mul_div_val;
+	u32 reg;
+
+	/*
+	 * If clock is less than 25MHz, divided clock is used.
+	 * For divided clock, we can use the standard sdhci_set_clock().
+	 * For clock above 25MHz, DRP clock is used.
+	 * Here, we cannot use sdhci_set_clock(), we need to program
+	 * TX RX CLOCK DCM DRP for appropriate clock.
+	 */
+	if (clock <= 25000000) {
+		/* Then call standard set_clock */
+		sdhci_set_clock(host, clock);
+		return;
+	}
+
+	host->mmc->actual_clock = 0;
+	vendor_ptr = sdhci_readw(host, SDHCI_UHS2_VENDOR);
+
+	/* Select un-phase shifted clock before reset Tx Tuning DCM */
+	reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
+	reg &= ~SDHC_TX_CLK_SEL_TUNED;
+	sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
+	/* Wait for 10ms to get stable clock output from Mux */
+	mdelay(10);
+
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+
+	/*
+	 * As minimum Multiplier value needed for DRP is 0x1,
+	 * Choose the Mulitplier value to be 0x1.
+	 */
+	mul = 0x1;
+	for (div = 1; div <= 32; div++) {
+		if ((host->max_clk * mul / div)
+				<= clock)
+			break;
+	}
+
+	host->mmc->actual_clock = (host->max_clk * mul) / div;
+	/*
+	 * Program the DCM DRP
+	 * Step 1: Assert DCM Reset
+	 * Step 2: Program the mul and div values in DRP
+	 * Step 3: Read from DRP base 0x00 to restore DCM output as per
+	 * www.xilinx.com/support/documentation/user_guides/ug191.pdf
+	 * Step 4: De-Assert reset to DCM
+	 */
+	snps_reset_dcm(host, SDHC_CARD_TX_CLK_DCM_RST, 1);
+
+	mul_div_val = (mul << 8) | div;
+	sdhci_writew(host, mul_div_val, TXRX_CLK_DCM_MUL_DIV_DRP);
+	sdhci_readl(host, TXRX_CLK_DCM_DRP_BASE_51);
+
+	snps_reset_dcm(host, SDHC_CARD_TX_CLK_DCM_RST, 0);
+
+	/* Set Programmable Clock Mode in the Clock Control register. */
+	clk = SDHCI_PROG_CLOCK_MODE | SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/* Wait max 20 ms */
+	timeout = 20;
+	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
+				& SDHCI_CLOCK_INT_STABLE)) {
+		if (timeout == 0) {
+			pr_err("%s: Internal clock never stabilised\n",
+					mmc_hostname(host->mmc));
+			return;
+		}
+		timeout--;
+		mdelay(1);
+	}
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/*
+	 * This Clock might have affected the TX CLOCK DCM
+	 * and RX CLOCK DCM which are used for Phase control.
+	 * Reset both DCM's for proper output.
+	 *
+	 * Step 1: Assert reset to DCM.
+	 * Step 2: De-Assert reset to DCM.
+	 */
+	snps_reset_dcm(host, SDHC_TUNING_TX_CLK_DCM_RST |
+			SDHC_TUNING_RX_CLK_DCM_RST, 1);
+
+	/* Wait for 10ms to get stable output from Mux */
+	mdelay(10);
+	snps_reset_dcm(host, SDHC_TUNING_TX_CLK_DCM_RST |
+			SDHC_TUNING_RX_CLK_DCM_RST, 0);
+
+	/* Select working phase value if clock is <= 50MHz */
+	if (clock <= 50000000) {
+		/* Change the Tx Phase value here */
+		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
+		reg |= (SDHC_TUNING_TX_CLK_SEL_MASK &
+				(SDHC_DEF_TX_CLK_PH_VAL <<
+				 SDHC_TUNING_TX_CLK_SEL_SHIFT));
+
+		sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
+		/* Wait for 10ms to get stable clock output from Mux */
+		mdelay(10);
+
+		/* Program to select phase shifted clock */
+		reg |= SDHC_TX_CLK_SEL_TUNED;
+		sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
+
+		/*
+		 * For 50Mhz, tuning is not possible.
+		 * Let's fix the sampling Phase of Rx Clock here.
+		 */
+		reg = sdhci_readl(host, (SDHC_DBOUNCE + vendor_ptr));
+		reg &= ~SDHC_TUNING_RX_CLK_SEL_MASK;
+		reg |= (SDHC_TUNING_RX_CLK_SEL_MASK &
+				SDHC_DEF_RX_CLK_PH_VAL);
+		sdhci_writel(host, reg, (SDHC_DBOUNCE + vendor_ptr));
+	}
+	/* Wait for 10ms to get stable clock output from Mux */
+	mdelay(10);
+}
+
+static int snps_init_clock(struct sdhci_host *host)
+{
+	u16 mul_div_val;
+
+	/*
+	 * Configure the BCLK DRP to get 100 MHZ Clock
+	 * To get 100MHz from 100MHz input freq,
+	 * mul=1 and div=1
+	 * Formula: output_clock = (input clock * mul) / div
+	 *
+	 * Program the DCM DRP
+	 * Step 1: Assert DCM Reset
+	 * Step 2: Program the mul and div values in DRP
+	 * Step 3: Read from DRP base 0x00 to restore DCM output as per
+	 * www.xilinx.com/support/documentation/user_guides/ug191.pdf
+	 * Step 4: De-Assert reset to DCM
+	 */
+	snps_reset_dcm(host, SDHC_BCLK_DCM_RST, 1);
+
+	mul_div_val = 0x0101;
+	sdhci_writew(host, mul_div_val, BCLK_DCM_MUL_DIV_DRP);
+	sdhci_readl(host, BCLK_DCM_DRP_BASE_51);
+
+	snps_reset_dcm(host, SDHC_BCLK_DCM_RST, 0);
+
+	/*
+	 * By Default Clocks to Controller are OFF.
+	 * Before stack applies reset; we need to turn on the clock
+	 */
+	sdhci_writew(host, SDHCI_CLOCK_INT_EN, SDHCI_CLOCK_CONTROL);
+
+	return 0;
+
+}
+static struct sdhci_ops sdhci_pci_ops_snps = {
+	.set_clock	= sdhci_set_clock_snps,
+};
+
+int sdhci_pci_probe_slot_snps(struct sdhci_pci_slot *slot)
+{
+	int ret = 0;
+	struct sdhci_host *host;
+	const struct sdhci_ops *sdhci_pci_ops;	/* Low level hw interface */
+
+	host = slot->host;
+	sdhci_pci_ops = host->ops;
+
+	sdhci_pci_ops_snps.enable_dma		= sdhci_pci_ops->enable_dma;
+	sdhci_pci_ops_snps.set_bus_width	= sdhci_pci_ops->set_bus_width;
+	sdhci_pci_ops_snps.reset		= sdhci_pci_ops->reset;
+	sdhci_pci_ops_snps.set_uhs_signaling	=
+					sdhci_pci_ops->set_uhs_signaling;
+	sdhci_pci_ops_snps.hw_reset		= sdhci_pci_ops->hw_reset;
+	sdhci_pci_ops_snps.select_drive_strength =
+					sdhci_pci_ops->select_drive_strength;
+
+	host->ops = &sdhci_pci_ops_snps;
+
+	/* Board specific clock initialization */
+	ret = snps_init_clock(host);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sdhci_pci_probe_slot_snps);
diff --git a/drivers/mmc/host/sdhci-pci-dwc.h b/drivers/mmc/host/sdhci-pci-dwc.h
new file mode 100644
index 0000000..02e2213
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pci-dwc.h
@@ -0,0 +1,55 @@
+/*
+ * Copyright (C) 2016 Synopsys, Inc.
+ *
+ * Author: Manjunath M B <manjumb@synopsys.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __SDHCI_DWC_MSHC_PCI_H__
+#define __SDHCI_DWC_MSHC_PCI_H__
+
+#include "sdhci-pci.h"
+
+#define SDHCI_UHS2_VENDOR	0xE8
+
+#define DRIVER_NAME "sdhci-pci-dwc"
+#define SDHC_DEF_TX_CLK_PH_VAL  4
+#define SDHC_DEF_RX_CLK_PH_VAL  4
+
+/* Synopsys Vendor Specific Registers */
+#define SDHC_DBOUNCE                           0x08
+#define SDHC_TUNING_RX_CLK_SEL_MASK            0x000000FF
+#define SDHC_GPIO_OUT                          0x34
+/* HAPS 51 Based implementation */
+#define SDHC_BCLK_DCM_RST                      0x00000001
+#define SDHC_CARD_TX_CLK_DCM_RST               0x00000002
+#define SDHC_TUNING_RX_CLK_DCM_RST             0x00000004
+#define SDHC_TUNING_TX_CLK_DCM_RST             0x00000008
+#define SDHC_TUNING_TX_CLK_SEL_MASK            0x00000070
+#define SDHC_TUNING_TX_CLK_SEL_SHIFT           4
+#define SDHC_TX_CLK_SEL_TUNED                  0x00000080
+
+/* Offset of BCLK DCM DRP Attributes */
+/* Every attribute is of 16 bit wide */
+#define BCLK_DCM_DRP_BASE_51                   0x1000
+
+#define BCLK_DCM_MUL_DIV_DRP                   0x1050
+#define MUL_MASK_DRP                           0xFF00
+#define DIV_MASK_DRP                           0x00FF
+
+/* Offset of TX and RX CLK DCM DRP */
+#define TXRX_CLK_DCM_DRP_BASE_51               0x2000
+#define TXRX_CLK_DCM_MUL_DIV_DRP               0x2050
+
+int sdhci_pci_probe_slot_snps(struct sdhci_pci_slot *slot);
+
+#endif
-- 
1.9.1

