From: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 9/9] mmc: dw_mmc: add support for exynos specific
 implementation of dw-mshc
Date: Fri, 7 Sep 2012 21:43:24 +0530
Message-ID: <CAJuYYwS4SWAP19_VEVeycXWsVKG4q6LshXh1rtxmtrQEoe_PBA@mail.gmail.com>
References: <1346237295-7116-10-git-send-email-thomas.abraham@linaro.org>
 <1346788120-23799-1-git-send-email-thomas.abraham@linaro.org>
 <006201cd8b53$3b168350$b14389f0$%jun@samsung.com>
 <CAJuYYwTyJLLKGcefaOtgfdubfZmz7E6h9aJ1S+8Us-+k1NZ-BQ@mail.gmail.com>
 <00a601cd8ce6$ca599e50$5f0cdaf0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <00a601cd8ce6$ca599e50$5f0cdaf0$%jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, will.newton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 7 September 2012 16:21, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> On Friday, September 07, 2012, Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> Hi Seungwon,
>>
>> Thanks for reviewing the patch.
>>
>> On 5 September 2012 16:13, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> > On Wednesday, September 05, 2012, Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> > Version 6 is right?
>> >
>> >> Samsung Exynos SoC's extend the dw-mshc controller for additional clock and bus
>> >> control. Add support for these extensions and include provide device tree based
>> >> discovery suppory as well.
>> >>
>> >> Signed-off-by: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> >> Acked-by: Will Newton <will.newton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>> >> ---
>> >>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   86 +++++++
>> >>  drivers/mmc/host/Kconfig                           |    9 +
>> >>  drivers/mmc/host/Makefile                          |    1 +
>> >>  drivers/mmc/host/dw_mmc-exynos.c                   |  253 ++++++++++++++++++++
>> >>  4 files changed, 349 insertions(+), 0 deletions(-)
>> >>  create mode 100644 Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> >>  create mode 100644 drivers/mmc/host/dw_mmc-exynos.c
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> >> b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> >> new file mode 100644
>> >> index 0000000..323a891
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> >> @@ -0,0 +1,86 @@
>> >> +* Samsung Exynos specific extensions to the Synopsis Designware Mobile
>> >> +  Storage Host Controller
>> >> +
>> >> +The Synopsis designware mobile storage host controller is used to interface
>> >> +a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
>> >> +differences between the core Synopsis dw mshc controller properties described
>> >> +by synposis-dw-mshc.txt and the properties used by the Samsung Exynos specific
>> >> +extensions to the Synopsis Designware Mobile Storage Host Controller.
>> >> +
>> >> +Required Properties:
>> >> +
>> >> +* compatible: should be
>> >> +     - "samsung,exynos4210-dw-mshc": for controllers with Samsung Exynos4210
>> >> +       specific extentions.
>> >> +     - "samsung,exynos4412-dw-mshc": for controllers with Samsung Exynos4412
>> >> +       specific extentions.
>> >> +     - "samsung,exynos5250-dw-mshc": for controllers with Samsung Exynos5250
>> >> +       specific extentions.
>> >> +
>> >> +* samsung,dw-mshc-ciu-div: Specifies the divider value for the card interface
>> >> +  unit (ciu) clock. This property is applicable only for Exynos5 SoC's and
>> >> +  ignored for Exynos4 SoC's. The valid range of divider value is 0 to 7.
>> >> +
>> >> +* samsung,dw-mshc-sdr-timing: Specifies the value of CIU clock phase shift value
>> >> +  in transmit mode and CIU clock phase shift value in receive mode for single
>> >> +  data rate mode operation. Refer notes below for the order of the cells and the
>> >> +  valid values.
>> >> +
>> >> +* samsung,dw-mshc-ddr-timing: Specifies the value of CUI clock phase shift value
>> >> +  in transmit mode and CIU clock phase shift value in receive mode for double
>> >> +  data rate mode operation. Refer notes below for the order of the cells and the
>> >> +  valid values.
>> >> +
>> >> +  Notes for the sdr-timing and ddr-timing values:
>> >> +
>> >> +    The order of the cells should be
>> >> +      - First Cell: CIU clock phase shift value for tx mode.
>> >> +      - Second Cell: CIU clock phase shift value for rx mode.
>> >> +
>> >> +    Valid values for SDR and DDR CIU clock timing for Exynos5250:
>> >> +      - valid value for tx phase shift and rx phase shift is 0 to 7.
>> >> +      - when CIU clock divider value is set to 3, all possible 8 phase shift
>> >> +        values can be used.
>> >> +      - if CIU clock divider value is 0 (that is divide by 1), both tx and rx
>> >> +        phase shift clocks should be 0.
>> >> +
>> >> +Required properties for a slot:
>> >> +
>> >> +* gpios: specifies a list of gpios used for command, clock and data bus. The
>> >> +  first gpio is the command line and the second gpio is the clock line. The
>> >> +  rest of the gpios (depending on the bus-width property) are the data lines in
>> >> +  no particular order. The format of the gpio specifier depends on the gpio
>> >> +  controller.
>> >> +
>> >> +Example:
>> >> +
>> >> +  The MSHC controller node can be split into two portions, SoC specific and
>> >> +  board specific portions as listed below.
>> >> +
>> >> +     dwmmc0@12200000 {
>> >> +             compatible = "samsung,exynos5250-dw-mshc";
>> >> +             reg = <0x12200000 0x1000>;
>> >> +             interrupts = <0 75 0>;
>> >> +             #address-cells = <1>;
>> >> +             #size-cells = <0>;
>> >> +     };
>> >> +
>> >> +     dwmmc0@12200000 {
>> >> +             num-slots = <1>;
>> >> +             supports-highspeed;
>> >> +             broken-cd;
>> >> +             fifo-depth = <0x80>;
>> >> +             card-detect-delay = <200>;
>> >> +             samsung,dw-mshc-sdr-timing = <2 3 3>;
>> >> +             samsung,dw-mshc-ddr-timing = <1 2 3>;
>> > Third filed is still useful?
>>
>> No, it is not used anymore. Thanks for pointing this out.
>>
>> >
>> >
>> >> +
>> >> +             slot@0 {
>> >> +                     reg = <0>;
>> >> +                     bus-width = <8>;
>> >> +                     gpios = <&gpc0 0 2 0 3>, <&gpc0 1 2 0 3>,
>> >> +                             <&gpc1 0 2 3 3>, <&gpc1 1 2 3 3>,
>> >> +                             <&gpc1 2 2 3 3>, <&gpc1 3 2 3 3>,
>> >> +                             <&gpc0 3 2 3 3>, <&gpc0 4 2 3 3>,
>> >> +                             <&gpc0 5 2 3 3>, <&gpc0 6 2 3 3>;
>> >> +             };
>> >> +     };
>> >> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> >> index aa131b3..9bf10e7 100644
>> >> --- a/drivers/mmc/host/Kconfig
>> >> +++ b/drivers/mmc/host/Kconfig
>> >> @@ -540,6 +540,15 @@ config MMC_DW_PLTFM
>> >>
>> >>         If unsure, say Y.
>> >>
>> >> +config MMC_DW_EXYNOS
>> >> +     tristate "Exynos specific extentions for Synopsys DW Memory Card Interface"
>> >> +     depends on MMC_DW
>> >> +     select MMC_DW_PLTFM
>> >> +     help
>> >> +       This selects support for Samsung Exynos SoC specific extensions to the
>> >> +       Synopsys DesignWare Memory Card Interface driver. Select this option
>> >> +       for platforms based on Exynos4 and Exynos5 SoC's.
>> >> +
>> >>  config MMC_DW_PCI
>> >>       tristate "Synopsys Designware MCI support on PCI bus"
>> >>       depends on MMC_DW && PCI
>> >> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>> >> index 8922b06..17ad0a7 100644
>> >> --- a/drivers/mmc/host/Makefile
>> >> +++ b/drivers/mmc/host/Makefile
>> >> @@ -39,6 +39,7 @@ obj-$(CONFIG_MMC_VIA_SDMMC) += via-sdmmc.o
>> >>  obj-$(CONFIG_SDH_BFIN)               += bfin_sdh.o
>> >>  obj-$(CONFIG_MMC_DW)         += dw_mmc.o
>> >>  obj-$(CONFIG_MMC_DW_PLTFM)   += dw_mmc-pltfm.o
>> >> +obj-$(CONFIG_MMC_DW_EXYNOS)  += dw_mmc-exynos.o
>> >>  obj-$(CONFIG_MMC_DW_PCI)     += dw_mmc-pci.o
>> >>  obj-$(CONFIG_MMC_SH_MMCIF)   += sh_mmcif.o
>> >>  obj-$(CONFIG_MMC_JZ4740)     += jz4740_mmc.o
>> >> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
>> >> new file mode 100644
>> >> index 0000000..313f364
>> >> --- /dev/null
>> >> +++ b/drivers/mmc/host/dw_mmc-exynos.c
>> >> @@ -0,0 +1,253 @@
>> >> +/*
>> >> + * Exynos Specific Extensions for Synopsys DW Multimedia Card Interface driver
>> >> + *
>> >> + * Copyright (C) 2012, Samsung Electronics Co., Ltd.
>> >> + *
>> >> + * This program is free software; you can redistribute it and/or modify
>> >> + * it under the terms of the GNU General Public License as published by
>> >> + * the Free Software Foundation; either version 2 of the License, or
>> >> + * (at your option) any later version.
>> >> + */
>> >> +
>> >> +#include <linux/module.h>
>> >> +#include <linux/platform_device.h>
>> >> +#include <linux/clk.h>
>> >> +#include <linux/mmc/host.h>
>> >> +#include <linux/mmc/dw_mmc.h>
>> >> +#include <linux/of.h>
>> >> +#include <linux/of_gpio.h>
>> >> +
>> >> +#include "dw_mmc.h"
>> >> +#include "dw_mmc-pltfm.h"
>> >> +
>> >> +#define NUM_PINS(x)                  (x + 2)
>> >> +
>> >> +#define SDMMC_CLKSEL                 0x09C
>> >> +#define SDMMC_CLKSEL_CCLK_SAMPLE(x)  (((x) & 7) << 0)
>> >> +#define SDMMC_CLKSEL_CCLK_DRIVE(x)   (((x) & 7) << 16)
>> >> +#define SDMMC_CLKSEL_CCLK_DIVIDER(x) (((x) & 7) << 24)
>> >> +#define SDMMC_CLKSEL_GET_DRV_WD3(x)  (((x) >> 16) & 0x7)
>> >> +#define SDMMC_CLKSEL_TIMING(x, y, z) (SDMMC_CLKSEL_CCLK_SAMPLE(x) |  \
>> >> +                                     SDMMC_CLKSEL_CCLK_DRIVE(y) |    \
>> >> +                                     SDMMC_CLKSEL_CCLK_DIVIDER(z))
>> >> +
>> >> +#define SDMMC_CMD_USE_HOLD_REG               BIT(29)
>> >> +
>> >> +#define EXYNOS4210_FIXED_CIU_CLK_DIV 2
>> >> +#define EXYNOS4412_FIXED_CIU_CLK_DIV 4
>> >> +
>> >> +/* Variations in Exynos specific dw-mshc controller */
>> >> +enum dw_mci_exynos_type {
>> >> +     DW_MCI_TYPE_EXYNOS4210,
>> >> +     DW_MCI_TYPE_EXYNOS4412,
>> >> +     DW_MCI_TYPE_EXYNOS5250,
>> >> +};
>> >> +
>> >> +/* Exynos implementation specific driver private data */
>> >> +struct dw_mci_exynos_priv_data {
>> >> +     enum dw_mci_exynos_type         ctrl_type;
>> >> +     u8                              ciu_div;
>> >> +     u32                             sdr_timing;
>> >> +     u32                             ddr_timing;
>> >> +};
>> >> +
>> >> +static struct dw_mci_exynos_compatible {
>> >> +     char                            *compatible;
>> >> +     enum dw_mci_exynos_type         ctrl_type;
>> >> +} exynos_compat[] = {
>> >> +     {
>> >> +             .compatible     = "samsung,exynos4210-dw-mshc",
>> >> +             .ctrl_type      = DW_MCI_TYPE_EXYNOS4210,
>> >> +     }, {
>> >> +             .compatible     = "samsung,exynos4412-dw-mshc",
>> >> +             .ctrl_type      = DW_MCI_TYPE_EXYNOS4412,
>> >> +     }, {
>> >> +             .compatible     = "samsung,exynos5250-dw-mshc",
>> >> +             .ctrl_type      = DW_MCI_TYPE_EXYNOS5250,
>> >> +     },
>> >> +};
>> >> +
>> >> +static int dw_mci_exynos_priv_init(struct dw_mci *host)
>> >> +{
>> >> +     struct dw_mci_exynos_priv_data *priv;
>> >> +     int idx;
>> >> +
>> >> +     priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
>> >> +     if (!priv) {
>> >> +             dev_err(host->dev, "mem alloc failed for private data\n");
>> >> +             return -ENOMEM;
>> >> +     }
>> >> +
>> >> +     for (idx = 0; idx < ARRAY_SIZE(exynos_compat); idx++) {
>> >> +             if (of_device_is_compatible(host->dev->of_node,
>> >> +                                     exynos_compat[idx].compatible))
>> >> +                     priv->ctrl_type = exynos_compat[idx].ctrl_type;
>> >> +     }
>> >> +
>> >> +     host->priv = priv;
>> >> +     return 0;
>> >> +}
>> >> +
>> >> +static int dw_mci_exynos_setup_clock(struct dw_mci *host)
>> >> +{
>> >> +     struct dw_mci_exynos_priv_data *priv = host->priv;
>> >> +
>> > It assume that initial bus_hz is from clk_get_rate.
>> > Can it be ensured? If value of bus_hz is set from platform, calculation is wrong below.
>>
>> In case of legacy (non-dt) platforms, if bus_hz is being specified
>> using platform_data, the clock rate of bus_hz should be set to the
>> clock rate at the cclk_in pad of the dwmmc controller. platform_data
>> need to calculate the internal clock speed of ciu_clk.
> Until now, bus_hz coming from platform_data has the value of which calculation is finished for cclk_in.
> We should pay attention to use bus_hz with setup_clock callback.
> If you remain some comment anywhere for the bus_hz, it would be helpful.

Okay, I will add this point in the documentation for platform_data
structure of dwmmc driver.

>
> And latest version is v5 or v6?
> It is difficult to distinguish it from previous one.

Yes, I did not increment the version number of the patch, sorry about
that. Only three patches out of the nine patches were modified to
address the comments. And since the changes were minor, I wanted to
retain the same number for the reworked patches and maintain the
version number with the rest of the patches in this series. If there
are no more comments on this patch series, I can repost the full
series with a incremented version number.

Thanks,
Thomas.

[...]
