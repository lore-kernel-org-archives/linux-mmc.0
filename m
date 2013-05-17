From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCHv2 6/6] mmc: dw_mmc: Add support DW SD/MMC driver on
 SOCFPGA
Date: Fri, 17 May 2013 13:46:07 +0200
Message-ID: <20130517114607.GB3466@amd.pavel.ucw.cz>
References: <1368731117-4749-1-git-send-email-dinguyen@altera.com>
 <1368731117-4749-6-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55067 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653Ab3EQLqK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 May 2013 07:46:10 -0400
Content-Disposition: inline
In-Reply-To: <1368731117-4749-6-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: linux-arm-kernel@lists.infradead.org, dinh.linux@gmail.com, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-mmc@vger.kernel.org

Hi!

> Add platform specific functionality for the DW SD/MMC driver for
> SoCFPGA. Move SDMMC_CMD_USE_HOLD_REG to dw_mmc.h so other platforms
> can use this define.

> --- /dev/null
> +++ b/drivers/mmc/host/dw_mmc-socfpga.c
> @@ -0,0 +1,139 @@
> +/*
> + * Altera SoCFPGA Specific Extensions for Synopsys DW Multimedia Card Interface driver
> + *
> + *  Copyright (C) 2012, Samsung Electronics Co., Ltd.
> + *  Copyright (C) 2013 Altera Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * Taken from dw_mmc_exynos.c

Actually it is   dw_mmc-exynos.c

> +#define SYSMGR_SDMMCGRP_CTRL_OFFSET		0x108
> +#define DRV_CLK_PHASE_SHIFT_SEL_MASK	0x7
> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)		\
> +	((((drvsel) << 0) & 0x7) | (((smplsel) << 3) & 0x38))

Should SYSMGR stuff go to shared header file somewhere?

> +extern void __iomem *sys_manager_base_addr;

This is unused.

> +/* SOCFPGA implementation specific driver private data */
> +struct dw_mci_socfpga_priv_data {
> +	u8	ciu_div;

comment would be nice, something like
/* card interface unit divisor */ ?

> +	u32	hs_timing;

/* card interface unit phase shift for RX/TX mode */
?

> +static int dw_mci_socfpga_setup_clock(struct dw_mci *host)
> +{
> +	struct dw_mci_socfpga_priv_data *priv = host->priv;
> +
> +	clk_disable(host->ciu_clk);
> +	regmap_write(priv->sysreg, SYSMGR_SDMMCGRP_CTRL_OFFSET, priv->hs_timing);
> +	clk_enable(host->ciu_clk);
> +
> +	host->bus_hz /= (priv->ciu_div + 1);

Previous version said:

+       host->bus_hz /= priv->ciu_div;

I see you want to avoid division by zero, but this will introduce
significant error for low divisors, right? Is divisor of 0 valid?

Otherwise it looks good. Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
