From: Andrea Adami <andrea.adami@gmail.com>
Subject: [PATCH v5 3/9] mfd: tmio: Add partition parsers platform data
Date: Mon, 14 Aug 2017 22:48:34 +0200
Message-ID: <1502743720-28672-4-git-send-email-andrea.adami@gmail.com>
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
written in NAND. This is done in the board files using this driver.

Thus, we need to extend tmio_nand_data to consider the partition parsers.

Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
 include/linux/mfd/tmio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 26e8f8c..357b6cfd 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -139,6 +139,7 @@ struct tmio_nand_data {
 	struct nand_bbt_descr	*badblock_pattern;
 	struct mtd_partition	*partition;
 	unsigned int		num_partitions;
+	const char *const	*part_parsers;
 };
 
 #define FBIO_TMIO_ACC_WRITE	0x7C639300
-- 
2.7.4
