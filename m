From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 7/8] SH: Add SDHI DMA support to kfr2r09
Date: Wed, 21 Apr 2010 17:37:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1004211735470.5292@axis700.grange>
References: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:47827 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755772Ab0DUPhQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Apr 2010 11:37:16 -0400
In-Reply-To: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-kfr2r09/setup.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index b2cd0ed..6e76747 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/mfd/sh_mobile_sdhi.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/onenand.h>
 #include <linux/delay.h>
@@ -25,6 +26,7 @@
 #include <video/sh_mobile_lcdc.h>
 #include <asm/suspend.h>
 #include <asm/clock.h>
+#include <asm/dmaengine.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
 #include <cpu/sh7724.h>
@@ -356,10 +358,18 @@ static struct resource kfr2r09_sh_sdhi0_resources[] = {
 	},
 };
 
+static struct sh_mobile_sdhi_info sh7724_sdhi0_data = {
+	.dma_slave_tx = SHDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx = SHDMA_SLAVE_SDHI0_RX,
+};
+
 static struct platform_device kfr2r09_sh_sdhi0_device = {
 	.name           = "sh_mobile_sdhi",
 	.num_resources  = ARRAY_SIZE(kfr2r09_sh_sdhi0_resources),
 	.resource       = kfr2r09_sh_sdhi0_resources,
+	.dev = {
+		.platform_data	= &sh7724_sdhi0_data,
+	},
 	.archdata = {
 		.hwblk_id = HWBLK_SDHI0,
 	},
-- 
1.6.2.4

