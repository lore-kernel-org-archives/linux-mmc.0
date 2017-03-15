From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 08/14] mmc: sdhci-xenon: Add Marvell Xenon SDHC core
 functionality
Date: Wed, 15 Mar 2017 14:11:31 +0100
Message-ID: <CAPDyKFpH+RGAZGoVCuCOKJ2iEa+Y=cNNcM-uKhkYaTpmogXCKA@mail.gmail.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
 <cb885ae19e7c467908cdaa1f1cc8d95a7217d663.1487091464.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cb885ae19e7c467908cdaa1f1cc8d95a7217d663.1487091464.git-series.gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jimmy Xu <zmxu@marvell.com>, Andrew Lunn <andrew@lunn.ch>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mike Turquette <mturquette@baylibre.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, linux-clk <linux-clk@vger.kernel.org>, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, Ryan Gao <ygao@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lis>
List-Id: linux-mmc@vger.kernel.org

On 14 February 2017 at 18:01, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> From: Hu Ziji <huziji@marvell.com>
>
> Add Xenon eMMC/SD/SDIO host controller core functionality.
> Add Xenon specific initialization process.
> Add Xenon specific mmc_host_ops APIs.
> Add Xenon specific register definitions.
>
> Add CONFIG_MMC_SDHCI_XENON support in drivers/mmc/host/Kconfig.
>
> Marvell Xenon SDHC conforms to SD Physical Layer Specification
> Version 3.01 and is designed according to the guidelines provided
> in the SD Host Controller Standard Specification Version 3.00.
>
> Signed-off-by: Hu Ziji <huziji@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/mmc/host/Kconfig       |   9 +-
>  drivers/mmc/host/Makefile      |   3 +-
>  drivers/mmc/host/sdhci-xenon.c | 602 ++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci-xenon.h |  70 ++++-
>  4 files changed, 684 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-xenon.c
>  create mode 100644 drivers/mmc/host/sdhci-xenon.h
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 2eb97014dc3f..1c1a88bfbdad 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -819,3 +819,12 @@ config MMC_SDHCI_BRCMSTB
>           Broadcom STB SoCs.
>
>           If unsure, say Y.
> +
> +config MMC_SDHCI_XENON
> +       tristate "Marvell Xenon eMMC/SD/SDIO SDHCI driver"
> +       depends on MMC_SDHCI_PLTFM
> +       help
> +         This selects Marvell Xenon eMMC/SD/SDIO SDHCI.
> +         If you have a machine with integrated Marvell Xenon SDHC IP,

/s/SDHC/SDHCI

> +         say Y or M here.
> +         If unsure, say N.
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index ccc9c4cba154..b0a2ab4b256e 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -82,3 +82,6 @@ obj-$(CONFIG_MMC_SDHCI_BRCMSTB)               += sdhci-brcmstb.o
>  ifeq ($(CONFIG_CB710_DEBUG),y)
>         CFLAGS-cb710-mmc        += -DDEBUG
>  endif
> +
> +obj-$(CONFIG_MMC_SDHCI_XENON)  += sdhci-xenon-driver.o
> +sdhci-xenon-driver-y           += sdhci-xenon.o

Why not only this:
obj-$(CONFIG_MMC_SDHCI_XENON) += sdhci-xenon.o

> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> new file mode 100644
> index 000000000000..e633f803907a
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -0,0 +1,602 @@
> +/*
> + * Driver for Marvell Xenon SDHC as a platform device
> + *
> + * Copyright (C) 2016 Marvell, All Rights Reserved.
> + *
> + * Author:     Hu Ziji <huziji@marvell.com>
> + * Date:       2016-8-24
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * Inspired by Jisheng Zhang <jszhang@marvell.com>
> + * Special thanks to Video BG4 project team.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +#include "sdhci-pltfm.h"
> +#include "sdhci-xenon.h"
> +
> +static int enable_xenon_internal_clk(struct sdhci_host *host)

[...]

> +/* Set SDCLK-off-while-idle */
> +static void xenon_set_sdclk_off_idle(struct sdhci_host *host,
> +                                    unsigned char sdhc_id, bool enable)

[...]

> +/* Recover the Register Setting cleared during SOFTWARE_RESET_ALL */
> +static void sdhci_xenon_reset_exit(struct sdhci_host *host,
> +                                  unsigned char sdhc_id, u8 mask)

[...]

ff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
> new file mode 100644
> index 000000000000..69de711db9eb
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-xenon.h

You should probably put all this in the c-file instead. That is how
most other sdhci variants does it.

[...]

Overall this looks good to me, however I think Adrian needs to have a
quick look as well.

One additional very minor nitpick. Perhaps you can align on the
function names prefix, as those currently varies between "whatever",
"xenon_" and "sdhci_xenon_".

Kind regards
Uffe
