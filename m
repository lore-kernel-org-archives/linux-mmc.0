From: Vincent.Yang <Vincent.Yang@tw.fujitsu.com>
Subject: RE: [PATCH 2/8] mmc: sdhci: host: add new f_sdh30
Date: Wed, 16 Jul 2014 17:35:41 +0800
Message-ID: <830AC58E49A426478AC39824BC0FA915D8B8FF0609@fmpitwmsex01.fmpi.sea.css.fujitsu.com>
References: <1405232971-4607-1-git-send-email-mollie.wu@linaro.org>
 <7710458.qT0KZ5qsA6@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7710458.qT0KZ5qsA6@wuerfel>
Content-Language: zh-TW
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mollie Wu <mollie.wu@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "anton@enomsg.org" <anton@enomsg.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, Tetsuya Takinishi <t.takinishi@jp.fujitsu.com>, "patches@linaro.org" <patches@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "chris@printf.net" <chris@printf.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "andy.green@linaro.org" <andy.green@linaro.org>, "olof@lixom.net" <olof@lixom.net>
List-Id: linux-mmc@vger.kernel.org

>-----Original Message-----
>From: Arnd Bergmann [mailto:arnd@arndb.de]
>On Sunday 13 July 2014 14:29:31 Mollie Wu wrote:
>> +Required properties:
>> +- compatible: "fujitsu,f-sdh30"
>> +- voltage-ranges : This is a list of pairs. In each pair, two cells
>> +  are required. First cell specifies minimum slot voltage (mV), second
>> +  cell specifies maximum slot voltage (mV). In case of supported voltage
>> +  range is discontinuous, several ranges could be specified as a list.
>> +
>> +Optional properties:
>> +- pwr-mux-gpios: This is one optional gpio for controlling a power mux
>> +  which switches between two power supplies. 3.3V is selected when gpio
>> +  is high, and 1.8V is selected when gpio is low. This voltage is used
>> +  for signal level.
>
>It sounds like what you really want here is a reference to a gpio-regulator
>node and, and to put the details of the voltage switching in there.

Hi Arnd,
Yes, I'll use a gpio-regulator for it in next version.

