From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 26/31] ARM: amba: netx: use common amba device initializers
Date: Fri, 20 Jan 2012 09:31:11 +0000
Message-ID: <E1RoAoR-0005G2-1Y@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:32830 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893Ab2ATJbo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 04:31:44 -0500
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-netx/fb.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-netx/fb.c b/arch/arm/mach-netx/fb.c
index eda856c..2cdf6ef 100644
--- a/arch/arm/mach-netx/fb.c
+++ b/arch/arm/mach-netx/fb.c
@@ -92,18 +92,7 @@ void clk_put(struct clk *clk)
 {
 }
 
-static struct amba_device fb_device = {
-	.dev		= {
-		.init_name = "fb",
-		.coherent_dma_mask = ~0,
-	},
-	.res		= {
-		.start	= 0x00104000,
-		.end	= 0x00104fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	.irq		= { NETX_IRQ_LCD },
-};
+static AMBA_AHB_DEVICE(fb, "fb", 0, 0x00104000, { NETX_IRQ_LCD }, NULL);
 
 int netx_fb_init(struct clcd_board *board, struct clcd_panel *panel)
 {
-- 
1.7.4.4

