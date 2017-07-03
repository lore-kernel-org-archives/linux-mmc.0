From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 3/9] mfd: tmio.h: support partition parser types
Date: Mon, 3 Jul 2017 12:26:21 +0100
Message-ID: <20170703112621.rd3ija3efqlq57rg@dell>
References: <1498681836-3765-1-git-send-email-andrea.adami@gmail.com>
 <1498681836-3765-4-git-send-email-andrea.adami@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1498681836-3765-4-git-send-email-andrea.adami@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Adami <andrea.adami@gmail.com>
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Please use the $SUBJECT line expected by the subsystem.

`git log --oneline -- $SUBSYSTEM` can help with this.

You also need a commit log.

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

I'm okay with this if it's suits the MTD folk.

>  };
>  
>  #define FBIO_TMIO_ACC_WRITE	0x7C639300

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
