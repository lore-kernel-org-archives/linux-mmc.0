From: "Priit Laes" <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v6 4/8] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Sun, 16 Feb 2014 11:22:28 +0200
Message-ID: <1392542548.11093.13.camel@chi.lan>
References: <20140216050933.728.25526.stgit@dizzy-6.o2s.ch>
	 <20140216051133.728.36386.stgit@dizzy-6.o2s.ch>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDJLTBEBXENBBT4EQKMAKGQEMOZVIFI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140216051133.728.36386.stgit-GPtPHOohwllnsqa/0SyWJQ@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

=C3=9Chel kenal p=C3=A4eval, P, 16.02.2014 kell 06:11, kirjutas David
Lanzend=C3=B6rfer:
> This is based on the driver Allwinner ships in their Android kernel sourc=
es.

[...]

> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -0,0 +1,876 @@
> +/*
> + * Driver for sunxi SD/MMC host controllers
> + * (C) Copyright 2014-2015 Reuuimlla Technology Co., Ltd.
> + * (C) Copyright 2014-2015 Aaron Maoye <leafy.myeh-jFKXxz0WcGyYHARAtoI1EgC/G2K4zDHf@public.gmane.org>
> + * (C) Copyright 2014-2015 O2S GmbH <www.o2s.ch>
> + * (C) Copyright 2014-2015 David Lanzend=C3=B6rfer <david.lanzendoerfer@=
o2s.ch>
> + * (C) Copyright 2014-2015 Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

ETIMETRAVEL

[...]
> +++ b/drivers/mmc/host/sunxi-mmc.h
> @@ -0,0 +1,239 @@
> +/*
> + * Driver for sunxi SD/MMC host controllers
> + * (C) Copyright 2014-2015 Reuuimlla Technology Co., Ltd.
> + * (C) Copyright 2014-2015 Aaron Maoye <leafy.myeh-jFKXxz0WcGyYHARAtoI1EgC/G2K4zDHf@public.gmane.org>
> + * (C) Copyright 2014-2015 O2S GmbH <www.o2s.ch>
> + * (C) Copyright 2014-2015 David Lanzend=C3=B6rfer <david.lanzendoerfer@=
o2s.ch>
> + * (C) Copyright 2014-2015 Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

ETIMETRAVEL

> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +#ifndef __SUNXI_MCI_H__
> +#define __SUNXI_MCI_H__

__SUNXI_MMC_H__=20

> +
> +/* register offset define */

s/define/definitions

> +#define SDXC_REG_GCTRL	(0x00) /* SMC Global Control Register */
> +#define SDXC_REG_CLKCR	(0x04) /* SMC Clock Control Register */
> +#define SDXC_REG_TMOUT	(0x08) /* SMC Time Out Register */

[...]

> +#define SDXC_FIFO_RUN_ERROR		BIT(11)
> +#define SDXC_HARD_WARE_LOCKED	BIT(12)
s/HARD_WARE/HARDWARE

> +#define SDXC_START_BIT_ERROR	BIT(13)
> +#define SDXC_AUTO_COMMAND_DONE	BIT(14)
> +#define SDXC_END_BIT_ERROR		BIT(15)
> +#define SDXC_SDIO_INTERRUPT		BIT(16)
> +#define SDXC_CARD_INSERT		BIT(30)
> +#define SDXC_CARD_REMOVE		BIT(31)
> +#define SDXC_INTERRUPT_ERROR_BIT		(SDXC_RESPONSE_ERROR | SDXC_RESPONSE_C=
RC_ERROR | \
> +				 SDXC_DATA_CRC_ERROR | SDXC_RESPONSE_TIMEOUT | \
> +				 SDXC_DATA_TIMEOUT | SDXC_FIFO_RUN_ERROR | \
> +				 SDXC_HARD_WARE_LOCKED | SDXC_START_BIT_ERROR | \
> +				 SDXC_END_BIT_ERROR) /* 0xbbc2 */
same as above.

Also, you may want to rename SDXC_RESPONSE_* to SDXC_RESP_*, which looks
better next to the SDXC_DATA_* defines...

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
