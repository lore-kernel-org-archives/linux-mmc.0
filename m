From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 8/9 v2] SH: Add SDHI DMA support to migor
Date: Tue, 4 May 2010 16:06:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005041421340.4925@axis700.grange>
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

 arch/sh/boards/mach-migor/setup.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 7da0fc9..87185de 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
+#include <linux/mfd/sh_mobile_sdhi.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/nand.h>
 #include <linux/i2c.h>
@@ -402,10 +403,18 @@ static struct resource sdhi_cn9_resources[] = {
 	},
 };
 
+static struct sh_mobile_sdhi_info sh7724_sdhi_data = {
+	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+};
+
 static struct platform_device sdhi_cn9_device = {
 	.name		= "sh_mobile_sdhi",
 	.num_resources	= ARRAY_SIZE(sdhi_cn9_resources),
 	.resource	= sdhi_cn9_resources,
+	.dev = {
+		.platform_data	= &sh7724_sdhi_data,
+	},
 	.archdata = {
 		.hwblk_id = HWBLK_SDHI,
 	},
-- 
1.6.2.4

