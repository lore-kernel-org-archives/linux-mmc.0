From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 15/29] mmc: extend and rename cd-gpio helpers to handle
 more slot GPIO functions
Date: Thu, 17 May 2012 19:46:21 +0530
Message-ID: <CANfBPZ90z-t_YTp8pbGvR1ZofLa7LvTUcKXjCNp0ZiWFeVQUCg@mail.gmail.com>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de> <1336057558-11031-16-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1336057558-11031-16-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, May 3, 2012 at 8:35 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> GPIOs can be used in MMC/SD-card slots not only for hotplug detection=
, but
> also to implement the write-protection pin. Rename cd-gpio helpers to
> slot-gpio to make addition of further slot GPIO functions possible.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> =A0drivers/mmc/core/Makefile =A0 =A0 =A0 | =A0 =A02 +-
> =A0drivers/mmc/core/cd-gpio.c =A0 =A0 =A0| =A0 83 -------------------=
--------------------
> =A0drivers/mmc/core/slot-gpio.c =A0 =A0| =A0 83 +++++++++++++++++++++=
++++++++++++++++++
> =A0drivers/mmc/host/tmio_mmc_pio.c | =A0 =A06 +-
> =A0include/linux/mmc/cd-gpio.h =A0 =A0 | =A0 18 --------
> =A0include/linux/mmc/slot-gpio.h =A0 | =A0 18 ++++++++
> =A06 files changed, 105 insertions(+), 105 deletions(-)
> =A0delete mode 100644 drivers/mmc/core/cd-gpio.c
> =A0create mode 100644 drivers/mmc/core/slot-gpio.c
> =A0delete mode 100644 include/linux/mmc/cd-gpio.h
> =A0create mode 100644 include/linux/mmc/slot-gpio.h
>
> diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
> index dca4428..38ed210 100644
> --- a/drivers/mmc/core/Makefile
> +++ b/drivers/mmc/core/Makefile
> @@ -7,6 +7,6 @@ mmc_core-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
:=3D core.o bus.o host.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 m=
mc.o mmc_ops.o sd.o sd_ops.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s=
dio.o sdio_ops.o sdio_bus.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s=
dio_cis.o sdio_io.o sdio_irq.o \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
quirks.o cd-gpio.o
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
quirks.o slot-gpio.o
>
> =A0mmc_core-$(CONFIG_DEBUG_FS) =A0 =A0+=3D debugfs.o
> diff --git a/drivers/mmc/core/cd-gpio.c b/drivers/mmc/core/cd-gpio.c
> deleted file mode 100644
> index f13e38d..0000000
> --- a/drivers/mmc/core/cd-gpio.c
> +++ /dev/null
> @@ -1,83 +0,0 @@
> -/*
> - * Generic GPIO card-detect helper
> - *
> - * Copyright (C) 2011, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> - *
> - * This program is free software; you can redistribute it and/or mod=
ify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/err.h>
> -#include <linux/gpio.h>
> -#include <linux/interrupt.h>
> -#include <linux/jiffies.h>
> -#include <linux/mmc/cd-gpio.h>
> -#include <linux/mmc/host.h>
> -#include <linux/module.h>
> -#include <linux/slab.h>
> -
> -struct mmc_cd_gpio {
> - =A0 =A0 =A0 unsigned int gpio;
> - =A0 =A0 =A0 char label[0];
> -};
> -
> -static irqreturn_t mmc_cd_gpio_irqt(int irq, void *dev_id)
> -{
> - =A0 =A0 =A0 /* Schedule a card detection after a debounce timeout *=
/
> - =A0 =A0 =A0 mmc_detect_change(dev_id, msecs_to_jiffies(100));
> - =A0 =A0 =A0 return IRQ_HANDLED;
> -}
> -
> -int mmc_cd_gpio_request(struct mmc_host *host, unsigned int gpio)
> -{
> - =A0 =A0 =A0 size_t len =3D strlen(dev_name(host->parent)) + 4;
> - =A0 =A0 =A0 struct mmc_cd_gpio *cd;
> - =A0 =A0 =A0 int irq =3D gpio_to_irq(gpio);
> - =A0 =A0 =A0 int ret;
> -
> - =A0 =A0 =A0 if (irq < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return irq;
> -
> - =A0 =A0 =A0 cd =3D kmalloc(sizeof(*cd) + len, GFP_KERNEL);
> - =A0 =A0 =A0 if (!cd)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> -
> - =A0 =A0 =A0 snprintf(cd->label, len, "%s cd", dev_name(host->parent=
));
> -
> - =A0 =A0 =A0 ret =3D gpio_request_one(gpio, GPIOF_DIR_IN, cd->label)=
;
> - =A0 =A0 =A0 if (ret < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto egpioreq;
> -
> - =A0 =A0 =A0 ret =3D request_threaded_irq(irq, NULL, mmc_cd_gpio_irq=
t,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
cd->label, host);
> - =A0 =A0 =A0 if (ret < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto eirqreq;
> -
> - =A0 =A0 =A0 cd->gpio =3D gpio;
> - =A0 =A0 =A0 host->hotplug.irq =3D irq;
> - =A0 =A0 =A0 host->hotplug.handler_priv =3D cd;
> -
> - =A0 =A0 =A0 return 0;
> -
> -eirqreq:
> - =A0 =A0 =A0 gpio_free(gpio);
> -egpioreq:
> - =A0 =A0 =A0 kfree(cd);
> - =A0 =A0 =A0 return ret;
> -}
> -EXPORT_SYMBOL(mmc_cd_gpio_request);
> -
> -void mmc_cd_gpio_free(struct mmc_host *host)
> -{
> - =A0 =A0 =A0 struct mmc_cd_gpio *cd =3D host->hotplug.handler_priv;
> -
> - =A0 =A0 =A0 if (!cd)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> -
> - =A0 =A0 =A0 free_irq(host->hotplug.irq, host);
> - =A0 =A0 =A0 gpio_free(cd->gpio);
> - =A0 =A0 =A0 kfree(cd);
> -}
> -EXPORT_SYMBOL(mmc_cd_gpio_free);
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpi=
o.c
> new file mode 100644
> index 0000000..17d705f
> --- /dev/null
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -0,0 +1,83 @@
> +/*
> + * Generic GPIO card-detect helper
> + *
> + * Copyright (C) 2011, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/slot-gpio.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +struct mmc_gpio {
> + =A0 =A0 =A0 unsigned int cd_gpio;
> + =A0 =A0 =A0 char cd_label[0];
> +};
> +
> +static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 /* Schedule a card detection after a debounce timeout *=
/
> + =A0 =A0 =A0 mmc_detect_change(dev_id, msecs_to_jiffies(100));
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
> +{
> + =A0 =A0 =A0 size_t len =3D strlen(dev_name(host->parent)) + 4;
> + =A0 =A0 =A0 struct mmc_gpio *ctx;
> + =A0 =A0 =A0 int irq =3D gpio_to_irq(gpio);
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 if (irq < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return irq;
> +
> + =A0 =A0 =A0 ctx =3D kmalloc(sizeof(*ctx) + len, GFP_KERNEL);
> + =A0 =A0 =A0 if (!ctx)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 snprintf(ctx->cd_label, len, "%s cd", dev_name(host->pa=
rent));
> +
> + =A0 =A0 =A0 ret =3D gpio_request_one(gpio, GPIOF_DIR_IN, ctx->cd_la=
bel);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto egpioreq;
> +
> + =A0 =A0 =A0 ret =3D request_threaded_irq(irq, NULL, mmc_gpio_cd_irq=
t,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
ctx->cd_label, host);

Learnt about IRQF_ONESHOT recently - you need to add that as a flag whe=
n
your handler function is NULL. See
http://www.spinics.net/lists/linux-tip-commits/msg14974.html

> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto eirqreq;
> +
> + =A0 =A0 =A0 ctx->cd_gpio =3D gpio;
> + =A0 =A0 =A0 host->hotplug.irq =3D irq;
> + =A0 =A0 =A0 host->hotplug.handler_priv =3D ctx;
> +
> + =A0 =A0 =A0 return 0;
> +
> +eirqreq:
> + =A0 =A0 =A0 gpio_free(gpio);
> +egpioreq:
> + =A0 =A0 =A0 kfree(ctx);
> + =A0 =A0 =A0 return ret;
> +}
> +EXPORT_SYMBOL(mmc_gpio_request_cd);
> +
> +void mmc_gpio_free_cd(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 struct mmc_gpio *ctx =3D host->hotplug.handler_priv;
> +
> + =A0 =A0 =A0 if (!ctx)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 free_irq(host->hotplug.irq, host);
> + =A0 =A0 =A0 gpio_free(ctx->cd_gpio);
> + =A0 =A0 =A0 kfree(ctx);
> +}
> +EXPORT_SYMBOL(mmc_gpio_free_cd);
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_=
mmc_pio.c
> index 175cc71..7da63b5 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -34,8 +34,8 @@
> =A0#include <linux/io.h>
> =A0#include <linux/irq.h>
> =A0#include <linux/mfd/tmio.h>
> -#include <linux/mmc/cd-gpio.h>
> =A0#include <linux/mmc/host.h>
> +#include <linux/mmc/slot-gpio.h>
> =A0#include <linux/mmc/tmio.h>
> =A0#include <linux/module.h>
> =A0#include <linux/pagemap.h>
> @@ -1034,7 +1034,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_m=
mc_host **host,
> =A0 =A0 =A0 =A0dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
>
> =A0 =A0 =A0 =A0if (pdata->flags & TMIO_MMC_USE_GPIO_CD) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mmc_cd_gpio_request(mmc, pdata-=
>cd_gpio);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mmc_gpio_request_cd(mmc, pdata-=
>cd_gpio);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmio_mmc_host_remove(_=
host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> @@ -1066,7 +1066,7 @@ void tmio_mmc_host_remove(struct tmio_mmc_host =
*host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * This means we can miss a card-eject=
, but this is anyway
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * possible, because of delayed proces=
sing of hotplug events.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_cd_gpio_free(mmc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_gpio_free_cd(mmc);
>
> =A0 =A0 =A0 =A0if (!host->native_hotplug)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_get_sync(&pdev->dev);
> diff --git a/include/linux/mmc/cd-gpio.h b/include/linux/mmc/cd-gpio.=
h
> deleted file mode 100644
> index cefaba0..0000000
> --- a/include/linux/mmc/cd-gpio.h
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -/*
> - * Generic GPIO card-detect helper header
> - *
> - * Copyright (C) 2011, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> - *
> - * This program is free software; you can redistribute it and/or mod=
ify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#ifndef MMC_CD_GPIO_H
> -#define MMC_CD_GPIO_H
> -
> -struct mmc_host;
> -int mmc_cd_gpio_request(struct mmc_host *host, unsigned int gpio);
> -void mmc_cd_gpio_free(struct mmc_host *host);
> -
> -#endif
> diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-g=
pio.h
> new file mode 100644
> index 0000000..edfaa32
> --- /dev/null
> +++ b/include/linux/mmc/slot-gpio.h
> @@ -0,0 +1,18 @@
> +/*
> + * Generic GPIO card-detect helper header
> + *
> + * Copyright (C) 2011, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef MMC_SLOT_GPIO_H
> +#define MMC_SLOT_GPIO_H
> +
> +struct mmc_host;
> +int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio);
> +void mmc_gpio_free_cd(struct mmc_host *host);
> +
> +#endif
> --
> 1.7.2.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
