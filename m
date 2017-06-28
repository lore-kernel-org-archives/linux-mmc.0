From: Andrea Adami <andrea.adami@gmail.com>
Subject: [PATCH v4 6/9] ARM: pxa: corgi.c: remove hardcoded partitioning, use sharpslpart parser
Date: Wed, 28 Jun 2017 22:30:33 +0200
Message-ID: <1498681836-3765-7-git-send-email-andrea.adami@gmail.com>
References: <1498681836-3765-1-git-send-email-andrea.adami@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33566 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbdF1Uax (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Jun 2017 16:30:53 -0400
In-Reply-To: <1498681836-3765-1-git-send-email-andrea.adami@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
 arch/arm/mach-pxa/corgi.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 7270f0d..2412add 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -606,24 +606,6 @@ static void __init corgi_init_spi(void)
 static inline void corgi_init_spi(void) {}
 #endif
 
-static struct mtd_partition sharpsl_nand_partitions[] = {
-	{
-		.name = "System Area",
-		.offset = 0,
-		.size = 7 * 1024 * 1024,
-	},
-	{
-		.name = "Root Filesystem",
-		.offset = 7 * 1024 * 1024,
-		.size = 25 * 1024 * 1024,
-	},
-	{
-		.name = "Home Filesystem",
-		.offset = MTDPART_OFS_APPEND,
-		.size = MTDPART_SIZ_FULL,
-	},
-};
-
 static uint8_t scan_ff_pattern[] = { 0xff, 0xff };
 
 static struct nand_bbt_descr sharpsl_bbt = {
@@ -633,10 +615,16 @@ static struct nand_bbt_descr sharpsl_bbt = {
 	.pattern = scan_ff_pattern
 };
 
+static const char * const probes[] = {
+	"cmdlinepart",
+	"ofpart",
+	"sharpslpart",
+	NULL,
+};
+
 static struct sharpsl_nand_platform_data sharpsl_nand_platform_data = {
 	.badblock_pattern	= &sharpsl_bbt,
-	.partitions		= sharpsl_nand_partitions,
-	.nr_partitions		= ARRAY_SIZE(sharpsl_nand_partitions),
+	.types			= probes,
 };
 
 static struct resource sharpsl_nand_resources[] = {
@@ -750,9 +738,6 @@ static void __init corgi_init(void)
 
 	platform_scoop_config = &corgi_pcmcia_config;
 
-	if (machine_is_husky())
-		sharpsl_nand_partitions[1].size = 53 * 1024 * 1024;
-
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	regulator_has_full_constraints();
-- 
2.7.4

