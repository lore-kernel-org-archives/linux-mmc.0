From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/6] phy: am654-mmc-phy: Add Support for MMC PHY on AM654 Devices
Date: Mon, 8 Oct 2018 13:32:27 +0200
Message-ID: <CAPDyKFpgUqHy4ihN-NZd8Qiat8K3U7xzofj_yjpDqGiFLd3JGg@mail.gmail.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com> <20181004111451.9539-3-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004111451.9539-3-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kishon <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On 4 October 2018 at 13:14, Faiz Abbas <faiz_abbas@ti.com> wrote:
> Add driver support for the MMC physical layer present
> on TI's AM654 devices.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

I assume Kishon would like to pick up this through his tree? If not,
please tell and I can do it, with his ack.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/phy/ti/Kconfig         |   7 +
>  drivers/phy/ti/Makefile        |   1 +
>  drivers/phy/ti/phy-am654-mmc.c | 291 +++++++++++++++++++++++++++++++++
>  3 files changed, 299 insertions(+)
>  create mode 100644 drivers/phy/ti/phy-am654-mmc.c
>
> diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
> index 20503562666c..ea5fe4db01c8 100644
> --- a/drivers/phy/ti/Kconfig
> +++ b/drivers/phy/ti/Kconfig
> @@ -76,3 +76,10 @@ config TWL4030_USB
>           family chips (including the TWL5030 and TPS659x0 devices).
>           This transceiver supports high and full speed devices plus,
>           in host mode, low speed.
> +
> +config PHY_AM654_MMC
> +       bool "TI AM654 MMC PHY Support"
> +       select GENERIC_PHY
> +       help
> +         This option enables support for the Physical layer for MMC host
> +         controllers present on TI AM654 SOCs.
> diff --git a/drivers/phy/ti/Makefile b/drivers/phy/ti/Makefile
> index 9f361756eaf2..5b2db2d164a5 100644
> --- a/drivers/phy/ti/Makefile
> +++ b/drivers/phy/ti/Makefile
> @@ -6,3 +6,4 @@ obj-$(CONFIG_OMAP_USB2)                 += phy-omap-usb2.o
>  obj-$(CONFIG_TI_PIPE3)                 += phy-ti-pipe3.o
>  obj-$(CONFIG_PHY_TUSB1210)             += phy-tusb1210.o
>  obj-$(CONFIG_TWL4030_USB)              += phy-twl4030-usb.o
> +obj-$(CONFIG_PHY_AM654_MMC)            += phy-am654-mmc.o
> diff --git a/drivers/phy/ti/phy-am654-mmc.c b/drivers/phy/ti/phy-am654-mmc.c
> new file mode 100644
> index 000000000000..91255947fb67
> --- /dev/null
> +++ b/drivers/phy/ti/phy-am654-mmc.c
> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * phy-am654-mmc.c - MMC PHY driver for TI's AM654 SOCs
> + *
> + * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/regmap.h>
> +
> +/* MMC PHY Registers */
> +#define PHYCTRL_CTRL1_REG      0x00
> +#define PHYCTRL_CTRL2_REG      0x04
> +#define PHYCTRL_CTRL3_REG      0x08
> +#define PHYCTRL_CTRL4_REG      0x0C
> +#define PHYCTRL_CTRL5_REG      0x10
> +#define PHYCTRL_CTRL6_REG      0x14
> +#define PHYCTRL_STAT1_REG      0x30
> +#define PHYCTRL_STAT2_REG      0x34
> +
> +#define IOMUX_ENABLE_SHIFT     31
> +#define IOMUX_ENABLE_MASK      BIT(IOMUX_ENABLE_SHIFT)
> +#define OTAPDLYENA_SHIFT       20
> +#define OTAPDLYENA_MASK        BIT(OTAPDLYENA_SHIFT)
> +#define OTAPDLYSEL_SHIFT       12
> +#define OTAPDLYSEL_MASK        GENMASK(15, 12)
> +#define STRBSEL_SHIFT          24
> +#define STRBSEL_MASK           GENMASK(27, 24)
> +#define SEL50_SHIFT            8
> +#define SEL50_MASK             BIT(SEL50_SHIFT)
> +#define SEL100_SHIFT           9
> +#define SEL100_MASK            BIT(SEL100_SHIFT)
> +#define DLL_TRIM_ICP_SHIFT     4
> +#define DLL_TRIM_ICP_MASK      GENMASK(7, 4)
> +#define DR_TY_SHIFT            20
> +#define DR_TY_MASK             GENMASK(22, 20)
> +#define ENDLL_SHIFT            1
> +#define ENDLL_MASK             BIT(ENDLL_SHIFT)
> +#define DLLRDY_SHIFT           0
> +#define DLLRDY_MASK            BIT(DLLRDY_SHIFT)
> +#define PDB_SHIFT              0
> +#define PDB_MASK               BIT(PDB_SHIFT)
> +#define CALDONE_SHIFT          1
> +#define CALDONE_MASK           BIT(CALDONE_SHIFT)
> +
> +#define DRIVER_STRENGTH_50_OHM 0x0
> +#define DRIVER_STRENGTH_33_OHM 0x1
> +#define DRIVER_STRENGTH_66_OHM 0x2
> +#define DRIVER_STRENGTH_100_OHM        0x3
> +#define DRIVER_STRENGTH_40_OHM 0x4
> +
> +static struct regmap_config am654_mmc_phy_regmap_config = {
> +       .reg_bits = 32,
> +       .val_bits = 32,
> +       .reg_stride = 4,
> +       .fast_io = true,
> +};
> +
> +struct am654_mmc_phy {
> +       struct regmap *reg_base;
> +       struct clk *mmcclk;
> +       int otap_del_sel;
> +       int trm_icp;
> +       int drv_strength;
> +};
> +
> +static int am654_mmc_phy_init(struct phy *phy)
> +{
> +       struct am654_mmc_phy *mmc_phy = phy_get_drvdata(phy);
> +       int ret;
> +       u32 val;
> +
> +       /* Reset registers to default value */
> +       regmap_write(mmc_phy->reg_base, PHYCTRL_CTRL1_REG, 0x10000);
> +       regmap_write(mmc_phy->reg_base, PHYCTRL_CTRL4_REG, 0x0);
> +       regmap_write(mmc_phy->reg_base, PHYCTRL_CTRL5_REG, 0x0);
> +
> +       /* Calibrate IO lines */
> +       regmap_update_bits(mmc_phy->reg_base, PHYCTRL_CTRL1_REG,
> +                          PDB_MASK, PDB_MASK);
> +       ret = regmap_read_poll_timeout(mmc_phy->reg_base, PHYCTRL_STAT1_REG,
> +                                      val, val & CALDONE_MASK, 1, 20);
> +       if (ret)
> +               return ret;
> +
> +       /* Enable pins by setting the IO mux to 0 */
> +       regmap_update_bits(mmc_phy->reg_base, PHYCTRL_CTRL1_REG,
> +                          IOMUX_ENABLE_MASK, 0);
> +
> +       mmc_phy->mmcclk = clk_get(&phy->dev, "mmcclk");
> +       if (IS_ERR(mmc_phy->mmcclk)) {
> +               dev_err(&phy->dev, "Error getting mmcclk");
> +               return PTR_ERR(mmc_phy->mmcclk);
> +       }
> +
> +       return 0;
> +}
> +
> +static int am654_mmc_phy_exit(struct phy *phy)
> +{
> +       struct am654_mmc_phy *mmc_phy = phy_get_drvdata(phy);
> +
> +       clk_put(mmc_phy->mmcclk);
> +
> +       return 0;
> +}
> +
> +static int am654_mmc_phy_power_on(struct phy *phy)
> +{
> +       struct am654_mmc_phy *mmc_phy = phy_get_drvdata(phy);
> +       u32 mask, val;
> +       int sel50, sel100;
> +       int rate;
> +
> +       /* Setup DLL Output TAP delay */
> +       mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
> +       val = (1 << OTAPDLYENA_SHIFT) |
> +             (mmc_phy->otap_del_sel << OTAPDLYSEL_SHIFT);
> +       regmap_update_bits(mmc_phy->reg_base, PHYCTRL_CTRL4_REG,
> +                          mask, val);
> +
> +       rate = clk_get_rate(mmc_phy->mmcclk);
> +       switch (rate) {
> +       case 200000000:
> +               sel50 = 0;
> +               sel100 = 0;
> +               break;
> +       case 100000000:
> +               sel50 = 0;
> +               sel100 = 1;
> +               break;
> +       default:
> +               sel50 = 1;
> +               sel100 = 0;
> +       }
> +
> +       /* Configure PHY DLL frequency */
> +       mask = SEL50_MASK | SEL100_MASK;
> +       val = (sel50 << SEL50_SHIFT) | (sel100 << SEL100_SHIFT);
> +       regmap_update_bits(mmc_phy->reg_base, PHYCTRL_CTRL5_REG,
> +                          mask, val);
> +
> +       /* Configure DLL TRIM */
> +       mask = DLL_TRIM_ICP_MASK;
> +       val = mmc_phy->trm_icp << DLL_TRIM_ICP_SHIFT;
> +
> +       /* Configure DLL driver strength */
> +       mask |= DR_TY_MASK;
> +       val |= mmc_phy->drv_strength << DR_TY_SHIFT;
> +       regmap_update_bits(mmc_phy->reg_base, PHYCTRL_CTRL1_REG, mask, val);
> +
> +       /* Enable DLL */
> +       regmap_update_bits(mmc_phy->reg_base, PHYCTRL_CTRL1_REG,
> +                          ENDLL_MASK, 0x1 << ENDLL_SHIFT);
> +
> +       /*
> +        * Poll for DLL ready. Use a one second timeout.
> +        * Works in all experiments done so far
> +        */
> +       return regmap_read_poll_timeout(mmc_phy->reg_base, PHYCTRL_STAT1_REG,
> +                                       val, val & DLLRDY_MASK, 1000, 1000000);
> +
> +}
> +
> +static int am654_mmc_phy_power_off(struct phy *phy)
> +{
> +       struct am654_mmc_phy *mmc_phy = phy_get_drvdata(phy);
> +
> +       /* Disable DLL */
> +       regmap_update_bits(mmc_phy->reg_base, PHYCTRL_CTRL1_REG,
> +                          ENDLL_MASK, 0);
> +
> +       /* Reset registers to default value except PDB */
> +       regmap_write(mmc_phy->reg_base, PHYCTRL_CTRL1_REG,
> +                    0x10000 | PDB_MASK);
> +       regmap_write(mmc_phy->reg_base, PHYCTRL_CTRL4_REG, 0x0);
> +       regmap_write(mmc_phy->reg_base, PHYCTRL_CTRL5_REG, 0x0);
> +
> +       return 0;
> +}
> +
> +static const struct phy_ops ops = {
> +       .init           = am654_mmc_phy_init,
> +       .exit           = am654_mmc_phy_exit,
> +       .power_on       = am654_mmc_phy_power_on,
> +       .power_off      = am654_mmc_phy_power_off,
> +       .owner          = THIS_MODULE,
> +};
> +
> +static int am654_mmc_phy_probe(struct platform_device *pdev)
> +{
> +       struct phy_provider *phy_provider;
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +       struct am654_mmc_phy *mmc_phy;
> +       struct phy *generic_phy;
> +       struct resource *res;
> +       void __iomem *base;
> +       struct regmap *map;
> +       int drv_strength;
> +       int err;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       map = devm_regmap_init_mmio(dev, base, &am654_mmc_phy_regmap_config);
> +       if (IS_ERR(map)) {
> +               dev_err(dev, "could not initialize regmap\n");
> +               return PTR_ERR(map);
> +       }
> +
> +       mmc_phy = devm_kzalloc(dev, sizeof(struct am654_mmc_phy), GFP_KERNEL);
> +       if (!mmc_phy)
> +               return -ENOMEM;
> +
> +       mmc_phy->reg_base = map;
> +       err = of_property_read_u32(np, "ti,otap-del-sel",
> +                                  &mmc_phy->otap_del_sel);
> +       if (err)
> +               return err;
> +
> +       err = of_property_read_u32(np, "ti,trm-icp",
> +                                  &mmc_phy->trm_icp);
> +       if (err)
> +               return err;
> +
> +       err = of_property_read_u32(np, "ti,driver-strength-ohm", &drv_strength);
> +       if (err)
> +               return err;
> +
> +       switch (drv_strength) {
> +       case 50:
> +               mmc_phy->drv_strength = DRIVER_STRENGTH_50_OHM;
> +               break;
> +       case 33:
> +               mmc_phy->drv_strength = DRIVER_STRENGTH_33_OHM;
> +               break;
> +       case 66:
> +               mmc_phy->drv_strength = DRIVER_STRENGTH_66_OHM;
> +               break;
> +       case 100:
> +               mmc_phy->drv_strength = DRIVER_STRENGTH_100_OHM;
> +               break;
> +       case 40:
> +               mmc_phy->drv_strength = DRIVER_STRENGTH_40_OHM;
> +               break;
> +       default:
> +               dev_err(dev, "Invalid driver strength\n");
> +               return -EINVAL;
> +       }
> +
> +       generic_phy = devm_phy_create(dev, dev->of_node, &ops);
> +       if (IS_ERR(generic_phy)) {
> +               dev_err(dev, "failed to create PHY\n");
> +               return PTR_ERR(generic_phy);
> +       }
> +
> +       phy_set_drvdata(generic_phy, mmc_phy);
> +       phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +
> +       return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static const struct of_device_id am654_mmc_phy_dt_ids[] = {
> +       { .compatible = "ti,am654-mmc-phy" },
> +       {}
> +};
> +
> +MODULE_DEVICE_TABLE(of, am654_mmc_phy_dt_ids);
> +
> +static struct platform_driver am654_mmc_phy_driver = {
> +       .probe          = am654_mmc_phy_probe,
> +       .driver         = {
> +               .name   = "am654-mmc-phy",
> +               .of_match_table = am654_mmc_phy_dt_ids,
> +       },
> +};
> +
> +module_platform_driver(am654_mmc_phy_driver);
> +
> +MODULE_AUTHOR("Faiz Abbas <faiz_abbas@ti.com>");
> +MODULE_DESCRIPTION("TI AM654 MMC PHY driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.18.0
>
