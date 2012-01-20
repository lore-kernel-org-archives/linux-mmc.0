From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 29/31] ARM: amba: nomadik: use common amba device
 initializers
Date: Fri, 20 Jan 2012 09:32:11 +0000
Message-ID: <E1RoApP-0005GE-D8@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56763 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880Ab2ATJcr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 04:32:47 -0500
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>
Cc: Alessandro Rubini <rubini@unipv.it>, Linus Walleij <linus.walleij@stericsson.com>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-nomadik/board-nhk8815.c |   17 ++++-------------
 arch/arm/mach-nomadik/cpu-8815.c      |    9 ++-------
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 721e51c..f6f74ad 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -185,20 +185,11 @@ static void __init nhk8815_onenand_init(void)
 #endif
 }
 
-#define __MEM_4K_RESOURCE(x) \
-	.res = {.start = (x), .end = (x) + SZ_4K - 1, .flags = IORESOURCE_MEM}
+static AMBA_APB_DEVICE(uart0, "uart0", 0, NOMADIK_UART0_BASE,
+	{ IRQ_UART0 }, NULL);
 
-static struct amba_device uart0_device = {
-	.dev = { .init_name = "uart0" },
-	__MEM_4K_RESOURCE(NOMADIK_UART0_BASE),
-	.irq = {IRQ_UART0},
-};
-
-static struct amba_device uart1_device = {
-	.dev = { .init_name = "uart1" },
-	__MEM_4K_RESOURCE(NOMADIK_UART1_BASE),
-	.irq = {IRQ_UART1},
-};
+static AMBA_APB_DEVICE(uart1, "uart1", 0, NOMADIK_UART1_BASE,
+	{ IRQ_UART1 }, NULL);
 
 static struct amba_device *amba_devs[] __initdata = {
 	&uart0_device,
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 65df7b4..27f43a4 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -97,12 +97,7 @@ static struct platform_device cpu8815_platform_gpio[] = {
 	GPIO_DEVICE(3),
 };
 
-static struct amba_device cpu8815_amba_rng = {
-	.dev = {
-		.init_name = "rng",
-	},
-	__MEM_4K_RESOURCE(NOMADIK_RNG_BASE),
-};
+static AMBA_APB_DEVICE(cpu8815_amba_rng, "rng", 0, NOMADIK_RNG_BASE, { }, NULL);
 
 static struct platform_device *platform_devs[] __initdata = {
 	cpu8815_platform_gpio + 0,
@@ -112,7 +107,7 @@ static struct platform_device *platform_devs[] __initdata = {
 };
 
 static struct amba_device *amba_devs[] __initdata = {
-	&cpu8815_amba_rng
+	&cpu8815_amba_rng_device
 };
 
 static int __init cpu8815_init(void)
-- 
1.7.4.4

