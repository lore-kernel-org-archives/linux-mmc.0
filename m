From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 11/31] ARM: amba: lpc32xx: get rid of NO_IRQ initializers
Date: Fri, 20 Jan 2012 09:26:07 +0000
Message-ID: <E1RoAjX-0005F1-KZ@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37490 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620Ab2ATJ0h (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 04:26:37 -0500
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-lpc32xx/phy3250.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index bfee5b4..025eb21 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -161,7 +161,7 @@ static struct amba_device lpc32xx_clcd_device = {
 		.flags			= IORESOURCE_MEM,
 	},
 	.dma_mask			= ~0,
-	.irq				= {IRQ_LPC32XX_LCD, NO_IRQ},
+	.irq				= {IRQ_LPC32XX_LCD},
 };
 
 /*
@@ -203,7 +203,7 @@ static struct amba_device lpc32xx_ssp0_device = {
 		.flags			= IORESOURCE_MEM,
 	},
 	.dma_mask			= ~0,
-	.irq				= {IRQ_LPC32XX_SSP0, NO_IRQ},
+	.irq				= {IRQ_LPC32XX_SSP0},
 };
 
 /* AT25 driver registration */
-- 
1.7.4.4

