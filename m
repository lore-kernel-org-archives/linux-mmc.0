From: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Subject: [PATCH v4 2/4] ARM: pxa168: Add SDHCI support
Date: Tue, 20 Dec 2011 18:43:01 +0530
Message-ID: <1324386781-25271-1-git-send-email-tanmay.upadhyay@einfochips.com>
References: <CAN1soZxZjdzivfttUhDDvjUDiyiAC5SSKtB0rXR1D=3=q6O0wQ@mail.gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ahm.einfochips.com ([203.76.128.206]:55975 "EHLO
	ahm.einfochips.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab1LTNNe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2011 08:13:34 -0500
In-Reply-To: <CAN1soZxZjdzivfttUhDDvjUDiyiAC5SSKtB0rXR1D=3=q6O0wQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: haojian.zhuang@gmail.com, eric.y.miao@gmail.com, jason.chagas@marvell.com
Cc: prakity@marvell.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>

v2 - clock register for SDHCI are not common across all MMP SoCs.
     So, move PXA168 implementation to pxa168.c

v3 - sdhci-pxav1 driver code is merged with sdhci-pxav2. So, change
     the device name accordingly
   - start sdhci device numbering from 1 as other PXA168 devices
     does that

v4 - Use different names for SD clock registers for PXA168 instead
     of redefining them in pxa168.c. Suggested by Haojian Zhuang

Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Reviewed-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/include/mach/pxa168.h    |   20 ++++++++++++++
 arch/arm/mach-mmp/include/mach/regs-apmu.h |   40 ++++++++++++++-------------
 arch/arm/mach-mmp/pxa168.c                 |   39 +++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 19 deletions(-)

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
diff --git a/arch/arm/mach-mmp/include/mach/regs-apmu.h b/arch/arm/mach-mmp/include/mach/regs-apmu.h
index 8447ac6..a84de77 100644
--- a/arch/arm/mach-mmp/include/mach/regs-apmu.h
+++ b/arch/arm/mach-mmp/include/mach/regs-apmu.h
@@ -17,27 +17,29 @@
 #define APMU_REG(x)	(APMU_VIRT_BASE + (x))
 
 /* Clock Reset Control */
-#define APMU_IRE	APMU_REG(0x048)
-#define APMU_LCD	APMU_REG(0x04c)
-#define APMU_CCIC	APMU_REG(0x050)
-#define APMU_SDH0	APMU_REG(0x054)
-#define APMU_SDH1	APMU_REG(0x058)
-#define APMU_USB	APMU_REG(0x05c)
-#define APMU_NAND	APMU_REG(0x060)
-#define APMU_DMA	APMU_REG(0x064)
-#define APMU_GEU	APMU_REG(0x068)
-#define APMU_BUS	APMU_REG(0x06c)
-#define APMU_SDH2	APMU_REG(0x0e8)
-#define APMU_SDH3	APMU_REG(0x0ec)
-#define APMU_ETH	APMU_REG(0x0fc)
-
-#define APMU_FNCLK_EN	(1 << 4)
-#define APMU_AXICLK_EN	(1 << 3)
-#define APMU_FNRST_DIS	(1 << 1)
-#define APMU_AXIRST_DIS	(1 << 0)
+#define APMU_IRE		APMU_REG(0x048)
+#define APMU_LCD		APMU_REG(0x04c)
+#define APMU_CCIC		APMU_REG(0x050)
+#define APMU_SDH0		APMU_REG(0x054)
+#define APMU_SDH1		APMU_REG(0x058)
+#define APMU_USB		APMU_REG(0x05c)
+#define APMU_NAND		APMU_REG(0x060)
+#define APMU_DMA		APMU_REG(0x064)
+#define APMU_GEU		APMU_REG(0x068)
+#define APMU_BUS		APMU_REG(0x06c)
+#define APMU_PXA168_SDH2	APMU_REG(0x0e0)
+#define APMU_PXA168_SDH3	APMU_REG(0x0e4)
+#define APMU_SDH2		APMU_REG(0x0e8)
+#define APMU_SDH3		APMU_REG(0x0ec)
+#define APMU_ETH		APMU_REG(0x0fc)
+
+#define APMU_FNCLK_EN		(1 << 4)
+#define APMU_AXICLK_EN		(1 << 3)
+#define APMU_FNRST_DIS		(1 << 1)
+#define APMU_AXIRST_DIS		(1 << 0)
 
 /* Wake Clear Register */
-#define APMU_WAKE_CLR	APMU_REG(0x07c)
+#define APMU_WAKE_CLR		APMU_REG(0x07c)
 
 #define APMU_PXA168_KP_WAKE_CLR		(1 << 7)
 #define APMU_PXA168_CFI_WAKE_CLR	(1 << 6)
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 76ca15c..023659b 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -65,6 +65,32 @@ void __init pxa168_init_irq(void)
 	pxa168_init_gpio();
 }
 
+static void sdh_clk_enable(struct clk *clk)
+{
+	void __iomem *reg_offset = clk->clk_rst;
+
+	/* Can't see any clean way to do this: Bits 3 & 0 in registers
+	 * for host 0 & 2 should be set for host 1 & 3 also */
+	if (reg_offset == APMU_SDH0 || reg_offset == APMU_SDH1)
+		__raw_writel(__raw_readl(APMU_SDH0) | 0x9, APMU_SDH0);
+	if (reg_offset == APMU_PXA168_SDH2 || reg_offset == APMU_PXA168_SDH3)
+		__raw_writel(__raw_readl(APMU_PXA168_SDH2) | 0x9,
+				APMU_PXA168_SDH2);
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
@@ -87,6 +113,11 @@ static APMU_CLK(lcd, LCD, 0x7f, 312000000);
 static APMU_CLK(eth, ETH, 0x09, 0);
 static APMU_CLK(usb, USB, 0x12, 0);
 
+static APMU_CLK_OPS(sdh1, SDH0, 0x12, 48000000, &sdh_clk_ops);
+static APMU_CLK_OPS(sdh2, SDH1, 0x12, 48000000, &sdh_clk_ops);
+static APMU_CLK_OPS(sdh3, PXA168_SDH2, 0x12, 48000000, &sdh_clk_ops);
+static APMU_CLK_OPS(sdh4, PXA168_SDH3, 0x12, 48000000, &sdh_clk_ops);
+
 /* device and clock bindings */
 static struct clk_lookup pxa168_clkregs[] = {
 	INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
@@ -108,6 +139,10 @@ static struct clk_lookup pxa168_clkregs[] = {
 	INIT_CLKREG(&clk_keypad, "pxa27x-keypad", NULL),
 	INIT_CLKREG(&clk_eth, "pxa168-eth", "MFUCLK"),
 	INIT_CLKREG(&clk_usb, "pxa168-ehci", "PXA168-USBCLK"),
+	INIT_CLKREG(&clk_sdh1, NULL, "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh2, NULL, "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh3, NULL, "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh4, NULL, "PXA-SDHCLK"),
 };
 
 static int __init pxa168_init(void)
@@ -173,6 +208,10 @@ PXA168_DEVICE(ssp5, "pxa168-ssp", 4, SSP5, 0xd4021000, 0x40, 60, 61);
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

