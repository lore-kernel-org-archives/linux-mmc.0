From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH 1/8] omap_hsmmc: move gpio and regulator control from
 board file
Date: Thu, 14 Jan 2010 09:58:52 +0200
Message-ID: <4B4ECEBC.6060402@nokia.com>
References: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com> <20100113114018.7615.66637.sendpatchset@ahunter-work.research.nokia.com> <20100113185448.GJ2986@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40812 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179Ab0ANIAK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jan 2010 03:00:10 -0500
In-Reply-To: <20100113185448.GJ2986@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>

ext Tony Lindgren wrote:
> * Adrian Hunter <adrian.hunter@nokia.com> [100113 03:38]:
>> From c2ed3074a73fc13d088c53193af546c01d1061b1 Mon Sep 17 00:00:00 2001
>> From: Adrian Hunter <adrian.hunter@nokia.com>
>> Date: Mon, 4 Jan 2010 13:44:36 +0200
>> Subject: [PATCH] omap_hsmmc: move gpio and regulator control from board file
>>
>> This patch moves the setup code for GPIO's and Voltage
>> Regulators from the board file mmc-twl4030.c to the
>> driver omap_hsmmc.c.
>>
>> Moving GPIO code to the driver makes the board initialisation
>> code independent of when GPIO's are defined.  That makes the
>> board initialisation now entirely independent of its original
>> twl4030 roots.
>>
>> Moving Voltage Regulator code to the driver allows for further
>> development of regulator support in the core MMC code.  It also
>> permits the MMC core to be compiled as a module, because the
>> board code no longer calls MMC core functions.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
>> ---
>>  arch/arm/configs/rx51_defconfig       |    4 +-
>>  arch/arm/mach-omap2/control.c         |    2 +
>>  arch/arm/mach-omap2/mmc-twl4030.c     |  419 +--------------------------------
>>  arch/arm/mach-omap2/mmc-twl4030.h     |    4 +-
>>  arch/arm/plat-omap/include/plat/mmc.h |    2 +-
>>  drivers/mmc/host/omap_hsmmc.c         |  417 +++++++++++++++++++++++++++++++-
>>  6 files changed, 419 insertions(+), 429 deletions(-)
> 
> <snip>
>  
>> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
>> index cdd1f35..f3e31dc 100644
>> --- a/arch/arm/mach-omap2/control.c
>> +++ b/arch/arm/mach-omap2/control.c
>> @@ -162,6 +162,7 @@ u32 omap_ctrl_readl(u16 offset)
>>  {
>>  	return __raw_readl(OMAP_CTRL_REGADDR(offset));
>>  }
>> +EXPORT_SYMBOL(omap_ctrl_readl);
>>  
>>  void omap_ctrl_writeb(u8 val, u16 offset)
>>  {
>> @@ -177,6 +178,7 @@ void omap_ctrl_writel(u32 val, u16 offset)
>>  {
>>  	__raw_writel(val, OMAP_CTRL_REGADDR(offset));
>>  }
>> +EXPORT_SYMBOL(omap_ctrl_writel);
>>  
>>  #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
>>  /*
> 
> NAK, we don't want to export omap_ctrl_read/write. That will
> lead into a horrible mess again of all the drivers tinkering
> with the omap hardware registers directly.

OK

> 
> All code like that needs to stay under mach-omap2. This same
> mmc controller could in theory be used on other hardware too,
> not just omaps. The ctrl registers are omap specific, not
> mmc controller specific.
> 
> Regards,
> 
> Tony
> 

