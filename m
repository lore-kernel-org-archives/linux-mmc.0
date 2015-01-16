From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: Re: [PATCH v3 4/4] mmc: sdhci: host: add new f_sdh30
Date: Fri, 16 Jan 2015 11:33:34 +0800
Message-ID: <CAOEd-H3eU=OJQp5+-yzP02ccpzZdoBJ1BUeFoZiu-DhLYDhGWA@mail.gmail.com>
References: <1420803705-4539-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<1420803705-4539-5-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<CAPDyKFqHk5cqFziwsDRa+RttjdiWZ9fYx9UP5nQdWEAJS=Cstg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:38256 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbbAPDdg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jan 2015 22:33:36 -0500
Received: by mail-la0-f52.google.com with SMTP id hs14so16995166lab.11
        for <linux-mmc@vger.kernel.org>; Thu, 15 Jan 2015 19:33:34 -0800 (PST)
In-Reply-To: <CAPDyKFqHk5cqFziwsDRa+RttjdiWZ9fYx9UP5nQdWEAJS=Cstg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, Andy Green <andy.green@linaro.org>, Patch Tracking <patches@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, Vincent Yang <Vincent.Yang@tw.fujitsu.com>, Tetsuya Takinishi <t.takinishi@jp.fujitsu.com>

2015-01-13 20:19 GMT+08:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 9 January 2015 at 12:41, Vincent Yang <vincent.yang.fujitsu@gmail.com> wrote:
>> This patch adds new host controller driver for
>> Fujitsu SDHCI controller f_sdh30.
>>
>> Signed-off-by: Andy Green <andy.green@linaro.org>
>> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
>> Signed-off-by: Tetsuya Takinishi <t.takinishi@jp.fujitsu.com>
>> ---
>>  .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |  30 ++
>>  drivers/mmc/host/Kconfig                           |   8 +
>>  drivers/mmc/host/Makefile                          |   1 +
>>  drivers/mmc/host/sdhci_f_sdh30.c                   | 306 +++++++++++++++++++++
>>  4 files changed, 345 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>>  create mode 100644 drivers/mmc/host/sdhci_f_sdh30.c
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>> new file mode 100644
>> index 0000000..d77df7b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>> @@ -0,0 +1,30 @@
>> +* Fujitsu SDHCI controller
>> +
>> +This file documents differences between the core properties in mmc.txt
>> +and the properties used by the sdhci_f_sdh30 driver.
>> +
>> +Required properties:
>> +- compatible: "fujitsu,mb86s70-sdhci-3.0"
>> +
>> +Optional properties:
>> +- vqmmc-supply: phandle to the regulator device tree node, mentioned
>> +  as the VCCQ/VDD_IO supply in the eMMC/SD specs.
>> +- clocks: Must contain an entry for each entry in clock-names. It is a
>> +  list of phandles and clock-specifier pairs.
>> +  See ../clocks/clock-bindings.txt for details.
>> +- clock-names: Should contain the following two entries:
>> +       "iface" - clock used for sdhci interface
>> +       "core"  - core clock for sdhci controller
>> +
>> +Example:
>> +
>> +       sdhci1: mmc@36600000 {
>> +               compatible = "fujitsu,mb86s70-sdhci-3.0";
>> +               reg = <0 0x36600000 0x1000>;
>> +               interrupts = <0 172 0x4>,
>> +                            <0 173 0x4>;
>> +               bus-width = <4>;
>> +               vqmmc-supply = <&vccq_sdhci1>;
>> +               clocks = <&clock 2 2 0>, <&clock 2 3 0>;
>> +               clock-names = "iface", "core";
>> +       };
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 2d6fbdd..288dcc3 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -290,6 +290,14 @@ config MMC_SDHCI_BCM2835
>>           This selects the BCM2835 SD/MMC controller. If you have a BCM2835
>>           platform with SD or MMC devices, say Y or M here.
>>
>> +config MMC_SDHCI_F_SDH30
>> +       tristate "SDHCI support for Fujitsu Semiconductor F_SDH30"
>> +       depends on MMC_SDHCI_PLTFM
>> +       depends on OF
>> +       help
>> +         This selects the Secure Digital Host Controller Interface (SDHCI)
>> +         Needed by some Fujitsu SoC for MMC / SD / SDIO support.
>> +         If you have a controller with this interface, say Y or M here.
>>           If unsure, say N.
>>
>>  config MMC_MOXART
>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>> index f7b0a77..6a7cfe0 100644
>> --- a/drivers/mmc/host/Makefile
>> +++ b/drivers/mmc/host/Makefile
>> @@ -16,6 +16,7 @@ obj-$(CONFIG_MMC_SDHCI_PXAV3) += sdhci-pxav3.o
>>  obj-$(CONFIG_MMC_SDHCI_PXAV2)  += sdhci-pxav2.o
>>  obj-$(CONFIG_MMC_SDHCI_S3C)    += sdhci-s3c.o
>>  obj-$(CONFIG_MMC_SDHCI_SIRF)           += sdhci-sirf.o
>> +obj-$(CONFIG_MMC_SDHCI_F_SDH30)        += sdhci_f_sdh30.o
>>  obj-$(CONFIG_MMC_SDHCI_SPEAR)  += sdhci-spear.o
>>  obj-$(CONFIG_MMC_WBSD)         += wbsd.o
>>  obj-$(CONFIG_MMC_AU1X)         += au1xmmc.o
>> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
>> new file mode 100644
>> index 0000000..2dc16e7
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
>> @@ -0,0 +1,306 @@
>> +/*
>> + * linux/drivers/mmc/host/sdhci_f_sdh30.c
>> + *
>> + * Copyright (C) 2013 - 2015 Fujitsu Semiconductor, Ltd
>> + *              Vincent Yang <vincent.yang@tw.fujitsu.com>
>> + * Copyright (C) 2015 Linaro Ltd  Andy Green <andy.green@linaro.org>
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
>
> You can likely remove some of these includes which you don't use. Like
> sd.h, suspend.h, etc...
>
> Also, I don't find clk.h

Yes, I'll remove unnecessary ones and add clk.h

>
>>
>> +#include "sdhci.h"
>> +#include "sdhci-pltfm.h"
>> +
>> +/* F_SDH30 extended Controller registers */
>> +#define F_SDH30_AHB_CONFIG             0x100
>> +#define  F_SDH30_AHB_BIGED             0x00000040
>> +#define  F_SDH30_BUSLOCK_DMA           0x00000020
>> +#define  F_SDH30_BUSLOCK_EN            0x00000010
>> +#define  F_SDH30_SIN                   0x00000008
>> +#define  F_SDH30_AHB_INCR_16           0x00000004
>> +#define  F_SDH30_AHB_INCR_8            0x00000002
>> +#define  F_SDH30_AHB_INCR_4            0x00000001
>> +
>> +#define F_SDH30_TUNING_SETTING         0x108
>> +#define  F_SDH30_CMD_CHK_DIS           0x00010000
>> +
>> +#define F_SDH30_IO_CONTROL2            0x114
>> +#define  F_SDH30_CRES_O_DN             0x00080000
>> +#define  F_SDH30_MSEL_O_1_8            0x00040000
>> +
>> +#define F_SDH30_ESD_CONTROL            0x124
>> +#define  F_SDH30_EMMC_RST              0x00000002
>> +#define  F_SDH30_EMMC_HS200            0x01000000
>> +
>> +#define F_SDH30_CMD_DAT_DELAY          0x200
>> +
>> +#define F_SDH30_MIN_CLOCK              400000
>> +
>> +struct f_sdhost_priv {
>> +       struct clk *clk_iface;
>> +       struct clk *clk;
>> +       u32 vendor_hs200;
>> +       struct device *dev;
>> +};
>> +
>> +void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
>> +{
>> +       struct f_sdhost_priv *priv = sdhci_priv(host);
>> +       u32 ctrl = 0;
>> +
>> +       usleep_range(2500, 3000);
>> +       ctrl = sdhci_readl(host, F_SDH30_IO_CONTROL2);
>> +       ctrl |= F_SDH30_CRES_O_DN;
>> +       sdhci_writel(host, ctrl, F_SDH30_IO_CONTROL2);
>> +       ctrl |= F_SDH30_MSEL_O_1_8;
>> +       sdhci_writel(host, ctrl, F_SDH30_IO_CONTROL2);
>> +
>> +       ctrl &= ~F_SDH30_CRES_O_DN;
>> +       sdhci_writel(host, ctrl, F_SDH30_IO_CONTROL2);
>> +       usleep_range(2500, 3000);
>> +
>> +       if (priv->vendor_hs200) {
>> +               dev_info(priv->dev, "%s: setting hs200\n", __func__);
>> +               ctrl = sdhci_readl(host, F_SDH30_ESD_CONTROL);
>> +               ctrl |= priv->vendor_hs200;
>> +               sdhci_writel(host, ctrl, F_SDH30_ESD_CONTROL);
>> +       }
>> +
>> +       ctrl = sdhci_readl(host, F_SDH30_TUNING_SETTING);
>> +       ctrl |= F_SDH30_CMD_CHK_DIS;
>> +       sdhci_writel(host, ctrl, F_SDH30_TUNING_SETTING);
>> +}
>> +
>> +unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
>> +{
>> +       return F_SDH30_MIN_CLOCK;
>> +}
>> +
>> +void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
>> +{
>> +       if (sdhci_readw(host, SDHCI_CLOCK_CONTROL) == 0)
>> +               sdhci_writew(host, 0xBC01, SDHCI_CLOCK_CONTROL);
>> +
>> +       sdhci_reset(host, mask);
>> +}
>> +
>> +static const struct sdhci_ops sdhci_f_sdh30_ops = {
>> +       .voltage_switch = sdhci_f_sdh30_soft_voltage_switch,
>> +       .get_min_clock = sdhci_f_sdh30_get_min_clock,
>> +       .reset = sdhci_f_sdh30_reset,
>> +       .set_clock = sdhci_set_clock,
>> +       .set_bus_width = sdhci_set_bus_width,
>> +       .set_uhs_signaling = sdhci_set_uhs_signaling,
>> +};
>> +
>> +static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>> +{
>> +       struct sdhci_host *host;
>> +       struct device *dev = &pdev->dev;
>> +       struct resource *res;
>> +       int irq, ctrl = 0, ret = 0;
>> +       struct f_sdhost_priv *priv;
>> +       u32 reg = 0;
>> +
>> +       irq = platform_get_irq(pdev, 0);
>> +       if (irq < 0) {
>> +               dev_err(dev, "%s: no irq specified\n", __func__);
>> +               ret = irq;
>> +               goto err;
>
> The goto is a superfluous, just do: return irq;

Yes, I'll do it.

>
>> +       }
>> +
>> +       host = sdhci_alloc_host(dev, sizeof(struct sdhci_host) +
>> +                                               sizeof(struct f_sdhost_priv));
>> +       if (IS_ERR(host)) {
>> +               ret = -ENOMEM;
>> +               goto err;
>
> Replace by:
> return PTR_ERR(host);

Yes, I'll do it.

>
>> +       }
>> +       priv = sdhci_priv(host);
>> +       priv->dev = dev;
>> +
>> +       host->quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
>> +                      SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
>> +       host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
>> +                       SDHCI_QUIRK2_TUNING_WORK_AROUND;
>> +
>> +       ret = mmc_of_parse(host->mmc);
>> +       if (ret)
>> +               goto err_of_parse;
>> +
>> +       platform_set_drvdata(pdev, host);
>> +
>> +       sdhci_get_of_property(pdev);
>> +       host->hw_name = "f_sdh30";
>> +       host->ops = &sdhci_f_sdh30_ops;
>> +       host->irq = irq;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       host->ioaddr = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(host->ioaddr)) {
>> +               dev_err(dev, "%s: failed to remap registers\n", __func__);
>
> The error print is not needed, since it's already done by
> devm_ioremap_resource().

Yes, I'll remove it.

>
>> +               ret = -ENXIO;
>
> Don't overwrite the error, instead do: ret = PTR_ERR(host);

Yes, I'll do it.

>
>> +               goto err_of_parse;
>> +       }
>> +
>> +       priv->clk_iface = devm_clk_get(&pdev->dev, "iface");
>
> Is this clock really optional?

