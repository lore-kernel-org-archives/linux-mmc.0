From: Andrea Adami <andrea.adami@gmail.com>
Subject: [PATCH v5 6/9] ARM: pxa/corgi: Remove hardcoded partitioning, use sharpslpart parser
Date: Mon, 14 Aug 2017 22:48:37 +0200
Message-ID: <1502743720-28672-7-git-send-email-andrea.adami@gmail.com>
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

With the introduction of sharpslpart partition parser we can now read the
offsets from NAND: we specify the list of the parsers as platform data, with
cmdlinepart and ofpart parsers first allowing to override the part. table
written in NAND. This is done here in the board file.

Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
 arch/arm/mach-pxa/corgi.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 7270f0d..9546452 100644
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
+	.part_parsers		= probes,
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
