From: Dinh Nguyen <dinh.linux@gmail.com>
Subject: Re: [PATCH 5/5] mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA
Date: Wed, 15 May 2013 11:40:12 -0500
Message-ID: <5193BA6C.2050406@gmail.com>
References: <1368571955-6652-1-git-send-email-dinguyen@altera.com> <1368571955-6652-5-git-send-email-dinguyen@altera.com> <201305151525.50005.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:56683 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428Ab3EOQkR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 May 2013 12:40:17 -0400
Received: by mail-ob0-f169.google.com with SMTP id vb8so2269185obc.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 May 2013 09:40:16 -0700 (PDT)
In-Reply-To: <201305151525.50005.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: dinguyen@altera.com, linux-arm-kernel@lists.infradead.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Olof Johansson <olof@lixom.net>, Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org

Hi Arnd,

Thanks for the review.

On 05/15/2013 08:25 AM, Arnd Bergmann wrote:
> On Wednesday 15 May 2013, dinguyen@altera.com wrote:
>> +
>> +#define SYSMGR_SDMMCGRP_CTRL_OFFSET		0x108
>> +#define DRV_CLK_PHASE_SHIFT_SEL_MASK	0x7
>> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)		\
>> +	((((drvsel) << 0) & 0x7) | (((smplsel) << 3) & 0x38))
>> +
>> +extern void __iomem *sys_manager_base_addr;
> 
> This is not acceptable, you cannot just reference external symbols
> from one driver in another, without a proper interface.
> 
> Please explain what the functionality is that you need here, then
> we can help you find the proper interface. My guess is that you
> need either the functionality provided by drivers/reset/
> or drivers/mfd/syscon.c.

Our implementation has the timing controls for the SD/MMC controller in
another custom IP block(system manager). sys_manager_base_addr was
mapped in mach-socfpga/socfpga.c. I saw the same approach with
drivers/clk(clk_mgr_base_addr), so I thought it would be ok with this
driver. Please advise on another way to do this...

> 
>> +       if (of_property_read_u32(dev->of_node, "pwr-en", &pwr_en)) {
>> +               dev_info(dev, "couldn't determine pwr-en, assuming pwr-en = 0\n");
>> +               pwr_en = 0;
>> +       }
>> +
>> +       /* Set PWREN bit */
>> +       mci_writel(host, PWREN, pwr_en);
> 
> If you add new properties, you have to document them in
> Documentations/devicetree/bindings/*.
> 
> What is the requirement for this property? Is there no way to 
> automatically power the card on/off using the normal
> dw_mci_set_ios function?

Apologies...it wasn't there in 3.8. I will fix...

Thanks,
Dinh
> 
> The rest of this patch looks ok to me.
> 
> 	Arnd
> 
