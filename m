From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 09/31] ARM: amba: samsung: get rid of NO_IRQ initializers
Date: Fri, 20 Jan 2012 09:25:27 +0000
Message-ID: <E1RoAit-0005Er-2s@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37472 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665Ab2ATJZy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 04:25:54 -0500
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-exynos/dma.c  |    4 ++--
 arch/arm/mach-s5p64x0/dma.c |    2 +-
 arch/arm/mach-s5pc100/dma.c |    4 ++--
 arch/arm/mach-s5pv210/dma.c |    4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-exynos/dma.c b/arch/arm/mach-exynos/dma.c
index b10fcd2..8d681bf 100644
--- a/arch/arm/mach-exynos/dma.c
+++ b/arch/arm/mach-exynos/dma.c
@@ -86,7 +86,7 @@ struct amba_device exynos4_device_pdma0 = {
 		.end = EXYNOS4_PA_PDMA0 + SZ_4K,
 		.flags = IORESOURCE_MEM,
 	},
-	.irq = {IRQ_PDMA0, NO_IRQ},
+	.irq = {IRQ_PDMA0},
 	.periphid = 0x00041330,
 };
 
@@ -135,7 +135,7 @@ struct amba_device exynos4_device_pdma1 = {
 		.end = EXYNOS4_PA_PDMA1 + SZ_4K,
 		.flags = IORESOURCE_MEM,
 	},
-	.irq = {IRQ_PDMA1, NO_IRQ},
+	.irq = {IRQ_PDMA1},
 	.periphid = 0x00041330,
 };
 
diff --git a/arch/arm/mach-s5p64x0/dma.c b/arch/arm/mach-s5p64x0/dma.c
index f820c07..99049aa 100644
--- a/arch/arm/mach-s5p64x0/dma.c
+++ b/arch/arm/mach-s5p64x0/dma.c
@@ -119,7 +119,7 @@ struct amba_device s5p64x0_device_pdma = {
 		.end = S5P64X0_PA_PDMA + SZ_4K,
 		.flags = IORESOURCE_MEM,
 	},
-	.irq = {IRQ_DMA0, NO_IRQ},
+	.irq = {IRQ_DMA0},
 	.periphid = 0x00041330,
 };
 
diff --git a/arch/arm/mach-s5pc100/dma.c b/arch/arm/mach-s5pc100/dma.c
index c841f4d3..ac08d7e 100644
--- a/arch/arm/mach-s5pc100/dma.c
+++ b/arch/arm/mach-s5pc100/dma.c
@@ -85,7 +85,7 @@ struct amba_device s5pc100_device_pdma0 = {
 		.end = S5PC100_PA_PDMA0 + SZ_4K,
 		.flags = IORESOURCE_MEM,
 	},
-	.irq = {IRQ_PDMA0, NO_IRQ},
+	.irq = {IRQ_PDMA0},
 	.periphid = 0x00041330,
 };
 
@@ -139,7 +139,7 @@ struct amba_device s5pc100_device_pdma1 = {
 		.end = S5PC100_PA_PDMA1 + SZ_4K,
 		.flags = IORESOURCE_MEM,
 	},
-	.irq = {IRQ_PDMA1, NO_IRQ},
+	.irq = {IRQ_PDMA1},
 	.periphid = 0x00041330,
 };
 
diff --git a/arch/arm/mach-s5pv210/dma.c b/arch/arm/mach-s5pv210/dma.c
index a6113e0..8602fa5 100644
--- a/arch/arm/mach-s5pv210/dma.c
+++ b/arch/arm/mach-s5pv210/dma.c
@@ -83,7 +83,7 @@ struct amba_device s5pv210_device_pdma0 = {
 		.end = S5PV210_PA_PDMA0 + SZ_4K,
 		.flags = IORESOURCE_MEM,
 	},
-	.irq = {IRQ_PDMA0, NO_IRQ},
+	.irq = {IRQ_PDMA0},
 	.periphid = 0x00041330,
 };
 
@@ -139,7 +139,7 @@ struct amba_device s5pv210_device_pdma1 = {
 		.end = S5PV210_PA_PDMA1 + SZ_4K,
 		.flags = IORESOURCE_MEM,
 	},
-	.irq = {IRQ_PDMA1, NO_IRQ},
+	.irq = {IRQ_PDMA1},
 	.periphid = 0x00041330,
 };
 
-- 
1.7.4.4

