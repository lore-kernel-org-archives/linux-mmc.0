From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 12/31] ARM: amba: mxs: get rid of NO_IRQ initializers
Date: Fri, 20 Jan 2012 09:26:28 +0000
Message-ID: <E1RoAjs-0005F5-2V@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60947 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab2ATJ04 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 04:26:56 -0500
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>
Cc: Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-mxs/devices/amba-duart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/devices/amba-duart.c b/arch/arm/mach-mxs/devices/amba-duart.c
index a559db0..a5479f7 100644
--- a/arch/arm/mach-mxs/devices/amba-duart.c
+++ b/arch/arm/mach-mxs/devices/amba-duart.c
@@ -23,7 +23,7 @@ const struct amba_device name##_device __initconst = {		\
 		.end = (soc ## _DUART_BASE_ADDR) + SZ_8K - 1,	\
 		.flags = IORESOURCE_MEM,			\
 	},							\
-	.irq = {soc ## _INT_DUART, NO_IRQ},			\
+	.irq = {soc ## _INT_DUART},				\
 }
 
 #ifdef CONFIG_SOC_IMX23
-- 
1.7.4.4

