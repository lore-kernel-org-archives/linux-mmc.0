From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 2/2] mmc: sdhci-cadence: add Cadence SD4HC support
Date: Thu, 8 Dec 2016 13:32:15 +0100
Message-ID: <CAPDyKFqbAzCyXArikgTUeTrs9vOzfwKWJcs3TgF7D-4f_xfjfQ@mail.gmail.com>
References: <1480903854-22701-1-git-send-email-yamada.masahiro@socionext.com> <1480903854-22701-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37296 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752464AbcLHMcS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2016 07:32:18 -0500
Received: by mail-wm0-f44.google.com with SMTP id t79so23215312wmt.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Dec 2016 04:32:17 -0800 (PST)
In-Reply-To: <1480903854-22701-3-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh+dt@kernel.org>, Andrei Pistirica <andrei.pistirica@microchip.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Joshua Henderson <joshua.henderson@microchip.com>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms+renesas@verge.net.au>, Eric Anholt <eric@anholt.net>

On 5 December 2016 at 03:10, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Add a driver for the Cadence SD4HC SD/SDIO/eMMC Controller.
>
> For SD, it basically relies on the SDHCI standard code.
> For eMMC, this driver provides some callbacks to support the
> hardware part that is specific to this IP design.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, applied for next!

Kind regards
Uffe


