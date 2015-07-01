From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC PATCH] mmc: sprd: add MMC host driver for Spreadtrum SoC
Date: Wed, 1 Jul 2015 12:50:32 -0500
Message-ID: <CAL_JsqKcZ-7rM5YrkpJSP7OfECmRg4hWPRFy=UqZn1y74R8qsg@mail.gmail.com>
References: <1435735399-15333-1-git-send-email-chunyan.zhang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435735399-15333-1-git-send-email-chunyan.zhang@spreadtrum.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Cc: "chris@printf.net" <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, billows.wu@spreadtrum.com, =?UTF-8?B?V2VpIFFpYW8gKOS5lOS8nyk=?= <wei.qiao@spreadtrum.com>, baolin.wang@spreadtrum.com, ning.yang@spreadtrum.com, orson.zhai@spreadtrum.com, jason.wu@spreadtrum.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jul 1, 2015 at 2:23 AM, Chunyan Zhang
<chunyan.zhang@spreadtrum.com> wrote:
> From: Billows Wu <billows.wu@spreadtrum.com>
>
> The Spreadtrum MMC host driver is used to support EMMC, SD, and
> SDIO types of memory cards.
>
> Signed-off-by: Billows Wu <billows.wu@spreadtrum.com>
> Reviewed-by: Orson Zhai <orson.zhai@spreadtrum.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---
>  drivers/mmc/host/sprd_sdhost.c         | 1270 ++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sprd_sdhost.h         |  507 +++++++++++++
>  drivers/mmc/host/sprd_sdhost_debugfs.c |  213 ++++++
>  drivers/mmc/host/sprd_sdhost_debugfs.h |   27 +
>  6 files changed, 2027 insertions(+)
>  create mode 100644 drivers/mmc/host/sprd_sdhost.c
>  create mode 100644 drivers/mmc/host/sprd_sdhost.h
>  create mode 100644 drivers/mmc/host/sprd_sdhost_debugfs.c
>  create mode 100644 drivers/mmc/host/sprd_sdhost_debugfs.h
>
> diff --git a/drivers/mmc/host/sprd_sdhost.c b/drivers/mmc/host/sprd_sdhost.c
> new file mode 100644
> index 0000000..e7a66e8
> --- /dev/null
> +++ b/drivers/mmc/host/sprd_sdhost.c
> @@ -0,0 +1,1270 @@
> +/*
> + * linux/drivers/mmc/host/sprd_sdhost.c - Secure Digital Host Controller
> + * Interface driver
> + *
> + * Copyright (C) 2015 Spreadtrum corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or (at
> + * your option) any later version.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/highmem.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/scatterlist.h>
> +
> +#include "sprd_sdhost.h"
> +#include "sprd_sdhost_debugfs.h"
> +
> +#define DRIVER_NAME "sdhost"
> +#define SDHOST_CAPS \
> +               (MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED | \
> +               MMC_CAP_ERASE |  MMC_CAP_UHS_SDR50 | \
> +               MMC_CAP_CMD23 | MMC_CAP_HW_RESET)
> +
> +struct sdhost_caps_data {
> +       char *name;
> +       uint32_t ocr_avail;
> +       uint32_t caps;
> +       uint32_t caps2;
> +       uint32_t pm_caps;
> +       /* TODO: we will obtain these values from regulator and clock
> +        * phandles after LDO and clock function is OK
> +        */

You can do fixed clocks and regulators in DT until you have a driver in place.

> +       uint32_t base_clk;
> +       uint32_t signal_default_voltage;
> +};
> +
> +struct sdhost_caps_data sd_caps_info = {
> +       .name = "sd",
> +       .ocr_avail = MMC_VDD_29_30 | MMC_VDD_30_31,
> +       .caps = SDHOST_CAPS,
> +       .caps2 = MMC_CAP2_HC_ERASE_SZ,
> +       .pm_caps = MMC_PM_WAKE_SDIO_IRQ,
> +       .base_clk = 192000000,
> +       .signal_default_voltage = 3000000,
> +};
> +
> +struct sdhost_caps_data wifi_caps_info = {
> +       .name = "wifi",
> +       .ocr_avail = MMC_VDD_165_195 | MMC_VDD_29_30 |
> +           MMC_VDD_30_31 | MMC_VDD_32_33 | MMC_VDD_33_34,
> +       .caps = SDHOST_CAPS | MMC_CAP_POWER_OFF_CARD | MMC_CAP_UHS_SDR12,

Is powering off a card a capability of the SD host controller or just
the regulator control you have?

> +       .pm_caps = MMC_PM_KEEP_POWER | MMC_PM_IGNORE_PM_NOTIFY,
> +       .base_clk = 76000000,
> +};
> +
> +struct sdhost_caps_data emmc_caps_info = {
> +       .name = "emmc",
> +       .ocr_avail = MMC_VDD_29_30 | MMC_VDD_30_31,
> +       .caps = SDHOST_CAPS |
> +           MMC_CAP_8_BIT_DATA | MMC_CAP_UHS_SDR12 |
> +           MMC_CAP_UHS_SDR25 | MMC_CAP_UHS_DDR50 | MMC_CAP_MMC_HIGHSPEED,
> +       .caps2 = MMC_CAP2_FULL_PWR_CYCLE | MMC_CAP2_HC_ERASE_SZ,
> +       .pm_caps = MMC_PM_WAKE_SDIO_IRQ,
> +       .base_clk = 192000000,
> +       .signal_default_voltage = 1800000,
> +};
> +
> +const struct of_device_id sdhost_of_match[] = {
> +       {.compatible = "sprd,sd-sdhost-3.0", .data = &sd_caps_info,},
> +       {.compatible = "sprd,wifi-sdhost-3.0", .data = &wifi_caps_info,},
> +       {.compatible = "sprd,emmc-sdhost-3.0",  .data = &emmc_caps_info,},

What these are connected to is irrelevant to the driver and compatible
string. All these differences belong in the DT unless the IP blocks
are really different.

Rob
