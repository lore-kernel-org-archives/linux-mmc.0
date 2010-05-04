From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 6/9 v2] SH: Add SDHI DMA support to ms7724se
Date: Tue, 4 May 2010 16:06:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005041415190.4925@axis700.grange>
References: <Pine.LNX.4.64.1005041318200.4925@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005041318200.4925@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v1 -> v2:

asm/dmaengine.h is now gone.

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