> ---
>
> Changes in v4:
>   - Override mmc_host_ops.execute_tuning instead of the
>     .platform_execute_tuning implementation
>
> Changes in v3:
>   - Remove unneeded explanation about HRS and SRS from DT binding;
>     the offsets to HRS/SRS are fixed for this hardware and this is
>     quite normal, like each hardware has a fixed register view except
>     the register base.  The detailed register map is what the driver
>     cares about, so no need to explain it in the binding.
>
> Changes in v2:
>   - Remove unnecessary "select MMC_SDHCI_IO_ACCESSORS"
>
>  .../devicetree/bindings/mmc/sdhci-cadence.txt      |  30 +++
>  drivers/mmc/host/Kconfig                           |  11 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/sdhci-cadence.c                   | 280 +++++++++++++++++++++
>  4 files changed, 322 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
>  create mode 100644 drivers/mmc/host/sdhci-cadence.c
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
> new file mode 100644
> index 0000000..750374f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
> @@ -0,0 +1,30 @@
> +* Cadence SD/SDIO/eMMC Host Controller
> +
> +Required properties:
> +- compatible: should be "cdns,sd4hc".
> +- reg: offset and length of the register set for the device.
> +- interrupts: a single interrupt specifier.
> +- clocks: phandle to the input clock.
> +
> +Optional properties:
> +For eMMC configuration, supported speed modes are not indicated by the SDHCI
> +Capabilities Register.  Instead, the following properties should be specified
> +if supported.  See mmc.txt for details.
> +- mmc-ddr-1_8v
> +- mmc-ddr-1_2v
> +- mmc-hs200-1_8v
> +- mmc-hs200-1_2v
> +- mmc-hs400-1_8v
> +- mmc-hs400-1_2v
> +
> +Example:
> +       emmc: sdhci@5a000000 {
> +               compatible = "cdns,sd4hc";
> +               reg = <0x5a000000 0x400>;
> +               interrupts = <0 78 4>;
> +               clocks = <&clk 4>;
> +               bus-width = <8>;
> +               mmc-ddr-1_8v;
> +               mmc-hs200-1_8v;
> +               mmc-hs400-1_8v;
> +       };
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index ab9181e..8ac1640 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -164,6 +164,17 @@ config MMC_SDHCI_OF_HLWD
>
>           If unsure, say N.
>
> +config MMC_SDHCI_CADENCE
> +       tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
> +       depends on MMC_SDHCI_PLTFM
> +       depends on OF
> +       help
> +         This selects the Cadence SD/SDIO/eMMC driver.
> +
> +         If you have a controller with this interface, say Y or M here.
> +
> +         If unsure, say N.
> +
>  config MMC_SDHCI_CNS3XXX
>         tristate "SDHCI support on the Cavium Networks CNS3xxx SoC"
>         depends on ARCH_CNS3XXX
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index e49a82a..55f7193 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -63,6 +63,7 @@ obj-$(CONFIG_MMC_REALTEK_PCI) += rtsx_pci_sdmmc.o
>  obj-$(CONFIG_MMC_REALTEK_USB)  += rtsx_usb_sdmmc.o
>
>  obj-$(CONFIG_MMC_SDHCI_PLTFM)          += sdhci-pltfm.o
> +obj-$(CONFIG_MMC_SDHCI_CADENCE)                += sdhci-cadence.o
>  obj-$(CONFIG_MMC_SDHCI_CNS3XXX)                += sdhci-cns3xxx.o
>  obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)      += sdhci-esdhc-imx.o
>  obj-$(CONFIG_MMC_SDHCI_DOVE)           += sdhci-dove.o
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> new file mode 100644
> index 0000000..6e2545f
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -0,0 +1,280 @@
> +/*
> + * Copyright (C) 2016 Socionext Inc.
> + *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/mmc/host.h>
> +
> +#include "sdhci-pltfm.h"
> +
> +/* HRS - Host Register Set (specific to Cadence) */
> +#define SDHCI_CDNS_HRS04               0x10            /* PHY access port */
> +#define   SDHCI_CDNS_HRS04_ACK                 BIT(26)
> +#define   SDHCI_CDNS_HRS04_RD                  BIT(25)
> +#define   SDHCI_CDNS_HRS04_WR                  BIT(24)
> +#define   SDHCI_CDNS_HRS04_RDATA_SHIFT         12
> +#define   SDHCI_CDNS_HRS04_WDATA_SHIFT         8
> +#define   SDHCI_CDNS_HRS04_ADDR_SHIFT          0
> +
> +#define SDHCI_CDNS_HRS06               0x18            /* eMMC control */
> +#define   SDHCI_CDNS_HRS06_TUNE_UP             BIT(15)
> +#define   SDHCI_CDNS_HRS06_TUNE_SHIFT          8
> +#define   SDHCI_CDNS_HRS06_TUNE_MASK           0x3f
> +#define   SDHCI_CDNS_HRS06_MODE_MASK           0x7
> +#define   SDHCI_CDNS_HRS06_MODE_SD             0x0
> +#define   SDHCI_CDNS_HRS06_MODE_MMC_SDR                0x2
> +#define   SDHCI_CDNS_HRS06_MODE_MMC_DDR                0x3
> +#define   SDHCI_CDNS_HRS06_MODE_MMC_HS200      0x4
> +#define   SDHCI_CDNS_HRS06_MODE_MMC_HS400      0x5
> +
> +/* SRS - Slot Register Set (SDHCI-compatible) */
> +#define SDHCI_CDNS_SRS_BASE            0x200
> +
> +/* PHY */
> +#define SDHCI_CDNS_PHY_DLY_SD_HS       0x00
> +#define SDHCI_CDNS_PHY_DLY_SD_DEFAULT  0x01
> +#define SDHCI_CDNS_PHY_DLY_UHS_SDR12   0x02
> +#define SDHCI_CDNS_PHY_DLY_UHS_SDR25   0x03
> +#define SDHCI_CDNS_PHY_DLY_UHS_SDR50   0x04
> +#define SDHCI_CDNS_PHY_DLY_UHS_DDR50   0x05
> +#define SDHCI_CDNS_PHY_DLY_EMMC_LEGACY 0x06
> +#define SDHCI_CDNS_PHY_DLY_EMMC_SDR    0x07
> +#define SDHCI_CDNS_PHY_DLY_EMMC_DDR    0x08
> +
> +/*
> + * The tuned val register is 6 bit-wide, but not the whole of the range is
> + * available.  The range 0-42 seems to be available (then 43 wraps around to 0)
> + * but I am not quite sure if it is official.  Use only 0 to 39 for safety.
> + */
> +#define SDHCI_CDNS_MAX_TUNING_LOOP     40
> +
> +struct sdhci_cdns_priv {
> +       void __iomem *hrs_addr;
> +};
> +
> +static void sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
> +                                    u8 addr, u8 data)
> +{
> +       void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS04;
> +       u32 tmp;
> +
> +       tmp = (data << SDHCI_CDNS_HRS04_WDATA_SHIFT) |
> +             (addr << SDHCI_CDNS_HRS04_ADDR_SHIFT);
> +       writel(tmp, reg);
> +
> +       tmp |= SDHCI_CDNS_HRS04_WR;
> +       writel(tmp, reg);
> +
> +       tmp &= ~SDHCI_CDNS_HRS04_WR;
> +       writel(tmp, reg);
> +}
> +
> +static void sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
> +{
> +       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_SD_HS, 4);
> +       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_SD_DEFAULT, 4);
> +       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_LEGACY, 9);
> +       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_SDR, 2);
> +       sdhci_cdns_write_phy_reg(priv, SDHCI_CDNS_PHY_DLY_EMMC_DDR, 3);
> +}
> +
> +static inline void *sdhci_cdns_priv(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +       return sdhci_pltfm_priv(pltfm_host);
> +}
> +
> +static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host)
> +{
> +       /*
> +        * Cadence's spec says the Timeout Clock Frequency is the same as the
> +        * Base Clock Frequency.  Divide it by 1000 to return a value in kHz.
> +        */
> +       return host->max_clk / 1000;
> +}
> +
> +static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
> +                                        unsigned int timing)
> +{
> +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +       u32 mode, tmp;
> +
> +       switch (timing) {
> +       case MMC_TIMING_MMC_HS:
> +               mode = SDHCI_CDNS_HRS06_MODE_MMC_SDR;
> +               break;
> +       case MMC_TIMING_MMC_DDR52:
> +               mode = SDHCI_CDNS_HRS06_MODE_MMC_DDR;
> +               break;
> +       case MMC_TIMING_MMC_HS200:
> +               mode = SDHCI_CDNS_HRS06_MODE_MMC_HS200;
> +               break;
> +       case MMC_TIMING_MMC_HS400:
> +               mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400;
> +               break;
> +       default:
> +               mode = SDHCI_CDNS_HRS06_MODE_SD;
> +               break;
> +       }
> +
> +       /* The speed mode for eMMC is selected by HRS06 register */
> +       tmp = readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
> +       tmp &= ~SDHCI_CDNS_HRS06_MODE_MASK;
> +       tmp |= mode;
> +       writel(tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
> +
> +       /* For SD, fall back to the default handler */
> +       if (mode == SDHCI_CDNS_HRS06_MODE_SD)
> +               sdhci_set_uhs_signaling(host, timing);
> +}
> +
> +static const struct sdhci_ops sdhci_cdns_ops = {
> +       .set_clock = sdhci_set_clock,
> +       .get_timeout_clock = sdhci_cdns_get_timeout_clock,
> +       .set_bus_width = sdhci_set_bus_width,
> +       .reset = sdhci_reset,
> +       .set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
> +       .ops = &sdhci_cdns_ops,
> +};
> +
> +static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
> +{
> +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +       void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS06;
> +       u32 tmp;
> +
> +       if (WARN_ON(val > SDHCI_CDNS_HRS06_TUNE_MASK))
> +               return -EINVAL;
> +
> +       tmp = readl(reg);
> +       tmp &= ~(SDHCI_CDNS_HRS06_TUNE_MASK << SDHCI_CDNS_HRS06_TUNE_SHIFT);
> +       tmp |= val << SDHCI_CDNS_HRS06_TUNE_SHIFT;
> +       tmp |= SDHCI_CDNS_HRS06_TUNE_UP;
> +       writel(tmp, reg);
> +
> +       return readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
> +                                 0, 1);
> +}
> +
> +static int sdhci_cdns_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       int max_streak = 0;
> +       int cur_streak = 0;
> +       int end_of_streak, i;
> +
> +       /*
> +        * This handler only implements the eMMC tuning that is specific to
> +        * this controller.  Fall back to the standard method for SD timing.
> +        */
> +       if (host->timing != MMC_TIMING_MMC_HS200)
> +               return sdhci_execute_tuning(mmc, opcode);
> +
> +       if (WARN_ON(opcode != MMC_SEND_TUNING_BLOCK_HS200))
> +               return -EINVAL;
> +
> +       for (i = 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
> +               if (sdhci_cdns_set_tune_val(host, i) ||
> +                   mmc_send_tuning(host->mmc, opcode, NULL)) { /* bad */
> +                       cur_streak = 0;
> +               } else { /* good */
> +                       cur_streak++;
> +                       max_streak = max(max_streak, cur_streak);
> +                       end_of_streak = i;
> +               }
> +       }
> +
> +       if (!max_streak) {
> +               dev_err(mmc_dev(host->mmc), "no tuning point found\n");
> +               return -EIO;
> +       }
> +
> +       return sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
> +}
> +
> +static int sdhci_cdns_probe(struct platform_device *pdev)
> +{
> +       struct sdhci_host *host;
> +       struct sdhci_pltfm_host *pltfm_host;
> +       struct sdhci_cdns_priv *priv;
> +       struct clk *clk;
> +       int ret;
> +
> +       clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +
> +       ret = clk_prepare_enable(clk);
> +       if (ret)
> +               return ret;
> +
> +       host = sdhci_pltfm_init(pdev, &sdhci_cdns_pltfm_data, sizeof(*priv));
> +       if (IS_ERR(host)) {
> +               ret = PTR_ERR(host);
> +               goto disable_clk;
> +       }
> +
> +       pltfm_host = sdhci_priv(host);
> +       pltfm_host->clk = clk;
> +
> +       priv = sdhci_cdns_priv(host);
> +       priv->hrs_addr = host->ioaddr;
> +       host->ioaddr += SDHCI_CDNS_SRS_BASE;
> +       host->mmc_host_ops.execute_tuning = sdhci_cdns_execute_tuning;
> +
> +       ret = mmc_of_parse(host->mmc);
> +       if (ret)
> +               goto free;
> +
> +       sdhci_cdns_phy_init(priv);
> +
> +       ret = sdhci_add_host(host);
> +       if (ret)
> +               goto free;
> +
> +       return 0;
> +free:
> +       sdhci_pltfm_free(pdev);
> +disable_clk:
> +       clk_disable_unprepare(clk);
> +
> +       return ret;
> +}
> +
> +static const struct of_device_id sdhci_cdns_match[] = {
> +       { .compatible = "cdns,sd4hc" },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_cdns_match);
> +
> +static struct platform_driver sdhci_cdns_driver = {
> +       .driver = {
> +               .name = "sdhci-cdns",
> +               .pm = &sdhci_pltfm_pmops,
> +               .of_match_table = sdhci_cdns_match,
> +       },
> +       .probe = sdhci_cdns_probe,
> +       .remove = sdhci_pltfm_unregister,
> +};
> +module_platform_driver(sdhci_cdns_driver);
> +
> +MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
> +MODULE_DESCRIPTION("Cadence SD/SDIO/eMMC Host Controller Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.7.4
>
