From: Orson Zhai <orsonzhai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH] mmc: sprd: add MMC host driver for Spreadtrum SoC
Date: Thu, 2 Jul 2015 17:26:34 +0800
Message-ID: <CA+H2tpG+_pCR-j3nZ+SeAhpj6QfiPK2=Q0pwjndQoG9R4+LMYw@mail.gmail.com>
References: <1435735399-15333-1-git-send-email-chunyan.zhang@spreadtrum.com>
	<CAL_JsqKcZ-7rM5YrkpJSP7OfECmRg4hWPRFy=UqZn1y74R8qsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqKcZ-7rM5YrkpJSP7OfECmRg4hWPRFy=UqZn1y74R8qsg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Chunyan Zhang <chunyan.zhang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>, "chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org" <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, billows.wu-lxIno14LUO0EEoCn2XhGlw@public.gmane.org, =?UTF-8?B?V2VpIFFpYW8gKOS5lOS8nyk=?= <wei.qiao-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>, baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org, ning.yang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org, =?UTF-8?B?T3Jzb24gWmhhaSjnv5/kuqwp?= <orson.zhai-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>, jason.wu-lxIno14LUO0EEoCn2XhGlw@public.gmane.org, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Rob,

Thanks for your quick reply.
I have one question to your last comment.

