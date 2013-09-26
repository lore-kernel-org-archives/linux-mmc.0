From: Dinh Nguyen <dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] arm: socfpga: Set the SDMMC clock phase in system manager
Date: Wed, 25 Sep 2013 22:00:14 -0500
Message-ID: <D47AF394-7C05-4CF3-98B6-2D94C63CD389@gmail.com>
References: <1378740833-4883-1-git-send-email-dinguyen@altera.com> <1378740833-4883-2-git-send-email-dinguyen@altera.com> <20130914110031.GB15077@amd.pavel.ucw.cz> <8761to4ai8.fsf@octavius.laptop.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8761to4ai8.fsf-DGHOrqG7t0YzNDMTQreKSUB+6BGkLq7r@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Pavel Machek <pavel-ynQEQJNshbs@public.gmane.org>, dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

On Sep 25, 2013, at 8:50 PM, Chris Ball wrote:

> Hi Dinh,
> 
> On Sat, Sep 14 2013, Pavel Machek wrote:
>>> From: Dinh Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
>>> 
>>> Add functionality in the System Manager to set the SDR settings for the
>>> SD/MMC IP.
>>> 
>>> Signed-off-by: Dinh Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
>>> Cc: Pavel Machek <pavel-ynQEQJNshbs@public.gmane.org>
>> 
>>> +void socfpga_sysmgr_set_dwmmc_drvsel_smpsel(void)
>>> +{
>>> +	struct device_node *np;
>>> +	u32 timing[2];
>>> +	u32 hs_timing;
>>> +
>>> +	np = of_find_compatible_node(NULL, NULL, "altr,socfpga-dw-mshc");
>>> +	of_property_read_u32_array(np, "samsung,dw-mshc-sdr-timing", timing, 2);
>>> +	hs_timing = SYSMGR_SDMMC_CTRL_SET(timing[0], timing[1]);
>>> +	writel(hs_timing, sys_manager_base_addr + SYSMGR_SDMMCGRP_CTRL_OFFSET);
>>> +}
>>> +EXPORT_SYMBOL(socfpga_sysmgr_set_dwmmc_drvsel_smpsel);
>> 
>> To get the abstraction right, would it make sense to have timing
>> parameters as arguments to socfpga_sysmgr_set_dwmmc_drvsel_smpsel(),
>> so that sysmgr code is not walking MMC's device tree directly?
> 
> I think this review comment from Pavel is still open, please reply.

I sent a Rev 2 that addresses this comment on 9/23. Let me know if I need to resend it in case you missed it.

Thanks,
Dinh
> Thanks,
> 
> - Chris.
> -- 
> Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
