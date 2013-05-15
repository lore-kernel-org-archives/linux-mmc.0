From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/5] mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA
Date: Wed, 15 May 2013 19:11:23 +0200
Message-ID: <5336483.qTzEF54m2z@wuerfel>
References: <1368571955-6652-1-git-send-email-dinguyen@altera.com> <201305151525.50005.arnd@arndb.de> <5193BA6C.2050406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:56190 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932900Ab3EORLR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 May 2013 13:11:17 -0400
In-Reply-To: <5193BA6C.2050406@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dinh Nguyen <dinh.linux@gmail.com>, Seungwon Jeon <tgih.jun@samsung.com>, Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, dinguyen@altera.com, Olof Johansson <olof@lixom.net>

On Wednesday 15 May 2013 11:40:12 Dinh Nguyen wrote:
> On 05/15/2013 08:25 AM, Arnd Bergmann wrote:
> > On Wednesday 15 May 2013, dinguyen@altera.com wrote:
> >> +
> >> +#define SYSMGR_SDMMCGRP_CTRL_OFFSET         0x108
> >> +#define DRV_CLK_PHASE_SHIFT_SEL_MASK        0x7
> >> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)              \
> >> +    ((((drvsel) << 0) & 0x7) | (((smplsel) << 3) & 0x38))
> >> +
> >> +extern void __iomem *sys_manager_base_addr;
> > 
> > This is not acceptable, you cannot just reference external symbols
> > from one driver in another, without a proper interface.
> > 
> > Please explain what the functionality is that you need here, then
> > we can help you find the proper interface. My guess is that you
> > need either the functionality provided by drivers/reset/
> > or drivers/mfd/syscon.c.
> 
> Our implementation has the timing controls for the SD/MMC controller in
> another custom IP block(system manager). sys_manager_base_addr was
> mapped in mach-socfpga/socfpga.c. I saw the same approach with
> drivers/clk(clk_mgr_base_addr), so I thought it would be ok with this
> driver. Please advise on another way to do this...

The clock code is tied more more closely to the platform code, so I
was turning a blind eye on that one, under the assumption that it
was only used there.

	Arnd
