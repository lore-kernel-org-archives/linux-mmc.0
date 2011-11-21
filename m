From: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Subject: [PATCH v3 2/4] ARM: pxa168: Add SDHCI support
Date: Mon, 21 Nov 2011 09:56:12 +0530
Message-ID: <1321849572-2944-1-git-send-email-tanmay.upadhyay@einfochips.com>
References: <87r51fwxgt.fsf@laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ahm.einfochips.com ([203.76.128.206]:59331 "EHLO
	ahm.einfochips.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab1KUE0W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Nov 2011 23:26:22 -0500
In-Reply-To: <87r51fwxgt.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: eric.y.miao@gmail.com, jason.chagas@marvell.com
Cc: prakity@marvell.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>

v2 - clock register for SDHCI are not common across all MMP SoCs.
     So, move PXA168 implementation to pxa168.c

v3 - sdhci-pxav1 driver code is merged with sdhci-pxav2. So, change
     the device name accordingly
   - start sdhci device numbering from 1 as other PXA168 devices
     does that

Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Reviewed-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/include/mach/pxa168.h |   20 +++++++++++++
 arch/arm/mach-mmp/pxa168.c              |   46 +++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
index 7fb568d..a181608 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -15,6 +15,7 @@ extern void pxa168_clear_keypad_wakeup(void);
 #include <plat/pxa27x_keypad.h>
 #include <mach/cputype.h>
 #include <linux/pxa168_eth.h>
+#include <linux/platform_data/pxa_sdhci.h>
 
 extern struct pxa_device_desc pxa168_device_uart1;
 extern struct pxa_device_desc pxa168_device_uart2;
@@ -34,6 +35,10 @@ extern struct pxa_device_desc pxa168_device_nand;
 extern struct pxa_device_desc pxa168_device_fb;
 extern struct pxa_device_desc pxa168_device_keypad;
 extern struct pxa_device_desc pxa168_device_eth;
+extern struct pxa_device_desc pxa168_device_sdh1;
+extern struct pxa_device_desc pxa168_device_sdh2;
+extern struct pxa_device_desc pxa168_device_sdh3;
+extern struct pxa_device_desc pxa168_device_sdh4;
 
 struct pxa168_usb_pdata {
 	/* If NULL, default phy init routine for PXA168 would be called */
@@ -132,4 +137,19 @@ static inline int pxa168_add_eth(struct pxa168_eth_platform_data *data)
 {
 	return pxa_register_device(&pxa168_device_eth, data, sizeof(*data));
 }
+
+static inline int pxa168_add_sdh(int id, struct sdhci_pxa_platdata *data)
+{
+	struct pxa_device_desc *d = NULL;
+
+	switch (id) {
+	case 1: d = &pxa168_device_sdh1; break;
+	case 2: d = &pxa168_device_sdh2; break;
+	case 3: d = &pxa168_device_sdh3; break;
+	case 4: d = &pxa168_device_sdh4; break;
+	default:
+		return -EINVAL;
+	}
+	return pxa_register_device(d, data, sizeof(*data));
+}
 #endif /* __ASM_MACH_PXA168_H */
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 76ca15c..102f65f 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -45,6 +45,14 @@ static struct mfp_addr_map pxa168_mfp_addr_map[] __initdata =
 
 #define APMASK(i)	(GPIO_REGS_VIRT + BANK_OFF(i) + 0x09c)
 
+/* Offset defined in arch/arm/mach-mmp/include/mach/regs-apmu.h are for MMP2
+ * PXA168 has different offset */
+#undef APMU_SDH2
+#undef APMU_SDH3
+
+#define APMU_SDH2	APMU_REG(0xe0)
+#define APMU_SDH3	APMU_REG(0xe4)
+
 static void __init pxa168_init_gpio(void)
 {
 	int i;
@@ -65,6 +73,31 @@ void __init pxa168_init_irq(void)
 	pxa168_init_gpio();
 }
 
+static void sdh_clk_enable(struct clk *clk)
+{
+	void __iomem *clk_reg_offset = clk->clk_rst;
+
+	/* Can't see any clean way to do this: Bits 3 & 0 in registers
+	 * for host 0 & 2 should be set for host 1 & 3 also */
+	if (clk_reg_offset == APMU_SDH0 || clk_reg_offset == APMU_SDH1)
+		__raw_writel(__raw_readl(APMU_SDH0) | 0x9, APMU_SDH0);
+	if (clk_reg_offset == APMU_SDH2 || clk_reg_offset == APMU_SDH3)
+		__raw_writel(__raw_readl(APMU_SDH2) | 0x9, APMU_SDH2);
+
+	__raw_writel(__raw_readl(clk->clk_rst) | clk->enable_val, clk->clk_rst);
+}
+
+static void sdh_clk_disable(struct clk *clk)
+{
+	__raw_writel(__raw_readl(clk->clk_rst) & ~(clk->enable_val),
+			clk->clk_rst);
+}
+
+struct clkops sdh_clk_ops = {
+	.enable		= sdh_clk_enable,
+	.disable	= sdh_clk_disable,
+};
+
 /* APB peripheral clocks */
 static APBC_CLK(uart1, PXA168_UART1, 1, 14745600);
 static APBC_CLK(uart2, PXA168_UART2, 1, 14745600);
@@ -87,6 +120,11 @@ static APMU_CLK(lcd, LCD, 0x7f, 312000000);
 static APMU_CLK(eth, ETH, 0x09, 0);
 static APMU_CLK(usb, USB, 0x12, 0);
 
+static APMU_CLK_OPS(sdh1, SDH0, 0x12, 48000000, &sdh_clk_ops);
+static APMU_CLK_OPS(sdh2, SDH1, 0x12, 48000000, &sdh_clk_ops);
+static APMU_CLK_OPS(sdh3, SDH2, 0x12, 48000000, &sdh_clk_ops);
+static APMU_CLK_OPS(sdh4, SDH3, 0x12, 48000000, &sdh_clk_ops);
+
 /* device and clock bindings */
 static struct clk_lookup pxa168_clkregs[] = {
 	INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
@@ -108,6 +146,10 @@ static struct clk_lookup pxa168_clkregs[] = {
 	INIT_CLKREG(&clk_keypad, "pxa27x-keypad", NULL),
 	INIT_CLKREG(&clk_eth, "pxa168-eth", "MFUCLK"),
 	INIT_CLKREG(&clk_usb, "pxa168-ehci", "PXA168-USBCLK"),
+	INIT_CLKREG(&clk_sdh1, NULL, "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh2, NULL, "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh3, NULL, "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh4, NULL, "PXA-SDHCLK"),
 };
 
 static int __init pxa168_init(void)
@@ -173,6 +215,10 @@ PXA168_DEVICE(ssp5, "pxa168-ssp", 4, SSP5, 0xd4021000, 0x40, 60, 61);
 PXA168_DEVICE(fb, "pxa168-fb", -1, LCD, 0xd420b000, 0x1c8);
 PXA168_DEVICE(keypad, "pxa27x-keypad", -1, KEYPAD, 0xd4012000, 0x4c);
 PXA168_DEVICE(eth, "pxa168-eth", -1, MFU, 0xc0800000, 0x0fff);
+PXA168_DEVICE(sdh1, "sdhci-pxav2", 0, SDH1, 0xd4280000, 0x100);
+PXA168_DEVICE(sdh2, "sdhci-pxav2", 1, SDH1, 0xd4281000, 0x100);
+PXA168_DEVICE(sdh3, "sdhci-pxav2", 2, SDH2, 0xd427e000, 0x100);
+PXA168_DEVICE(sdh4, "sdhci-pxav2", 3, SDH2, 0xd427f000, 0x100);
 
 struct resource pxa168_usb_host_resources[] = {
 	/* USB Host conroller register base */
-- 
1.7.0.4

