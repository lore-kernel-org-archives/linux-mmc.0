From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 06/07] sh: SDHI platform data to the SE7724 board
Date: Fri, 02 Oct 2009 11:23:07 +0900
Message-ID: <20091002022307.8215.39215.sendpatchset@rxone.opensource.se>
References: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f211.google.com ([209.85.219.211]:61326 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753AbZJBC1l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Oct 2009 22:27:41 -0400
In-Reply-To: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, g.liakhovetski@gmx.de, ian@mnementh.co.uk, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, akpm@linux-foundation.org

From: Magnus Damm <damm@opensource.se>

Add SD Card support to the se7724 board using the
sh_mobile_sdhi driver hooked up to SDHI0 and CN7.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-se/7724/setup.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

--- 0001/arch/sh/boards/mach-se/7724/setup.c
+++ work/arch/sh/boards/mach-se/7724/setup.c	2009-10-02 09:46:17.000000000 +0900
@@ -448,6 +448,28 @@ static struct platform_device sh7724_usb
 	.resource	= sh7724_usb1_gadget_resources,
 };
 
+static struct resource sdhi0_cn7_resources[] = {
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
+static struct platform_device sdhi0_cn7_device = {
+	.name           = "sh_mobile_sdhi",
+	.num_resources  = ARRAY_SIZE(sdhi0_cn7_resources),
+	.resource       = sdhi0_cn7_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_SDHI0,
+	},
+};
+
 static struct platform_device *ms7724se_devices[] __initdata = {
 	&heartbeat_device,
 	&smc91x_eth_device,
@@ -460,6 +482,7 @@ static struct platform_device *ms7724se_
 	&sh7724_usb0_host_device,
 	&sh7724_usb1_gadget_device,
 	&fsi_device,
+	&sdhi0_cn7_device,
 };
 
 #define EEPROM_OP   0xBA206000
@@ -698,6 +721,16 @@ static int __init devices_setup(void)
 	clk_set_rate(&fsimcka_clk, 11000);
 	clk_put(fsia_clk);
 
+	/* SDHI0 connected to cn7 */
+	gpio_request(GPIO_FN_SDHI0CD, NULL);
+	gpio_request(GPIO_FN_SDHI0WP, NULL);
+	gpio_request(GPIO_FN_SDHI0D3, NULL);
+	gpio_request(GPIO_FN_SDHI0D2, NULL);
+	gpio_request(GPIO_FN_SDHI0D1, NULL);
+	gpio_request(GPIO_FN_SDHI0D0, NULL);
+	gpio_request(GPIO_FN_SDHI0CMD, NULL);
+	gpio_request(GPIO_FN_SDHI0CLK, NULL);
+
 	/*
 	 * enable SH-Eth
 	 *
