From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/3 v2] ARM: mach-shmobile: add support for the second
 SD-/MMC-card slot on ap4evb
Date: Sun, 23 May 2010 16:12:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005231611390.3571@axis700.grange>
References: <Pine.LNX.4.64.1005141228510.6147@axis700.grange>
 <Pine.LNX.4.64.1005141233510.6147@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:34573 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754788Ab0EWOMc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 23 May 2010 10:12:32 -0400
In-Reply-To: <Pine.LNX.4.64.1005141233510.6147@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

The ap4evb board is equipped with two card slots: one SD-card slot and one
SD-/MMC-card slot. The latter is connected to the second SDHI interface on
sh7372 (SDHI1). Its power supply can be jumpered either to 1.8 or 3.3V, we fix
it at default 1.8V for now.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v1 -> v2:

updated to the current genesis tree

 arch/arm/mach-shmobile/board-ap4evb.c |   44 +++++++++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index e02e09a..6c23d74 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/mfd/sh_mobile_sdhi.h>
+#include <linux/mmc/host.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
@@ -233,8 +234,8 @@ static struct platform_device keysc_device = {
 
 /* SDHI0 */
 static struct sh_mobile_sdhi_info sdhi0_info = {
-	.dma_slave_tx = SHDMA_SLAVE_SDHI0_TX,
-	.dma_slave_rx = SHDMA_SLAVE_SDHI0_RX,
+	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
 };
 
 static struct resource sdhi0_resources[] = {
@@ -260,6 +261,36 @@ static struct platform_device sdhi0_device = {
 	},
 };
 
+/* SDHI1 */
+static struct sh_mobile_sdhi_info sdhi1_info = {
+	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
+	.tmio_ocr_mask	= MMC_VDD_165_195,
+};
+
+static struct resource sdhi1_resources[] = {
+	[0] = {
+		.name	= "SDHI1",
+		.start  = 0xe6860000,
+		.end    = 0xe68601ff,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = evt2irq(0x0e80),
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi1_device = {
+	.name           = "sh_mobile_sdhi",
+	.num_resources  = ARRAY_SIZE(sdhi1_resources),
+	.resource       = sdhi1_resources,
+	.id             = 1,
+	.dev	= {
+		.platform_data	= &sdhi1_info,
+	},
+};
+
 /* USB1 */
 void usb1_host_port_power(int port, int power)
 {
@@ -379,6 +410,7 @@ static struct platform_device *ap4evb_devices[] __initdata = {
 	&smc911x_device,
 	&keysc_device,
 	&sdhi0_device,
+	&sdhi1_device,
 	&usb1_host_device,
 	&lcdc_device,
 	&mipidsi0_device,
@@ -544,6 +576,14 @@ static void __init ap4evb_init(void)
 	/* setup USB phy */
 	__raw_writew(0x8a0a, 0xE6058130);	/* USBCR2 */
 
+	/* SDHI1 */
+	gpio_request(GPIO_FN_SDHICMD1, NULL);
+	gpio_request(GPIO_FN_SDHICLK1, NULL);
+	gpio_request(GPIO_FN_SDHID1_3, NULL);
+	gpio_request(GPIO_FN_SDHID1_2, NULL);
+	gpio_request(GPIO_FN_SDHID1_1, NULL);
+	gpio_request(GPIO_FN_SDHID1_0, NULL);
+
 	sh7372_add_standard_devices();
 
 	platform_add_devices(ap4evb_devices, ARRAY_SIZE(ap4evb_devices));
-- 
1.6.2.4

