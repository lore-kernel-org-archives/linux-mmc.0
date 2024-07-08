Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D822884E11;
	Mon,  8 Jul 2024 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448717; cv=none; b=GT3GqDB8VqcmikXCexH3t41NyrW2tWOHfV7JTOA4qKV9pgooQTeagInAvUUTM0SyDDgxamREOKantQ4202WS52sQC+a2HvbwePNpjI5wmmRmGxJscnAdfnhfJOTkMYaVgIBx0PL3/V3sSAmhs6IIQVblFl564MkAJyLF0+3JEvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448717; c=relaxed/simple;
	bh=bLvPuTBIGrWz2AhT90LlzQqz+r5dtp2gOEx6gzloYic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LW1W0zPGkdHY6kQ+pRg68FwcTWDvDJlPCApmKtw+NC15F5vroQZeARxzUJC+i7cqqlPjfjBdh7mpRYMZXZzUCMcBFdTDm6sR+1XZDgbaLJ07H167f0L1HXpw1zfrmQtQCfAGs7789Objsmf1dEKBrDup684nw27T3QgwiYovizw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STaA7sh4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STaA7sh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8497C4AF0A;
	Mon,  8 Jul 2024 14:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720448716;
	bh=bLvPuTBIGrWz2AhT90LlzQqz+r5dtp2gOEx6gzloYic=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=STaA7sh4i/DdE0wKbYHbM7EKVKizmwv/GNoB3JyFHHzRq+0hEKrMegfUt0yrL3CuE
	 2Rb1fZoCVxsflHjt66TLF6hertZlVx/oosH9CjEnwtFiDoUx2tvsLpLpQBHvByRPsQ
	 TEgFaR1aANyOcIWFozuhJEgAqXDkW+Lv1kDJcyx+6BeGIdhMYGJozjcmJqwqb0eNq5
	 /cUQg6Otmd2X0G8mabwU96tx+2j9D/Fgpf4D6Ydx1ChxPdPkJCunoLL18whG/mQpwq
	 2S50gkKZBV41h4qlPlQDO70vLg8AmGJQ+SjXctxcfzTCvnKb83PMtQM8p0QdJgmYYb
	 n7P2KkoC5iNow==
Message-ID: <30cb5871-71f1-4b62-91fc-489519125bc2@kernel.org>
Date: Mon, 8 Jul 2024 16:25:09 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI
 driver
To: Shan-Chun Hung <shanchun1218@gmail.com>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 adrian.hunter@intel.com, p.zabel@pengutronix.de, pbrobinson@gmail.com,
 serghox@gmail.com, mcgrof@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, forbidden405@outlook.com,
 tmaimon77@gmail.com, andy.shevchenko@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240704062623.1480062-1-shanchun1218@gmail.com>
 <20240704062623.1480062-3-shanchun1218@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240704062623.1480062-3-shanchun1218@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/07/2024 08:26, Shan-Chun Hung wrote:
