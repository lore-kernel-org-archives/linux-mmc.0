From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 7/10 v2] SH: Add SDHI DMA support to ecovec
Date: Wed, 19 May 2010 20:34:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005191808420.3099@axis700.grange>
References: <Pine.LNX.4.64.1005191750400.3099@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005191750400.3099@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, dan.j.williams@intel.com, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, sameo@linux.intel.com, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-ecovec24/setup.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 0e36b04..37d9efc 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/sh_mobile_sdhi.h>
 #include <linux/mtd/physmap.h>
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
@@ -442,7 +443,9 @@ static void sdhi0_set_pwr(struct platform_device *pdev, int state)
 }
 
 static struct sh_mobile_sdhi_info sdhi0_info = {
-	.set_pwr = sdhi0_set_pwr,
+	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+	.set_pwr	= sdhi0_set_pwr,
 };
 
 static struct resource sdhi0_resources[] = {
@@ -478,7 +481,9 @@ static void sdhi1_set_pwr(struct platform_device *pdev, int state)
 }
 
 static struct sh_mobile_sdhi_info sdhi1_info = {
-	.set_pwr = sdhi1_set_pwr,
+	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
+	.set_pwr	= sdhi1_set_pwr,
 };
 
 static struct resource sdhi1_resources[] = {
-- 
1.6.2.4

