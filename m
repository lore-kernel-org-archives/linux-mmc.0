From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 28/31] ARM: amba: u300: use common amba device initializers
Date: Fri, 20 Jan 2012 09:31:51 +0000
Message-ID: <E1RoAp5-0005GA-9Z@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-u300/core.c |   85 ++++++++------------------------------------
 1 files changed, 16 insertions(+), 69 deletions(-)

diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index ed92967..b986560 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -94,19 +94,9 @@ static struct amba_pl011_data uart0_plat_data = {
 #endif
 };
 
-static struct amba_device uart0_device = {
-	.dev = {
-		.coherent_dma_mask = ~0,
-		.init_name = "uart0", /* Slow device at 0x3000 offset */
-		.platform_data = &uart0_plat_data,
-	},
-	.res = {
-		.start = U300_UART0_BASE,
-		.end   = U300_UART0_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	.irq = { IRQ_U300_UART0 },
-};
+/* Slow device at 0x3000 offset */
+static AMBA_APB_DEVICE(uart0, "uart0", 0, U300_UART0_BASE,
+	{ IRQ_U300_UART0 }, &uart0_plat_data);
 
 /* The U335 have an additional UART1 on the APP CPU */
 #ifdef CONFIG_MACH_U300_BS335
@@ -118,71 +108,28 @@ static struct amba_pl011_data uart1_plat_data = {
 #endif
 };
 
-static struct amba_device uart1_device = {
-	.dev = {
-		.coherent_dma_mask = ~0,
-		.init_name = "uart1", /* Fast device at 0x7000 offset */
-		.platform_data = &uart1_plat_data,
-	},
-	.res = {
-		.start = U300_UART1_BASE,
-		.end   = U300_UART1_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	.irq = { IRQ_U300_UART1 },
-};
+/* Fast device at 0x7000 offset */
+static AMBA_APB_DEVICE(uart1, "uart1", 0, U300_UART1_BASE,
+	{ IRQ_U300_UART1 }, &uart1_plat_data);
 #endif
 
-static struct amba_device pl172_device = {
-	.dev = {
-		.init_name = "pl172", /* AHB device at 0x4000 offset */
-		.platform_data = NULL,
-	},
-	.res = {
-		.start = U300_EMIF_CFG_BASE,
-		.end   = U300_EMIF_CFG_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
+/* AHB device at 0x4000 offset */
+static AMBA_APB_DEVICE(pl172, "pl172", 0, U300_EMIF_CFG_BASE, { }, NULL);
 
 
 /*
  * Everything within this next ifdef deals with external devices connected to
  * the APP SPI bus.
  */
-static struct amba_device pl022_device = {
-	.dev = {
-		.coherent_dma_mask = ~0,
-		.init_name = "pl022", /* Fast device at 0x6000 offset */
-	},
-	.res = {
-		.start = U300_SPI_BASE,
-		.end   = U300_SPI_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	.irq = {IRQ_U300_SPI },
-	/*
-	 * This device has a DMA channel but the Linux driver does not use
-	 * it currently.
-	 */
-};
+/* Fast device at 0x6000 offset */
+static AMBA_APB_DEVICE(pl022, "pl022", 0, U300_SPI_BASE,
+	{ IRQ_U300_SPI }, NULL);
 
-static struct amba_device mmcsd_device = {
-	.dev = {
-		.init_name = "mmci", /* Fast device at 0x1000 offset */
-		.platform_data = NULL, /* Added later */
-	},
-	.res = {
-		.start = U300_MMCSD_BASE,
-		.end   = U300_MMCSD_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	.irq = {IRQ_U300_MMCSD_MCIINTR0, IRQ_U300_MMCSD_MCIINTR1 },
-	/*
-	 * This device has a DMA channel but the Linux driver does not use
-	 * it currently.
-	 */
-};
+/* Fast device at 0x1000 offset */
+#define U300_MMCSD_IRQS	{ IRQ_U300_MMCSD_MCIINTR0, IRQ_U300_MMCSD_MCIINTR1 }
+
+static AMBA_APB_DEVICE(mmcsd, "mmci", 0, U300_MMCSD_BASE,
+	U300_MMCSD_IRQS, NULL);
 
 /*
  * The order of device declaration may be important, since some devices
-- 
1.7.4.4
