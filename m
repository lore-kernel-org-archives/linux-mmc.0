From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/3] arm: socfpga: Set the SDMMC clock phase in system manager
Date: Wed, 25 Sep 2013 21:50:07 -0400
Message-ID: <8761to4ai8.fsf@octavius.laptop.org>
References: <1378740833-4883-1-git-send-email-dinguyen@altera.com>
	<1378740833-4883-2-git-send-email-dinguyen@altera.com>
	<20130914110031.GB15077@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49958 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755281Ab3IZBuW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 25 Sep 2013 21:50:22 -0400
In-Reply-To: <20130914110031.GB15077@amd.pavel.ucw.cz> (Pavel Machek's message
	of "Sat, 14 Sep 2013 13:00:31 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavel Machek <pavel@denx.de>
Cc: dinguyen@altera.com, dinh.linux@gmail.com, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Dinh,

On Sat, Sep 14 2013, Pavel Machek wrote:
>> From: Dinh Nguyen <dinguyen@altera.com>
>> 
>> Add functionality in the System Manager to set the SDR settings for the
>> SD/MMC IP.
>> 
>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
>> Cc: Pavel Machek <pavel@denx.de>
>
>> +void socfpga_sysmgr_set_dwmmc_drvsel_smpsel(void)
>> +{
>> +	struct device_node *np;
>> +	u32 timing[2];
>> +	u32 hs_timing;
>> +
>> +	np = of_find_compatible_node(NULL, NULL, "altr,socfpga-dw-mshc");
>> +	of_property_read_u32_array(np, "samsung,dw-mshc-sdr-timing", timing, 2);
>> +	hs_timing = SYSMGR_SDMMC_CTRL_SET(timing[0], timing[1]);
>> +	writel(hs_timing, sys_manager_base_addr + SYSMGR_SDMMCGRP_CTRL_OFFSET);
>> +}
>> +EXPORT_SYMBOL(socfpga_sysmgr_set_dwmmc_drvsel_smpsel);
>
> To get the abstraction right, would it make sense to have timing
> parameters as arguments to socfpga_sysmgr_set_dwmmc_drvsel_smpsel(),
> so that sysmgr code is not walking MMC's device tree directly?

I think this review comment from Pavel is still open, please reply.
Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
