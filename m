From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/6] sh: ecovec: use the CONFIG_MMC_TMIO symbols instead of
 MFD
Date: Wed, 23 Mar 2011 14:42:50 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103231432200.6836@axis700.grange>
References: <Pine.LNX.4.64.1103231156220.6836@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1103231156220.6836@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

The CONFIG_MFD_SH_MOBILE_SDHI Kconfig symbol is going to disappear soon,
switch ecovec to using CONFIG_MMC_TMIO(_MODULE).

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

No change, here for completeness

 arch/sh/boards/mach-ecovec24/setup.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 52751f0..37ad5dc 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -462,7 +462,7 @@ static struct i2c_board_info ts_i2c_clients = {
 	.irq		= IRQ0,
 };
 
-#ifdef CONFIG_MFD_SH_MOBILE_SDHI
+#if defined(CONFIG_MMC_TMIO) || defined(CONFIG_MMC_TMIO_MODULE)
 /* SDHI0 */
 static void sdhi0_set_pwr(struct platform_device *pdev, int state)
 {
@@ -887,7 +887,7 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&ceu0_device,
 	&ceu1_device,
 	&keysc_device,
-#ifdef CONFIG_MFD_SH_MOBILE_SDHI
+#if defined(CONFIG_MMC_TMIO) || defined(CONFIG_MMC_TMIO_MODULE)
 	&sdhi0_device,
 #if !defined(CONFIG_MMC_SH_MMCIF)
 	&sdhi1_device,
@@ -1169,7 +1169,7 @@ static int __init arch_setup(void)
 	gpio_direction_input(GPIO_PTR5);
 	gpio_direction_input(GPIO_PTR6);
 
-#ifdef CONFIG_MFD_SH_MOBILE_SDHI
+#if defined(CONFIG_MMC_TMIO) || defined(CONFIG_MMC_TMIO_MODULE)
 	/* enable SDHI0 on CN11 (needs DS2.4 set to ON) */
 	gpio_request(GPIO_FN_SDHI0CD,  NULL);
 	gpio_request(GPIO_FN_SDHI0WP,  NULL);
-- 
1.7.2.5

