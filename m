From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: use resource_size_t to store physical address
Date: Fri, 13 Nov 2015 03:10:13 +0200
Message-ID: <CAHp75VfyOWrihHC4nhpKQrjH9SjP0NnaN1WU8se3PL4biWtz4g@mail.gmail.com>
References: <28102387.ALpaBHpim0@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33516 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270AbbKMBKO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Nov 2015 20:10:14 -0500
In-Reply-To: <28102387.ALpaBHpim0@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>

On Thu, Nov 12, 2015 at 4:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The dw_mmc driver stores the physical address of the MMIO registers
> in a pointer, which requires the use of type casts, and is actually
> broken if anyone ever has this device on a 32-bit SoC in registers
> above 4GB. Gcc warns about this possibility when the driver is built
> with ARM LPAE enabled:

> -       host->phy_regs = (void *)(regs->start);
> +       host->phy_regs = regs->start;

>         /* Set external dma config: burst size, burst width */
> -       cfg.dst_addr = (dma_addr_t)(host->phy_regs + fifo_offset);
> +       cfg.dst_addr = host->phy_regs + fifo_offset;

dst_addr is dma_addr_t?

>         /* Registers's physical base address */
> -       void                    *phy_regs;
> +       resource_size_t         phy_regs;

If dst_addr is dma_addr_t wouldn't be a problem when
resource_size_t is defined as 64-bit address, and dma_addr_t as 32-bit?

Btw, for me casting to dma_addr_t looks sane.

-- 
With Best Regards,
Andy Shevchenko