>
>> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c
>b/drivers/mmc/host/sdhci_f_sdh30.c
>> new file mode 100644
>> index 0000000..8d23f2d
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
>> @@ -0,0 +1,380 @@
>> +/*
>> + * linux/drivers/mmc/host/sdhci_f_sdh30.c
>> + *
>> + * Copyright (C) 2013 - 2014 Fujitsu Semiconductor, Ltd
>> + *              Vincent Yang <vincent.yang@tw.fujitsu.com>
>> + * Copyright (C) 2014 Linaro Ltd  Andy Green <andy.green@linaro.org>
>> + *
>> + * This program is free software: you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation, version 2 of the License.
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/delay.h>
>> +#include <linux/module.h>
>> +#include <linux/mmc/sd.h>
>> +#include <linux/mmc/host.h>
>> +#include <linux/mmc/card.h>
>> +#include <linux/gpio.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/suspend.h>
>> +
>> +#include "sdhci.h"
>> +#include "sdhci-pltfm.h"
>> +#include "../core/core.h"
>
>Should this be <linux/mmc/core.h>? A device driver should not be looking
>at the drivers/mmc/core/core.h.

Yes, I'll remove it.

>
>> +#define DRIVER_NAME "f_sdh30"
>
>This macro doesn't seem to serve any purpose, it would be easier to
>read if you open-code this.

Yes, I'll do it.

>
>> +
>> +void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
>> +{
>> +     struct f_sdhost_priv *priv = sdhci_priv(host);
>> +     u32 ctrl = 0;
>> +
>> +     usleep_range(2500, 3000);
>> +     ctrl = sdhci_readl(host, F_SDH30_IO_CONTROL2);
>> +     ctrl |= F_SDH30_CRES_O_DN;
>> +     sdhci_writel(host, ctrl, F_SDH30_IO_CONTROL2);
>> +     ctrl |= F_SDH30_MSEL_O_1_8;
>> +     sdhci_writel(host, ctrl, F_SDH30_IO_CONTROL2);
>> +
>> +     if (gpio_is_valid(priv->gpio_select_1v8)) {
>> +             dev_info(priv->dev, "%s: setting gpio\n", __func__);
>> +             gpio_direction_output(priv->gpio_select_1v8, 0);
>> +     }
>> +
>> +     ctrl &= ~F_SDH30_CRES_O_DN;
>> +     sdhci_writel(host, ctrl, F_SDH30_IO_CONTROL2);
>> +     usleep_range(2500, 3000);
>> +
>> +     if (priv->vendor_hs200) {
>> +             dev_info(priv->dev, "%s: setting hs200\n", __func__);
>> +             ctrl = sdhci_readl(host, F_SDH30_ESD_CONTROL);
>> +             ctrl |= priv->vendor_hs200;
>> +             sdhci_writel(host, ctrl, F_SDH30_ESD_CONTROL);
>> +     }
>> +
>> +     ctrl = sdhci_readl(host, F_SDH30_TUNING_SETTING);
>> +     ctrl |= F_SDH30_CMD_CHK_DIS;
>> +     sdhci_writel(host, ctrl, F_SDH30_TUNING_SETTING);
>> +}
>
>I think this should really use the regulator API.
>
>If the regular is defined properly, this will work without any extra code.

Yes, I'll use a gpio-regulator for it.

>
>> +unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
>> +{
>> +     return F_SDH30_MIN_CLOCK;
>> +}
>> +
>> +void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
>> +{
>> +     struct f_sdhost_priv *priv = sdhci_priv(host);
>> +
>> +     if (gpio_is_valid(priv->gpio_select_1v8))
>> +             gpio_direction_output(priv->gpio_select_1v8, 1);
>> +
>> +     if (sdhci_readw(host, SDHCI_CLOCK_CONTROL) == 0) {
>> +             sdhci_writew(host, 0xBC01, SDHCI_CLOCK_CONTROL);
>> +             mmiowb();
>> +     }
>
>Can you explain the mmiowb call here?

This came from the original 3.0 based driver. It's trying to be a
write memory barrier. It wants to ensure the clock control change
actually happened before the following code.
I'll change it to a regular wmb in next version.

>
>> +
>> +     if (!of_property_read_u32(pdev->dev.of_node, "bus-width", &bus_width))
>{
>> +             switch (bus_width) {
>> +             case 8:
>> +                     dev_info(dev, "Applying 8 bit bus width\n");
>> +                     host->mmc->caps |= MMC_CAP_8_BIT_DATA;
>> +                     break;
>> +             case 4:
>> +                     dev_info(dev, "Applying 4 bit bus width\n");
>> +                     host->mmc->caps |= MMC_CAP_4_BIT_DATA;
>> +                     break;
>> +             case 1:
>> +             default:
>> +                     dev_err(dev, "Invalid bus width: %u\n", bus_width);
>> +                     break;
>> +             }
>> +     }
>
>This should probably be done in generic sdhci code somewhere. How about
>adding it to sdhci_get_of_property instead_

I should use generic mmc_of_parse for it. I'll update it in next version.

>> +     priv->clk_sd4 = clk_get(&pdev->dev, "sd_sd4clk");
>> +     if (!IS_ERR(priv->clk_sd4)) {
>> +             ret = clk_prepare_enable(priv->clk_sd4);
>> +             if (ret < 0) {
>> +                     dev_err(dev, "Failed to enable sd4 clock: %d\n", ret);
>> +                     goto err_clk1;
>> +             }
>> +     }
>> +     priv->clk_b = clk_get(&pdev->dev, "sd_bclk");
>> +     if (!IS_ERR(priv->clk_b)) {
>> +             ret = clk_prepare_enable(priv->clk_b);
>> +             if (ret < 0) {
>> +                     dev_err(dev, "Failed to enable clk_b clock: %d\n", ret);
>> +                     goto err_clk2;
>> +             }
>> +     }
>
>Please pick clock names that match what some of the other drivers use.

I'll use "iface" and "core" for clock names because they match what used
in sdhci-msm driver.

Thanks a lot for your review!

Best regards,
Vincent Yang

>
>Ideally some of that should also move to common code.
>
>        Arnd
