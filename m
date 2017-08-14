From: Andrea Adami <andrea.adami@gmail.com>
Subject: [PATCH v5 7/9] ARM: pxa/tosa: Remove hardcoded partitioning, use sharpslpart parser
Date: Mon, 14 Aug 2017 22:48:38 +0200
Message-ID: <1502743720-28672-8-git-send-email-andrea.adami@gmail.com>
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
 arch/arm/mach-pxa/tosa.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 13de660..b90560b 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -673,24 +673,6 @@ static int tosa_tc6393xb_suspend(struct platform_device *dev)
 	return 0;
 }
 
-static struct mtd_partition tosa_nand_partition[] = {
-	{
-		.name	= "smf",
-		.offset	= 0,
-		.size	= 7 * 1024 * 1024,
-	},
-	{
-		.name	= "root",
-		.offset	= MTDPART_OFS_APPEND,
-		.size	= 28 * 1024 * 1024,
-	},
-	{
-		.name	= "home",
-		.offset	= MTDPART_OFS_APPEND,
-		.size	= MTDPART_SIZ_FULL,
-	},
-};
-
 static uint8_t scan_ff_pattern[] = { 0xff, 0xff };
 
 static struct nand_bbt_descr tosa_tc6393xb_nand_bbt = {
@@ -700,10 +682,16 @@ static struct nand_bbt_descr tosa_tc6393xb_nand_bbt = {
 	.pattern	= scan_ff_pattern
 };
 
+static const char * const probes[] = {
+	"cmdlinepart",
+	"ofpart",
+	"sharpslpart",
+	NULL,
+};
+
 static struct tmio_nand_data tosa_tc6393xb_nand_config = {
-	.num_partitions	= ARRAY_SIZE(tosa_nand_partition),
-	.partition	= tosa_nand_partition,
 	.badblock_pattern = &tosa_tc6393xb_nand_bbt,
+	.part_parsers = probes,
 };
 
 static int tosa_tc6393xb_setup(struct platform_device *dev)
-- 
2.7.4
