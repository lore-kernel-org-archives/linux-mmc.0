From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v4 2/9] mtd: nand: sharpsl.h: support partition parser
 types
Date: Sun, 13 Aug 2017 09:40:19 +0200
Message-ID: <20170813094019.2fced1d1@bbrezillon>
References: <1498681836-3765-1-git-send-email-andrea.adami@gmail.com>
        <1498681836-3765-3-git-send-email-andrea.adami@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53168 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdHMHkX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Aug 2017 03:40:23 -0400
In-Reply-To: <1498681836-3765-3-git-send-email-andrea.adami@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrea Adami <andrea.adami@gmail.com>
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Le Wed, 28 Jun 2017 22:30:29 +0200,
Andrea Adami <andrea.adami@gmail.com> a écrit :

Please add a commit message explaining why you're doing that.

> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
> ---
>  include/linux/mtd/sharpsl.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/mtd/sharpsl.h b/include/linux/mtd/sharpsl.h
> index 65e91d0..c0e0be2 100644
> --- a/include/linux/mtd/sharpsl.h
> +++ b/include/linux/mtd/sharpsl.h
> @@ -17,4 +17,5 @@ struct sharpsl_nand_platform_data {
>  	const struct mtd_ooblayout_ops *ecc_layout;
>  	struct mtd_partition	*partitions;
>  	unsigned int		nr_partitions;
> +	const char *const	*types;	/* names of parsers to use if any */

types is not really descriptive here. How about 'part_parsers' or
something clearly reflecting the purpose of this field.

BTW, try to avoid putting comments on the same line.

>  };

