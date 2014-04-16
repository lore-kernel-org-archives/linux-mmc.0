From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 1/4] mmc: sdhci: add a driver for Berlin SoCs
Date: Wed, 16 Apr 2014 16:26:06 +0200
Message-ID: <534E92FE.8010400@gmail.com>
References: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com> <1397652011-21284-2-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397652011-21284-2-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart@free-electrons.com>, chris@printf.net, anton@enomsg.org
Cc: alexandre.belloni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 04/16/2014 02:40 PM, Antoine T=C3=A9nart wrote:
> Add a Driver to support the SDHCI controller of the Marvell Berlin So=
Cs.
> This controller supports 3 sockets.

nit: Isn't it three controller with one socket each?

> Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com=
>
> ---
>   drivers/mmc/host/Kconfig        |  11 ++++
>   drivers/mmc/host/Makefile       |   1 +
>   drivers/mmc/host/sdhci-berlin.c | 129 +++++++++++++++++++++++++++++=
+++++++++++
>   3 files changed, 141 insertions(+)
>   create mode 100644 drivers/mmc/host/sdhci-berlin.c
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 1384f67abe21..42db70031eb2 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -283,6 +283,17 @@ config MMC_SDHCI_BCM2835
>
>   	  If unsure, say N.
>
> +config MMC_SDHCI_BERLIN
> +	tristate "Marvell Berlin SD/MMC Host Controller support"
> +	depends on ARCH_BERLIN
> +	depends on MMC_SDHCI_PLTFM
> +	select MMC_SDHCI_IO_ACCESSORS
> +	help
> +	  This selects the Berlin SD/MMC controller. If you have a Berlin
> +	  platform with SD or MMC devices, say Y or M here.
> +
> +	  If unsure, say N.
> +
>   config MMC_OMAP
>   	tristate "TI OMAP Multimedia Card Interface support"
>   	depends on ARCH_OMAP
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 3483b6b6b880..b0256290530c 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+=3D sdhci-of-esdh=
c.o
>   obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+=3D sdhci-of-hlwd.o
>   obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+=3D sdhci-bcm-kona.o
>   obj-$(CONFIG_MMC_SDHCI_BCM2835)		+=3D sdhci-bcm2835.o
> +obj-$(CONFIG_MMC_SDHCI_BERLIN)		+=3D sdhci-berlin.o
>
>   ifeq ($(CONFIG_CB710_DEBUG),y)
>   	CFLAGS-cb710-mmc	+=3D -DDEBUG
> diff --git a/drivers/mmc/host/sdhci-berlin.c b/drivers/mmc/host/sdhci=
-berlin.c
> new file mode 100644
> index 000000000000..ece8f7863937
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-berlin.c
> @@ -0,0 +1,129 @@
> +/*
> + * Marvell Berlin SDHCI driver
> + *
> + * Copyright (C) 2014 Marvell Technology Group Ltd.
> + *
> + * Antoine T=C3=A9nart <antoine.tenart@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/mmc/host.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +
> +#include "sdhci-pltfm.h"
> +
> +static struct sdhci_ops sdhci_berlin_ops =3D {
> +	.get_max_clock =3D sdhci_pltfm_clk_get_max_clock,
> +};
> +
> +static struct sdhci_pltfm_data sdhci_berlin2_pdata =3D {
> +	.quirks	=3D SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_BROKEN_ADMA |
> +		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +	.ops =3D &sdhci_berlin_ops,
> +};
> +
> +static struct sdhci_pltfm_data sdhci_berlin2q_pdata =3D {
> +	.quirks	=3D SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
> +		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +	.ops =3D &sdhci_berlin_ops,
> +};
> +
> +static const struct of_device_id sdhci_berlin_of_match_table[] =3D {
> +	{
> +		.compatible =3D "marvell,berlin2-sdhci",
> +		.data =3D &sdhci_berlin2_pdata,
> +	},
> +	{
> +		.compatible =3D "marvell,berlin2cd-sdhci",
> +		.data =3D &sdhci_berlin2_pdata,
> +	},
> +	{
> +		.compatible =3D "marvell,berlin2q-sdhci",
> +		.data =3D &sdhci_berlin2q_pdata,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_berlin_of_match_table);
> +
> +static int sdhci_berlin_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct sdhci_host *host;
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct clk *clk;
> +	const struct of_device_id *device =3D
> +		of_match_device(sdhci_berlin_of_match_table, dev);
> +	int ret;
> +
> +	host =3D sdhci_pltfm_init(pdev,
> +				(struct sdhci_pltfm_data *)device->data, 0);
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host =3D sdhci_priv(host);
> +
> +	clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "could not get clock: %ld\n", PTR_ERR(clk));
> +		ret =3D PTR_ERR(clk);
> +		goto err_clk_get;
> +	}
> +
> +	clk_prepare_enable(clk);
> +	pltfm_host->clk =3D clk;
> +
> +	sdhci_get_of_property(pdev);
> +
> +	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> +		host->mmc->caps |=3D MMC_CAP_NONREMOVABLE;

Documentation/devicetree/bindings/mmc/mmc.txt names "non-removable"
as a standard property. Any chance we can shove this two lines above
right into sdhci_get_of_property()?

Besides the other comments from Joe, this looks good to me,

Reviewed-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> +
> +	ret =3D sdhci_add_host(host);
> +	if (ret)
> +		goto err_add_host;
> +
> +	return 0;
> +
> +err_add_host:
> +	clk_disable_unprepare(pltfm_host->clk);
> +err_clk_get:
> +	sdhci_pltfm_free(pdev);
> +
> +	return ret;
> +}
> +
> +static int sdhci_berlin_remove(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host =3D platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +
> +	sdhci_pltfm_unregister(pdev);
> +	clk_disable_unprepare(pltfm_host->clk);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sdhci_berlin_driver =3D {
> +	.driver		=3D {
> +		.name	=3D "berlin-sdhci",
> +		.owner	=3D THIS_MODULE,
> +		.pm	=3D SDHCI_PLTFM_PMOPS,
> +		.of_match_table =3D sdhci_berlin_of_match_table,
> +	},
> +	.probe		=3D sdhci_berlin_probe,
> +	.remove		=3D sdhci_berlin_remove,
> +};
> +module_platform_driver(sdhci_berlin_driver);
> +
> +MODULE_DESCRIPTION("SDHCI driver for Marvell Berlin SoC");
> +MODULE_AUTHOR("Antoine T=C3=A9nart <antoine.tenart@free-electrons.co=
m>");
> +MODULE_LICENSE("GPL");
>