I'm sorry about this mistake.
I double checked it and found it should be required instead of optional.
I'll also update device tree binding document accordingly.

>
>> +       if (!IS_ERR(priv->clk_iface)) {
>> +               ret = clk_prepare_enable(priv->clk_iface);
>> +               if (ret < 0) {
>> +                       dev_err(dev, "Failed to enable iface clock: %d\n", ret);
>> +                       goto err_of_parse;
>> +               }
>> +       }
>> +       priv->clk = devm_clk_get(&pdev->dev, "core");
>
> Is this clock really optional?

I'm sorry about this mistake.
It should also be required instead of optional.

>
>> +       if (!IS_ERR(priv->clk)) {
>> +               ret = clk_prepare_enable(priv->clk);
>> +               if (ret < 0) {
>> +                       dev_err(dev, "Failed to enable core clock: %d\n", ret);
>> +                       goto err_clk;
>> +               }
>> +       }
>> +
>> +       pm_runtime_set_active(&pdev->dev);
>> +       pm_runtime_enable(&pdev->dev);
>> +       ret = pm_runtime_get_sync(&pdev->dev);
>> +       if (ret < 0)
>> +               dev_err(dev, "Failed to pm_runtime_get_sync: %d\n", ret);
>
> As I stated earlier I think this is a strange behaviour of how to
> implement runtime PM support. Could you elaborate one more time why
> this actually is needed?

