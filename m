From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [RFC/PATCH] mmc: omap_hsmmc: introduce omap_hsmmc_prepare/complete
Date: Fri, 26 Oct 2012 16:45:17 +0530
Message-ID: <508A70C5.1000407@ti.com>
References: <1350910768-8522-1-git-send-email-balbi@ti.com> <20121022132708.GA14033@arwen.pp.htv.fi> <20121025180418.GB18046@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55293 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758360Ab2JZLPc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 26 Oct 2012 07:15:32 -0400
In-Reply-To: <20121025180418.GB18046@arwen.pp.htv.fi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: balbi@ti.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-mmc@vger.kernel.org, cjb@laptop.org, Tony Lindgren <tony@atomide.com>, Balaji T K <balajitk@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Thursday 25 October 2012 11:34 PM, Felipe Balbi wrote:
> Hi,
>
> On Mon, Oct 22, 2012 at 04:27:08PM +0300, Felipe Balbi wrote:
>> On Mon, Oct 22, 2012 at 03:59:28PM +0300, Felipe Balbi wrote:
>>> prepare() is supposed to prevent new children from
>>> being registered. On the MMC subsystem, children
>>> (new cards) registration starts with the card
>>> detect IRQ.
>>>
>>> Move card detect IRQ disabling to prepare() so that
>>> no new cards will be registered while we're trying
>>> to suspend.
>>>
>>> Likewise, move card detect IRQ enabling to complete()
>>> so we only try to register new children after our MMC
>>> IP is back up.
>>>
>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>> ---
>>>
>>> Venkat, do you think the patch below makes sense ?
>> btw, just checked suspend to ram with beagle and panda. We still have
>> our filesystem after waking up.
>>
>> ps: you will [1] to test it:
>>
>> [1] http://marc.info/?l=linux-arm-kernel&m=135090724817604&w=2
> ping
>
I've been off for the past 3 days. Will test this on Monday once I'm 
back in office.
