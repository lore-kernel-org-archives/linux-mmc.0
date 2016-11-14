From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH v5 2/5] mmc: zx: Initial support for ZX mmc controller
Date: Mon, 14 Nov 2016 18:02:03 +0800
Message-ID: <CABymUCNHbaH2vR2J0WeN8KgBgD=x9vze0U3uz8ydGBMrohLCXA@mail.gmail.com>
References: <1478568298-18380-1-git-send-email-jun.nie@linaro.org>
 <1478568298-18380-3-git-send-email-jun.nie@linaro.org> <8fbabe63-a4df-a368-9f6e-ddaf996b4023@rock-chips.com>
 <CABymUCOSDioY9pPwyAVJRr+F4FU9-+TxG4zbQajPvQ0QTxT3Ag@mail.gmail.com> <58570036-488a-9a49-bfd1-555b5d3994df@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:33272 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933366AbcKNKCF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2016 05:02:05 -0500
Received: by mail-qt0-f170.google.com with SMTP id p16so44115590qta.0
        for <linux-mmc@vger.kernel.org>; Mon, 14 Nov 2016 02:02:04 -0800 (PST)
In-Reply-To: <58570036-488a-9a49-bfd1-555b5d3994df@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, "xie.baoyou" <xie.baoyou@zte.com.cn>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Jason Liu <jason.liu@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

