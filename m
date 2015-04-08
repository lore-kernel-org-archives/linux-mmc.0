From: chaotian.jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 2/5] mmc: mediatek: Add Mediatek MMC driver
Date: Wed, 8 Apr 2015 14:39:19 +0800
Message-ID: <1428475159.15142.3.camel@mhfsdcap03>
References: <1426562035-16709-1-git-send-email-chaotian.jing@mediatek.com>
 <1426562035-16709-3-git-send-email-chaotian.jing@mediatek.com>
 <CABuKBe+MFHJO8GXRg5KYs2t+j6U4Ynv_hCeW0YQCrS_eZ-fuLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CABuKBe+MFHJO8GXRg5KYs2t+j6U4Ynv_hCeW0YQCrS_eZ-fuLA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, bin.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Dear Matthias,

Thanks for your review!
Please help to check my comment.
On Tue, 2015-04-07 at 16:01 +0200, Matthias Brugger wrote:
> 2015-03-17 4:13 GMT+01:00 Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>:
> > Add Mediatek MMC driver code
> >
> > Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  drivers/mmc/host/Kconfig  |    8 +
> >  drivers/mmc/host/Makefile |    1 +
> >  drivers/mmc/host/mtk-sd.c | 1412 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1421 insertions(+)
> >  create mode 100644 drivers/mmc/host/mtk-sd.c
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 61ac63a..8b64377 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -768,3 +768,11 @@ config MMC_TOSHIBA_PCI
> >         tristate "Toshiba Type A SD/MMC Card Interface Driver"
> >         depends on PCI
> >         help
> > +
> > +config MMC_MTK
> > +       tristate "MediaTek SD/MMC Card Interface support"
> > +       help
> > +         This selects the MediaTek(R) Secure digital and Multimedia card Interface.
> > +         If you have a machine with a integrated SD/MMC card reader, say Y or M here.
> > +         This is needed if support for any SD/SDIO/MMC devices is required.
> > +         If unsure, say N.
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index 6a7cfe0..161b3e4 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -20,6 +20,7 @@ obj-$(CONFIG_MMC_SDHCI_F_SDH30)       += sdhci_f_sdh30.o
> >  obj-$(CONFIG_MMC_SDHCI_SPEAR)  += sdhci-spear.o
> >  obj-$(CONFIG_MMC_WBSD)         += wbsd.o
> >  obj-$(CONFIG_MMC_AU1X)         += au1xmmc.o
> > +obj-$(CONFIG_MMC_MTK)           += mtk-sd.o
> >  obj-$(CONFIG_MMC_OMAP)         += omap.o
> >  obj-$(CONFIG_MMC_OMAP_HS)      += omap_hsmmc.o
> >  obj-$(CONFIG_MMC_ATMELMCI)     += atmel-mci.o
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > new file mode 100644
> > index 0000000..86c999b
> > --- /dev/null
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -0,0 +1,1412 @@
> > +/*
> > + * Copyright (c) 2014-2015 MediaTek Inc.
> > + * Author: Chaotian.Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/ioport.h>
> > +#include <linux/irq.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_gpio.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/spinlock.h>
> > +
> > +#include <linux/mmc/card.h>
> > +#include <linux/mmc/core.h>
> > +#include <linux/mmc/host.h>
> > +#include <linux/mmc/mmc.h>
> > +#include <linux/mmc/sd.h>
> > +#include <linux/mmc/sdio.h>
> > +
> > +#define MAX_GPD_NUM         (1 + 1)    /* one null gpd */
> > +#define MAX_BD_NUM          1024
> > +#define MAX_BD_PER_GPD      MAX_BD_NUM
> 
> This looks strange.
> Why don't you define MAX_GPD_NUM as two?
> Why do you define MAX_BD_PER_GPD when it is the same as MAX_BD_NUM?
> 
In fact, the second GPD is useless now, I will remove the define of
MAX_GPD_NUM and MAX_BD_PER_GPD.

> Cheers,
> Matthias
> 