On Thu, Jul 2, 2015 at 1:50 AM, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, Jul 1, 2015 at 2:23 AM, Chunyan Zhang
> <chunyan.zhang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org> wrote:
>> From: Billows Wu <billows.wu-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
>>
>> The Spreadtrum MMC host driver is used to support EMMC, SD, and
>> SDIO types of memory cards.
>>
>> Signed-off-by: Billows Wu <billows.wu-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
>> Reviewed-by: Orson Zhai <orson.zhai-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
>> Signed-off-by: Chunyan Zhang <chunyan.zhang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
>> ---
>>  drivers/mmc/host/sprd_sdhost.c         | 1270 ++++++++++++++++++++++++++++++++
>>  drivers/mmc/host/sprd_sdhost.h         |  507 +++++++++++++
>>  drivers/mmc/host/sprd_sdhost_debugfs.c |  213 ++++++
>>  drivers/mmc/host/sprd_sdhost_debugfs.h |   27 +
>>  6 files changed, 2027 insertions(+)
>>  create mode 100644 drivers/mmc/host/sprd_sdhost.c
>>  create mode 100644 drivers/mmc/host/sprd_sdhost.h
>>  create mode 100644 drivers/mmc/host/sprd_sdhost_debugfs.c
>>  create mode 100644 drivers/mmc/host/sprd_sdhost_debugfs.h
>>
>> diff --git a/drivers/mmc/host/sprd_sdhost.c b/drivers/mmc/host/sprd_sdhost.c
>> new file mode 100644
>> index 0000000..e7a66e8
>> --- /dev/null
>> +++ b/drivers/mmc/host/sprd_sdhost.c
>> @@ -0,0 +1,1270 @@
>> +/*
>> + * linux/drivers/mmc/host/sprd_sdhost.c - Secure Digital Host Controller
>> + * Interface driver
>> + *
>> + * Copyright (C) 2015 Spreadtrum corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or (at
>> + * your option) any later version.
>> + *
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/highmem.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/slab.h>
>> +#include <linux/scatterlist.h>
>> +
>> +#include "sprd_sdhost.h"
>> +#include "sprd_sdhost_debugfs.h"
>> +
>> +#define DRIVER_NAME "sdhost"
>> +#define SDHOST_CAPS \
>> +               (MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED | \
>> +               MMC_CAP_ERASE |  MMC_CAP_UHS_SDR50 | \
>> +               MMC_CAP_CMD23 | MMC_CAP_HW_RESET)
>> +
>> +struct sdhost_caps_data {
>> +       char *name;
>> +       uint32_t ocr_avail;
>> +       uint32_t caps;
>> +       uint32_t caps2;
>> +       uint32_t pm_caps;
>> +       /* TODO: we will obtain these values from regulator and clock
>> +        * phandles after LDO and clock function is OK
>> +        */
>
> You can do fixed clocks and regulators in DT until you have a driver in place.
>
>> +       uint32_t base_clk;
>> +       uint32_t signal_default_voltage;
>> +};
>> +
>> +struct sdhost_caps_data sd_caps_info = {
>> +       .name = "sd",
>> +       .ocr_avail = MMC_VDD_29_30 | MMC_VDD_30_31,
>> +       .caps = SDHOST_CAPS,
>> +       .caps2 = MMC_CAP2_HC_ERASE_SZ,
>> +       .pm_caps = MMC_PM_WAKE_SDIO_IRQ,
>> +       .base_clk = 192000000,
>> +       .signal_default_voltage = 3000000,
>> +};
>> +
>> +struct sdhost_caps_data wifi_caps_info = {
>> +       .name = "wifi",
>> +       .ocr_avail = MMC_VDD_165_195 | MMC_VDD_29_30 |
>> +           MMC_VDD_30_31 | MMC_VDD_32_33 | MMC_VDD_33_34,
>> +       .caps = SDHOST_CAPS | MMC_CAP_POWER_OFF_CARD | MMC_CAP_UHS_SDR12,
>
> Is powering off a card a capability of the SD host controller or just
> the regulator control you have?
>
>> +       .pm_caps = MMC_PM_KEEP_POWER | MMC_PM_IGNORE_PM_NOTIFY,
>> +       .base_clk = 76000000,
>> +};
>> +
>> +struct sdhost_caps_data emmc_caps_info = {
>> +       .name = "emmc",
>> +       .ocr_avail = MMC_VDD_29_30 | MMC_VDD_30_31,
>> +       .caps = SDHOST_CAPS |
>> +           MMC_CAP_8_BIT_DATA | MMC_CAP_UHS_SDR12 |
>> +           MMC_CAP_UHS_SDR25 | MMC_CAP_UHS_DDR50 | MMC_CAP_MMC_HIGHSPEED,
>> +       .caps2 = MMC_CAP2_FULL_PWR_CYCLE | MMC_CAP2_HC_ERASE_SZ,
>> +       .pm_caps = MMC_PM_WAKE_SDIO_IRQ,
>> +       .base_clk = 192000000,
>> +       .signal_default_voltage = 1800000,
>> +};
>> +
>> +const struct of_device_id sdhost_of_match[] = {
>> +       {.compatible = "sprd,sd-sdhost-3.0", .data = &sd_caps_info,},
>> +       {.compatible = "sprd,wifi-sdhost-3.0", .data = &wifi_caps_info,},
>> +       {.compatible = "sprd,emmc-sdhost-3.0",  .data = &emmc_caps_info,},
>
> What these are connected to is irrelevant to the driver and compatible
> string. All these differences belong in the DT unless the IP blocks
> are really different.

It's my idea to let Billows do like this.
I learn from SSP part in freescale  "arch/arm/boot/dts/imx28-evk.dts"
Their ssp0-ssp2 each have 2 roles, mmc or generic spi bus.
And they may write one of their combo configuration like this:

 43                         ssp1: ssp@80012000 {
 44                                 compatible = "fsl,imx28-mmc";
 45                                 bus-width = <8>;
 46                                 wp-gpios = <&gpio0 28 0>;
 47                         };
 48
 49                         ssp2: ssp@80014000 {
 50                                 #address-cells = <1>;
 51                                 #size-cells = <0>;
 52                                 compatible = "fsl,imx28-spi";
 53                                 pinctrl-names = "default";
 54                                 pinctrl-0 = <&spi2_pins_a>;
 55                                 status = "okay";
 56
 57                                 flash: m25p80@0 {
 58                                         #address-cells = <1>;
 59                                         #size-cells = <1>;
 60                                         compatible = "sst,sst25vf016b";
 61                                         spi-max-frequency = <40000000>;
 62                                         reg = <0>;
 63                                 };
 64                         };

Billows tell me they also have 3 roles in their sd host controller
corresponding to 3 kinds of different operation.
He used to create "sprd,name" property for this. Is it a good way or
anything else better?

Thanks,
Orson

>
> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
