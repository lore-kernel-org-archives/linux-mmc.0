From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 5/8] SH: Add SDHI DMA support to ecovec
Date: Wed, 21 Apr 2010 17:37:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1004211734460.5292@axis700.grange>
References: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:49963 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755737Ab0DUPhP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Apr 2010 11:37:15 -0400
In-Reply-To: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/boards/mach-ecovec24/setup.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 0e36b04..ff330f0 100644
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
@@ -31,6 +32,7 @@
 #include <media/sh_mobile_ceu.h>
 #include <media/tw9910.h>
 #include <media/mt9t112.h>
+#include <asm/dmaengine.h>
 #include <asm/heartbeat.h>
 #include <asm/sh_eth.h>
 #include <asm/clock.h>
@@ -442,6 +444,8 @@ static void sdhi0_set_pwr(struct platform_device *pdev, int state)
 }
 
 static struct sh_mobile_sdhi_info sdhi0_info = {
+	.dma_slave_tx = SHDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx = SHDMA_SLAVE_SDHI0_RX,
 	.set_pwr = sdhi0_set_pwr,
 };
 
@@ -478,6 +482,9 @@ static void sdhi1_set_pwr(struct platform_device *pdev, int state)
 }
 
 static struct sh_mobile_sdhi_info sdhi1_info = {
+	.dma_slave_tx = SHDMA_SLAVE_SDHI1_TX,
+	.dma_slave_rx = SHDMA_SLAVE_SDHI1_RX,
+	.tmio_flags = TMIO_DEFER_RX_COMPLETE,
 	.set_pwr = sdhi1_set_pwr,
 };
 
-- 
1.6.2.4

