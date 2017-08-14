From: Andrea Adami <andrea.adami@gmail.com>
Subject: [PATCH v5 9/9] ARM: pxa/poodle: Remove hardcoded partitioning, use sharpslpart parser
Date: Mon, 14 Aug 2017 22:48:40 +0200
Message-ID: <1502743720-28672-10-git-send-email-andrea.adami@gmail.com>
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35664 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752624AbdHNUs7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Aug 2017 16:48:59 -0400
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
 arch/arm/mach-pxa/poodle.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 62a1191..fd01d6b 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -333,24 +333,6 @@ static struct pxafb_mach_info poodle_fb_info = {
 	.lcd_conn	= LCD_COLOR_TFT_16BPP,
 };
 
-static struct mtd_partition sharpsl_nand_partitions[] = {
-	{
-		.name = "System Area",
-		.offset = 0,
-		.size = 7 * 1024 * 1024,
-	},
-	{
-		.name = "Root Filesystem",
-		.offset = 7 * 1024 * 1024,
-		.size = 22 * 1024 * 1024,
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
@@ -360,10 +342,16 @@ static struct nand_bbt_descr sharpsl_bbt = {
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
-- 
2.7.4

