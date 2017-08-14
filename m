From: Andrea Adami <andrea.adami@gmail.com>
Subject: [PATCH v5 8/9] ARM: pxa/spitz: Remove hardcoded partitioning, use sharpslpart parser
Date: Mon, 14 Aug 2017 22:48:39 +0200
Message-ID: <1502743720-28672-9-git-send-email-andrea.adami@gmail.com>
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35318 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752692AbdHNUs5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Aug 2017 16:48:57 -0400
In-Reply-To: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

With the introduction of sharpslpart partition parser we can now read the
offsets from NAND: we specify the list of the parsers as platform data, with
cmdlinepart and ofpart parsers first allowing to override the part. table
written in NAND. This is done here in the board file.

Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
 arch/arm/mach-pxa/spitz.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 67d66c7..defefa3 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -739,21 +739,6 @@ static inline void spitz_lcd_init(void) {}
  * NAND Flash
  ******************************************************************************/
 #if defined(CONFIG_MTD_NAND_SHARPSL) || defined(CONFIG_MTD_NAND_SHARPSL_MODULE)
-static struct mtd_partition spitz_nand_partitions[] = {
-	{
-		.name = "System Area",
-		.offset = 0,
-		.size = 7 * 1024 * 1024,
-	}, {
-		.name = "Root Filesystem",
-		.offset = 7 * 1024 * 1024,
-	}, {
-		.name = "Home Filesystem",
-		.offset = MTDPART_OFS_APPEND,
-		.size = MTDPART_SIZ_FULL,
-	},
-};
-
 static uint8_t scan_ff_pattern[] = { 0xff, 0xff };
 
 static struct nand_bbt_descr spitz_nand_bbt = {
@@ -808,10 +793,16 @@ static const struct mtd_ooblayout_ops akita_ooblayout_ops = {
 	.free = akita_ooblayout_free,
 };
 
+static const char * const probes[] = {
+	"cmdlinepart",
+	"ofpart",
+	"sharpslpart",
+	NULL,
+};
+
 static struct sharpsl_nand_platform_data spitz_nand_pdata = {
 	.badblock_pattern	= &spitz_nand_bbt,
-	.partitions		= spitz_nand_partitions,
-	.nr_partitions		= ARRAY_SIZE(spitz_nand_partitions),
+	.part_parsers		= probes,
 };
 
 static struct resource spitz_nand_resources[] = {
@@ -834,14 +825,7 @@ static struct platform_device spitz_nand_device = {
 
 static void __init spitz_nand_init(void)
 {
-	if (machine_is_spitz()) {
-		spitz_nand_partitions[1].size = 5 * 1024 * 1024;
-	} else if (machine_is_akita()) {
-		spitz_nand_partitions[1].size = 58 * 1024 * 1024;
-		spitz_nand_bbt.len = 1;
-		spitz_nand_pdata.ecc_layout = &akita_ooblayout_ops;
-	} else if (machine_is_borzoi()) {
-		spitz_nand_partitions[1].size = 32 * 1024 * 1024;
+	if (machine_is_akita() || machine_is_borzoi()) {
 		spitz_nand_bbt.len = 1;
 		spitz_nand_pdata.ecc_layout = &akita_ooblayout_ops;
 	}
-- 
2.7.4

