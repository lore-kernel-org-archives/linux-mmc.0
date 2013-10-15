From: Dinh Nguyen <dinh.linux@gmail.com>
Subject: Re: [RESEND PATCHv2 1/3] arm: socfpga: Set the SDMMC clock phase
 in system manager
Date: Tue, 15 Oct 2013 08:22:50 -0500
Message-ID: <525D41AA.7060503@gmail.com>
References: <1381780051-1826-1-git-send-email-dinguyen@altera.com> <201310151450.48650.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:58252 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758938Ab3JONWv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Oct 2013 09:22:51 -0400
In-Reply-To: <201310151450.48650.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, dinguyen@altera.com
Cc: Pavel Machek <pavel@denx.de>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Arnd,

On 10/15/13 7:50 AM, Arnd Bergmann wrote:
> On Monday 14 October 2013, dinguyen@altera.com wrote:
>> +void socfpga_sysmgr_set_dwmmc_drvsel_smpsel(u32 drvsel, u32 smplsel)
>> +{
>> +       u32 hs_timing;
>> +
>> +       hs_timing = SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel);
>> +       writel(hs_timing, sys_manager_base_addr + SYSMGR_SDMMCGRP_CTRL_OFFSET);
>> +}
>> +EXPORT_SYMBOL(socfpga_sysmgr_set_dwmmc_drvsel_smpsel);
> This looks like the wrong approach. What are you trying to do? If you want to
> set a clock, please use the clk API.
I can't use the clk API because this function is setting up a clock 
phase bit for the SD/MMC
clock that is used to clock the card, not the IP. This register is 
located outside the SD/MMC
and the clock manager.

Just to refresh your memory on this topic:
I tried to use the syscon approach that you suggested:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/168470.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/170423.html

But this approach was rejected by Stephen Warren because we wanted to 
the SD driver to be automonous
of registers outside its IP:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/194014.html

So I went with the approach of exposing a platform API so that the 
SD/MMC platform specific
code can call it.

The system manager has a plethora of registers that controls other IPs 
on the SOC, so I kinda thought
syscon was the way to go with this. A driver for this IP did not make 
sense to me.

Please advise if you know of another approach?

Thanks,
Dinh






>
> 	Arnd

