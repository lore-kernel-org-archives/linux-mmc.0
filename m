From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 8/10 v2] SH: Add SDHI DMA support to ms7724se
Date: Wed, 19 May 2010 20:34:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005191809310.3099@axis700.grange>
References: <Pine.LNX.4.64.1005191750400.3099@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42331 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752044Ab0ESSer (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 May 2010 14:34:47 -0400
In-Reply-To: <Pine.LNX.4.64.1005191750400.3099@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, dan.j.williams@intel.com, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, sameo@linux.intel.com, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-se/7724/setup.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 66cdbc3..553cdfe 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/sh_mobile_sdhi.h>
 #include <linux/mtd/physmap.h>
 #include <linux/delay.h>
 #include <linux/smc91x.h>
@@ -456,11 +457,19 @@ static struct resource sdhi0_cn7_resources[] = {
 	},
 };
 
+static struct sh_mobile_sdhi_info sh7724_sdhi0_data = {
+	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+};
+
 static struct platform_device sdhi0_cn7_device = {
 	.name           = "sh_mobile_sdhi",
 	.id		= 0,
 	.num_resources  = ARRAY_SIZE(sdhi0_cn7_resources),
 	.resource       = sdhi0_cn7_resources,
+	.dev = {
+		.platform_data	= &sh7724_sdhi0_data,
+	},
 	.archdata = {
 		.hwblk_id = HWBLK_SDHI0,
 	},
@@ -479,11 +488,19 @@ static struct resource sdhi1_cn8_resources[] = {
 	},
 };
 
+static struct sh_mobile_sdhi_info sh7724_sdhi1_data = {
+	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
+};
+
 static struct platform_device sdhi1_cn8_device = {
 	.name           = "sh_mobile_sdhi",
 	.id		= 1,
 	.num_resources  = ARRAY_SIZE(sdhi1_cn8_resources),
 	.resource       = sdhi1_cn8_resources,
+	.dev = {
+		.platform_data	= &sh7724_sdhi1_data,
+	},
 	.archdata = {
 		.hwblk_id = HWBLK_SDHI1,
 	},
-- 
1.6.2.4

