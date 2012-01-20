From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH 16/31] ARM: amba: u300: get rid of NO_IRQ initializers
Date: Fri, 20 Jan 2012 09:27:49 +0000
Message-ID: <E1RoAlB-0005FL-Pi@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120120092207.GD1068-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson <STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
 arch/arm/mach-u300/core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index b4c6926..ed92967 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -105,7 +105,7 @@ static struct amba_device uart0_device = {
 		.end   = U300_UART0_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
-	.irq = { IRQ_U300_UART0, NO_IRQ },
+	.irq = { IRQ_U300_UART0 },
 };
 
 /* The U335 have an additional UART1 on the APP CPU */
@@ -129,7 +129,7 @@ static struct amba_device uart1_device = {
 		.end   = U300_UART1_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
-	.irq = { IRQ_U300_UART1, NO_IRQ },
+	.irq = { IRQ_U300_UART1 },
 };
 #endif
 
@@ -160,7 +160,7 @@ static struct amba_device pl022_device = {
 		.end   = U300_SPI_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
-	.irq = {IRQ_U300_SPI, NO_IRQ },
+	.irq = {IRQ_U300_SPI },
 	/*
 	 * This device has a DMA channel but the Linux driver does not use
 	 * it currently.
-- 
1.7.4.4
