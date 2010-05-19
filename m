From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 9/10 v2] SH: Add SDHI DMA support to kfr2r09
Date: Wed, 19 May 2010 20:34:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005191810210.3099@axis700.grange>
References: <Pine.LNX.4.64.1005191750400.3099@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:46265 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753535Ab0ESSe2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 May 2010 14:34:28 -0400
In-Reply-To: <Pine.LNX.4.64.1005191750400.3099@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, dan.j.williams@intel.com, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, sameo@linux.intel.com, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v1 -> v2:

asm/dmaengine.h is now gone.

 arch/sh/boards/mach-kfr2r09/setup.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index b2cd0ed..95850aa 100644
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
@@ -356,10 +357,18 @@ static struct resource kfr2r09_sh_sdhi0_resources[] = {
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

