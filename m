From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/3] sh: disable SD-card write-protection detection on kfr2r09
Date: Tue, 11 May 2010 11:52:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005111152000.6810@axis700.grange>
References: <Pine.LNX.4.64.1005111146330.6810@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005111146330.6810@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

kfr2r09 board has a micro-SD card slot, therefore card write-protection
detection cannot work there, disable it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-kfr2r09/setup.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 95850aa..68994a1 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/sh_mobile_sdhi.h>
+#include <linux/mfd/tmio.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/onenand.h>
 #include <linux/delay.h>
@@ -358,8 +359,9 @@ static struct resource kfr2r09_sh_sdhi0_resources[] = {
 };
 
 static struct sh_mobile_sdhi_info sh7724_sdhi0_data = {
-	.dma_slave_tx = SHDMA_SLAVE_SDHI0_TX,
-	.dma_slave_rx = SHDMA_SLAVE_SDHI0_RX,
+	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
 };
 
 static struct platform_device kfr2r09_sh_sdhi0_device = {
-- 
1.6.2.4

