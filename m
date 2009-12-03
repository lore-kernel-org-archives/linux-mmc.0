From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 3/5] SPI S3C64XX: Header for passing platform data
Date: Thu, 3 Dec 2009 22:06:37 +0000
Message-ID: <20091203220637.GR4808@trinity.fluff.org>
References: <1259218097-9845-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:58574 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbZLCWGb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 3 Dec 2009 17:06:31 -0500
Content-Disposition: inline
In-Reply-To: <1259218097-9845-1-git-send-email-jassi.brar@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dbrownell@users.sourceforge.net, ben-linux@fluff.org

On Thu, Nov 26, 2009 at 03:48:17PM +0900, Jassi Brar wrote:
> We need a way to pass controller specific information to the
> SPI device driver. For that purpose a new header is made.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---
>  arch/arm/plat-s3c64xx/include/plat/spi.h |   68 ++++++++++++++++++++++++++++++
>  1 files changed, 68 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-s3c64xx/include/plat/spi.h
> 
> diff --git a/arch/arm/plat-s3c64xx/include/plat/spi.h b/arch/arm/plat-s3c64xx/include/plat/spi.h
> new file mode 100644
> index 0000000..d65ddfd
> --- /dev/null
> +++ b/arch/arm/plat-s3c64xx/include/plat/spi.h

let's not have all these called spi.h, it will make life more difficult
when trying to find which spi.h we are searching for in our platform
support.

> @@ -0,0 +1,68 @@
> +/* linux/arch/arm/plat-s3c64xx/include/plat/spi.h
> + *
> + * Copyright (C) 2009 Samsung Electronics Ltd.
> + *	Jaswinder Singh <jassi.brar@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __S3C64XX_PLAT_SPI_H
> +#define __S3C64XX_PLAT_SPI_H __FILE__
> +
> +#define S3C64XX_SPI_SRCCLK_PCLK		0
> +#define S3C64XX_SPI_SRCCLK_SPIBUS	1
> +#define S3C64XX_SPI_SRCCLK_48M		2
> +
> +#define BUSNUM(b)		(b)
> +
> +/**
> + * struct s3c64xx_spi_csinfo - ChipSelect description
> + * @fb_delay: Slave specific feedback delay.
> + * @set_level: CS line control.
> + */
> +struct s3c64xx_spi_csinfo {
> +	u8 fb_delay;
> +	void (*set_level)(int lvl);
> +};

I think set_level should be called 'set_cs' to make it clearer what is
being done here.

> +/**
> + * struct s3c64xx_spi_cntrlr_info - SPI Controller defining structure
> + * @src_clk_nr: Clock source index for the CLK_CFG[SPI_CLKSEL] field.
> + * @src_clk_name: Platform name of the corresponding clock.
> + * @src_clk: Pointer to the source clock.
> + * @num_cs: Number of CS this controller emulates.
> + * @cs: Array describing each CS.
> + * @cfg_gpio: Configure pins for this SPI controller.
> + * @fifo_lvl_mask: All tx fifo_lvl fields start at offset-6
> + * @rx_lvl_offset: Depends on tx fifo_lvl field and bus number
> + * @high_speed: If the controller supports HIGH_SPEED_EN bit
> + */
> +struct s3c64xx_spi_cntrlr_info {

how about not bothering with the _cntrlr_ here and just call it
s3c64xx_spi_info instead?

> +	int src_clk_nr;
> +	char *src_clk_name;
> +	struct clk *src_clk;

do not pass 'struct clk *' in via platform data.

> +	int num_cs;
> +	struct s3c64xx_spi_csinfo *cs;
> +
> +	int (*cfg_gpio)(struct platform_device *pdev);
> +
> +	/* Following two fields are for future compatibility */
> +	int fifo_lvl_mask;
> +	int rx_lvl_offset;
> +	int high_speed;
> +};

I was wondering if a single 'set_cs' callback here would be in order,
given each spi device can already hold a chip-select number for use
with such callbacks, so:

void (*set_cs)(struct s3c64xx_spi_cntrlr_info *us, struct spi_device *sel, int to);

> +/**
> + * s3c64xx_spi_set_info - SPI Controller configure callback by the board
> + *				initialization code.
> + * @cntrlr: SPI controller number the configuration is for.
> + * @src_clk_nr: Clock the SPI controller is to use to generate SPI clocks.
> + * @cs: Pointer to the array of CS descriptions.
> + * @num_cs: Number of elements in the 'cs' array.
> + */
> +extern void s3c64xx_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
> +
> +#endif /* __S3C64XX_PLAT_SPI_H */
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

