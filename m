From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: Fix Unbalanced pm_runtime_enable warning
Date: Thu, 08 Mar 2012 23:43:25 -0500
Message-ID: <m2ty1ypeoi.fsf@bob.laptop.org>
References: <20120305234240.GQ12083@atomide.com> <87obsaio93.fsf@ti.com>
	<4F58FB25.8020602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54652 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756586Ab2CIEn3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Mar 2012 23:43:29 -0500
In-Reply-To: <4F58FB25.8020602@ti.com> (Kevin Hilman's message of "Thu, 08 Mar
	2012 10:32:05 -0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Hi,

On Thu, Mar 08 2012, Kevin Hilman wrote:
>> Tony Lindgren<tony@atomide.com>  writes:
>>
>>> mmc: omap_hsmmc: Fix Unbalanced pm_runtime_enable warning
>>>
>>> Otherwise we can get following warning when re-loading the
>>> omap_hsmmc driver module when gpio_twl4030 module is not
>>> loaded:
>>>
>>> omap_hsmmc omap_hsmmc.0: Unbalanced pm_runtime_enable!
>>> omap_hsmmc omap_hsmmc.0: Unable to grab MMC CD IRQ
>>> omap_hsmmc: probe of omap_hsmmc.0 failed with error -22
>>>
>>> Signed-off-by: Tony Lindgren<tony@atomide.com>
>>> ---
>>>
>>> Kevin, maybe take a look and see if this is correct and
>>> fits into your PM branches?
>>
>> Looks right to me:
>>
>> Acked-by: Kevin Hilman<khilman@ti.com>
>>
>> But this is a fix to the driver itself, so Chris should queue this in
>> mmc-next.
>>
>> Chris, can you take this one?
>
> just checking on this to be sure it can make it for v3.4.

Thanks, I've pushed this to mmc-next for 3.4 now.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