Thanks for pointing out this.
We studied again and realized that this runtime PM support was only there for
powerdomain management, but we have not yet upstreamed the powerdomain
support. Thus we would like to remove it in next version.

>
> Moreover, if you insist of keeping the device runtime PM resumed
> forever, you should replace the pm_runtime_get_sync() with a call to
> pm_runtime_get_noresume() prior you invoke pm_runtime_set_active().

We will remove runtime PM support in next version.

>
>> +
>> +       /* init vendor specific regs */
>> +       ctrl = sdhci_readw(host, F_SDH30_AHB_CONFIG);
>> +       ctrl |= F_SDH30_SIN | F_SDH30_AHB_INCR_16 | F_SDH30_AHB_INCR_8 |
>> +               F_SDH30_AHB_INCR_4;
>> +       ctrl &= ~(F_SDH30_AHB_BIGED | F_SDH30_BUSLOCK_EN);
>> +       sdhci_writew(host, ctrl, F_SDH30_AHB_CONFIG);
>> +
>> +       reg = sdhci_readl(host, F_SDH30_ESD_CONTROL);
>> +       sdhci_writel(host, reg & ~F_SDH30_EMMC_RST, F_SDH30_ESD_CONTROL);
>> +       msleep(20);
>> +       sdhci_writel(host, reg | F_SDH30_EMMC_RST, F_SDH30_ESD_CONTROL);
>> +
>> +       reg = sdhci_readl(host, SDHCI_CAPABILITIES);
>> +       if (reg & SDHCI_CAN_DO_8BIT)
>> +               priv->vendor_hs200 = F_SDH30_EMMC_HS200;
>> +       else
>> +               priv->vendor_hs200 = 0;
>> +
>> +       ret = sdhci_add_host(host);
>> +       if (ret) {
>> +               dev_err(dev, "%s: host add error\n", __func__);
>
> The printing is already taken care of by sdhci_add_host() no need to
> do it here as well.

Yes, I'll remove it.

>
>> +               goto err_add_host;
>> +       }
>> +
>> +       return 0;
>> +
>> +err_add_host:
>> +       pm_runtime_disable(&pdev->dev);
>> +       pm_runtime_put_noidle(&pdev->dev);
>> +       clk_disable_unprepare(priv->clk);
>> +err_clk:
>> +       clk_disable_unprepare(priv->clk_iface);
>
> According to upper code, both clk_iface and clk are optional, thus you
> need to check (!IS_ERR(clk*)) before gating them.

