From: Prabu Thangamuthu <Prabu.T@synopsys.com>
Subject: [PATCH v3] mmc: sdhci-pci: add Support of Synopsys DWC_MSHC IP
Date: Wed, 20 Apr 2016 12:22:59 +0000
Message-ID: <705D14B1C7978B40A723277C067CEDE2010A4B12F8@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:35026 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbcDTMXI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2016 08:23:08 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Ulf Hansson (ulf.hansson@linaro.org)" <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Guenter Roeck <linux@roeck-us.net>, Jiri Slaby <jslaby@suse.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Andrei Pistirica <andrei.pistirica@microchip.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Joshua Henderson <joshua.henderson@microchip.com>, Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: "prabu.t@synopsys.com" <prabu.t@synopsys.com>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Patch for Standard SD Host Controller Interface compliant Synopsys
sdhci-dwc controller driver. This code supports PCI based interface.

Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>
---
Change log v3:
	-Removed unused code.
	-Updated review comments.

Change log v2:
	-Removed Synopsys specific PCI device ID's from pci_ids.h.
	-Updated the PCI device ID's in sdhci-pci-core.c.

 MAINTAINERS                       |   7 +
 drivers/mmc/host/Makefile         |   3 +-
 drivers/mmc/host/sdhci-pci-core.c |  14 ++
 drivers/mmc/host/sdhci-pci-dwc.c  | 260 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci-dwc.h  |  55 ++++++++
 5 files changed, 338 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/host/sdhci-pci-dwc.c
 create mode 100644 drivers/mmc/host/sdhci-pci-dwc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d5b4be..01b40da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9751,6 +9751,13 @@ S:	Maintained
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
index af918d2..092a746 100644
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
index 79e1901..4a7769c 100644
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
@@ -797,6 +803,14 @@ static const struct sdhci_pci_fixes sdhci_amd = {
 
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
index 0000000..3490af8
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pci-dwc.c
@@ -0,0 +1,260 @@
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
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#include "sdhci.h"
+#include "sdhci-pci.h"
+#include "sdhci-pci-dwc.h"
+
+/*****************************************************************************\
+ *                                                                           *
+ * Hardware specific clock handling                                          *
+ *                                                                           *
+\*****************************************************************************/
+static const struct sdhci_ops *sdhci_ops;	/* Low level hw interface */
+
+static void snps_reset_dcm(struct sdhci_host *host,
+				unsigned int mask, unsigned char reset)
+{
+	u32 reg = 0;
+	u16 vendor_ptr = 0;
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
+static void sdhci_set_clock_snps(struct sdhci_host *host,
+						unsigned int clock)
+{
+	int div = 0;
+	int mul = 0;
+	int div_val = 0;
+	int mul_val = 0;
+	int mul_div_val = 0;
+	u32 reg = 0;
+	u16 clk = 0;
+	u16 vendor_ptr = 0;
+	u32 mask = 0;
+	unsigned long timeout;
+	u32 tx_clk_phase_val = SDHC_DEF_TX_CLK_PH_VAL;
+	u32 rx_clk_phase_val = SDHC_DEF_RX_CLK_PH_VAL;
+
+	/*
+	 * if clock is less than 25MHz, divided clock is used.
+	 * For divided clock, we can use the standard sdhci_set_clock().
+	 * For clock above 25MHz, DRP clock is used
+	 * Here, we cannot use sdhci_set_clock(), we need to program
+	 * TX RX CLOCK DCM DRP for appropriate clock
+	 */
+
+	if (clock <= 25000000) {
+		/* Then call generic set_clock */
+		if (sdhci_ops->set_clock)
+			sdhci_ops->set_clock(host, clock);
+	} else {
+
+		host->mmc->actual_clock = 0;
+		vendor_ptr = sdhci_readw(host, SDHCI_UHS2_VENDOR);
+
+		/* Select un-phase shifted clock before reset Tx Tuning DCM*/
+		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
+		reg &= ~SDHC_TX_CLK_SEL_TUNED;
+		sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
+		mdelay(10);
+
+		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+
+		/* Lets chose the Mulitplier value to be 0x2 */
+		mul = 0x2;
+		for (div = 1; div <= 32; div++) {
+			if (((host->max_clk * mul) / div)
+					<= clock)
+				break;
+		}
+		/*
+		 * Set Programmable Clock Mode in the Clock
+		 * Control register.
+		 */
+		div_val = div - 1;
+		mul_val = mul - 1;
+
+		host->mmc->actual_clock = (host->max_clk * mul) / div;
+		/*
+		 * Program the DCM DRP
+		 * Step 1: Assert DCM Reset
+		 * Step 2: Program the mul and div values in DRP
+		 * Step 3: Read from DRP base 0x00 to restore DCM output as per
+		 * www.xilinx.com/support/documentation/user_guides/ug191.pdf
+		 * Step 4: De-Assert reset to DCM
+		 */
+
+		mask = SDHC_CARD_TX_CLK_DCM_RST;
+		snps_reset_dcm(host, mask, 1);
+
+		mul_div_val = (mul_val << 8) | div_val;
+		sdhci_writew(host, mul_div_val, TXRX_CLK_DCM_MUL_DIV_DRP);
+
+		reg = sdhci_readl(host, TXRX_CLK_DCM_DRP_BASE_51);
+
+		snps_reset_dcm(host, mask, 0);
+
+		clk |= SDHCI_PROG_CLOCK_MODE | SDHCI_CLOCK_INT_EN;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+		/* Wait max 20 ms */
+		timeout = 20;
+		while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
+					& SDHCI_CLOCK_INT_STABLE)) {
+			if (timeout == 0) {
+				pr_err("%s: Internal clock never stabilised\n",
+						mmc_hostname(host->mmc));
+				return;
+			}
+			timeout--;
+			mdelay(1);
+		}
+
+		clk |= SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+		/*
+		 * This Clock might have affected the TX CLOCK DCM and RX CLOCK
+		 * DCM which are used for Phase control; Reset these DCM's
+		 * for proper clock output
+		 *
+		 * Step 1: Reset the DCM
+		 * Step 2: De-Assert reset to DCM
+		 */
+
+		mask = SDHC_TUNING_TX_CLK_DCM_RST | SDHC_TUNING_RX_CLK_DCM_RST;
+		snps_reset_dcm(host, mask, 1);
+		mdelay(10);
+		snps_reset_dcm(host, mask, 0);
+
+		/* Select working phase value if clock is <= 50MHz */
+		if (clock <= 50000000) {
+			/*Change the Tx Phase value here */
+			reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
+			reg |= (SDHC_TUNING_TX_CLK_SEL_MASK &
+			   (tx_clk_phase_val << SDHC_TUNING_TX_CLK_SEL_SHIFT));
+
+			sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
+			mdelay(10);
+
+			/* Program to select phase shifted clock */
+			reg |= SDHC_TX_CLK_SEL_TUNED;
+			sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
+
+			/*
+			 * For 50Mhz, tuning is not possible.
+			 * Lets fix the sampling Phase of Rx Clock here.
+			 */
+			reg = sdhci_readl(host, (SDHC_DBOUNCE + vendor_ptr));
+			reg &= ~SDHC_TUNING_RX_CLK_SEL_MASK;
+			reg |= (SDHC_TUNING_RX_CLK_SEL_MASK &
+					rx_clk_phase_val);
+			sdhci_writel(host, reg, (SDHC_DBOUNCE + vendor_ptr));
+		}
+		mdelay(10);
+	}
+}
+
+static int snps_init_clock(struct sdhci_host *host)
+{
+	int div = 0;
+	int mul = 0;
+	int div_val = 0;
+	int mul_val = 0;
+	int mul_div_val = 0;
+	int reg = 0;
+	u32 mask = 0;
+
+	/* Configure the BCLK DRP to get 100 MHZ Clock */
+
+	/*
+	 * To get 100MHz from 100MHz input freq,
+	 * mul=2 and div=2
+	 * Formula: output_clock = (input clock * mul) / div
+	 */
+	mul = 2;
+	div = 2;
+	mul_val = mul - 1;
+	div_val = div - 1;
+	/*
+	 * Program the DCM DRP
+	 * Step 1: Assert DCM Reset
+	 * Step 2: Program the mul and div values in DRP
+	 * Step 3: Read from DRP base 0x00 to restore DCM output as per
+	 * www.xilinx.com/support/documentation/user_guides/ug191.pdf
+	 * Step 4: De-Assert reset to DCM
+	 */
+	mask = SDHC_BCLK_DCM_RST;
+	snps_reset_dcm(host, mask, 1);
+
+	mul_div_val = (mul_val << 8) | div_val;
+	sdhci_writew(host, mul_div_val, BCLK_DCM_MUL_DIV_DRP);
+
+	reg = sdhci_readl(host, BCLK_DCM_DRP_BASE_51);
+
+	snps_reset_dcm(host, mask, 0);
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
+
+	host = slot->host;
+	sdhci_ops = host->ops;
+
+	sdhci_pci_ops_snps.enable_dma		= sdhci_ops->enable_dma;
+	sdhci_pci_ops_snps.set_bus_width	= sdhci_ops->set_bus_width;
+	sdhci_pci_ops_snps.reset		= sdhci_ops->reset;
+	sdhci_pci_ops_snps.set_uhs_signaling	= sdhci_ops->set_uhs_signaling;
+	sdhci_pci_ops_snps.hw_reset		= sdhci_ops->hw_reset;
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

