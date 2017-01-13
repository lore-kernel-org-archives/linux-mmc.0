From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v3 2/2] mmc: pwrseq: add support for Marvell SD8787 chip
Date: Fri, 13 Jan 2017 15:16:25 +0800
Message-ID: <cd669d08-0db4-57e4-478b-2b200ccef6f1@rock-chips.com>
References: <20170113052937.12538-1-matt@ranostay.consulting>
 <20170113052937.12538-3-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170113052937.12538-3-matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 2017/1/13 13:29, Matt Ranostay wrote:
> Allow power sequencing for the Marvell SD8787 Wifi/BT chip.
> This can be abstracted to other chipsets if needed in the future.
>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> ---
>  drivers/mmc/core/Kconfig         |  10 ++++
>  drivers/mmc/core/Makefile        |   1 +
>  drivers/mmc/core/pwrseq_sd8787.c | 117 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 128 insertions(+)
>  create mode 100644 drivers/mmc/core/pwrseq_sd8787.c
>
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index cdfa8520a4b1..fc1ecdaaa9ca 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -12,6 +12,16 @@ config PWRSEQ_EMMC
>  	  This driver can also be built as a module. If so, the module
>  	  will be called pwrseq_emmc.
>
> +config PWRSEQ_SD8787
> +	tristate "HW reset support for SD8787 BT + Wifi module"
> +	depends on OF && (MWIFIEX || BT_MRVL_SDIO)
> +	help
> +	  This selects hardware reset support for the SD8787 BT + Wifi
> +	  module. By default this option is set to n.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called pwrseq_sd8787.
> +

I don't like this way, as we have a chance to list lots
configure options here. wifi A,B,C,D...Z, all of them need a
new section here if needed?

Instead, could you just extent pwrseq_simple.c and add you
.compatible = "mmc-pwrseq-sd8787", "mmc-pwrseq-simple"?


>  config PWRSEQ_SIMPLE
>  	tristate "Simple HW reset support for MMC"
>  	default y
> diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
> index b2a257dc644f..0f81464fa824 100644
> --- a/drivers/mmc/core/Makefile
> +++ b/drivers/mmc/core/Makefile
> @@ -10,6 +10,7 @@ mmc_core-y			:= core.o bus.o host.o \
>  				   quirks.o slot-gpio.o
>  mmc_core-$(CONFIG_OF)		+= pwrseq.o
>  obj-$(CONFIG_PWRSEQ_SIMPLE)	+= pwrseq_simple.o
> +obj-$(CONFIG_PWRSEQ_SD8787)	+= pwrseq_sd8787.o
>  obj-$(CONFIG_PWRSEQ_EMMC)	+= pwrseq_emmc.o
>  mmc_core-$(CONFIG_DEBUG_FS)	+= debugfs.o
>  obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
> diff --git a/drivers/mmc/core/pwrseq_sd8787.c b/drivers/mmc/core/pwrseq_sd8787.c
> new file mode 100644
> index 000000000000..f4080fe6439e
> --- /dev/null
> +++ b/drivers/mmc/core/pwrseq_sd8787.c
> @@ -0,0 +1,117 @@
> +/*
> + * pwrseq_sd8787.c - power sequence support for Marvell SD8787 BT + Wifi chip
> + *
> + * Copyright (C) 2016 Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> + *
> + * Based on the original work pwrseq_simple.c
> + *  Copyright (C) 2014 Linaro Ltd
> + *  Author: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +
> +#include <linux/mmc/host.h>
> +
> +#include "pwrseq.h"
> +
> +struct mmc_pwrseq_sd8787 {
> +	struct mmc_pwrseq pwrseq;
> +	struct gpio_desc *reset_gpio;
> +	struct gpio_desc *pwrdn_gpio;
> +};
> +
> +#define to_pwrseq_sd8787(p) container_of(p, struct mmc_pwrseq_sd8787, pwrseq)
> +
> +static void mmc_pwrseq_sd8787_pre_power_on(struct mmc_host *host)
> +{
> +	struct mmc_pwrseq_sd8787 *pwrseq = to_pwrseq_sd8787(host->pwrseq);
> +
> +	gpiod_set_value_cansleep(pwrseq->reset_gpio, 1);
> +
> +	msleep(300);
> +	gpiod_set_value_cansleep(pwrseq->pwrdn_gpio, 1);
> +}
> +
> +static void mmc_pwrseq_sd8787_power_off(struct mmc_host *host)
> +{
> +	struct mmc_pwrseq_sd8787 *pwrseq = to_pwrseq_sd8787(host->pwrseq);
> +
> +	gpiod_set_value_cansleep(pwrseq->pwrdn_gpio, 0);
> +	gpiod_set_value_cansleep(pwrseq->reset_gpio, 0);
> +}
> +
> +static const struct mmc_pwrseq_ops mmc_pwrseq_sd8787_ops = {
> +	.pre_power_on = mmc_pwrseq_sd8787_pre_power_on,
> +	.power_off = mmc_pwrseq_sd8787_power_off,
> +};
> +
> +static const struct of_device_id mmc_pwrseq_sd8787_of_match[] = {
> +	{ .compatible = "mmc-pwrseq-sd8787",},
> +	{/* sentinel */},
> +};
> +MODULE_DEVICE_TABLE(of, mmc_pwrseq_sd8787_of_match);
> +
> +static int mmc_pwrseq_sd8787_probe(struct platform_device *pdev)
> +{
> +	struct mmc_pwrseq_sd8787 *pwrseq;
> +	struct device *dev = &pdev->dev;
> +
> +	pwrseq = devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
> +	if (!pwrseq)
> +		return -ENOMEM;
> +
> +	pwrseq->pwrdn_gpio = devm_gpiod_get(dev, "pwrdn", GPIOD_OUT_LOW);
> +	if (IS_ERR(pwrseq->pwrdn_gpio))
> +		return PTR_ERR(pwrseq->pwrdn_gpio);
> +
> +	pwrseq->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(pwrseq->reset_gpio))
> +		return PTR_ERR(pwrseq->reset_gpio);
> +
> +	pwrseq->pwrseq.dev = dev;
> +	pwrseq->pwrseq.ops = &mmc_pwrseq_sd8787_ops;
> +	pwrseq->pwrseq.owner = THIS_MODULE;
> +	platform_set_drvdata(pdev, pwrseq);
> +
> +	return mmc_pwrseq_register(&pwrseq->pwrseq);
> +}
> +
> +static int mmc_pwrseq_sd8787_remove(struct platform_device *pdev)
> +{
> +	struct mmc_pwrseq_sd8787 *pwrseq = platform_get_drvdata(pdev);
> +
> +	mmc_pwrseq_unregister(&pwrseq->pwrseq);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mmc_pwrseq_sd8787_driver = {
> +	.probe = mmc_pwrseq_sd8787_probe,
> +	.remove = mmc_pwrseq_sd8787_remove,
> +	.driver = {
> +		.name = "pwrseq_sd8787",
> +		.of_match_table = mmc_pwrseq_sd8787_of_match,
> +	},
> +};
> +
> +module_platform_driver(mmc_pwrseq_sd8787_driver);
> +MODULE_LICENSE("GPL v2");
>


-- 
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
