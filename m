From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 3/5] mmc: dw-mmc: add the header file for exynos specific
 code.
Date: Tue, 4 Sep 2012 11:04:05 +0100
Message-ID: <5045D215.3080201@imgtec.com>
References: <503C797F.4040506@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:21954 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752242Ab2IDKEH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Sep 2012 06:04:07 -0400
In-Reply-To: <503C797F.4040506@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, Thomas Abraham <thomas.abraham@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>

On 28/08/12 08:55, Jaehoon Chung wrote:
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  include/linux/mmc/exynos-dw_mmc.h |   61 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 61 insertions(+), 0 deletions(-)
>  create mode 100644 include/linux/mmc/exynos-dw_mmc.h
> 
> diff --git a/include/linux/mmc/exynos-dw_mmc.h b/include/linux/mmc/exynos-dw_mmc.h
> new file mode 100644
> index 0000000..3a6b08b
> --- /dev/null
> +++ b/include/linux/mmc/exynos-dw_mmc.h
> @@ -0,0 +1,61 @@
> +/*
> + * Synopsys DesignWare Multimedia Card Interface driver
> + *
> + * Copyright (c) 2012 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Header file for Exynos specific register
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _EXYNOS_DW_MMC_H
> +#define _EXYNOS_DW_MMC_H
> +#include <linux/mmc/dw_mmc.h>
> +#include <linux/mmc/host.h>
> +
> +#define SDMMC_EXYNOS_CLKSEL	0x09C
> +
> +#define SDMMC_GET_CLK_DRV(x)		((x) >> 16 & 0x7)
> +#define SDMMC_GET_CLK_SAMPLE(x)		((x) & 0x7)
> +#define SDMCM_GET_DIVRATIO(x)		((x) >> 24 & 0x7)
> +#define SDMMC_CLK_RESET_DRV_SAMPLE	(0x07070007);
> +
> +#define mci_readl(dev, reg)			\
> +	__raw_readl((dev)->regs + SDMMC_##reg)
> +#define mci_writel(dev, reg, value)			\
> +	__raw_writel((value), (dev)->regs + SDMMC_##reg)
> +
> +static inline int exynos_get_clk_drv(struct dw_mci *host)
> +{
> +	return SDMMC_GET_CLK_DRV(mci_readl(host, EXYNOS_CLKSEL));
> +}
> +
> +static inline int exynos_get_clk_sample(struct dw_mci *host)
> +{
> +	return SDMMC_GET_CLK_DRV(mci_readl(host, EXYNOS_CLKSEL));
> +}
> +
> +static inline void exynos_set_clk_drv_sample(struct dw_mci *host,
> +		struct mmc_ios *ios)
> +{
> +	u32 regs, ratio;
> +
> +	regs = mci_readl(host, EXYNOS_CLKSEL);
> +	ratio = SDMMC_GET_DIV_RATIO(reg);
> +	if (!ratio) {
> +		regs &= ~SDMMC_CLK_RESET_DRV_SAMPLE;
> +		regs |= ratio;
> +		if (ios->timing == MMC_TIMING_UHS_DDR50)
> +			regs |= host->pdata->ddr_timing;
> +		else
> +			regs |= host->pdata->sdr_timing;

Ah right, I see you're using them from a different patch. It feels wrong
to platform specific data within the general platform data structure as
it would be there unused for every other platform. Perhaps it would be
better to have an outer exynos platform data struct which contains the
standard one, and then use container_of to access it using the pointer
to the inner one. Does that make sense?

> +	} else
> +		regs &= ~SDMMC_CLK_RESET_DRV_SAMPLE;
> +
> +	mci_writel(host, EXYNOS_CLKSEL, regs);
> +}
> +
> +#endif /* _EXYNOS_DW_MMC_H */
> 

