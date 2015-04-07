From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 2/5] mmc: mediatek: Add Mediatek MMC driver
Date: Tue, 7 Apr 2015 16:01:46 +0200
Message-ID: <CABuKBe+MFHJO8GXRg5KYs2t+j6U4Ynv_hCeW0YQCrS_eZ-fuLA@mail.gmail.com>
References: <1426562035-16709-1-git-send-email-chaotian.jing@mediatek.com>
	<1426562035-16709-3-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426562035-16709-3-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mmc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, bin.zhang@mediatek.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

2015-03-17 4:13 GMT+01:00 Chaotian Jing <chaotian.jing@mediatek.com>:
> Add Mediatek MMC driver code
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/Kconfig  |    8 +
>  drivers/mmc/host/Makefile |    1 +
>  drivers/mmc/host/mtk-sd.c | 1412 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1421 insertions(+)
>  create mode 100644 drivers/mmc/host/mtk-sd.c
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 61ac63a..8b64377 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -768,3 +768,11 @@ config MMC_TOSHIBA_PCI
>         tristate "Toshiba Type A SD/MMC Card Interface Driver"
>         depends on PCI
>         help
> +
> +config MMC_MTK
> +       tristate "MediaTek SD/MMC Card Interface support"
> +       help
> +         This selects the MediaTek(R) Secure digital and Multimedia card Interface.
> +         If you have a machine with a integrated SD/MMC card reader, say Y or M here.
> +         This is needed if support for any SD/SDIO/MMC devices is required.
> +         If unsure, say N.
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 6a7cfe0..161b3e4 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_MMC_SDHCI_F_SDH30)       += sdhci_f_sdh30.o
>  obj-$(CONFIG_MMC_SDHCI_SPEAR)  += sdhci-spear.o
>  obj-$(CONFIG_MMC_WBSD)         += wbsd.o
>  obj-$(CONFIG_MMC_AU1X)         += au1xmmc.o
> +obj-$(CONFIG_MMC_MTK)           += mtk-sd.o
>  obj-$(CONFIG_MMC_OMAP)         += omap.o
>  obj-$(CONFIG_MMC_OMAP_HS)      += omap_hsmmc.o
>  obj-$(CONFIG_MMC_ATMELMCI)     += atmel-mci.o
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> new file mode 100644
> index 0000000..86c999b
> --- /dev/null
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -0,0 +1,1412 @@
> +/*
> + * Copyright (c) 2014-2015 MediaTek Inc.
> + * Author: Chaotian.Jing <chaotian.jing@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/ioport.h>
> +#include <linux/irq.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spinlock.h>
> +
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/core.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/sd.h>
> +#include <linux/mmc/sdio.h>
> +
> +#define MAX_GPD_NUM         (1 + 1)    /* one null gpd */
> +#define MAX_BD_NUM          1024
> +#define MAX_BD_PER_GPD      MAX_BD_NUM

This looks strange.
Why don't you define MAX_GPD_NUM as two?
Why do you define MAX_BD_PER_GPD when it is the same as MAX_BD_NUM?

Cheers,
Matthias

-- 
motzblog.wordpress.com
