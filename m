From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 07/07] sh: SDHI platform data to the kfr2r09 board
Date: Fri, 02 Oct 2009 11:23:19 +0900
Message-ID: <20091002022319.8215.68511.sendpatchset@rxone.opensource.se>
References: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f211.google.com ([209.85.219.211]:61326 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754290AbZJBC1x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Oct 2009 22:27:53 -0400
In-Reply-To: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-mmc@vger.kernel.org, ian@mnementh.co.uk, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, g.liakhovetski@gmx.de

From: Magnus Damm <damm@opensource.se>

Add SD Card support to the kfr2r09 board using the
sh_mobile_sdhi driver hooked up to SDHI0 and yc304.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-kfr2r09/setup.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

--- 0001/arch/sh/boards/mach-kfr2r09/setup.c
+++ work/arch/sh/boards/mach-kfr2r09/setup.c	2009-10-01 13:22:17.000000000 +0900
@@ -212,11 +212,34 @@ static struct platform_device kfr2r09_us
 	.resource	= kfr2r09_usb0_gadget_resources,
 };
 
+static struct resource kfr2r09_sh_sdhi0_resources[] = {
+	[0] = {
+		.name	= "SDHI0",
+		.start  = 0x04ce0000,
+		.end    = 0x04ce01ff,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 101,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device kfr2r09_sh_sdhi0_device = {
+	.name           = "sh_mobile_sdhi",
+	.num_resources  = ARRAY_SIZE(kfr2r09_sh_sdhi0_resources),
+	.resource       = kfr2r09_sh_sdhi0_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_SDHI0,
+	},
+};
+
 static struct platform_device *kfr2r09_devices[] __initdata = {
 	&kfr2r09_nor_flash_device,
 	&kfr2r09_nand_flash_device,
 	&kfr2r09_sh_keysc_device,
 	&kfr2r09_sh_lcdc_device,
+	&kfr2r09_sh_sdhi0_device,
 };
 
 #define BSC_CS0BCR 0xfec10004
@@ -361,6 +384,16 @@ static int __init kfr2r09_devices_setup(
 	if (kfr2r09_usb0_gadget_setup() == 0)
 		platform_device_register(&kfr2r09_usb0_gadget_device);
 
+	/* SDHI0 connected to yc304 */
+	gpio_request(GPIO_FN_SDHI0CD, NULL);
+	gpio_request(GPIO_FN_SDHI0WP, NULL);
+	gpio_request(GPIO_FN_SDHI0D3, NULL);
+	gpio_request(GPIO_FN_SDHI0D2, NULL);
+	gpio_request(GPIO_FN_SDHI0D1, NULL);
+	gpio_request(GPIO_FN_SDHI0D0, NULL);
+	gpio_request(GPIO_FN_SDHI0CMD, NULL);
+	gpio_request(GPIO_FN_SDHI0CLK, NULL);
+
 	return platform_add_devices(kfr2r09_devices,
 				    ARRAY_SIZE(kfr2r09_devices));
 }