> Add the SDHCI driver for the MA35D1 platform. It is based upon the
> SDHCI interface, but requires some extra initialization.
> 
> Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
> ---
>  drivers/mmc/host/Kconfig           |  12 ++
>  drivers/mmc/host/Makefile          |   1 +
>  drivers/mmc/host/sdhci-of-ma35d1.c | 297 +++++++++++++++++++++++++++++
>  3 files changed, 310 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-of-ma35d1.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index bb0d4fb0892a..aa6922ff4210 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -252,6 +252,18 @@ config MMC_SDHCI_OF_SPARX5
> 
>  	  If unsure, say N.
> 
> +config MMC_SDHCI_OF_MA35D1
> +	tristate "SDHCI OF support for the MA35D1 SDHCI controller"
> +	depends on ARCH_MA35 || COMPILE_TEST
> +	depends on MMC_SDHCI_PLTFM
> +	help
> +	  This selects the MA35D1 Secure Digital Host Controller Interface.
> +	  The controller supports SD/MMC/SDIO devices.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_CADENCE
>  	tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
>  	depends on MMC_SDHCI_PLTFM
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index f53f86d200ac..3ccffebbe59b 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -88,6 +88,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
>  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
>  obj-$(CONFIG_MMC_SDHCI_OF_DWCMSHC)	+= sdhci-of-dwcmshc.o
>  obj-$(CONFIG_MMC_SDHCI_OF_SPARX5)	+= sdhci-of-sparx5.o
> +obj-$(CONFIG_MMC_SDHCI_OF_MA35D1)	+= sdhci-of-ma35d1.o
>  obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
>  obj-$(CONFIG_MMC_SDHCI_IPROC)		+= sdhci-iproc.o
>  obj-$(CONFIG_MMC_SDHCI_NPCM)		+= sdhci-npcm.o
> diff --git a/drivers/mmc/host/sdhci-of-ma35d1.c b/drivers/mmc/host/sdhci-of-ma35d1.c
> new file mode 100644
> index 000000000000..b5aab65b9093
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-ma35d1.c
> @@ -0,0 +1,297 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Nuvoton Technology Corp.
> + *
> + * Author: Shan-Chun Hung <shanchun1218@gmail.com>
> + */
> +
> +#include <linux/align.h>
> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/build_bug.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/math.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/minmax.h>
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/sizes.h>
> +#include <linux/types.h>
> +
> +#include "sdhci-pltfm.h"
> +#include "sdhci.h"
> +
> +#define MA35_SYS_MISCFCR0	0x070
> +#define MA35_SDHCI_MSHCCTL	0x508
> +#define MA35_SDHCI_MBIUCTL	0x510
> +
> +#define MA35_SDHCI_CMD_CONFLICT_CHK	BIT(0)
> +#define MA35_SDHCI_INCR_MSK		GENMASK(3, 0)
> +#define MA35_SDHCI_INCR16		BIT(3)
> +#define MA35_SDHCI_INCR8		BIT(2)
> +
> +struct ma35_priv {
> +	struct regmap		*regmap;

Drop, you don't use it.

> +	struct reset_control	*rst;
> +	struct pinctrl		*pinctrl;
> +	struct pinctrl_state	*pins_uhs;
> +	struct pinctrl_state	*pins_default;
> +};
> +
> +struct ma35_restore_data {
> +	u32	reg;
> +	u32	width;
> +};
> +

...

> +
> +static int ma35_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_host *host;
> +	struct ma35_priv *priv;
> +	int err;
> +	u32 extra, ctl;
> +
> +	host = sdhci_pltfm_init(pdev, &sdhci_ma35_pdata, sizeof(struct ma35_priv));
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	/* Extra adma table cnt for cross 128M boundary handling. */
> +	extra = DIV_ROUND_UP_ULL(dma_get_required_mask(dev), SZ_128M);
> +	extra = min(extra, SDHCI_MAX_SEGS);
> +
> +	host->adma_table_cnt += extra;
> +	pltfm_host = sdhci_priv(host);
> +	priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	pltfm_host->clk = devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(pltfm_host->clk)) {
> +		err = PTR_ERR(pltfm_host->clk);
> +		dev_err_probe(dev, err, "failed to get clk\n");

Syntax is err = dev_err_probe()

> +		goto err_sdhci;
> +	}
> +
> +	err = mmc_of_parse(host->mmc);
> +	if (err)
> +		goto err_sdhci;
> +
> +	priv->rst = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(priv->rst)) {
> +		err = PTR_ERR(priv->rst);
> +		dev_err_probe(dev, err, "failed to get reset control\n");

err = dev_err_probe

... so all your previous versions were leaking memory. Double check your
error paths.

> +		goto err_sdhci;
> +	}
> +
> +	sdhci_get_of_property(pdev);
> +

Best regards,
Krzysztof

