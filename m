From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 3/9] mfd: tmio.h: support partition parser types
Date: Thu, 1 Jun 2017 15:35:35 +0100
Message-ID: <20170601143535.s6ovk5ts3cbehw3f@dell>
References: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
 <1496270458-6479-4-git-send-email-andrea.adami@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35508 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdFAOfl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jun 2017 10:35:41 -0400
Received: by mail-wm0-f51.google.com with SMTP id b84so161244549wmh.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Jun 2017 07:35:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1496270458-6479-4-git-send-email-andrea.adami@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrea Adami <andrea.adami@gmail.com>
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 01 Jun 2017, Andrea Adami wrote:

> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
> ---
>  include/linux/mfd/tmio.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index a1520d8..23bb069 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -139,6 +139,7 @@ struct tmio_nand_data {
>  	struct nand_bbt_descr	*badblock_pattern;
>  	struct mtd_partition	*partition;
>  	unsigned int		num_partitions;
> +	const char *const	*types;	/* names of parsers to use if any */

Please use kerneldoc instead.

>  };
>  
>  #define FBIO_TMIO_ACC_WRITE	0x7C639300

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
