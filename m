From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 14/31] ARM: amba: netx: get rid of NO_IRQ initializers
Date: Fri, 20 Jan 2012 09:27:08 +0000
Message-ID: <E1RoAkW-0005FD-UH@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60967 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779Ab2ATJ1f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 04:27:35 -0500
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-netx/fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-netx/fb.c b/arch/arm/mach-netx/fb.c
index b991323..eda856c 100644
--- a/arch/arm/mach-netx/fb.c
+++ b/arch/arm/mach-netx/fb.c
@@ -102,7 +102,7 @@ static struct amba_device fb_device = {
 		.end	= 0x00104fff,
 		.flags	= IORESOURCE_MEM,
 	},
-	.irq		= { NETX_IRQ_LCD, NO_IRQ },
+	.irq		= { NETX_IRQ_LCD },
 };
 
 int netx_fb_init(struct clcd_board *board, struct clcd_panel *panel)
-- 
1.7.4.4

