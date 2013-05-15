From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/5] mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA
Date: Wed, 15 May 2013 15:25:49 +0200
Message-ID: <201305151525.50005.arnd@arndb.de>
References: <1368571955-6652-1-git-send-email-dinguyen@altera.com> <1368571955-6652-5-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54719 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758125Ab3EONZ4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 May 2013 09:25:56 -0400
In-Reply-To: <1368571955-6652-5-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: linux-arm-kernel@lists.infradead.org, dinh.linux@gmail.com, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Olof Johansson <olof@lixom.net>, Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org

On Wednesday 15 May 2013, dinguyen@altera.com wrote:
> +
> +#define SYSMGR_SDMMCGRP_CTRL_OFFSET		0x108
> +#define DRV_CLK_PHASE_SHIFT_SEL_MASK	0x7
> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)		\
> +	((((drvsel) << 0) & 0x7) | (((smplsel) << 3) & 0x38))
> +
> +extern void __iomem *sys_manager_base_addr;

This is not acceptable, you cannot just reference external symbols
from one driver in another, without a proper interface.

Please explain what the functionality is that you need here, then
we can help you find the proper interface. My guess is that you
need either the functionality provided by drivers/reset/
or drivers/mfd/syscon.c.

> +       if (of_property_read_u32(dev->of_node, "pwr-en", &pwr_en)) {
> +               dev_info(dev, "couldn't determine pwr-en, assuming pwr-en = 0\n");
> +               pwr_en = 0;
> +       }
> +
> +       /* Set PWREN bit */
> +       mci_writel(host, PWREN, pwr_en);

If you add new properties, you have to document them in
Documentations/devicetree/bindings/*.

What is the requirement for this property? Is there no way to 
automatically power the card on/off using the normal
dw_mci_set_ios function?

The rest of this patch looks ok to me.

	Arnd