2016-11-14 17:03 GMT+08:00 Shawn Lin <shawn.lin@rock-chips.com>:
> =E5=9C=A8 2016/11/14 16:50, Jun Nie =E5=86=99=E9=81=93:
>>
>> 2016-11-14 16:07 GMT+08:00 Shawn Lin <shawn.lin@rock-chips.com>:
>>>
>>> Hi, Jun,
>>>
>>> Mostly it looks fine but some minor nits.
>>>
>>>
>>> On 2016/11/8 9:24, Jun Nie wrote:
>>>>
>>>>
>>>> This platform driver adds initial support for the DW host controller
>>>> found on ZTE SoCs.
>>>>
>>>> It has been tested on ZX296718 EVB board currently. More support on
>>>> timing tuning will be added when hardware is available.
>>>>
>>>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>>>> ---
>>>>  drivers/mmc/host/Kconfig     |   9 ++
>>>>  drivers/mmc/host/Makefile    |   1 +
>>>>  drivers/mmc/host/dw_mmc-zx.c | 243
>>>> +++++++++++++++++++++++++++++++++++++++++++
>>>>  drivers/mmc/host/dw_mmc-zx.h |  31 ++++++
>>>>  4 files changed, 284 insertions(+)
>>>>  create mode 100644 drivers/mmc/host/dw_mmc-zx.c
>>>>  create mode 100644 drivers/mmc/host/dw_mmc-zx.h
>>>>
>>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>>> index 5274f50..4dafbc2 100644
>>>> --- a/drivers/mmc/host/Kconfig
>>>> +++ b/drivers/mmc/host/Kconfig
>>>> @@ -662,6 +662,15 @@ config MMC_DW_ROCKCHIP
>>>>           Synopsys DesignWare Memory Card Interface driver. Select thi=
s
>>>> option
>>>>           for platforms based on RK3066, RK3188 and RK3288 SoC's.
>>>>
>>>> +config MMC_DW_ZX
>>>> +       tristate "ZTE specific extensions for Synopsys DW Memory Card
>>>> Interface"
>>>> +       depends on MMC_DW && ARCH_ZX
>>>> +       select MMC_DW_PLTFM
>>>> +       help
>>>> +         This selects support for ZTE SoC specific extensions to the
>>>> +         Synopsys DesignWare Memory Card Interface driver. Select thi=
s
>>>> option
>>>> +         for platforms based on ZX296718 SoC's.
>>>> +
>>>>  config MMC_SH_MMCIF
>>>>         tristate "SuperH Internal MMCIF support"
>>>>         depends on HAS_DMA
>>>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>>>> index e2bdaaf..9766143 100644
>>>> --- a/drivers/mmc/host/Makefile
>>>> +++ b/drivers/mmc/host/Makefile
>>>> @@ -48,6 +48,7 @@ obj-$(CONFIG_MMC_DW_EXYNOS)   +=3D dw_mmc-exynos.o
>>>>  obj-$(CONFIG_MMC_DW_K3)                +=3D dw_mmc-k3.o
>>>>  obj-$(CONFIG_MMC_DW_PCI)       +=3D dw_mmc-pci.o
>>>>  obj-$(CONFIG_MMC_DW_ROCKCHIP)  +=3D dw_mmc-rockchip.o
>>>> +obj-$(CONFIG_MMC_DW_ZX)                +=3D dw_mmc-zx.o
>>>>  obj-$(CONFIG_MMC_SH_MMCIF)     +=3D sh_mmcif.o
>>>>  obj-$(CONFIG_MMC_JZ4740)       +=3D jz4740_mmc.o
>>>>  obj-$(CONFIG_MMC_VUB300)       +=3D vub300.o
>>>> diff --git a/drivers/mmc/host/dw_mmc-zx.c b/drivers/mmc/host/dw_mmc-zx=
.c
>>>> new file mode 100644
>>>> index 0000000..c48d851
>>>> --- /dev/null
>>>> +++ b/drivers/mmc/host/dw_mmc-zx.c
>>>> @@ -0,0 +1,243 @@
>>>> +/*
>>>> + * ZX Specific Extensions for Synopsys DW Multimedia Card Interface
>>>> driver
>>>> + *
>>>> + * Copyright (C) 2016, Linaro Ltd.
>>>> + * Copyright (C) 2016, ZTE Corp.
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modi=
fy
>>>> + * it under the terms of the GNU General Public License as published =
by
>>>> + * the Free Software Foundation; either version 2 of the License, or
>>>> + * (at your option) any later version.
>>>> + */
>>>> +
>>>> +#include <linux/clk.h>
>>>> +#include <linux/mfd/syscon.h>
>>>> +#include <linux/mmc/dw_mmc.h>
>>>> +#include <linux/mmc/host.h>
>>>> +#include <linux/mmc/mmc.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/pm_runtime.h>
>>>> +#include <linux/regmap.h>
>>>> +#include <linux/slab.h>
>>>> +
>>>> +#include "dw_mmc.h"
>>>> +#include "dw_mmc-pltfm.h"
>>>> +#include "dw_mmc-zx.h"
>>>> +
>>>> +struct dw_mci_zx_priv_data {
>>>> +       struct regmap   *sysc_base;
>>>> +};
>>>> +
>>>> +enum delay_type {
>>>> +       DELAY_TYPE_READ,        /* read dqs delay */
>>>> +       DELAY_TYPE_CLK,         /* clk sample delay */
>>>> +};
>>>> +
>>>> +static int dw_mci_zx_emmc_set_delay(struct dw_mci *host, unsigned int
>>>> delay,
>>>> +                                   enum delay_type dflag)
>>>> +{
>>>> +       struct dw_mci_zx_priv_data *priv =3D host->priv;
>>>> +       struct regmap *sysc_base =3D priv->sysc_base;
>>>> +       unsigned int clksel;
>>>> +       unsigned int loop =3D 1000;
>>>> +       int ret;
>>>> +
>>>> +       if (!sysc_base)
>>>> +               return -EINVAL;
>>>> +
>>>> +       ret =3D regmap_update_bits(sysc_base, LB_AON_EMMC_CFG_REG0,
>>>> +                                PARA_HALF_CLK_MODE |
>>>> PARA_DLL_BYPASS_MODE
>>>> |
>>>> +                                PARA_PHASE_DET_SEL_MASK |
>>>> +                                PARA_DLL_LOCK_NUM_MASK |
>>>> +                                DLL_REG_SET | PARA_DLL_START_MASK,
>>>> +                                PARA_DLL_START(4) |
>>>> PARA_DLL_LOCK_NUM(4));
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       ret =3D regmap_read(sysc_base, LB_AON_EMMC_CFG_REG1, &clksel);
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       if (dflag =3D=3D DELAY_TYPE_CLK) {
>>>> +               clksel &=3D ~CLK_SAMP_DELAY_MASK;
>>>> +               clksel |=3D CLK_SAMP_DELAY(delay);
>>>> +       } else {
>>>> +               clksel &=3D ~READ_DQS_DELAY_MASK;
>>>> +               clksel |=3D READ_DQS_DELAY(delay);
>>>> +       }
>>>> +
>>>> +       regmap_write(sysc_base, LB_AON_EMMC_CFG_REG1, clksel);
>>>> +       regmap_update_bits(sysc_base, LB_AON_EMMC_CFG_REG0,
>>>> +                          PARA_DLL_START_MASK | PARA_DLL_LOCK_NUM_MAS=
K
>>>> |
>>>> +                          DLL_REG_SET,
>>>> +                          PARA_DLL_START(4) | PARA_DLL_LOCK_NUM(4) |
>>>> +                          DLL_REG_SET);
>>>> +
>>>> +       do {
>>>> +               ret =3D regmap_read(sysc_base, LB_AON_EMMC_CFG_REG2,
>>>> &clksel);
>>>> +               if (ret)
>>>> +                       return ret;
>>>> +
>>>> +       } while (--loop && !(clksel & ZX_DLL_LOCKED));
>>>> +
>>>> +       if (!loop) {
>>>> +               dev_err(host->dev, "Error: %s dll lock fail\n",
>>>> __func__);
>>>> +               return -EIO;
>>>> +       }
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int dw_mci_zx_emmc_execute_tuning(struct dw_mci_slot *slot, u3=
2
>>>> opcode)
>>>> +{
>>>> +       struct dw_mci *host =3D slot->host;
>>>> +       struct mmc_host *mmc =3D slot->mmc;
>>>> +       int len, start =3D 0, end =3D 0, delay, best =3D 0;
>>>> +
>>>> +       for (delay =3D 1 ; delay < 128; delay++) {
>>>> +               dw_mci_zx_emmc_set_delay(host, delay, DELAY_TYPE_CLK);
>>>
>>>
>>>
>>> you never check if doing dw_mci_zx_emmc_set_delay successfully?
>>>
>> Set delay failure leads to tuning command failure. So failure case
>> will be reflected in tuning result.
>
>
> okay, I see. But doesn't that imply you could save some cpu cycle?
> Why you still try to do tuning when failing to set delay.

You are right. Skipping tuning can save CPU cycle in theory. Will
change in next version.

>
>>
>>>
>>>> +               if (mmc_send_tuning(mmc, opcode, NULL)) {
>>>> +                       if (start >=3D 0) {
>>>> +                               end =3D delay - 1;
>>>> +                               /* check and update longest good range
>>>> */
>>>> +                               if ((end - start) > len) {
>>>> +                                       best =3D (start + end) >> 1;
>>>> +                                       len =3D end - start;
>>>> +                               }
>>>> +                       }
>>>> +                       start =3D -1;
>>>> +                       end =3D 0;
>>>> +                       continue;
>>>> +               }
>>>> +               if (start < 0)
>>>> +                       start =3D delay;
>>>> +       }
>>>> +
>>>> +       if (start >=3D 0) {
>>>> +               end =3D delay - 1;
>>>> +               if ((end - start) > len) {
>>>> +                       best =3D (start + end) >> 1;
>>>> +                       len =3D end - start;
>>>> +               }
>>>> +       }
>>>> +       if (best < 0)
>>>> +               return -EIO;
>>>> +
>>>> +       dev_info(host->dev, "%s best range: start %d end %d\n",
>>>> __func__,
>>>> +                start, end);
>>>> +       dw_mci_zx_emmc_set_delay(host, best, DELAY_TYPE_CLK);
>>>
>>>
>>>
>>> ditto.
>>>
>>>
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int dw_mci_zx_prepare_hs400_tuning(struct dw_mci *host,
>>>> +                                         struct mmc_ios *ios)
>>>> +{
>>>> +       int ret;
>>>> +
>>>> +       /* config phase shift as 90 degree */
>>>> +       ret =3D dw_mci_zx_emmc_set_delay(host, 32, DELAY_TYPE_READ);
>>>> +       if (ret < 0)
>>>> +               return -EIO;
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int dw_mci_zx_execute_tuning(struct dw_mci_slot *slot, u32
>>>> opcode)
>>>> +{
>>>> +       struct dw_mci *host =3D slot->host;
>>>> +
>>>> +       if (host->verid =3D=3D 0x290a) /* only for emmc */
>>>> +               return dw_mci_zx_emmc_execute_tuning(slot, opcode);
>>>> +       /* TODO: Add 0x210a dedicated tuning for sd/sdio */
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int dw_mci_zx_parse_dt(struct dw_mci *host)
>>>> +{
>>>> +       struct device_node *np =3D host->dev->of_node;
>>>> +       struct device_node *node;
>>>> +       struct dw_mci_zx_priv_data *priv;
>>>> +       struct regmap *sysc_base;
>>>> +       int ret;
>>>> +
>>>> +       /* syscon is needed only by emmc */
>>>> +       node =3D of_parse_phandle(np, "zte,aon-syscon", 0);
>>>> +       if (node) {
>>>> +               sysc_base =3D syscon_node_to_regmap(node);
>>>> +               of_node_put(node);
>>>> +
>>>> +               if (IS_ERR(sysc_base)) {
>>>> +                       ret =3D PTR_ERR(sysc_base);
>>>> +                       if (ret !=3D -EPROBE_DEFER)
>>>> +                               dev_err(host->dev, "Can't get syscon:
>>>> %d\n",
>>>> +                                       ret);
>>>> +                       return ret;
>>>> +               }
>>>> +       } else {
>>>> +               return 0;
>>>> +       }
>>>> +
>>>> +       priv =3D devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
>>>> +       if (!priv)
>>>> +               return -ENOMEM;
>>>> +       priv->sysc_base =3D sysc_base;
>>>> +       host->priv =3D priv;
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static unsigned long zx_dwmmc_caps[3] =3D {
>>>> +       MMC_CAP_CMD23,
>>>> +       MMC_CAP_CMD23,
>>>> +       MMC_CAP_CMD23,
>>>> +};
>>>> +
>>>> +static const struct dw_mci_drv_data zx_drv_data =3D {
>>>> +       .caps                   =3D zx_dwmmc_caps,
>>>> +       .execute_tuning         =3D dw_mci_zx_execute_tuning,
>>>> +       .prepare_hs400_tuning   =3D dw_mci_zx_prepare_hs400_tuning,
>>>> +       .parse_dt               =3D dw_mci_zx_parse_dt,
>>>> +};
>>>> +
>>>> +static const struct of_device_id dw_mci_zx_match[] =3D {
>>>> +       { .compatible =3D "zte,zx296718-dw-mshc", .data =3D &zx_drv_da=
ta},
>>>> +       {},
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, dw_mci_zx_match);
>>>> +
>>>> +static int dw_mci_zx_probe(struct platform_device *pdev)
>>>> +{
>>>> +       const struct dw_mci_drv_data *drv_data;
>>>> +       const struct of_device_id *match;
>>>> +
>>>> +       match =3D of_match_node(dw_mci_zx_match, pdev->dev.of_node);
>>>> +       drv_data =3D match->data;
>>>> +
>>>> +       return dw_mci_pltfm_register(pdev, drv_data);
>>>> +}
>>>> +
>>>> +static const struct dev_pm_ops dw_mci_zx_dev_pm_ops =3D {
>>>> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>>>> +                               pm_runtime_force_resume)
>>>> +       SET_RUNTIME_PM_OPS(dw_mci_runtime_suspend,
>>>> +                          dw_mci_runtime_resume,
>>>> +                          NULL)
>>>> +};
>>>> +
>>>> +static struct platform_driver dw_mci_zx_pltfm_driver =3D {
>>>> +       .probe          =3D dw_mci_zx_probe,
>>>> +       .remove         =3D dw_mci_pltfm_remove,
>>>> +       .driver         =3D {
>>>> +               .name           =3D "dwmmc_zx",
>>>> +               .of_match_table =3D dw_mci_zx_match,
>>>> +               .pm             =3D &dw_mci_zx_dev_pm_ops,
>>>> +       },
>>>> +};
>>>> +
>>>> +module_platform_driver(dw_mci_zx_pltfm_driver);
>>>> +
>>>> +MODULE_DESCRIPTION("ZTE emmc/sd driver");
>>>> +MODULE_LICENSE("GPL v2");
>>>> diff --git a/drivers/mmc/host/dw_mmc-zx.h b/drivers/mmc/host/dw_mmc-zx=
.h
>>>> new file mode 100644
>>>> index 0000000..f369997
>>>> --- /dev/null
>>>> +++ b/drivers/mmc/host/dw_mmc-zx.h
>>>> @@ -0,0 +1,31 @@
>>>> +#ifndef _DW_MMC_ZX_H_
>>>> +#define _DW_MMC_ZX_H_
>>>> +
>>>> +/* ZX296718 SoC specific DLL register offset. */
>>>> +#define LB_AON_EMMC_CFG_REG0  0x1B0
>>>> +#define LB_AON_EMMC_CFG_REG1  0x1B4
>>>> +#define LB_AON_EMMC_CFG_REG2  0x1B8
>>>> +
>>>> +/* LB_AON_EMMC_CFG_REG0 register defines */
>>>> +#define PARA_DLL_START(x)      ((x) & 0xFF)
>>>> +#define PARA_DLL_START_MASK    0xFF
>>>> +#define DLL_REG_SET            BIT(8)
>>>> +#define PARA_DLL_LOCK_NUM(x)   (((x) & 7) << 16)
>>>> +#define PARA_DLL_LOCK_NUM_MASK  (7 << 16)
>>>> +#define PARA_PHASE_DET_SEL(x)  (((x) & 7) << 20)
>>>> +#define PARA_PHASE_DET_SEL_MASK        (7 << 20)
>>>> +#define PARA_DLL_BYPASS_MODE   BIT(23)
>>>> +#define PARA_HALF_CLK_MODE     BIT(24)
>>>> +
>>>> +/* LB_AON_EMMC_CFG_REG1 register defines */
>>>> +#define READ_DQS_DELAY(x)      ((x) & 0x7F)
>>>> +#define READ_DQS_DELAY_MASK    (0x7F)
>>>> +#define READ_DQS_BYPASS_MODE   BIT(7)
>>>> +#define CLK_SAMP_DELAY(x)      (((x) & 0x7F) << 8)
>>>> +#define CLK_SAMP_DELAY_MASK    (0x7F << 8)
>>>> +#define CLK_SAMP_BYPASS_MODE   BIT(15)
>>>> +
>>>> +/* LB_AON_EMMC_CFG_REG2 register defines */
>>>> +#define ZX_DLL_LOCKED          BIT(2)
>>>> +
>>>> +#endif /* _DW_MMC_ZX_H_ */
>>>>
>>>
>>>
>>> --
>>> Best Regards
>>> Shawn Lin
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> Best Regards
> Shawn Lin
>
