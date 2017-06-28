From: Andrea Adami <andrea.adami@gmail.com>
Subject: [PATCH v4 3/9] mfd: tmio.h: support partition parser types
Date: Wed, 28 Jun 2017 22:30:30 +0200
Message-ID: <1498681836-3765-4-git-send-email-andrea.adami@gmail.com>
References: <1498681836-3765-1-git-send-email-andrea.adami@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33985 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751919AbdF1Uay (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Jun 2017 16:30:54 -0400
In-Reply-To: <1498681836-3765-1-git-send-email-andrea.adami@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
 include/linux/mfd/tmio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index a1520d8..23bb069 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -139,6 +139,7 @@ struct tmio_nand_data {
 	struct nand_bbt_descr	*badblock_pattern;
 	struct mtd_partition	*partition;
 	unsigned int		num_partitions;
+	const char *const	*types;	/* names of parsers to use if any */
 };
 
 #define FBIO_TMIO_ACC_WRITE	0x7C639300
-- 
2.7.4

