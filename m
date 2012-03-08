From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Fix Unbalanced pm_runtime_enable warning
Date: Thu, 08 Mar 2012 10:32:05 -0800
Message-ID: <4F58FB25.8020602@ti.com>
References: <20120305234240.GQ12083@atomide.com> <87obsaio93.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:40559 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753852Ab2CHScG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Mar 2012 13:32:06 -0500
Received: by mail-gx0-f169.google.com with SMTP id q1so507850gge.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Mar 2012 10:32:05 -0800 (PST)
In-Reply-To: <87obsaio93.fsf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Chris,

On 03/05/2012 04:09 PM, Kevin Hilman wrote:
> Tony Lindgren<tony@atomide.com>  writes:
>
>> mmc: omap_hsmmc: Fix Unbalanced pm_runtime_enable warning
>>
>> Otherwise we can get following warning when re-loading the
>> omap_hsmmc driver module when gpio_twl4030 module is not
>> loaded:
>>
>> omap_hsmmc omap_hsmmc.0: Unbalanced pm_runtime_enable!
>> omap_hsmmc omap_hsmmc.0: Unable to grab MMC CD IRQ
>> omap_hsmmc: probe of omap_hsmmc.0 failed with error -22
>>
>> Signed-off-by: Tony Lindgren<tony@atomide.com>
>> ---
>>
>> Kevin, maybe take a look and see if this is correct and
>> fits into your PM branches?
>
> Looks right to me:
>
> Acked-by: Kevin Hilman<khilman@ti.com>
>
> But this is a fix to the driver itself, so Chris should queue this in
> mmc-next.
>
> Chris, can you take this one?
>

just checking on this to be sure it can make it for v3.4.

Kevin