I'm sorry both clk_iface and clk should be required.
Thus I think I could skip this check.

>
>> +err_of_parse:
>> +       sdhci_free_host(host);
>> +err:
>> +       return ret;
>> +}
>> +
>> +static int sdhci_f_sdh30_remove(struct platform_device *pdev)
>> +{
>> +       struct sdhci_host *host = platform_get_drvdata(pdev);
>> +       struct f_sdhost_priv *priv = sdhci_priv(host);
>> +       struct resource *iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +
>> +       pm_runtime_get_sync(&pdev->dev);
>
> If you keep the device runtime PM resumed forever, done by your
> ->probe() routine you don't need the above pm_runtime_get_sync()

Thanks for pointing out this.
I'll remove runtime PM support in next version.
All pm_runtime_*() functions will be removed.

>
>> +       pm_runtime_disable(&pdev->dev);
>> +       pm_runtime_put_noidle(&pdev->dev);
>> +
>> +       sdhci_remove_host(host, readl(host->ioaddr + SDHCI_INT_STATUS) ==
>> +                         0xffffffff);
>> +       release_mem_region(iomem->start, resource_size(iomem));
>
> No need for this, you are using the devm_* managed functions.

Yes, I'll remove it.

>
>> +
>> +       clk_disable_unprepare(priv->clk_iface);
>> +       clk_disable_unprepare(priv->clk);
>
> According to probe the clocks are optional!?

Sorry they should be required and I'll fix it in next version.

>
>> +
>> +       sdhci_free_host(host);
>> +       platform_set_drvdata(pdev, NULL);
>> +
>> +       return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int sdhci_f_sdh30_suspend(struct device *dev)
>> +{
>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>> +
>> +       return sdhci_suspend_host(host);
>> +}
>> +
>> +static int sdhci_f_sdh30_resume(struct device *dev)
>> +{
>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>> +
>> +       return sdhci_resume_host(host);
>> +}
>> +#endif
>> +
>> +#ifdef CONFIG_PM
>> +static int sdhci_f_sdh30_runtime_suspend(struct device *dev)
>> +{
>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>> +
>> +       return sdhci_runtime_suspend_host(host);
>> +}
>> +
>> +static int sdhci_f_sdh30_runtime_resume(struct device *dev)
>> +{
>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>> +
>> +       return sdhci_runtime_resume_host(host);
>> +}
>> +#endif
>> +
>> +static const struct dev_pm_ops sdhci_f_sdh30_pmops = {
>> +       SET_SYSTEM_SLEEP_PM_OPS(sdhci_f_sdh30_suspend, sdhci_f_sdh30_resume)
>> +       SET_RUNTIME_PM_OPS(sdhci_f_sdh30_runtime_suspend,
>> +                          sdhci_f_sdh30_runtime_resume, NULL)
>> +};
>> +
>> +static const struct of_device_id f_sdh30_dt_ids[] = {
>> +       { .compatible = "fujitsu,mb86s70-sdhci-3.0" },
>> +       { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, f_sdh30_dt_ids);
>> +
>> +static struct platform_driver sdhci_f_sdh30_driver = {
>> +       .driver = {
>> +               .name = "f_sdh30",
>> +               .of_match_table = f_sdh30_dt_ids,
>> +#ifdef CONFIG_PM_SLEEP
>
> You can remove this ifdef.

Yes, I'll remove it.
Thanks a lot for your review and comments!

Kind regards
Vincent

>
>> +               .pm     = &sdhci_f_sdh30_pmops,
>> +#endif
>> +       },
>> +       .probe  = sdhci_f_sdh30_probe,
>> +       .remove = sdhci_f_sdh30_remove,
>> +};
>> +
>> +module_platform_driver(sdhci_f_sdh30_driver);
>> +
>> +MODULE_DESCRIPTION("F_SDH30 SD Card Controller driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("FUJITSU SEMICONDUCTOR LTD.");
>> +MODULE_ALIAS("platform:f_sdh30");
>> --
>> 1.9.0
>>
>
> Kind regards
> Uffe
