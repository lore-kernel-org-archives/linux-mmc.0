From: Andrea Adami <andrea.adami@gmail.com>
Subject: [PATCH v4 5/9] mtd: nand: tmio_nand.c: take in account partition parser types
Date: Wed, 28 Jun 2017 22:30:32 +0200
Message-ID: <1498681836-3765-6-git-send-email-andrea.adami@gmail.com>
References: <1498681836-3765-1-git-send-email-andrea.adami@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498681836-3765-1-git-send-email-andrea.adami@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
 drivers/mtd/nand/tmio_nand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/tmio_nand.c b/drivers/mtd/nand/tmio_nand.c
index fc5e773..6a53582 100644
--- a/drivers/mtd/nand/tmio_nand.c
+++ b/drivers/mtd/nand/tmio_nand.c
@@ -440,7 +440,9 @@ static int tmio_probe(struct platform_device *dev)
 		goto err_irq;
 
 	/* Register the partitions */
-	retval = mtd_device_parse_register(mtd, NULL, NULL,
+	retval = mtd_device_parse_register(mtd,
+					   data ? data->types : NULL,
+					   NULL,
 					   data ? data->partition : NULL,
 					   data ? data->num_partitions : 0);
 	if (!retval)
-- 
2.7.4
