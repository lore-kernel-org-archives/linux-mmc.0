From: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Subject: [PATCH v2 1/3] ARM: pxa168: Add SDHCI support
Date: Fri,  4 Nov 2011 15:09:07 +0530
Message-ID: <1320399547-2374-1-git-send-email-tanmay.upadhyay@einfochips.com>
References: <y>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ahm.einfochips.com ([203.76.128.206]:40214 "EHLO
	ahm.einfochips.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884Ab1KDJj0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2011 05:39:26 -0400
In-Reply-To: <y>
In-Reply-To: <1319546069-31742-1-git-send-email-tanmay.upadhyay@einfochips.com>
References: <1319546069-31742-1-git-send-email-tanmay.upadhyay@einfochips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: eric.y.miao@gmail.com, jason.chagas@marvell.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, cjb@laptop.org, Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>

v2 - clock register for SDHCI are not common across all MMP SoCs.
So, move PXA168 implementation to pxa168.c

Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
---
 arch/arm/mach-mmp/clock.c               |    1 +
 arch/arm/mach-mmp/clock.h               |    1 +
 arch/arm/mach-mmp/include/mach/pxa168.h |   20 +++++++++++++
 arch/arm/mach-mmp/pxa168.c              |   46 +++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/clock.c b/arch/arm/mach-mmp/clock.c
index 7c6f95f..eefefea 100644
--- a/arch/arm/mach-mmp/clock.c
+++ b/arch/arm/mach-mmp/clock.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 
 #include <mach/regs-apbc.h>
+#include <mach/regs-apmu.h>
 #include "clock.h"
 
 static void apbc_clk_enable(struct clk *clk)
diff --git a/arch/arm/mach-mmp/clock.h b/arch/arm/mach-mmp/clock.h
index 3143e99..1243e4d 100644
--- a/arch/arm/mach-mmp/clock.h
+++ b/arch/arm/mach-mmp/clock.h
@@ -27,6 +27,7 @@ struct clk {
 
 extern struct clkops apbc_clk_ops;
 extern struct clkops apmu_clk_ops;
+extern struct clkops sdh_clk_ops;
 
 #define APBC_CLK(_name, _reg, _fnclksel, _rate)			\
 struct clk clk_##_name = {					\
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
index 7f00584..390a550 100644
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
+extern struct pxa_device_desc pxa168_device_sdh0;
+extern struct pxa_device_desc pxa168_device_sdh1;
+extern struct pxa_device_desc pxa168_device_sdh2;
+extern struct pxa_device_desc pxa168_device_sdh3;
 
 static inline int pxa168_add_uart(int id)
 {
@@ -125,4 +130,19 @@ static inline int pxa168_add_eth(struct pxa168_eth_platform_data *data)
 {
 	return pxa_register_device(&pxa168_device_eth, data, sizeof(*data));
 }
+
+static inline int pxa168_add_sdh(int id, struct sdhci_pxa_platdata *data)
+{
+	struct pxa_device_desc *d = NULL;
+
+	switch (id) {
+	case 0: d = &pxa168_device_sdh0; break;
+	case 1: d = &pxa168_device_sdh1; break;
+	case 2: d = &pxa168_device_sdh2; break;
+	case 3: d = &pxa168_device_sdh3; break;
+	default:
+		return -EINVAL;
+	}
+	return pxa_register_device(d, data, sizeof(*data));
+}
 #endif /* __ASM_MACH_PXA168_H */
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 0156f53..868605d 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -43,6 +43,14 @@ static struct mfp_addr_map pxa168_mfp_addr_map[] __initdata =
 
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
@@ -63,6 +71,31 @@ void __init pxa168_init_irq(void)
 	pxa168_init_gpio();
 }
 
+static void sdh_clk_enable(struct clk *clk)
+{
+	unsigned long clk_reg_offset = (unsigned long) clk->clk_rst;
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
@@ -84,6 +117,11 @@ static APMU_CLK(nand, NAND, 0x19b, 156000000);
 static APMU_CLK(lcd, LCD, 0x7f, 312000000);
 static APMU_CLK(eth, ETH, 0x09, 0);
 
+static APMU_CLK_OPS(sdh0, SDH0, 0x12, 48000000, &sdh_clk_ops);
+static APMU_CLK_OPS(sdh1, SDH1, 0x12, 48000000, &sdh_clk_ops);
+static APMU_CLK_OPS(sdh2, SDH2, 0x12, 48000000, &sdh_clk_ops);
+static APMU_CLK_OPS(sdh3, SDH3, 0x12, 48000000, &sdh_clk_ops);
+
 /* device and clock bindings */
 static struct clk_lookup pxa168_clkregs[] = {
 	INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
@@ -104,6 +142,10 @@ static struct clk_lookup pxa168_clkregs[] = {
 	INIT_CLKREG(&clk_lcd, "pxa168-fb", NULL),
 	INIT_CLKREG(&clk_keypad, "pxa27x-keypad", NULL),
 	INIT_CLKREG(&clk_eth, "pxa168-eth", "MFUCLK"),
+	INIT_CLKREG(&clk_sdh0, "sdhci-pxav1.0", "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh1, "sdhci-pxav1.1", "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh2, "sdhci-pxav1.2", "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh3, "sdhci-pxav1.3", "PXA-SDHCLK"),
 };
 
 static int __init pxa168_init(void)
@@ -169,3 +211,7 @@ PXA168_DEVICE(ssp5, "pxa168-ssp", 4, SSP5, 0xd4021000, 0x40, 60, 61);
 PXA168_DEVICE(fb, "pxa168-fb", -1, LCD, 0xd420b000, 0x1c8);
 PXA168_DEVICE(keypad, "pxa27x-keypad", -1, KEYPAD, 0xd4012000, 0x4c);
 PXA168_DEVICE(eth, "pxa168-eth", -1, MFU, 0xc0800000, 0x0fff);
+PXA168_DEVICE(sdh0, "sdhci-pxav1", 0, SDH1, 0xd4280000, 0x100);
+PXA168_DEVICE(sdh1, "sdhci-pxav1", 1, SDH1, 0xd4281000, 0x100);
+PXA168_DEVICE(sdh2, "sdhci-pxav1", 2, SDH2, 0xd427e000, 0x100);
+PXA168_DEVICE(sdh3, "sdhci-pxav1", 3, SDH2, 0xd427f000, 0x100);
-- 
1.7.0.4

