From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 19/31] ARM: amba: vexpress: get rid of private platform
 amba_device initializer
Date: Fri, 20 Jan 2012 09:28:50 +0000
Message-ID: <E1RoAmA-0005FX-5m@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:32770 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab2ATJ3P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 04:29:15 -0500
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-vexpress/core.h     |   17 -----------------
 arch/arm/mach-vexpress/ct-ca9x4.c |    8 ++++----
 arch/arm/mach-vexpress/v2m.c      |   20 ++++++++++----------
 3 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
index f439715..9f0f282 100644
--- a/arch/arm/mach-vexpress/core.h
+++ b/arch/arm/mach-vexpress/core.h
@@ -1,19 +1,2 @@
 #define __MMIO_P2V(x)	(((x) & 0xfffff) | (((x) & 0x0f000000) >> 4) | 0xf8000000)
 #define MMIO_P2V(x)	((void __iomem *)__MMIO_P2V(x))
-
-#define AMBA_DEVICE(name,busid,base,plat)	\
-struct amba_device name##_device = {		\
-	.dev		= {			\
-		.coherent_dma_mask = ~0UL,	\
-		.init_name = busid,		\
-		.platform_data = plat,		\
-	},					\
-	.res		= {			\
-		.start	= base,			\
-		.end	= base + SZ_4K - 1,	\
-		.flags	= IORESOURCE_MEM,	\
-	},					\
-	.dma_mask	= ~0UL,			\
-	.irq		= IRQ_##base,		\
-	/* .dma		= DMA_##base,*/		\
-}
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 2b1e836..3fde21c 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -109,10 +109,10 @@ static struct clcd_board ct_ca9x4_clcd_data = {
 	.remove		= versatile_clcd_remove_dma,
 };
 
-static AMBA_DEVICE(clcd, "ct:clcd", CT_CA9X4_CLCDC, &ct_ca9x4_clcd_data);
-static AMBA_DEVICE(dmc, "ct:dmc", CT_CA9X4_DMC, NULL);
-static AMBA_DEVICE(smc, "ct:smc", CT_CA9X4_SMC, NULL);
-static AMBA_DEVICE(gpio, "ct:gpio", CT_CA9X4_GPIO, NULL);
+static AMBA_AHB_DEVICE(clcd, "ct:clcd", 0, CT_CA9X4_CLCDC, IRQ_CT_CA9X4_CLCDC, &ct_ca9x4_clcd_data);
+static AMBA_APB_DEVICE(dmc, "ct:dmc", 0, CT_CA9X4_DMC, IRQ_CT_CA9X4_DMC, NULL);
+static AMBA_APB_DEVICE(smc, "ct:smc", 0, CT_CA9X4_SMC, IRQ_CT_CA9X4_SMC, NULL);
+static AMBA_APB_DEVICE(gpio, "ct:gpio", 0, CT_CA9X4_GPIO, IRQ_CT_CA9X4_GPIO, NULL);
 
 static struct amba_device *ct_ca9x4_amba_devs[] __initdata = {
 	&clcd_device,
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index b4a28ca..ad64f97 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -266,16 +266,16 @@ static struct mmci_platform_data v2m_mmci_data = {
 	.status		= v2m_mmci_status,
 };
 
-static AMBA_DEVICE(aaci,  "mb:aaci",  V2M_AACI, NULL);
-static AMBA_DEVICE(mmci,  "mb:mmci",  V2M_MMCI, &v2m_mmci_data);
-static AMBA_DEVICE(kmi0,  "mb:kmi0",  V2M_KMI0, NULL);
-static AMBA_DEVICE(kmi1,  "mb:kmi1",  V2M_KMI1, NULL);
-static AMBA_DEVICE(uart0, "mb:uart0", V2M_UART0, NULL);
-static AMBA_DEVICE(uart1, "mb:uart1", V2M_UART1, NULL);
-static AMBA_DEVICE(uart2, "mb:uart2", V2M_UART2, NULL);
-static AMBA_DEVICE(uart3, "mb:uart3", V2M_UART3, NULL);
-static AMBA_DEVICE(wdt,   "mb:wdt",   V2M_WDT, NULL);
-static AMBA_DEVICE(rtc,   "mb:rtc",   V2M_RTC, NULL);
+static AMBA_APB_DEVICE(aaci,  "mb:aaci",  0, V2M_AACI, IRQ_V2M_AACI, NULL);
+static AMBA_APB_DEVICE(mmci,  "mb:mmci",  0, V2M_MMCI, IRQ_V2M_MMCI, &v2m_mmci_data);
+static AMBA_APB_DEVICE(kmi0,  "mb:kmi0",  0, V2M_KMI0, IRQ_V2M_KMI0, NULL);
+static AMBA_APB_DEVICE(kmi1,  "mb:kmi1",  0, V2M_KMI1, IRQ_V2M_KMI1, NULL);
+static AMBA_APB_DEVICE(uart0, "mb:uart0", 0, V2M_UART0, IRQ_V2M_UART0, NULL);
+static AMBA_APB_DEVICE(uart1, "mb:uart1", 0, V2M_UART1, IRQ_V2M_UART1, NULL);
+static AMBA_APB_DEVICE(uart2, "mb:uart2", 0, V2M_UART2, IRQ_V2M_UART2, NULL);
+static AMBA_APB_DEVICE(uart3, "mb:uart3", 0, V2M_UART3, IRQ_V2M_UART3, NULL);
+static AMBA_APB_DEVICE(wdt,   "mb:wdt",   0, V2M_WDT, IRQ_V2M_WDT, NULL);
+static AMBA_APB_DEVICE(rtc,   "mb:rtc",   0, V2M_RTC, IRQ_V2M_RTC, NULL);
 
 static struct amba_device *v2m_amba_devs[] __initdata = {
 	&aaci_device,
-- 
1.7.4.4

