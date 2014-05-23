From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/8] mmc: sdhci-st: Intial support for ST SDHCI controller
Date: Fri, 23 May 2014 09:34:04 +0200
Message-ID: <CAPDyKFpanhYbf89tEKru=_oOfBGZZxs0=eqr_5MvU9v_bGULjQ@mail.gmail.com>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
	<1400771902-26553-2-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400771902-26553-2-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice CHOTARD <patrice.chotard@st.com>, srinivas.kandagatla@gmail.com, Chris Ball <chris@printf.net>, kernel@stlinux.com, Lee Jones <lee.jones@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>
List-Id: linux-mmc@vger.kernel.org

On 22 May 2014 17:18, Peter Griffin <peter.griffin@linaro.org> wrote:
> This platform driver adds initial support for the SDHCI host controll=
er
> found on STMicroelectronics SoCs.
>
> It has been tested on STiH41x b2020 platforms currently.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
>  drivers/mmc/host/Kconfig    |  12 +++
>  drivers/mmc/host/Makefile   |   1 +
>  drivers/mmc/host/sdhci-st.c | 244 ++++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 257 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-st.c
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8aaf8c1..b62c40d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -283,6 +283,18 @@ config MMC_SDHCI_BCM2835
>
>           If unsure, say N.
>
> +config MMC_SDHCI_ST
> +       tristate "SDHCI support on STMicroelectronics SoC"
> +       depends on ARCH_STI
> +       depends on MMC_SDHCI_PLTFM
> +       select MMC_SDHCI_IO_ACCESSORS
> +       help
> +         This selects the Secure Digital Host Controller Interface i=
n
> +         STMicroelectronics SoCs.
> +
> +         If you have a controller with this interface, say Y or M he=
re.
> +         If unsure, say N.
> +
>  config MMC_OMAP
>         tristate "TI OMAP Multimedia Card Interface support"
>         depends on ARCH_OMAP
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 0c8aa5e..6e0acf7 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_HLWD)               +=3D =
sdhci-of-hlwd.o
>  obj-$(CONFIG_MMC_SDHCI_BCM_KONA)       +=3D sdhci-bcm-kona.o
>  obj-$(CONFIG_MMC_SDHCI_BCM2835)                +=3D sdhci-bcm2835.o
>  obj-$(CONFIG_MMC_SDHCI_MSM)            +=3D sdhci-msm.o
> +obj-$(CONFIG_MMC_SDHCI_ST)             +=3D sdhci-st.o
>
>  ifeq ($(CONFIG_CB710_DEBUG),y)
>         CFLAGS-cb710-mmc        +=3D -DDEBUG
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.=
c
> new file mode 100644
> index 0000000..1790fa7
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -0,0 +1,244 @@
> +/*
> + * Support for SDHCI on STMicroelectronics SoCs
> + *
> + * Copyright (C) 2014 STMicroelectronics Ltd
> + * Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> + *
> + * Based on sdhci-cns3xxx.c
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/of_gpio.h>
> +#include <linux/mmc/host.h>
> +#include <linux/reset.h>
> +
> +#include "sdhci-pltfm.h"
> +
> +struct st_mmc_platform_data {
> +       struct  reset_control   *rstc;
> +};
> +
> +static int sdhci_st_8bit_width(struct sdhci_host *host, int width)
> +{
> +       u8 ctrl;
> +
> +       ctrl =3D sdhci_readb(host, SDHCI_HOST_CONTROL);
> +
> +       switch (width) {
> +       case MMC_BUS_WIDTH_8:
> +               ctrl |=3D SDHCI_CTRL_8BITBUS;
> +               ctrl &=3D ~SDHCI_CTRL_4BITBUS;
> +               break;
> +       case MMC_BUS_WIDTH_4:
> +               ctrl |=3D SDHCI_CTRL_4BITBUS;
> +               ctrl &=3D ~SDHCI_CTRL_8BITBUS;
> +               break;
> +       default:
> +               ctrl &=3D ~(SDHCI_CTRL_8BITBUS | SDHCI_CTRL_4BITBUS);
> +               break;
> +       }
> +
> +       sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +
> +       return 0;
> +}
> +
> +static unsigned int sdhci_st_get_max_clk(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +
> +       return clk_get_rate(pltfm_host->clk);
> +}

There are sdhci library function for the above:
sdhci_pltfm_clk_get_max_clock()

> +
> +static u32 sdhci_st_readl(struct sdhci_host *host, int reg)
> +{
> +       u32 ret;
> +
> +       switch (reg) {
> +       case SDHCI_CAPABILITIES:
> +               ret =3D readl(host->ioaddr + reg);
> +               /* Support 3.3V and 1.8V */
> +               ret &=3D ~SDHCI_CAN_VDD_300;
> +               break;
> +       default:
> +               ret =3D readl(host->ioaddr + reg);
> +       }
> +       return ret;
> +}
> +
> +static const struct sdhci_ops sdhci_st_ops =3D {
> +       .get_max_clock =3D sdhci_st_get_max_clk,
> +       .platform_bus_width =3D sdhci_st_8bit_width,
> +       .read_l =3D sdhci_st_readl,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_st_pdata =3D {
> +       .ops =3D &sdhci_st_ops,
> +       .quirks =3D SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
> +           SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +};
> +
> +
> +static int sdhci_st_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np =3D pdev->dev.of_node;
> +       struct sdhci_host *host;
> +       struct st_mmc_platform_data *pdata;
> +       struct sdhci_pltfm_host *pltfm_host;
> +       struct clk *clk;
> +       int ret =3D 0;
> +       u16 host_version;
> +
> +       dev_dbg(&pdev->dev, "SDHCI ST platform driver\n");
> +
> +       pdata =3D devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL=
);
> +       if (!pdata)
> +               return -ENOMEM;
> +
> +       pdata->rstc =3D devm_reset_control_get(&pdev->dev, NULL);
> +       if (IS_ERR(pdata->rstc))
> +               pdata->rstc =3D NULL;
> +       else
> +               reset_control_deassert(pdata->rstc);
> +
> +       clk =3D  devm_clk_get(&pdev->dev, "mmc");
> +       if (IS_ERR(clk)) {
> +               dev_err(&pdev->dev, "Perpheral clk not found\n");
> +               return PTR_ERR(clk);
> +       }
> +
> +       host =3D sdhci_pltfm_init(pdev, &sdhci_st_pdata, 0);
> +       if (IS_ERR(host)) {
> +               dev_err(&pdev->dev, "Failed sdhci_pltfm_init\n");
> +               return PTR_ERR(host);
> +       }
> +
> +       clk_prepare_enable(clk);
> +
> +       host->mmc->caps |=3D MMC_CAP_8_BIT_DATA | MMC_CAP_BUS_WIDTH_T=
EST
> +                       | MMC_CAP_1_8V_DDR;

Comment below.

> +
> +       if (of_property_read_bool(np, "non-removable"))
> +               host->mmc->caps |=3D MMC_CAP_NONREMOVABLE;

MMC_CAP_1_8V_DDR, MMC_CAP_8_BIT_DATA, MMC_CAP_NONREMOVABLE aren=E2=80=99=
t
those board specific capabilities?

Unless there are something that prevents you from using the common mmc
DT parser, I would suggest you to use it. mmc_of_parse(). Thus you can
provide these capabilities through DT instead.

Kind regards
Ulf Hansson
