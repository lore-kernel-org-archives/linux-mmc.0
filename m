From: Andrea Adami <andrea.adami@gmail.com>
Subject: [PATCH v3 2/9] mtd: nand: sharpsl.h: support partition parser types
Date: Thu,  1 Jun 2017 00:40:51 +0200
Message-ID: <1496270458-6479-3-git-send-email-andrea.adami@gmail.com>
References: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
 include/linux/mtd/sharpsl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mtd/sharpsl.h b/include/linux/mtd/sharpsl.h
index 65e91d0..c0e0be2 100644
--- a/include/linux/mtd/sharpsl.h
+++ b/include/linux/mtd/sharpsl.h
@@ -17,4 +17,5 @@ struct sharpsl_nand_platform_data {
 	const struct mtd_ooblayout_ops *ecc_layout;
 	struct mtd_partition	*partitions;
 	unsigned int		nr_partitions;
+	const char *const	*types;	/* names of parsers to use if any */
 };
-- 
2.7.4
